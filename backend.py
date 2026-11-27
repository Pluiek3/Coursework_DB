from PySide6.QtCore import QObject, Signal, Property, Slot
import psycopg2

class Backend(QObject):
    dataChanged = Signal()

    def __init__(self):
        super().__init__()
        
        self.db_config = {
            "dbname": "slovnicek",       
            "user": "pluiek",         
            "password": "Obtizny", 
            "host": "localhost",
            "port": "5432"
        }
        
        self._dictionaries = []
        
        self._dictionary_modules = []
        
        self._module_cards = []
        
        self._current_dict_name = ""
        self._current_module_name = ""
        
        self.load_dictionaries()
        
    def get_connection(self):
        return psycopg2.connect(**self.db_config)

    def load_dictionaries(self):
        try:
            conn = self.get_connection()
            cur = conn.cursor()
            cur.execute("""
                SELECT d.id, d.name, l1.name as src_lang, l2.name as tgt_lang 
                FROM dictionary d
                JOIN language l1 ON d.source_language_id = l1.id
                JOIN language l2 ON d.target_language_id = l2.id
            """)
            rows = cur.fetchall()
            self._dictionaries = [
                {"id": row[0], "name": row[1], "language": f"{row[2]} ➔ {row[3]}"} 
                for row in rows
            ]
            cur.close()
            conn.close()
        except Exception as e:
            print(f"Ошибка БД (load_dictionaries): {e}")
            
    @Property(list, notify=dataChanged)
    def dictionaries(self):
        return self._dictionaries
        
    @Property(str, notify=dataChanged)
    def currentDictionaryName(self): 
        return self._current_dict_name

    @Property(list, notify=dataChanged)
    def dictionaryModules(self):
        return self._dictionary_modules
    
    @Property(str, notify=dataChanged)
    def currentModuleName(self): 
        return self._current_module_name

    @Property(list, notify=dataChanged)
    def moduleCards(self): 
        return self._module_cards
        
    @Slot(int)
    def selectDictionary(self, dict_id):
        try:
            conn = self.get_connection()
            cur = conn.cursor()
            cur.execute("SELECT name FROM dictionary WHERE id = %s", (dict_id,))
            self._current_dict_name = cur.fetchone()[0]
            cur.execute("SELECT id, name FROM module WHERE dictionary_id = %s", (dict_id,))
            self._dictionary_modules = [{"id": row[0], "name": row[1]} for row in cur.fetchall()]
            self._module_cards = []
            cur.close()
            conn.close()
            self.dataChanged.emit()
        except Exception as e:
            print(f"Ошибка БД (selectDictionary): {e}")
    

    @Slot(int, str)
    def selectModule(self, module_id, module_name):
        try:
            self._current_module_name = module_name
            conn = self.get_connection()
            cur = conn.cursor()
            
            cur.execute("""
                SELECT c.term, c.translation 
                FROM card c
                JOIN module_card mc ON c.id = mc.card_id
                WHERE mc.module_id = %s
            """, (module_id,))
            
            self._module_cards = [{"term": row[0], "translation": row[1]} for row in cur.fetchall()]
            cur.close()
            conn.close()
            self.dataChanged.emit()
        except Exception as e:
            print(f"Ошибка БД (selectModule): {e}")
