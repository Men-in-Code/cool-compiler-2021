from cool.utils.Errors.CoolError import CoolError

WRONG_SIGNATURE = 'Method "%s" already defined in "%s" with a different signature.'
SELF_IS_READONLY = 'Variable "self" is read-only.'
LOCAL_ALREADY_DEFINED = 'Variable "%s" is already defined in method "%s".'
INCOMPATIBLE_TYPES = 'Inferred type %s of initialization of attribute %s does not conform to declared type %s.'
VARIABLE_NOT_DEFINED = 'Variable "%s" is not defined in "%s".'
INVALID_OPERATION = 'non-Int arguments: %s %s %s.'
TYPE_AS_VARIABLE = 'Type <%s> used as variable.'
INVALID_CONDITION = ' <%s> condition must be boolean '
INVALID_HERITAGE = 'Cant heritage from <%s>'
INVALID_UNARY_OPERATION = 'Operation is not defined with <%s>'

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