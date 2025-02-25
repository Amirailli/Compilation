%{
    #include <stdio.h>
    int nb_ligne = 1;
%}

lettre [a-zA-Z]
chiffre [0-9]
IDF {lettre}({lettre}|{chiffre}|_)*  

%%

"##".*            {/* ignore les commentaires sur un seul lignes */}
\{--(.|\n)*?--\}  {/* ignore les commentaires sur plusieurs lignes */}




"MainPrgm"      { printf("Mot-cle detecte : MainPrgm\n"); }
"Var"           { printf("Mot-cle detecte : Var\n"); }
"BeginPg"       { printf("Mot-cle detecte : BeginPg\n"); }
"EndPg"         { printf("Mot-cle detecte : EndPg\n"); }
"let"           { printf("Mot-cle detecte : let\n"); }
"@define"       { printf("Mot-cle detecte : @define\n"); }


"{"         { printf("Ouverture de bloc\n"); }
"}"         { printf("Fermeture de bloc\n"); }
"["         { printf("Crochet ouvrant\n"); }
"]"         { printf("Crochet fermant \n"); }

";"         { printf("Point virgule\n"); }
":"         { printf("Declaration\n"); }
","         { printf("Virgule\n"); }
"\'"        { printf("Guillemets\n"); }
":="        { printf("Affectation\n"); }
"="        { printf("Egal\n"); }


[+\-*/]     { printf("Operateur: %s\n", yytext); }
{chiffre}+  { printf("Nombre: %s\n", yytext); } 
{lettre}    { printf("Lettre: %s\n", yytext); }
{IDF}       { 
                if (yyleng <= 14) 
                    printf("Identificateur valide : %s\n", yytext);
                else 
                    printf("Erreur lexicale : IDF trop long\n"); 
            }  



[ \t]+         {/* Ignorer */}
\n          { nb_ligne++; }
.           { printf("Erreur lexicale à la ligne %d: %s\n", nb_ligne, yytext); }

%%

int main() {
    yylex();
    return 0;
}

