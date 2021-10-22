%x COMMENT

%{
#include "grammar.tab.h"
%}

%%

[ \t\n\r\f\v]

"//".* 
"/*" { BEGIN(COMMENT); }
<COMMENT>"*/" { BEGIN(INITIAL); }
<COMMENT>([^*]|\n)+|.
<COMMENT><<EOF>> { printf("%d: Unterminated comment.\n", yylineno); exit(-1); }

"const" { return CONST; }
"int" { return INT; }
"void" { return VOID; }
"if" { return IF; }
"else" { return ELSE; }
"while" { return WHILE; }
"break" { return BREAK; }
"continue" { return CONTINUE; }
"return" { return RETURN; }

"<=" { return LE_OP; }
">=" { return GE_OP; }
"==" { return EQ_OP; }
"!=" { return NE_OP; }
"&&" { return AND_OP; }
"||" { return OR_OP; }
[;,=\{\}\[\]\(\)<>\+\-*/%!] { return yytext[0]; }

[_a-zA-Z][_a-zA-Z0-9]* { return IDENT; }
0[0-9]* { return NUM; }
0x[0-9a-fA-F]+ { return NUM; }
[1-9][0-9]* { return NUM; }

%%
