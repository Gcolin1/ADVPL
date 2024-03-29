#include 'protheus.ch'
#define BREAKLINE  chr(13) + chr(10)

//user indica que é uma função de usuario
user function Hello()
    ConOut("Hello world!")
    alert("AVISO")
return

user function Emprestimo()
    local nEmprestimo := val(fwInputbox("informe o valor do emprestimo"))
    local nIdade := val(fwInputbox("informe sua idade"))
    local nParcelas := val(fwInputbox("informe o numero de parcelas"))
    local nSalario := val(fwInputbox("informe seu salario"))
    local nPercentual := nSalario * 0.3
    local nValorParcela := nEmprestimo / nParcelas

    if nIdade < 18 .or. nIdade > 65 
        fwalertsucess("A pessoa que está solicitando emprestimo tem " + cValToChar(nIdade) + " anos de idade e tem o salario de " + cValToChar(nSalario) + " reais. o valor solicitado é de " + cValToChar(nEmprestimo) + " reais para ser pago em " + cValToChar(nParcelas) + " parcelas." + BREAKLINE + " O emprestimo foi reprovado: idade negada")

    elseif nParcelas < 3 .or. nParcelas > 24
        alert("A pessoa que está solicitando emprestimo tem " + cValToChar(nIdade) + " anos de idade e tem o salario de " + cValToChar(nSalario) + " reais. o valor solicitado é de " + cValToChar(nEmprestimo) + " reais para ser pago em " + cValToChar(nParcelas) + " parcelas." + BREAKLINE + " O emprestimo foi reprovado: numero de parcelas invalido")
    
    elseif nValorParcela > nPercentual 
        fwalertsucess("A pessoa que está solicitando emprestimo tem " + cValToChar(nIdade) + " anos de idade e tem o salario de " + cValToChar(nSalario) + " reais. o valor solicitado é de " + cValToChar(nEmprestimo) + " reais para ser pago em " + cValToChar(nParcelas) + " parcelas." + BREAKLINE + " O emprestimo foi reprovado: valor da parcela ultrapassa percentual")
    else 
        fwalertsucess("A pessoa que está solicitando emprestimo tem " + cValToChar(nIdade) + " anos de idade e tem o salario de " + cValToChar(nSalario) + " reais. o valor solicitado é de " + cValToChar(nEmprestimo) + " reais para ser pago em " + cValToChar(nParcelas) + " parcelas." + BREAKLINE + " O emprestimo foi aprovado")
    endif  
return