#### Arquitectura del compilador

El desarrollo de proyecto se dividió en cinco módulos encargados cada uno de llevar a cabo las tareas del compilador. Es por ello que existe el módulo $lexer$, $parser$, $semantic$, $cil\_builder$ y $mips\_builder$. Los dos últimos encargados de la generación de código, dividida en dos fases. La primera donde se genera un lenguaje intermedio que permite realizar el paso del $ast$ de Cool al $ast$ de Cil y la segunda fase es donde se genera el código de $mips$ a partir del lenguaje generado anteriormente. 

Para las dos primeras fases se hace uso de de las herramientas de construcción de compiladores $lex$ y $yacc$, existentes en el paquete $PLY$ de $python$. Usar $PLY$ incluye admitir el análisis sintáctico $LALR(1)$, así como proporcionar una amplia validación de entrada, informes de errores y diagnósticos. Estas dos herramientas se complementan perfectamente pues, $lex.py$ proporciona una interfaz externa en forma de función $token()$ que devuelve el siguiente $token$ válido en el flujo de entrada. $yacc.py$ llama a esto repetidamente para recuperar $tokens$ e invocar reglas gramaticales.

#####  Análisis lexicográfico

Para llevar a cabo esta fase se hace uso de la herramienta  $lex.py$. Con ella se toma un texto de entrada y se forman los $tokens$ mediante el uso de las expresiones regulares. Para ello se define para cada $token$ una expresión regular encargado de reconocerlo. Ejemplo:

