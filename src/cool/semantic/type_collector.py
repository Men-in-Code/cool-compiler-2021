from cool.Parser.AstNodes import *
from cool.semantic import visitor
from cool.semantic.semantic import SemanticException
from cool.semantic.semantic import ErrorType
from cool.semantic.semantic import Context
from cool.utils.Errors.semantic_errors import *

class TypeCollector(object):
    def __init__(self, errors=[]):
        self.context = None
        self.errors = errors
        self.type_level = {}
        self.BUILT_IN_TYPES = ['Int','String','Bool','Object','SELF_TYPE','AUTO_TYPE']
    
    @visitor.on('node')
    def visit(self, node):
        pass
    
            
    @visitor.when(ProgramNode)
    def visit(self, node):
        self.context = Context()
        self.context.create_type('SELF_TYPE')
        self.context.create_type('AUTO_TYPE')
        
        
        for def_class in node.declarations:
            self.visit(def_class)
             
        def get_type_level(typex):
            try:
                parent = self.type_level[typex]
            except KeyError:
                return 0
            if parent == 0:
                self.errors.append(SemanticError(node.column,node.row,"cyclic inheritance"))
            elif type(parent) is not int:
                self.type_level[typex] = 0 if parent else 1
                if type(parent) is str:
                    self.type_level[typex] = get_type_level(parent) + 1
                
            return self.type_level[typex]
        
        node.declarations.sort(key = lambda node: get_type_level(node.id))
                
    @visitor.when(ClassDeclarationNode)
    def visit(self, node):
        try:
            self.context.create_type(node.id)
            
            if node.parent in ['Int','String','Bool','SELF_TYPE']:
                error = SemanticError(node.column,node.row,"can't inherit from built-in types")
                self.errors.append(error)
                
            self.type_level[node.id] = node.parent
            
        except SemanticException as ex:
            node.parent = ErrorType().name
            error = SemanticError(node.column,node.row,ex.text)
            self.errors.append(error)