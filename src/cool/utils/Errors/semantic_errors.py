from cool.utils.Errors.CoolError import CoolError

class SemanticError(CoolError):
    def __init__(self, column: int, line: int, text: str):
        super().__init__(column, line, text)

    @property
    def errorType(self):
        return "SemanticError"

class TypeError(SemanticError):
    def __init__(self, column: int, line: int, text: str):
        super().__init__(column, line, text)

    @property
    def errorType(self):
        return "TypeError"