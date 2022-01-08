import itertools as itt

class SemanticException(Exception):
    @property
    def text(self):
        return self.args[0]

class Attribute:
    def __init__(self, name, typex):
        self.name = name
        self.type = typex

    def __str__(self):
        return f'[attrib] {self.name} : {self.type.name};'

    def __repr__(self):
        return str(self)

class Method:
    def __init__(self, name, param_names, params_types, return_type):
        self.name = name
        self.param_names = param_names
        self.param_types = params_types
        self.return_type = return_type

    def __str__(self):
        params = ', '.join(f'{n}:{t.name}' for n,t in zip(self.param_names, self.param_types))
        return f'[method] {self.name}({params}): {self.return_type.name};'

    def __eq__(self, other):
        return other.name == self.name and \
            other.return_type == self.return_type and \
            other.param_types == self.param_types

class Type:
    def __init__(self, name:str):
        self.name = name
        self.attributes = []
        self.methods = {}
        self.parent = None
        self.is_autotype = False

    def set_parent(self, parent):
        if self.parent is not None:
            raise SemanticException(f'Parent type is already set for {self.name}.')
        self.parent = parent

    def get_attribute(self, name:str):
        try:
            return next(attr for attr in self.attributes if attr.name == name)
        except StopIteration:
            if self.parent is None:
                raise SemanticException(f'Attribute "{name}" is not defined in {self.name}.')
            try:
                return self.parent.get_attribute(name)
            except SemanticException:
                raise SemanticException(f'Attribute "{name}" is not defined in {self.name}.')

    def define_attribute(self, name:str, typex):
        try:
            self.get_attribute(name)
        except SemanticException:
            attribute = Attribute(name, typex)
            self.attributes.append(attribute)
            return attribute
        else:
            raise SemanticException(f'Attribute "{name}" is already defined in {self.name}.')

    def change_attr(self,name:str, new_typex):
        try:
            attr = self.get_attribute(name)
            attr.type = new_typex
        except SemanticException:
            print('REVISAR TYPE.CHANGE_TYPE')

    def change_method(self,name:str,new_typex):
        try:
            method = self.get_method(name)
            method.return_type = new_typex
        except:
            print('REVISAR TYPE.CHANGE_METHOD')

    def change_param(self,name:str,new_param_list):
        try:
            method = self.get_method(name)
            param_name = []
            param_type = []
            for var in new_param_list.locals:
                param_name.append(var.name)
                param_type.append(var.type)
            method.param_names = param_name
            method.param_types = param_type
        except:
            print('REVISAR TYPE.CHANGE_PARAM')

    def substitute_type(self, typeA , typeB):
        for attr in self.attributes:
            if attr.type == typeA:
                attr.type = typeB
        for meth in self.methods.values():
            if meth.return_type == typeA:
                meth.return_type = typeB
                for p_type in meth.param_types:
                    if p_type == typeA:
                        p_type = typeB

    def has_parent(self,typeA):
        return (self == typeA) or (self.parent and self.parent.has_parent(typeA))

    def get_method(self, name:str):
        try:
            return self.methods[name]
        except KeyError:
            if self.parent is None:
                raise SemanticException(f'Method "{name}" is not defined in {self.name}.')
            try:
                return self.parent.get_method(name)
            except SemanticException:
                raise SemanticException(f'Method "{name}" is not defined in {self.name}.')

    def define_method(self, name:str, param_names:list, param_types:list, return_type):
        if name in self.methods:
            raise SemanticException(f'Method "{name}" already defined in {self.name}')
            # raise SemanticError(f'Method "{name}" already defined in {self.name} with a different signature.')

        method = self.methods[name] = Method(name, param_names, param_types, return_type)
        return method
    
    # my method, change it in future
    def define_method(self, name:str, param_names:list, param_types:list, return_type):
        try:
            method = self.get_method(name)
        except SemanticException:
            pass
        else:
            has_autotype_param = [param for param in param_types if param.is_autotype]
            if method.return_type != return_type or method.param_types != param_types:
                raise SemanticException(f'Method "{name}" already defined in {self.name} with a different signature.')
            ##############METHOD NO HEREDA AUTO)TYPE
            elif method.return_type.is_autotype or ( len(has_autotype_param)!= 0):
                raise SemanticException(f'Method "{name}" has AUTO_TYPE params and you cant redefine it')

        method = self.methods[name] = Method(name, param_names, param_types, return_type)
        return method

    def conforms_to(self, other):
        a = other.bypass() or self == other 
        b = self.parent is not None and self.parent.conforms_to(other)
        return a or b

    def bypass(self):
        return False

    def __str__(self):
        output = f'type {self.name}'
        parent = '' if self.parent is None else f' : {self.parent.name}'
        output += parent
        output += ' {'
        output += '\n\t' if self.attributes or self.methods else ''
        output += '\n\t'.join(str(x) for x in self.attributes)
        output += '\n\t' if self.attributes else ''
        output += '\n\t'.join(str(x) for x in self.methods.values())
        output += '\n' if self.methods else ''
        output += '}\n'
        return output

    def __repr__(self):
        return str(self)

class ObjectType(Type):
    def __init__(self):
        Type.__init__(self, 'Object')

    def __eq__(self,other):
        return other.name == self.name or isinstance(other, ObjectType)

class ErrorType(Type):
    def __init__(self):
        Type.__init__(self, 'Error')

    def conforms_to(self, other):
        return True

    def bypass(self):
        return True

    def __eq__(self, other):
        return isinstance(other, Type)

class VoidType(Type):
    def __init__(self):
        Type.__init__(self, 'Void')

    def conforms_to(self, other):
        raise Exception('Invalid type: void type.')

    def bypass(self):
        return True

    def __eq__(self, other):
        return isinstance(other, VoidType)

class IntType(Type):

    def __init__(self):
        Type.__init__(self, 'Int')
        self.parent = ObjectType()

    def __eq__(self, other):
        return other.name == self.name or isinstance(other, IntType)

class BoolType(Type):
    def __init__(self):
        Type.__init__(self , 'Bool')
        self.parent = ObjectType()

    def __eq__(self,other):
        return other.name == self.name or isinstance(other, BoolType)

class StringType(Type):
    def __init__(self):
        Type.__init__(self,'String')
        self.parent = ObjectType()

    def __eq__(self,other):
        return other.name == self.name or isinstance(other, StringType)

class IOType(Type):
    def __init__(self):
        Type.__init__(self,'IO')
        self.parent = ObjectType()

    def __eq__(self,other):
        return other.name == self.name or isinstance(other, StringType)

class SelfType(Type):
    def __init__(self):
        Type.__init__(self,'self')

class Context:
    def __init__(self):
        self.types = {}
        self.special_types = []
        object_type = ObjectType()
        object_type.define_method('abort',[],[],ObjectType())
        object_type.define_method('type_name',[],[],StringType())
        object_type.define_method('copy',[],[],'self')

        IO_type = IOType()
        IO_type.define_method('out_string',['x'],[StringType()],'self')
        IO_type.define_method('out_int',['x'],[IntType()],'self')
        IO_type.define_method('in_string',[],[],StringType())
        IO_type.define_method('in_int',[],[],IntType())

        int_type = IntType()
        bool_type = BoolType()
        error_type = ErrorType()

        string_type = StringType()
        string_type.define_method('lenght',[],[],IntType())
        string_type.define_method('concat',['s'],[StringType()],StringType())
        string_type.define_method('substr', ['i','l'] ,[IntType(),IntType()],StringType())

        self.types['Object'] = object_type
        self.types['Int'] = int_type
        self.types['String'] = string_type
        self.types['Bool'] = bool_type
        self.types['Error'] = error_type
        self.types['IO'] = IO_type
        

        

    def create_type(self, name:str):
        if name in self.types:
            raise SemanticException(f'Type with the same name ({name}) already in context.')
        typex = self.types[name] = Type(name)
        return typex

    def change_type(self,name:str,typex:str):
        self.types[name] = self.types[typex]

    def get_type(self, name:str):
        try:
            return self.types[name]
        except KeyError:
            raise SemanticException(f'Type "{name}" is not defined.')

    def __str__(self):
        return '{\n\t' + '\n\t'.join(y for x in self.types.values() for y in str(x).split('\n')) + '\n}'

    def __repr__(self):
        return str(self)

class VariableInfo:
    def __init__(self, name, vtype):
        self.name = name
        self.type = vtype

class Scope:
    def __init__(self, parent=None):
        self.locals = []
        self.parent = parent
        self.children = []
        self.index = 0 if parent is None else len(parent)

    def __len__(self):
        return len(self.locals)

    def create_child(self):
        child = Scope(self)
        self.children.append(child)
        return child

    def define_variable(self, vname, vtype):
        info = VariableInfo(vname, vtype)
        self.locals.append(info)
        return info

    def find_variable(self, vname, index=None):
        locals = self.locals if index is None else itt.islice(self.locals, index)
        try:
            return next(x for x in locals if x.name == vname)
        except :
            if self.parent is not None:
                a = self.parent.find_variable(vname, self.index)
            else :
                a = None
            return a

    def is_defined(self, vname):
        a = self.find_variable(vname) is not None
        return a

    def is_local(self, vname):
        return any(True for x in self.locals if x.name == vname)
    
    def change_type(self,vname:str,vtype):
        var = self.find_variable(vname)
        var.type = vtype
    
    def substitute_type(self,typeA,typeB):

        for var in self.locals:
            if var.type == typeA:
                var.type = typeB

        if self.parent:
            self.parent.substitute_type(typeA,typeB)

def get_common_parent(type_A, type_B = None, context = None):
    if type_B:
        parent_listA = [type_A.name]
        parent_listB = [type_B.name]
        common_parent = None
        while type_A.parent is not None:
            parent_listA.append(type_A.parent.name)
            type_A = context.get_type(type_A.parent.name)
        parent_listA = reversed(parent_listA)

        while type_B.parent is not None:
            parent_listB.append(type_B.parent.name)
            type_B = context.get_type(type_B.parent.name)
        parent_listB = reversed(parent_listB)

        for itemA, itemB in zip(parent_listA,parent_listB):
            if(itemA == itemB):
                common_parent = itemA
            else:
                break
    else:
        common_parent = type_A.name

    return common_parent 

    