from cool.Parser.AstNodes import *
from cool.semantic import visitor
from cool.semantic.semantic import SemanticException
from cool.semantic.semantic import VoidType, ErrorType
from cool.utils.Errors.semantic_errors import *

class TypeBuilder:
    def __init__(self, context, errors=[]):
        self.context = context
        self.current_type = None
        self.errors = errors
        self.counter = 1
    
    @visitor.on('node')
    def visit(self, node):
        pass
        
    @visitor.when(ProgramNode)
    def visit(self, node):
        for def_class in node.declarations:
            self.visit(def_class)           
    
    @visitor.when(ClassDeclarationNode)
    def visit(self, node):
        self.current_type = self.context.get_type(node.id)
        
        if node.parent:
            try:
                parent_type = self.context.get_type(node.parent)
                self.current_type.set_parent(parent_type)
            except SemanticException as ex:
                error = SemanticError(node.column,node.row,ex.text)
                self.errors.append(error)
        else:
            parent_type = self.context.get_type('Object')
            self.current_type.set_parent(parent_type)
        
        for feature in node.features:
            self.visit(feature)
            
    @visitor.when(AttrDeclarationNode)
    def visit(self, node):
        try:
            if node.type == 'SELF_TYPE':
                node.type = self.current_type.name
                attr_type = self.current_type
            else:
                attr_type = self.context.get_type(node.type)  
        except SemanticException as ex:
            error = SemanticError(node.column,node.row,ex.text)
            self.errors.append(error)
            attr_type = ErrorType()
            
        try:
            self.current_type.define_attribute(node.id, attr_type)
        except SemanticException as ex:
            error = NameError(node.column,node.row,ex.text)
            self.errors.append(error)
        
    @visitor.when(FuncDeclarationNode)
    def visit(self, node):
        arg_names, arg_types = [], []
        
        for i,_ in enumerate(node.params):
            idx,typex = node.params[i]
            if typex == 'SELF_TYPE':
                node.params[i] = (idx,self.current_type.name)
        if node.type == 'SELF_TYPE':
            node.type = self.current_type.name
        
        for idx, typex in node.params:
            try:
                arg_type = self.context.get_type(typex)
            except SemanticException as ex:
                error = SemanticError(node.column,node.row,ex.text)
                arg_type = ErrorType()
                
            arg_names.append(idx)
            arg_types.append(arg_type)
        
        try:
            ret_type = VoidType() if node.type == 'void' else self.context.get_type(node.type)
        except SemanticException as ex:
            error = SemanticError(node.column,node.row,ex.text)
            self.errors.append(error)
            ret_type = ErrorType()
        
        try:
            self.current_type.define_method(node.id, arg_names, arg_types, ret_type)
        except SemanticException as ex:
            error = SemanticError(node.column,node.row,ex.text)
            self.errors.append(error)
