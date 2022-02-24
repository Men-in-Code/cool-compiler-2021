import sys
from pathlib import Path
from cool.lexer.lexer import Lexer, main
from cool.utils.LexerTokens import *
from cool.Parser.parser import Parser
from cool.semantic.semanticAnalizer import run_semantic_pipeline
from cool.cil_builder.cilAnalizer import run_code_gen_pipeline

import os.path
from pathlib import Path


if __name__ == '__main__':
    add = "codegen/arith.cl"

    path: str = f"{Path.cwd()}/tests/{add}" if os.path.exists(
        f"{Path.cwd()}/tests/{add}") else f"{Path.cwd()}/../tests/{add}"

    _in = sys.argv[1] if len(sys.argv) > 1 else path
    
    with open(_in) as file:
        text = file.read()

#     text = '''
#     class C inherits A
#     {
#         var_1:Int<-100;
#         var_2:Int<-200;
#         var_3:Int<-200;
#         f():Int
#         {
#             1
#         };
#     };

#     class E inherits B
#     {   
#         g():Int
#         {
#             2
#         };
#         f():Int
#         {
#             2
#         };
#         var_9:Int<-900;
#         var_10:Int;        
#     };

#     class Main inherits IO 
#     {

#         var_4:Int<-400;
#         f():Int
#         {
#             3
#         };
#         var_5:Int;

#         main(): Object
#         { 
#             1
#         };
#     };

#     class B inherits A
#     {   
#         g():Int
#         {
#             3
#         };
#         var_11:A;
#         var_12:A;
#     };

#     class A inherits Main
#     {   
#         var_6:Int<-900;
#         var_7:Int;
#         var_8:Int;  
#     };
      
#     class D inherits B
#     {   
#         var_9:D;
#         var_10:C;  
#     };   

# '''
 

    lexer = main(text)             ##estas dos lineas estan para mi pa ver q tokeniza
    tokens = lexer.tokenize()



    if (len(lexer.errors)!= 0):
        for e in lexer.errors:
            print(e)
        raise Exception()

    # print(lexer)

    parser = Parser(Lexer(text))
    ast = parser.parse(text)

    if parser.found_error:
        print(parser.errors[0])
        raise Exception()

    context,scope = run_semantic_pipeline(ast)
    mips_output = run_code_gen_pipeline(ast,context,scope)
    # mips_output = run_mips_gen_pipeline(cil_ast,context,scope)

