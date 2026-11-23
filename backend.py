from PySide6.QtCore import QObject, Signal, Property, Slot

class Backend(QObject):
    dataChanged = Signal()

    def __init__(self):
        super().__init__()
        self._current_module = "Тест"
        self._modules = ["Тест"]

    @Property(str, notify=dataChanged)
    def currentModule(self):
        return self._current_module

    @Property(list, notify=dataChanged)
    def modules(self):
        return self._modules

    @Slot(str)
    def selectModule(self, module_name):
        self._current_module = module_name
        print(f"Выбран модуль: {module_name}")
        self.dataChanged.emit()
