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

%token T_PERIOD T_COMMA T_COLON T_SEMICOLON
%token T_PLUS T_MINUS T_TIMES T_DIV
%token T_LITEQUALS T_LESSTHANOREQUALTO T_LESSTHAN T_POINTER
%token T_LPAREN T_RPAREN T_LBRACKETS T_RBRACKETS T_LBRACES T_RBRACES
%token T_PRINT T_RETURN
%token T_IF T_ELSE T_WHILE T_REPEAT T_UNTIL
%token T_NEW T_INT T_BOOLEAN T_TRUE T_FALSE
%token T_NONE T_EQUALS T_AND T_OR T_NOT T_EXTENDS
%token INT ID


/* Precedence List */

%left T_OR T_AND
%left T_LESSTHAN T_LESSTHANOREQUALTO T_EQUALS
%left T_PLUS T_MINUS
%left T_TIMES T_DIV
%right T_NOT

%%

/* GRAMMAR */

Start   : Start Class 
        | Class
        ;

Class   : ID T_EXTENDS ID T_LBRACES MemberList MethodList T_RBRACES
        | ID T_LBRACES MemberList MethodList T_RBRACES
        ;


MemberList  : MemberList Member
            | Member
            |
            ;

Member  : ReturnType ID T_SEMICOLON
        ;

MethodList  : MethodList Method
            | Method
            |
            ;

Method  : ID T_LPAREN ParameterList T_RPAREN T_POINTER ReturnType T_LBRACES MethodBody T_RBRACES
        ; 

ParameterList   : ParameterList T_COMMA Parameter 
                | Parameter
                |
                ;

Parameter   : ID T_COLON ReturnType
            ;

MethodBody  : Declaration MethodBody
            | Declaration MethodBody2
            | MethodBody2
            |
            ;

MethodBody2 : Statement MethodBody2
            | Statement T_SEMICOLON
            | T_RETURN Expr T_SEMICOLON
            |
            ;


ReturnType  : ID
            | T_INT
            | T_BOOLEAN
            | T_NONE
            ;

Declaration : Declaration ID T_COMMA
            | ID T_SEMICOLON
            | ReturnType
            ;

Statement   : Assignment
            | MethodCallStatement
            | IfElse
            | While
            | RepeatUntil
            | Print
            ;

Assignment  : ID T_LITEQUALS Expr T_SEMICOLON
            | ID T_PERIOD ID T_LITEQUALS Expr T_SEMICOLON
            ;

MethodCallStatement : MethodCall T_SEMICOLON
                    ;

IfElse  : T_IF Expr T_LBRACES Block T_RBRACES
        | T_IF Expr T_LBRACES Block T_RBRACES T_ELSE T_LBRACES Block T_RBRACES 
        ;

While   : T_WHILE Expr T_LBRACES Block T_RBRACES
        ;

RepeatUntil : T_REPEAT T_LBRACES Block T_RBRACES T_UNTIL T_LPAREN Expr T_RPAREN T_SEMICOLON
            ;

Block   : Block Statement
        | Statement
        ;

Print   : T_PRINT Expr T_SEMICOLON
        ;

Type    : T_INT
        | T_TRUE
        | T_FALSE
        | T_NONE        
        ;


/* Grammar for Expressions */

Expr    : Expr T_PLUS Expr                  
        | Expr T_MINUS Expr                 
        | Expr T_TIMES Expr                 
        | Expr T_DIV Expr                   
        | Expr T_LESSTHAN Expr              
        | Expr T_LESSTHANOREQUALTO Expr     
        | Expr T_EQUALS Expr                
        | Expr T_AND Expr                   
        | Expr T_OR Expr                    
        | T_NOT Expr                        
        | T_MINUS Expr                      %prec T_NOT
        | ID
        | ID T_PERIOD ID
        | MethodCall
        | T_LPAREN Expr T_RPAREN
        | INT
        | T_TRUE
        | T_FALSE
        | T_NEW ID
        | T_NEW ID T_LPAREN Arguments T_RPAREN
        ;

MethodCall  : ID T_LPAREN Arguments T_RPAREN
            | ID T_PERIOD ID T_LPAREN Arguments T_RPAREN
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
