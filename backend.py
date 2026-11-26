from PySide6.QtCore import QObject, Signal, Property, Slot
import psycopg2

class Backend(QObject):
    dataChanged = Signal()

    def __init__(self):
        super().__init__()
        
        self._current_module = ""
        
        self.db_config = {
            "dbname": "slovnicek",       
            "user": "pluiek",         
            "password": "Obtizny", 
            "host": "localhost",
            "port": "5432"
        }
        
        self._dictionaries = []
        
        self._modules = []
        
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
            print(f"Ошибка подключения к БД (load_dictionaries): {e}")
            
    @Property(list, notify=dataChanged)
    def dictionaries(self):
        return self._dictionaries

    @Property(list, notify=dataChanged)
    def modules(self):
        return self._modules
        
    @Slot(int)
    def selectDictionary(self, dict_id):
        try:
            conn = self.get_connection()
            cur = conn.cursor()
            cur.execute("SELECT id, name FROM module WHERE dictionary_id = %s", (dict_id,))
            rows = cur.fetchall()
            self._modules = [{"id": row[0], "name": row[1]} for row in rows]
            cur.close()
            conn.close()
            self.dataChanged.emit()
        except Exception as e:
            print(f"Ошибка БД (selectDictionary): {e}")
    

    @Slot(str)
    def selectModule(self, module_name):
        self._current_module = module_name
        print(f"Выбран модуль: {module_name}")
        self.dataChanged.emit()
