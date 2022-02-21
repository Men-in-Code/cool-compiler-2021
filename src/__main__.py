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
    add = "lexer/iis4.cl"

    path: str = f"{Path.cwd()}/tests/{add}" if os.path.exists(
        f"{Path.cwd()}/tests/{add}") else f"{Path.cwd()}/../tests/{add}"

    _in = sys.argv[1] if len(sys.argv) > 1 else path
    
    with open(_in) as file:
        text = file.read()

    text = ''' 
    class Main inherits IO {
        main(): IO 
        { 
            out_string(true.type_name())
            };
    };
    class A {
        x:Int<-100;
        y:String;
        f():String{
            y
        };
     };
'''

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

