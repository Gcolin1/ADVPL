#INCLUDE 'protheus.ch'
#INCLUDE 'restful.ch'
#include "FWMVCDEF.ch"
 
wsRestFul calculoInss description "serviço para realizar cadastro do calculo de inss" format APLICATION_JSON
    WSDATA apiVersion as STRING OPTIONAL

    WSMETHOD POST incInss DESCRIPTION "API pra gerar inclusão dos calculos de inss";
    WSsyntax "{apiVersion}/inss";
    PATH "{apiVersion}/inss" PRODUCES APPLICATION_JSON

end wsRestFul

WSMETHOD POST incInss WSSERVICE calculoInss
    local cBody := ::getContent() 
    local oModel := FWLoadModel("PLTINSS")
    //instanciando novo objeto json
    local oJson := jsonObject():new()
    //convertendo de string para json
    oJson:fromJson(cBody)
    //verificando campo obrigatório


    //validando campos de nome e salario
    do case
        case !oJson:hasProperty("nome")
            ::setResponse('{"mensagem": "nome não infomado"}')
        case  !oJson:hasProperty("salario")
            ::setResponse('{"mensagem": "salario não infomado"}')  
        case   valType(oJson["salario"]) != "N"
            ::setResponse('{"mensagem": "Propriedade salário deve ser do tipo numérico"}')  
        case   valType(oJson["nome"]) != "C"
            ::setResponse('{"mensagem": "Propriedade nome deve ser do tipo caracter"}')  
        otherWise
            oModel:setOperation(3)
            oModel:activate()
            oModel:setValue("MasterZZ1", "ZZ1_NOME", oJson["nome"])
            oModel:setValue("MasterZZ1", "ZZ1_SALARI", oJson["salario"])
            if oModel:vldData()
                oModel:commitData()
                ::setResponse('{"mensagem": "Dados incluidos com sucesso"}')  
            else
                ::setResponse('{"mensagem": "falha ao gravar dados"}')  
            endif
    endcase

return .t.

