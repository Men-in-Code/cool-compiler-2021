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
    add = "codegen/hairyscary.cl"

    path: str = f"{Path.cwd()}/tests/{add}" if os.path.exists(
        f"{Path.cwd()}/tests/{add}") else f"{Path.cwd()}/../tests/{add}"

    _in = sys.argv[1] if len(sys.argv) > 1 else path
    
    with open(_in) as file:
        text = file.read()

    text = '''
    class Main inherits IO 
    {
        var_1 : Int <- 10; 
        var_2 : Int <- 20; 
        var_3 : Int <- 30; 
        var_4 : Int <- 40; 

        main(): IO
        { 
            {
                var_1;
                out_int(0);
            }
        };
    };

    class A inherits Main
    {   
        var_5 : Int <- 50; 
        var_6 : Int <- 60; 
        var_7 : Int <- 70; 
        var_8 : Int <- 80; 

        set_value(x : Int): Int
        {
            var_1
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

