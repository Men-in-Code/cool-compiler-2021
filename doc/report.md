#### Arquitectura del compilador

El desarrollo de proyecto se dividió en cinco módulos encargados cada uno de llevar a cabo las tareas del compilador. Es por ello que existe el módulo $lexer$, $parser$, $semantic$, $cil\_builder$ y $mips\_builder$. Los dos últimos encargados de la generación de código, dividida en dos fases. La primera donde se genera un lenguaje intermedio que permite realizar el paso del $ast$ de Cool al $ast$ de Cil y la segunda fase es donde se genera el código de $mips$ a partir del lenguaje generado anteriormente. 

Para las dos primeras fases se hace uso de de las herramientas de construcción de compiladores $lex$ y $yacc$, existentes en el paquete $PLY$ de $python$. Usar $PLY$ incluye admitir el análisis sintáctico $LALR(1)$, así como proporcionar una amplia validación de entrada, informes de errores y diagnósticos. Estas dos herramientas se complementan perfectamente pues, $lex.py$ proporciona una interfaz externa en forma de función $token()$ que devuelve el siguiente $token$ válido en el flujo de entrada. $yacc.py$ llama a esto repetidamente para recuperar $tokens$ e invocar reglas gramaticales.

Tanto lex como yacc proveen formas de manejar los errores lexicográficos y sintácticos, que se determinan cuando fallan las reglas que les fueron definidas. Es importante señalar que la sintaxis generalmente se especifica en términos de una gramática BNF(notación de Backus-Naur).

#####  Análisis lexicográfico

Para llevar a cabo esta fase se hace uso de la herramienta  $lex.py$. en el módulo $lexer.py$. Con ella se toma un texto de entrada y se forman los $tokens$ mediante el uso de las expresiones regulares. Para ello se define para cada $token$ una expresión regular encargado de reconocerlo. Ejemplo:

![Screenshot from 2022-02-25 14-24-11](/media/abelo/Local Disk/4to/Mio/2do Semestre/CMP/cool-compiler-2021/doc/Screenshot from 2022-02-25 14-24-11.png) <img src="/media/abelo/Local Disk/4to/Mio/2do Semestre/CMP/cool-compiler-2021/doc/Screenshot from 2022-02-25 14-27-15.png" alt="Screenshot from 2022-02-25 14-27-15"  />



Como se puede apreciar en las imágenes anteriores, extraídas del código del proyecto,  a la izquierda se observan tres sencillas expresiones regulares para reconocer los operadores de igualdad, suma y resta; formadas únicamente por el símbolo del operador. En la imagen de la derecha vemos expresiones regulares más complejas para reconocer un identificador y un número.

Como se puede apreciar para definir las reglas de reconocimiento de $tokens$ se usan las funciones, pues es necesario definir acciones extra cuando se ha reconocido el $token$, como computar su columna, obtener el valor numérico si es un número, entre otras. La regla de expresión regular se especifica en la cadena de documentación de la función. Esta recibe un solo argumento que es una instancia de $LexToken$. Este objeto tiene atributos de $t.type$ que es el tipo de $token$ (como un $string$), $t.value$ que es el lexema (el texto real coincidente), $t.lineno$ que es el número de línea actual y $t.lexpos$ que es el posición del token en relación con el comienzo del texto de entrada. De forma predeterminada, $t.type$ se establece en el nombre que sigue al prefijo $t\_$. Este nombre no es más que un literal con el que llamamos al $token$.



##### Análisis sintáctico

Para llevar a cabo el proceso de $parsing$ se crea el módulo $parser.py$ y este a su vez hace uso de $yacc.py$, encargado de implementar esta fase en $PLY$. $yacc.py$ utiliza la técnica de análisis sintáctico conocida como análisis $LR$ o $shift-reduce$. A modo de resumen, el análisis $LR$ es una técnica de $bottom-up$ que intenta reconocer el lado derecho de varias reglas gramaticales. Cada vez que se encuentra un lado derecho válido en la entrada, se activa el código de acción apropiado y los símbolos gramaticales se reemplazan por el símbolo gramatical del lado izquierdo.

El modo en que se emplea esta técnica resulta semejante al ya visto en clases prácticas, es por ello que en cada regla gramática se va construyendo el $AST$. Este enfoque consiste en crear un conjunto de estructuras de datos para diferentes tipos de nodos de árbol de sintaxis abstracta y asignar nodos a $p[0]$ en cada regla.

A continuación vemos un ejemplo de se usa $yacc.py$:

![Screenshot from 2022-02-25 15-30-01](/media/abelo/Local Disk/4to/Mio/2do Semestre/CMP/cool-compiler-2021/doc/Screenshot from 2022-02-25 15-30-01.png)

En este ejemplo, cada regla gramatical está definida por una función donde el $string$ de documentación de esa función contiene la especificación adecuada de la gramática libre de contexto. Las declaraciones que componen el cuerpo de la función implementan las acciones semánticas de la regla. Cada función acepta un solo argumento $p$ que es una secuencia que contiene los valores de cada símbolo gramatical en la regla correspondiente. Los valores de $p[i]$ se asignan a símbolos gramaticales. En el primer caso estaríamos ante una regla para producir un nodo de suma o resta, en dependencia de el símbolo en $p[2]$ y el tamaño de la regla y en caso contrario se deriva en un término. Abajo se crea la función encargada de manejar la reglas de los términos. En este caso pudiéramos derivar en una multiplicación, división o en un elemento unario. Aclarar que en ambas reglas, para $arith$ y $term$ en caso de que se reconozca un símbolo($+,-,/,*$) se estamos asignado en nodo de nuestro binario de nuestro $AST$, pero a modo general, para los no terminales, el valor está determinado por lo que se coloca en $p[0]$ cuando se reducen las reglas.



##### Gramática

```bnf
program : class_list

class_list : def_class SEMI class_list
           | def_class SEMI
                      
def_class : class TYPE OCUR feature_list CCUR
          | class TYPE inherits TYPE OCUR feature_list CCUR

feature_list : def_attr SEMI feature_list
             | def_func SEMI feature_list
             | empty
             
def_attr : ID COLON TYPE
         | ID COLON TYPE LARROW expr            
 
def_func : ID OPAR param_list_call CPAR COLON TYPE OCUR expr CCUR
             
param_list_call : param_list
                | param_list_empty           

param_list : param
           | param COMMA param_list
                      
param_list_empty : empty                     
                      
param : ID COLON TYPE                      
                      
expr_list : expr SEMI expr_list
          | expr SEMI                      
                      
declar_list : declar
            | declar COMMA declar_list                   

declar : ID COLON TYPE
       | ID COLON TYPE LARROW expr
                    
assign_list : case_assign
            | case_assign assign_list
      
case_assign : ID COLON TYPE RARROW expr SEMI

expr : boolean

boolean : not comparison
        | comparison

comparison : comparison EQUAL boolean
		   | comparison LESS boolean
           | comparison LESSEQ boolean 
           | arith

arith : arith PLUS term
      | arith MINUS term
      | term
      
term : term STAR unary
     | term DIV unary
     | unary
     
unary : factor

unary : NOX unary

unary : isvoid expr


factor : OPAR expr CPAR

factor : factor DOT ID OPAR arg_list_call CPAR
       | ID OPAR arg_list_call CPAR
       | factor ARROBA TYPE DOT ID OPAR arg_list_call CPAR
       
factor : atom


atom : let declar_list in expr

atom : while expr loop expr pool

atom : if expr then expr else expr fi

atom : case expr of assign_list esac

atom : OCUR expr_list CCUR

atom : ID LARROW expr

atom : NUMBER

atom : true
     | false
     
atom : ID


arg_list_call : arg_list
              | arg_list_empty
```

