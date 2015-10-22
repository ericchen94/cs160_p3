%{
    #include <cstdlib>
    #include <cstdio>
    #include <iostream>

    #define YYDEBUG 1

    int yylex(void);
    void yyerror(const char *);
%}

%error-verbose

/* Token List */

%token T_LITINT T_LEXEME


%left T_OR T_AND
%left T_LESSTHAN T_LESSTHANOREQUALTO T_EQUALS
%left T_PLUS T_MINUS
%left T_TIMES T_DIV
%right T_NOT


%%

Start : Expr
      ;

/* Grammar for Exprs */

Expr    : Expr T_PLUS Expr                  %left T_PLUS
        | Expr T_MINUS Expr                 %left T_MINUS
        | Expr T_TIMES Expr                 %left T_TIMES
        | Expr T_DIV Expr                   %left T_DIV
        | Expr T_LESSTHAN Expr              %left T_LESSTHAN
        | Expr T_LESSTHANOREQUALTO Expr     %left T_LESSTHANOREQUALTO
        | Expr T_EQUALS Expr                %left T_EQUALS
        | Expr T_AND Expr                   %left T_AND
        | Expr T_OR Expr                    %left T_OR
        | T_NOT Expr                        %left T_NOT
        | T_MINUS Expr                      %prec T_NOT
        | identifier
        | identifier T_PERIOD identifier
        | MethodCall
        | T_LPAREN Expr T_RPAREN
        | T_LITINT
        | T_TRUE
        | T_FALSE
        | T_NEW Classname
        | T_NEW Classname T_LPAREN Arguments T_RPAREN
        ;

MethodCall  : identifier T_LPAREN Arguments T_RPAREN
            | identifier T_PERIOD identifier T_LPAREN Arguments T_RPAREN
            ;

Arguments   : Arguments2
            |
            ;

Arguments2  : Arguments2 T_COMMA Expr
            | Expr
            ;


%%

extern int yylineno;

void yyerror(const char *s) {
  fprintf(stderr, "%s at line %d\n", s, yylineno);
  exit(1);
}