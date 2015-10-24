%option yylineno
%pointer

%{
    #include <cstdlib>
    #include <cerrno>
    #include <climits>
    #include <limits>
    #include "parser.hpp"
    
	void yyerror(const char *);
%}

/* Definition Section */

/* Start Condition - Comments */


%%

"."                         {return T_PERIOD;}
","                         {return T_COMMA;}
":"                         {return T_COLON;}
";"                         {return T_SEMICOLON;}
"+"                         {return T_PLUS;}
"-"                         {return T_MINUS;}
"*"                         {return T_TIMES;}
"/"                         {return T_DIV;}
"="                         {return T_LITEQUALS;}
"<="                        {return T_LESSTHANOREQUALTO;}
"<"                         {return T_LESSTHAN;}
"->"                        {return T_POINTER;}
"("                         {return T_LPAREN;}
")"                         {return T_RPAREN;}
"["                         {return T_LBRACKETS;}
"]"                         {return T_RBRACKETS;}
"{"                         {return T_LBRACES;}
"}"                         {return T_RBRACES;}
"print"                     {return T_PRINT;}
"return"                    {return T_RETURN;}
"if"                        {return T_IF;}
"else"                      {return T_ELSE;}
"while"                     {return T_WHILE;}
"repeat"                    {return T_REPEAT;}
"until"                     {return T_UNTIL;}
"new"                       {return T_NEW;}
"integer"                   {return T_INT;}
"boolean"                   {return T_BOOLEAN;}
"none"                      {return T_NONE;}
"equals"                    {return T_EQUALS;}
"and"                       {return T_AND;}
"or"                        {return T_OR;}
"not"                       {return T_NOT;}
"true"                      {return T_TRUE;}
"false"                     {return T_FALSE;}
"extends"                   {return T_EXTENDS;}
0|([1-9][0-9]*)             {return INT;}
[a-zA-Z]([a-zA-Z]|[0-9])*   {return ID;}
[ \t\n\r]                   {/* skip whitespace */;}
[/][\*].*[/*][/]                 {;}

.                           yyerror("invalid character");

%%

int yywrap(void) {
  return 1;
}
