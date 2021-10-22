%{
#include<stdio.h>
#include<stdlib.h>
%}

%token IDENT NUM
%token LE_OP GE_OP EQ_OP NE_OP AND_OP OR_OP
%token CONST INT VOID IF ELSE WHILE BREAK CONTINUE RETURN

%%

comp_unit
    :
    | comp_unit decl
    | comp_unit func_def
    ;

decl
    : CONST type val_def_list ';'
    | type val_def_list ';'
    ;

/* for const and var definition */
val_def_list
    : IDENT loc_list '=' init_val
    | val_def_list ',' IDENT loc_list '=' init_val
    ;

init_val
    : exp 
    | '{' '}'
    | '{' init_list '}'
    ;

init_list
    : init_val
    | init_list ',' init_val
    ;

loc_list
    :
    | loc_list '[' exp ']'
    ;

func_def
    : type IDENT '(' d_params ')' block
    ;

type
    : VOID
    | INT
    ;

d_params
    :
    | d_param_list
    ;

d_param_list
    : param
    | d_param_list ',' param
    ;

param
    : INT IDENT '[' ']' loc_list
    | INT IDENT
    ;

block
    : '{' block_item_list '}'
    ;

block_item_list
    :
    | block_item_list decl
    | block_item_list stmt
    ;

stmt
    : IDENT loc_list '=' exp ';' 
    | exp ';' 
    | block
    | IF '(' cond ')' stmt ELSE stmt
    | IF '(' cond ')' stmt
    | WHILE '(' cond ')' stmt
    | BREAK ';' 
    | CONTINUE ';'
    | RETURN exp ';'
    | RETURN ';'
    | ';' 
    ;

exp
    : add_exp
    ;

cond
    : or_exp
    ;

or_exp
    : and_exp 
    | or_exp OR_OP and_exp
    ;

and_exp
    : eq_exp 
    | and_exp AND_OP eq_exp
    ;

eq_exp
    : rel_exp 
    | eq_exp EQ_OP rel_exp
    | eq_exp NE_OP rel_exp
    ;

rel_exp
    : add_exp 
    | rel_exp '<' add_exp
    | rel_exp '>' add_exp
    | rel_exp LE_OP add_exp
    | rel_exp GE_OP add_exp
    ;

add_exp
    : mul_exp 
    | add_exp '+' mul_exp
    | add_exp '-' mul_exp
    ;

mul_exp
    : unary_exp 
    | mul_exp '*' unary_exp
    | mul_exp '/' unary_exp
    | mul_exp '%' unary_exp
    ;

unary_exp
    : '(' exp ')'
    | IDENT loc_list
    | NUM
    | IDENT '(' c_params ')'
    | unary_op unary_exp
    ;

unary_op
    : '+'
    | '-'
    | '!'
    ;

c_params
    :
    | c_params_list
    ;

c_params_list
    : exp
    | c_params_list ',' exp
    ;

%%

int
main(int argc, char **argv) {
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("error: %s\n", s);
    exit(-1);
}
