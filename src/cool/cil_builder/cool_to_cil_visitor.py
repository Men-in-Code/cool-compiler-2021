from typing import List
import cool.cil_builder.cil_ast as cil
from cool.Parser.AstNodes import *
from cool.semantic import visitor
from cool.semantic.semantic import ObjectType, Scope
from cool.semantic.semantic import get_common_parent,multiple_get_common_parent,is_local
from cool.semantic.semantic import SemanticException
from cool.semantic.semantic import ErrorType, IntType, BoolType
from cool.utils.Errors.semantic_errors import *
from cool.semantic.semantic import *

class BaseCOOLToCILVisitor:
    def __init__(self, context):
        self.dottypes = []
        self.dotdata = []
        self.dotcode = []
        self.current_type = None
        self.current_method = None
        self.current_function = None
        self.context = context
    
    @property
    def params(self):
        return self.current_function.params
    
    @property
    def localvars(self):
        return self.current_function.localvars
    
    @property
    def instructions(self):
        return self.current_function.instructions

    def register_param(self,vinfo):
        vinfo.name = f'param_{self.current_function.name[9:]}_{vinfo.name}'
        param_node = cil.ParamNode(vinfo.name)
        self.params.append(param_node)
    
    def is_in_actual_params(self,param_name):
        return param_name in self.params


    def register_local(self, vinfo):
        vinfo.name = f'local_{self.current_function.name[9:]}_{vinfo.name}_{len(self.localvars)}'
        local_node = cil.LocalNode(vinfo.name)
        self.localvars.append(local_node)
        return vinfo.name

    def define_internal_local(self):
        vinfo = VariableInfo('internal', None)
        return self.register_local(vinfo)

    def register_instruction(self, instruction):
        self.instructions.append(instruction)
        return instruction
    
    def to_function_name(self, method_name, type_name):
        return f'function_{method_name}_at_{type_name}'
    
    def register_function(self, function_name):
        function_node = cil.FunctionNode(function_name, [], [], [])
        self.dotcode.append(function_node)
        return function_node
    
    def register_type(self, name):
        type_node = cil.TypeNode(name)
        self.dottypes.append(type_node)
        return type_node

    def register_data(self, value):
        vname = f'data_{len(self.dotdata)}'
        data_node = cil.DataNode(vname, value)
        self.dotdata.append(data_node)
        return data_node

    def fill_cil_types(self,context):
        for p in [t for t in self.dottypes]:
            p_type = context.get_type(p.name)
            parents = p_type.get_all_parents()
            for p_type in parents:
                for method in p_type.methods:
                    p.methods.append((method.name,self.to_function_name(method.name,p_type.name)))

    def fill_builtin(self,context:Context):
        aaa = Type('aaa')
        built_in_types = [context.get_type('Object'),context.get_type('IO'),context.get_type('Int'),context.get_type('String')]
        for t in built_in_types:
            cilType = self.register_type(t.name)
            cilType.attributes = [for a in t.]
            cilType.methods


            # p.methods += [self.to_function_name(method,type) for method in p_type.methods 
            #     for p_type in parents]

class COOLToCILVisitor(BaseCOOLToCILVisitor):
    @visitor.on('node')
    def visit(self, node):
        pass
    
    @visitor.when(ProgramNode)
    def visit(self, node, scope):
        ######################################################
        # node.declarations -> [ ClassDeclarationNode ... ]
        ######################################################
        cil_scope = Scope()
        self.current_function = self.register_function('entry')
        instance = self.define_internal_local()
        result = self.define_internal_local()
        main_method_name = self.to_function_name('main', 'Main')
        self.register_instruction(cil.AllocateNode('Main', instance))
        self.register_instruction(cil.ArgNode(instance))
        self.register_instruction(cil.StaticCallNode(main_method_name, result))
        self.register_instruction(cil.ReturnNode(0))
        self.current_function = None

        
        for declaration, child_scope in zip(node.declarations, scope.children):
            self.visit(declaration, child_scope,cil_scope.create_child())

        self.fill_cil_types(self.context)

        return cil.ProgramNode(self.dottypes, self.dotdata, self.dotcode)
    
    @visitor.when(ClassDeclarationNode)
    def visit(self, node, scope,cil_scope):
        ####################################################################
        # node.id -> str
        # node.parent -> str
        # node.features -> [ FuncDeclarationNode/AttrDeclarationNode ... ]
        ####################################################################
        
        self.current_type = self.context.get_type(node.id)

        # Your code here!!! (Handle all the .TYPE section)
        cil_type = self.register_type(node.id)
        cil_type.attributes = [v.name for (v,_) in self.current_type.all_attributes()]

        

        func_declarations = (f for f in node.features if isinstance(f, FuncDeclarationNode))
        for feature, child_scope in zip(func_declarations, scope.children):
            value = self.visit(feature, child_scope,cil_scope.create_child())
        

        self.current_type = None

                
    @visitor.when(FuncDeclarationNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.id -> str
        # node.params -> [ (str, str) ... ]
        # node.type -> str
        # node.body -> [ ExpressionNode ... ]
        ###############################
        self.current_method = self.current_type.get_method(node.id)

        # Your code here!!! (Handle PARAMS)
        function_name = self.to_function_name(node.id,self.current_type.name)
        self.dottypes[-1].methods.append((node.id,function_name))
        self.current_function = self.register_function(function_name)
        self_param = [cil.ParamNode('self')]
        self.current_function.params = self_param+[cil.ParamNode(param_name) for (param_name,_) in node.params] 

        value = 0
        for instruction, child_scope in zip(node.body, scope.children):
            value = self.visit(instruction, child_scope,cil_scope)

        # Your code here!!! (Handle RETURN)
        self.register_instruction(cil.ReturnNode(value))
        self.current_method = None
        return self.current_function

    @visitor.when(VarDeclarationNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.id -> str
        # node.type -> str
        # node.expr -> ExpressionNode
        ###############################
        # Your code here!!!
        pass

    @visitor.when(AssignNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.id -> str
        # node.expr -> ExpressionNode
        ###############################
        
        # Your code here!!!
        # dest = self.register_local(node.id)
        # source = self.visit(node.expr)
        # return cil.AssignNode(dest,source)
        pass

    @visitor.when(CallNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.obj -> AtomicNode
        # node.id -> str
        # node.args -> [ ExpressionNode ... ]
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(ConstantNumNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.lex -> str
        ###############################
        
        # Your code here!!! (Pretty easy ;-))
        return node.lex
        pass

    @visitor.when(VariableNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.lex -> str
        ###############################
        
        # Your code here!!!

        if cil_scope.find_variable(node.lex):
            self.register_local(node.lex)
            return node.lex
        elif node.lex in [param_nodes.name[0] for param_nodes in self.current_function.params]:
            return node.lex
        elif node.lex in self.current_type.all_attributes():
            new_local = self.define_internal_local()
        else:
            pass

    @visitor.when(InstantiateNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.lex -> str
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(PlusNode)
    def visit(self, node, scope,cil_scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        dest = self.define_internal_local()
        left = self.visit(node.left,scope,cil_scope)
        right = self.visit(node.right,scope,cil_scope)
        self.register_instruction(cil.PlusNode(dest,left,right))
        return dest
        pass

    @visitor.when(MinusNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(StarNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        pass

    @visitor.when(DivNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        
        # Your code here!!!
        cil.DivNode
        pass