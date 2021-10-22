compiler: lex.l grammar.y
	bison -d grammar.y
	flex lex.l
	cc grammar.tab.c lex.yy.c -lfl

test: a.out
	./a.out < main.c
