#include 'protheus.ch'
#define BREAKLINE  chr(13) + chr(10)
#include "TOTVS.CH"

user function PLSCALCINSS()
    local oDlg, oGet, cSalario := Space(20)
    local cNome := Space(40)

  // Cria diálogo
    DEFINE DIALOG oDlg TITLE "Exemplo TGet" FROM 180,180 TO 550,700 PIXEL
  // Ativa diálogo centralizado
  // Cria o Objeto tGet usando o comando @ .. GET
    @ 10,40 SAY "Nome" SIZE 100,20 OF oDlg PIXEL 
    @ 20,40 GET oGet VAR cNome SIZE 170,20 OF oDlg PIXEL VALID !empty(cNome)

    @ 50,40 SAY "Informe seu salario" SIZE 100,20 OF oDlg PIXEL 
    @ 60,40 GET oGet VAR cSalario SIZE 170,20 OF oDlg PIXEL VALID !empty(cSalario) 

    oTButton1 := TButton():New( 90, 040, "Calcular",oDlg,{||Calculo(cSalario, cNome)}, 080,025,,,.F.,.T.,.F.,,.F.,,,.F. ) 
    oTButton1:setcss("background: #02559B; color: #f2f2f2; font-weight: bold; font-size: 16px; border-radius: 10px")
    oTButton2 := TButton():New( 90, 130, "Fechar",oDlg,{||oDlg:End()}, 080,025,,,.F.,.T.,.F.,,.F.,,,.F. ) 
    oTButton2:setcss("background-color: #EF0102; color: #f2f2f2; font-weight: bold; font-size: 16px; border-radius: 10px")
    
    
   ACTIVATE DIALOG oDlg CENTERED
return

static function Calculo(cSalario, cNome)
    local nSalario := val(cSalario)
    local nAliquota := 0
    local nPrimeiraFaixa := 1212 * 0.075
    local nSegundaFaixa := (2427.35 - 1212) * 0.09 
    local nValorSalarioExcedido := 0
    local nTerceiraFaixa := (3641.03 - 2427.35) * 0.12
    local nQuartaFaixa := (7087.22 - 3641.03) * 0.14

    if nSalario <= 0
        alert("salario bruto informado <b>invalido</b>")
    else
        if nSalario <= 1212.00 
            nAliquota := nSalario * 0.075
        elseif nSalario <= 2427.35
            nValorSalarioExcedido := (nSalario - 1212.00) * 0.09
            nAliquota := nPrimeiraFaixa + nValorSalarioExcedido
        elseif nSalario <= 3641.03
            nValorSalarioExcedido := nSalario - 2427.35
            nTerceiraFaixa := (nSalario - 2427.35) * 0.12
            nAliquota := nPrimeiraFaixa + nSegundaFaixa + nTerceiraFaixa
        elseif nSalario <= 8000 .or. nSalario >= 8000
            nValorSalarioExcedido := nSalario - 3641.03
            nAliquota := nPrimeiraFaixa + nSegundaFaixa + nTerceiraFaixa + nQuartaFaixa
        endif
        
        message(nSalario, nAliquota, cNome)
    endif
        
return

static function message(nSalario, nAliquota, cNome) 
    fwalertsucess("<br>Nome: </br> " + cNome + BREAKLINE + "salario bruto informado " + Transform(nSalario, "@E R$999,999.99") + " reais" + BREAKLINE + decodeutf8("teto máximo de contribuição ao INSS ") +  Transform(nAliquota, "@E R$999,999.99") + " reais")
return