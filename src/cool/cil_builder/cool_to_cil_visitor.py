from markupsafe import string
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
        self.current_type_dir = None
        self.context = context
        self.label_id = 0
        self.tag_id = 0
    
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
        data_node = cil.DataCilNode(vname, value)
        self.dotdata.append(data_node)
        return data_node

    def fill_cil_types(self,context):
        for p in [t for t in self.dottypes]:
            p_type = context.get_type(p.name)
            parents = p_type.get_all_parents()
            parent_methods = []
            for p_type in reversed(parents):
                for method in p_type.methods:
                    parent_methods.append((method,self.to_function_name(method,p_type.name)))
            p.methods = parent_methods+p.methods
    
    def create_label(self):
        self.label_id += 1
        return f'label{self.label_id}'

    def create_tag(self):
        self.tag_id += 1
        return self.tag_id - 1

    def generateTree(self):
        classList = {}
        for classNode in self.context.types.values():
            if classNode.parent is not None:
                try:
                    classList[classNode.parent.name].append(classNode)
                except KeyError:
                    classList[classNode.parent.name] = [classNode]
        return classList

    def enumerateTypes(self):
        parentTree = self.generateTree()
        self.context.types['Object'].class_tag = self.create_tag()
        for Node in parentTree.values():
            for child in Node:
                child.class_tag = self.create_tag()


    def fill_builtin(self):
        built_in_types = [
            self.context.get_type('Object'),
            self.context.get_type('IO'),
            self.context.get_type('Int'),
            self.context.get_type('String'),
            self.context.get_type('Bool')]
        for t in built_in_types:
            cilType = self.register_type(t.name)
            cilType.methods = [(m,self.to_function_name(m,t.name)) for m in t.methods]
            if cilType.name in ['Int','String','Bool']:
                cilType.attributes.append('value')


        #=============================Object=========================================
        self.current_type = self.context.get_type('Object')

        #init_Object
        self.current_function = self.register_function('init_Object')
        self_param = self.register_param(VariableInfo('self',self.current_type.name))
        self.register_instruction(cil.ReturnCilNode(self_param))

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
        self.current_function = self.register_function(self.to_function_name('copy',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        result = self.define_internal_local()
        self.register_instruction(cil.CopyCilNode(param_self,result))
        self.register_instruction(cil.ReturnCilNode(result))
        
        #=========================Int=========================================
        self.current_type = self.context.get_type('Int')
        
        #init_Int
        self.current_function = self.register_function('init_Int')
        self_param = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('value',self.current_type.name))
        self.register_instruction(cil.SetAttribCilNode(self_param,'Int','value', param1))
        self.register_instruction(cil.ReturnCilNode(self_param))

        #=========================String=========================================
        self.current_type = self.context.get_type('String')

        #init_String
        self.current_function = self.register_function('init_String')
        self_param = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('value',self.current_type.name))
        result = self.define_internal_local()
        self.register_instruction(cil.SetAttribCilNode(result,'String','value',param1))
        self.register_instruction(cil.ReturnCilNode(result))

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
        #init_Bool
        # self.current_function = self.register_function(self.to_function_name('init',self.current_type.name))
        # param_self = self.register_param(VariableInfo('self',self.current_type.name))
        # param1 = self.register_param(VariableInfo('value',self.current_type.name))
        # result = self.define_internal_local()
        # self.register_instruction(cil.AllocateCilNode(self.current_type.name,result))
        # self.register_instruction(cil.IntCilNode(param1,result))
        # self.register_instruction(cil.ReturnCilNode(result))

        #=========================IO=========================================
        self.current_type = self.context.get_type('IO')
        #function out_string
        self.current_function = self.register_function(self.to_function_name('out_string',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('param1',self.context.get_type('String')))
        result = self.define_internal_local()
        self.register_instruction(cil.GetAttribCilNode(param1,'String','value',result))
        self.register_instruction(cil.PrintStringCilNode(result))
        self.register_instruction(cil.ReturnCilNode(param_self))

        #function out_int
        self.current_function = self.register_function(self.to_function_name('out_int',self.current_type.name))
        param_self = self.register_param(VariableInfo('self',self.current_type.name))
        param1 = self.register_param(VariableInfo('param1',self.context.get_type('Int')))
        result = self.define_internal_local()
        self.register_instruction(cil.GetAttribCilNode(param1,'Int','value',result))
        self.register_instruction(cil.PrintIntCilNode(result))
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
        self.current_function = self.register_function('entry')
        instance = self.define_internal_local(scope)
        result = self.define_internal_local(scope)
        self.register_instruction(cil.AllocateCilNode('Main', instance))
        self.register_instruction(cil.StaticCallCilNode('Main','init_Main',[instance],instance))
        self.register_instruction(cil.StaticCallCilNode('Main','main',[instance], result))
        self.register_instruction(cil.ReturnCilNode(0))

        self.fill_builtin()
        self.enumerateTypes() 

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
        self.current_type.tag = len(self.dottypes)
        cil_type = self.register_type(node.id)
        cil_type.attributes = [v.name for (v,_) in self.current_type.all_attributes()]


        #Register Init_Class Function
        self.current_function = self.register_function(f'init_{self.current_type.name}')
        self_param = self.register_param(VariableInfo('self',self.current_type.name))
        # self.register_instruction(cil.AllocateCilNode(self.current_type.name,instance_dir))
        self.current_type_dir = self_param

        attr_list =[attr for attr in node.features if isinstance(attr,AttrDeclarationNode)]
        for attr in attr_list:
            self.visit(attr,scope)

        self.register_instruction(cil.ReturnCilNode(self_param))

        self.current_function = None
        #End register Init_Class Function


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
            self.register_param(VariableInfo(f'param_{param.id}',param.type))
        value = self.visit(node.body, scope)

        self.register_instruction(cil.ReturnCilNode(value))
        self.current_method = None

        return self.current_function

    @visitor.when(AttrDeclarationNode)
    def visit(self,node,scope):
        ###############################################
        # node.id = str
        # node.type = str
        # node.expr = ExpressionNode
        #################################################
        class_dir = self.current_type_dir
        if node.expr is not None:
            result = self.visit(node.expr,scope)
            self.register_instruction(cil.SetAttribCilNode(class_dir,self.current_type.name,node.id,result))
        else:
            if node.type == 'Int':
                # self.register_instruction(cil.SetDefaultCilNode(class_dir,self.current_type.name,node.id,'0'))
                int_internal = self.define_internal_local()
                result_location = self.define_internal_local()
                result = self.define_internal_local()

                self.register_instruction(cil.IntCilNode(0,int_internal))
                self.register_instruction(cil.AllocateCilNode('Int',result_location))
                self.register_instruction(cil.StaticCallCilNode('Int','init_Int',[result_location,int_internal],result))
                self.register_instruction(cil.SetAttribCilNode(class_dir,self.current_type.name,node.name,result))
            elif node.type == 'String':
                # self.register_instruction(cil.SetDefaultCilNode(class_dir,self.current_type.name,node.id,""))
                pass
            elif node.type == 'Bool':
                pass
                # self.register_instruction(cil.SetDefaultCilNode(class_dir,self.current_type.name,node.id,'0'))
            else:
                # self.register_instruction(cil.SetDefaultCilNode(class_dir,self.current_type.name,node.id,'void'))
                pass


    @visitor.when(ConstantNumNode) #7.1 Constant
    def visit(self, node,scope):
        ###############################
        # node.lex -> str
        ###############################
        returnVal = self.define_internal_local()
        int_internal = self.define_internal_local()
        result_location = self.define_internal_local()
        # self.register_instruction(cil.AllocateCilNode('Int',returnVal))
        self.register_instruction(cil.AllocateCilNode('Int',result_location))
        self.register_instruction(cil.IntCilNode(int(node.lex),int_internal))
        self.register_instruction(cil.StaticCallCilNode('Int','init_Int',[result_location,int_internal],returnVal))
        # self.register_instruction(cil.SetAttribCilNode(returnVal,'Int','value',node.lex)) 
        return result_location

    @visitor.when(StringNode) #7.1 Constant
    def visit(self, node,scope):
    ###############################
    # node.lex -> str
    ###############################
        returnVal = self.define_internal_local()
        string_internal = self.define_internal_local()
        data_name = self.register_data(node.lex)
        self.register_instruction(cil.StringCilNode(data_name.name,string_internal)) 
        self.register_instruction(cil.StaticCallCilNode('String','init_String',[string_internal],returnVal))
        return returnVal

    @visitor.when(VariableNode) #7.2 Identifiers
    def visit(self, node,scope):
        ###############################
        # node.lex -> str
        ###############################
        if scope.is_cil_defined(node.lex):
            cool_var = scope.find_variable(node.lex)
            self.register_local(VariableInfo(node.lex,cool_var.type))
            return node.lex
        elif f'param_{node.lex}' in [param_nodes.name for param_nodes in self.params]:
            return f'param_{node.lex}'
        # elif node.lex in self.current_type.all_attributes():
        else:
        #### que iria en instance ###### ojo
            new_local = self.define_internal_local()
            self.register_instruction(cil.GetAttribCilNode('self',self.current_type.name,node.lex,new_local))
            return new_local


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
        #node.obj = ExpressionNode
        #node.id = str
        #node.args = args
        #node.parent = Type
        ###############################
        result = self.define_internal_local()
        arg_list = []

        for a in (node.args):
            method_arg = self.visit(a,scope)
            arg_list.append(method_arg)

        if node.call_type == 2:
            # self_instance = self.define_internal_local()
            arg_list.insert(0,'self')
            self.register_instruction(cil.StaticCallCilNode(self.current_type.name,node.id,arg_list,result))
        else:
            expresion = self.visit(node.obj,scope)
            # arg_list.append(expresion)
            if node.call_type == 1:
                self.register_instruction(cil.DynamicCallCilNode(expresion,node.obj.computed_type.name,node.id,[expresion]+arg_list,result))
            else:
                self.register_instruction(cil.DynamicCallCilNode(expresion,node.parent,node.id,arg_list,result))

        return result

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
        for let_local in node.params:
            self.visit(let_local,child_scope)
        result = self.visit(node.body)
        return result

    @visitor.when(LetDeclarationNode) #7.8 Let Node 
    def visit(self, node, scope):
        ###############################
        # node.id = str
        # node.type = Type
        # node.expr = ExpresionNode
        ###############################
        var_created = self.register_local(VariableInfo(node.id,node.type),scope)
        expr_result = self.visit(node.expr,scope)
        self.register_instruction(cil.AssignCilNode(var_created,expr_result))
        return var_created



    @visitor.when(CaseNode) #7.9 Case Node 
    def visit(self, node, scope):
        ###############################
        # node.case = ExpresionNode
        # node.body = [Expression Node]
        ###############################
        expresionLabel_list = []
        distance_list = []

        result = self.define_internal_local()   
        expr_is_void = self.define_internal_local()
        dynamic_type_of_Expr = self.define_internal_local()
        label_error = self.create_label()
        label_end = self.create_label()

        expr_result = self.visit(node.case)
        self.register_instruction(cil.IsVoidCilNode(expr_result,expr_is_void))
        self.register_instruction(cil.GotoIfCilNode(expr_is_void,label_error))

        #####
        #Preguntar para coger el tipo menor
        #####
        #Revisar tipos primero y quedarme con el menor Tipe P tal que P >= C
        self.register_instruction(cil.TypeOfCilNode(expr_result,dynamic_type_of_Expr))
        min_distance = self.define_internal_local()
        condition_reached = self.define_internal_local()

        for (i,expr_node) in enumerate(node.body):
            result_len_i = self.define_internal_local()
            distance_list.append(result_len_i)
            if i == 0:
                self.register_instruction(cil.TypeDistanceCilNode(dynamic_type_of_Expr,expr_node.type,result_len_i))
                self.register_instruction(cil.AssignCilNode(min_distance,result_len_i))
            else:
                expresionLabel_list.append(self.create_label())
                self.register_instruction(cil.TypeDistanceCilNode(dynamic_type_of_Expr,expr_node.type,result_len_i))
                self.register_instruction(cil.MinCilNode(result_len_i,min_distance,min_distance))

        for i in range(len(node.body)):
            a_i_distance = distance_list[i]
            label_i = expresionLabel_list[i]
            self.register_instruction(cil.EqualsCilNode(condition_reached,min_distance,a_i_distance))
            self.register_instruction(cil.GotoIfCilNode(condition_reached,label_i))

        #Ejecutar a isntruccion correspondiente
        for (i,expr_node) in enumerate(node.body):
            self.register_instruction(cil.LabelCilNode(expresionLabel_list[i]))
            child_scope = scope.create_child()
            self.register_local(expr_node.id,child_scope)
            body_node_result = self.visit(expr_node,child_scope)
            self.register_instruction(cil.AssignCilNode(result,body_node_result))
            self.register_instruction(cil.GotoCilNode(label_end))

        #Si no supo encontrar P tal que C<=P dar error(es el mismo error que el isVoid, arreglar en caso de que se necesite)
        self.register_instruction(cil.LabelCilNode(label_error))
        self.register_instruction(cil.ErrorCilNode('IsVoidInCaseNodeExpresion'))
        self.register_instruction(cil.LabelCilNode(label_end))

        return result

    @visitor.when(VarDeclarationNode) #Case Node
    def visit(self, node, scope):
        ###############################
        # node.id -> str
        # node.type -> str
        # node.expr -> ExpressionNode
        ###############################
        result = self.visit(node.expr,scope)
        return result 

    @visitor.when(PlusNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        dest = self.define_internal_local()
        result = self.define_internal_local()
        result_fun = self.define_internal_local()

        left = self.visit(node.left,scope)
        right = self.visit(node.right,scope)
        # self.register_instruction(cil.GetAttribCilNode(left,'Int','value',left))
        # self.register_instruction(cil.GetAttribCilNode(right,'Int','value',right))
        self.register_instruction(cil.AllocateCilNode('Int',result))
        self.register_instruction(cil.PlusCilNode(dest,left,right))
        self.register_instruction(cil.StaticCallCilNode('Int','init_Int',[result,dest],result_fun))
        return result

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

    @visitor.when(DivNode)
    def visit(self, node, scope):
        ###############################
        # node.left -> ExpressionNode
        # node.right -> ExpressionNode
        ###############################
        dest = self.define_internal_local()
        check_zero = self.define_internal_local()
        label_zero_div = self.create_label()
        end = self.create_label()
        
        left = self.visit(node.left,scope)
        right = self.visit(node.right,scope)
        # self.register_instruction(cil.EqualsCilNode(check_zero,0,right))
        # self.register_instruction(cil.GotoIfCilNode(check_zero,label_zero_div))
        self.register_instruction(cil.DivCilNode(dest,left,right))
        # self.register_instruction(cil.GotoCilNode(end))

        # self.register_instruction(cil.LabelCilNode(label_zero_div))
        # self.register_instruction(cil.ErrorCilNode('ERROR DIVIDIR ZERO'))
        # self.register_instruction(cil.LabelCilNode(end))
        return dest

    @visitor.when(InstantiateNode)
    def visit(self, node, scope):
        ###############################
        # node.lex -> str
        ###############################
        allocate_dir = self.define_internal_local()
        result = self.define_internal_local()
        if node.lex == "SELF_TYPE":
            self.register_instruction(cil.AllocateCilNode(self.current_type.name,allocate_dir))
            self.register_instruction(cil.StaticCallCilNode(self.current_type.name,f'init_{self.current_type.name}',[allocate_dir],result)) #OJO result puede ser innecesario
        else:
            self.register_instruction(cil.AllocateCilNode(node.lex,allocate_dir))
            self.register_instruction(cil.StaticCallCilNode(self.current_type.name,f'init_{node.lex}',[allocate_dir],result))
        return allocate_dir