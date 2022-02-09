from ast import arg
from copy import copy
from typing import List
from venv import create

from git import typ
from numpy import VisibleDeprecationWarning
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
        self.label_id = 0
    
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
        vinfo.name = f'{vinfo.name}'
        param_node = cil.ParamCilNode(vinfo.name)
        self.params.append(param_node)
        return vinfo.name
    
    def is_in_actual_params(self,param_name):
        return param_name in self.params


    def register_local(self, vinfo,scope = None):
        cool_name = vinfo.name
        vinfo.name = f'local_{self.current_function.name[9:]}_{vinfo.name}_{len(self.localvars)}'
        local_node = cil.LocalCilNode(vinfo.name)
        self.localvars.append(local_node)
        if scope is not None:
            scope.define_cil_local(cool_name,vinfo.name)
        return vinfo.name

    def define_internal_local(self,scope = None):
        vinfo = VariableInfo('internal', None)
        return self.register_local(vinfo,scope)

    def register_instruction(self, instruction):
        self.instructions.append(instruction)
        return instruction
    
    def to_function_name(self, method_name, type_name):
        return f'function_{method_name}_at_{type_name}'
    
    def register_function(self, function_name):
        function_node = cil.FunctionCilNode(function_name, [], [], [])
        self.dotcode.append(function_node)
        return function_node
    
    def register_type(self, name):
        type_node = cil.TypeCilNode(name)
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
                    p.methods.append((method,self.to_function_name(method,p_type.name)))
    
    def create_label(self):
        self.label_id += 1
        return f'label{self.label_id}'

    def fill_builtin(self):
        built_in_types = [self.context.get_type('Object'),self.context.get_type('IO'),self.context.get_type('Int'),self.context.get_type('String')]
        for t in built_in_types:
            cilType = self.register_type(t.name)
            cilType.methods = [(m,self.to_function_name(m,t.name)) for m in t.methods]

        #=============================Object=========================================
        self.current_type = self.context.get_type('Object')

        #function abort
        self.current_function = self.register_function(self.to_function_name('abort',self.current_type.name))
        self.register_param(VariableInfo('self',self.current_type.name))
        self.register_instruction(cil.AbortCilNode())
        self.register_instruction(cil.ReturnCilNode())

        #function type_name
        self.current_function = self.register_function(self.to_function_name('type_name',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        result = self.define_internal_local()
        self.register_instruction(cil.TypeNameCilNode(param_self,result))
        self.register_instruction(cil.ReturnCilNode(result))

        #function copy
        self.current_function = self.register_function(self.to_function_name('type_name',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        result = self.define_internal_local()
        self.register_instruction(cil.CopyCilNode(param_self,result))
        self.register_instruction(cil.ReturnCilNode(result))
        
        #=========================Int=========================================
        self.current_type = self.context.get_type('Int')
        #=========================String=========================================
        self.current_type = self.context.get_type('String')
        #function length
        self.current_function = self.register_function(self.to_function_name('length',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        result = self.define_internal_local()
        self.register_instruction(cil.LengthCilNode(param_self,result))
        self.register_instruction(cil.ReturnCilNode(result))

        #function concat
        self.current_function = self.register_function(self.to_function_name('concat',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('var2',self.current_type.name))
        result = self.define_internal_local()
        self.register_instruction(cil.ConcatCilNode(param_self,param1,result))
        self.register_instruction(cil.ReturnCilNode(result))

        #function substr
        self.current_function = self.register_function(self.to_function_name('substr',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('param1','Int'))
        param2 = self.register_param(VariableInfo('param2','Int'))
        result = self.define_internal_local()
        self.register_instruction(cil.SubstringCilNode(param_self,param1,param2,result))
        self.register_instruction(cil.ReturnCilNode(result))

        #=========================Bool=========================================
        self.current_type = self.context.get_type('Bool')

        #=========================IO=========================================
        self.current_type = self.context.get_type('IO')
        #function out_string
        self.current_function = self.register_function(self.to_function_name('out_string',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('param1',self.context.get_type('String')))
        result = self.define_internal_local()
        self.register_instruction(cil.PrintStringCilNode(param_self,param1))
        self.register_instruction(cil.ReturnCilNode(param_self))

        #function out_int
        self.current_function = self.register_function(self.to_function_name('out_int',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('param1',self.context.get_type('Int')))
        result = self.define_internal_local()
        self.register_instruction(cil.PrintIntCilNode(param_self,param1))
        self.register_instruction(cil.ReturnCilNode(param_self))

        #function in_string
        self.current_function = self.register_function(self.to_function_name('in_string',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('param1',self.context.get_type('String')))
        result = self.define_internal_local()
        self.register_instruction(cil.ReadStringCilNode(param_self,param1,result))
        self.register_instruction(cil.ReturnCilNode(result))

        #function in_int
        self.current_function = self.register_function(self.to_function_name('in_int',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('param1',self.context.get_type('String')))
        result = self.define_internal_local()
        self.register_instruction(cil.ReadIntCilNode(param_self,param1,result))
        self.register_instruction(cil.ReturnCilNode(result))

        self.current_type = None
        self.current_function = None
        self.current_method = None


class COOLToCILVisitor(BaseCOOLToCILVisitor):
    @visitor.on('node')
    def visit(self, node):
        pass
    
    @visitor.when(ProgramNode)
    def visit(self, node, scope):
        ######################################################
        # node.declarations -> [ ClassDeclarationNode ... ]
        ######################################################
        # self.current_function = self.register_function('entry')
        # instance = self.define_internal_local(scope)
        # result = self.define_internal_local(scope)
        # main_method_name = self.to_function_name('main', 'Main')
        # self.register_instruction(cil.AllocateCilNode('Main', instance))
        # self.register_instruction(cil.ArgCilNode(instance))
        # self.register_instruction(cil.StaticCallCilNode(main_method_name, result))
        # self.register_instruction(cil.ReturnCilNode(0))
        self.fill_builtin()
        
        for declaration, child_scope in zip(node.declarations, scope.children):
            self.visit(declaration, child_scope)
        self.fill_cil_types(self.context)
        self.current_function = None

        return cil.ProgramCilNode(self.dottypes, self.dotdata, self.dotcode)
    
    @visitor.when(ClassDeclarationNode)
    def visit(self, node, scope):
        ####################################################################
        # node.id -> str
        # node.parent -> str
        # node.features -> [ FuncDeclarationNode/AttrDeclarationNode ... ]
        ####################################################################
        
        self.current_type = self.context.get_type(node.id)

        cil_type = self.register_type(node.id)
        cil_type.attributes = [v.name for (v,_) in self.current_type.all_attributes()]

        func_declarations = [f for f in node.features if isinstance(f, FuncDeclarationNode)]
        for feature, child_scope in zip(func_declarations, scope.children):
            value = self.visit(feature,scope.create_child())
        

        self.current_type = None

                
    @visitor.when(FuncDeclarationNode)
    def visit(self, node, scope):
        ###############################
        # node.id -> str
        # node.params -> [ (str, str) ... ]
        # node.type -> str
        # node.body -> [ ExpressionNode ... ]
        ###############################
        self.current_method = self.current_type.get_method(node.id)

        function_name = self.to_function_name(node.id,self.current_type.name)
        self.dottypes[-1].methods.append((node.id,function_name))
        self.current_function = self.register_function(function_name)

        self.register_param(VariableInfo('self',self.current_type.name))
        for param in node.params:
            self.register_param(VariableInfo(param.id,param.type))
        value = self.visit(node.body, scope)

        self.register_instruction(cil.ReturnCilNode(value))
        self.current_method = None

        return self.current_function

    @visitor.when(ConstantNumNode) #7.1 Constant
    def visit(self, node,scope):
        ###############################
        # node.lex -> str
        ###############################
        returnVal = self.define_internal_local()
        self.register_instruction(cil.ConstantCilNode(returnVal,node.lex)) 
        return returnVal

    @visitor.when(VariableNode) #7.2 Identifiers
    def visit(self, node,scope):
        ###############################
        # node.lex -> str
        ###############################
        if scope.is_cil_defined(node.lex):
            self.register_local(VariableInfo(node.lex,None))
            return node.lex
        elif node.lex in [param_nodes.name for param_nodes in self.params]:
            return f'param_{node.lex}'
        elif node.lex in self.current_type.all_attributes():
            new_local = self.define_internal_local()
            return f'attrib_{new_local.name}'
        else:
            pass

    @visitor.when(AssignNode) #7.3 Assignement
    def visit(self, node,scope):
        ###############################
        # node.id -> str
        # node.expr -> ExpressionNode
        ###############################
        source = self.visit(node.expr,scope)
        local_var = scope.find_cil_variable(node.id)
        if local_var is not None: #local
            dest = local_var
            self.register_instruction(cil.AssignCilNode(dest,source))
        elif self.is_in_actual_params(node.id): #param
            dest = node.id
            self.register_instruction(cil.AssignCilNode(dest,source))
        else: #attribute
            self.register_instruction(cil.SetAttribCilNode(self.current_type.name,source,node.id))
            dest = node.id
            
        return dest

    @visitor.when(CallNode) #7.4 Dispatch
    def visit(self, node, scope):
        ###############################
        #self.obj = ExpressionNode
        #self.id = str
        #self.args = args
        #self.parent = Type
        ###############################
        result = self.define_internal_local()
        expresion = self.visit(node.obj,scope)

        arg_list = [cil.ArgCilNode(expresion)]
        for a in reversed(node.args):
            method_arg = self.visit(a,scope)
            arg_list.append(cil.ArgCilNode(method_arg))
        if node.parent is not None:
            self.register_instruction(cil.StaticCallCilNode(expresion,node.computed_type,None,arg_list,result))
        else:
            self.register_instruction(cil.DynamicCallCilNode(expresion,node.computed_type,None,arg_list,result))
    
    @visitor.when(IfNode) #7.5 Conditional
    def visit(self,node,scope):
        ###############################
        #node.ifexp = ExpressionNode
        #node.elseexp = ExpressionNode
        #node.thenexp = ExpressionNode
        ###############################
        result = self.define_internal_local()
        condition = self.visit(node.ifexp,scope)
        then_label = self.create_label()
        end_label = self.create_label()

        self.register_instruction(cil.GotoIfCilNode(condition,then_label))
        else_result = self.visit(node.elseexp)
        self.register_instruction(cil.AssignCilNode(result,else_result))
        self.register_instruction(cil.GotoCilNode(end_label))

        self.register_instruction(cil.LabelCilNode(then_label))
        then_result = self.visit(node.thenexp)
        self.register_instruction(cil.AssignCilNode(result,then_result))
        self.register_instruction(cil.LabelCilNode(end_label))

        return result 

    @visitor.when(WhileNode) #7.6 Loop
    def visit(self,node,scope):
        ###############################
        # node.condition = ExpressionNode
        # node.body = ExpressionNode
        ###############################
        result = self.define_internal_local()
        # self.register_instruction(cil.AssignCilNode())
        label_start = self.create_label()
        label_end = self.create_label()
        self.register_instruction(cil.LabelCilNode(label_start))
        if_result = self.visit(node.condition,scope)
        self.register_instruction(cil.GotoIfCilNode(if_result,label_end))
        body_result = self.visit(node.body,scope)
        self.register_instruction(cil.GotoCilNode(label_start))
        self.register_instruction(cil.LabelCilNode(label_end))

        # self.register_instruction(cil.returnVoidCilNode)
        return result



    @visitor.when(ExpressionGroupNode) #7.7 Blocks
    def visit(self, node, scope):
        ###############################
        # node.body -> ExpressionNode
        ###############################
        for expression in node.body:
            value = self.visit(expression,scope)
        return value

    @visitor.when(LetNode) #7.8 Let Node 
    def visit(self, node, scope):
        ###############################
        # node.params = [DeclarationNode]
        # node.body = ExpresionNode
        ###############################
        child_scope = scope.create_child()
        result = self.define_internal_local()
        for let_local in node.params:
            self.visit(let_local,child_scope)
        result = self.visit(node.body)
        return result

    @visitor.when(DeclarationNode) #7.8 Let Node 
    def visit(self, node, scope):
        ###############################
        # node.case = case
        # node.body = body
        ###############################
        pass



    @visitor.when(CaseNode) #7.9 Case Node 
    def visit(self, node, scope):
        ###############################
        # node.case = case
        # node.body = body
        ###############################
        pass

    @visitor.when(VarDeclarationNode) #Case Node
    def visit(self, node, scope):
        ###############################
        # node.id -> str
        # node.type -> str
        # node.expr -> ExpressionNode
        ###############################
        pass


    

    @visitor.when(PlusNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        dest = self.define_internal_local()
        left = self.visit(node.left,scope)
        right = self.visit(node.right,scope)
        self.register_instruction(cil.PlusCilNode(dest,left,right))
        return dest

    @visitor.when(MinusNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        dest = self.define_internal_local()
        left = self.visit(node.left,scope)
        right = self.visit(node.right,scope)
        self.register_instruction(cil.MinusCilNode(dest,left,right))
        return dest

    @visitor.when(StarNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        dest = self.define_internal_local()
        left = self.visit(node.left,scope)
        right = self.visit(node.right,scope)
        self.register_instruction(cil.StarCilNode(dest,left,right))
        return dest
        pass

    @visitor.when(DivNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        dest = self.define_internal_local()
        left = self.visit(node.left,scope)
        right = self.visit(node.right,scope)
        self.register_instruction(cil.StarCilNode(dest,left,right))
        return dest

    @visitor.when(InstantiateNode)
    def visit(self, node, scope):
        ###############################
        # node.lex -> str
        ###############################
        pass

# class WhileNode(ExpressionNode):
#     def __init__(self, condition, body, row, column):
#         self.condition = condition
#         self.body = body
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class CaseNode(ExpressionNode):
#     def __init__(self,case,body, row, column):
#         self.case = case
#         self.body = body
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class LetNode(ExpressionNode):
#     def __init__(self, params, body, row, column):
#         self.params = params
#         self.body = body
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class ExpressionGroupNode(ExpressionNode):
#     def __init__(self, body, row, column):
#         self.body = body
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class AttrDeclarationNode(DeclarationNode):
#     def __init__(self, idx, typex, expr, row = 0, column = 0):
#         self.id = idx
#         self.type = typex
#         self.expr = expr
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class ParamDeclarationNode(DeclarationNode):
#     def __init__(self, idx, typex, row = 0, column = 0):
#         self.id = idx
#         self.type = typex
#         self.row = row
#         self.column = column

# class VarDeclarationNode(ExpressionNode):
#     def __init__(self, idx, typex, expr, row = 0, column = 0):
#         self.id = idx
#         self.type = typex
#         self.expr = expr
#         self.place_holder = None
#         self.row = row
#         self.column = column
        
# class DeclarationNode(ExpressionNode):
#     def __init__(self, idx, typex, expr, row = 0, column = 0):
#         self.id = idx
#         self.type = typex
#         self.expr = expr
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class AssignNode(ExpressionNode):
#     def __init__(self, idx, expr, row, column):
#         self.id = idx
#         self.expr = expr
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class CallNode(ExpressionNode):
#     def __init__(self, obj, idx, args, parent, row = 0, column = 0):
#         self.obj = obj
#         self.id = idx
#         self.args = args
#         self.parent = parent
#         self.place_holder = None
#         self.row = row
#         self.column = column

# class ExpressionGroupNode(ExpressionNode):
#     def __init__(self, body, row, column):

#         self.place_holder = None
#         self.row = row
#         self.column = column

# class AtomicNode(ExpressionNode):
#     def __init__(self, lex, row, column):
#         self.lex = lex
#         self.place_holder = None
#         self.row = row
#         self.column = column

        
# class BinaryIntNode(BinaryNode):
#     pass
# class BinaryBoolNode(BinaryNode):
#     pass

# class UnaryNode(ExpressionNode):
#     def __init__(self,right, row, column):
#         self.right = right
#         self.place_holder = None
#         self.row = row
#         self.column = column