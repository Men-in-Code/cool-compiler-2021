import sys
from pathlib import Path

from ply.lex import LexError, lex
from cool.lexer.lexer import Lexer, main
from cool.utils.Errors import parser_errors
from cool.utils.LexerTokens import *
from cool.Parser.parser import Parser
from cool.utils.Errors.parser_errors  import ParserError
from cool.utils.Errors.LexerErrors import LexerErrors


import os.path
from pathlib import Path


if __name__ == '__main__':
    add = "parser/block2.cl"

    path: str = f"{Path.cwd()}/tests/{add}" if os.path.exists(
        f"{Path.cwd()}/tests/{add}") else f"{Path.cwd()}/../tests/{add}"

    _in = sys.argv[1] if len(sys.argv) > 1 else path
    
    with open(_in) as file:
        text = file.read()

    lexer = main(text)             ##estas dos lineas estan para mi pa ver q tokeniza
    tokens = lexer.tokenize()


    if (len(lexer.errors)!= 0):
        for e in lexer.errors:
            print(e)
        raise Exception()

    print(lexer)

    parser = Parser(Lexer(text))
    ast = parser.parse(text)

    if parser.found_error:
        print(parser.errors[0])
        raise Exception()
