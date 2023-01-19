#include "protheus.ch"
#include "FWMVCDEF.ch"
#include "FWMBROWSE.ch"

user function PLTELINSS
    local oBrowse
    Private aRotina := MenuDef()
    oBrowse := FWMBrowse():New()
    oBrowse:setAlias("ZZ1")
    oBrowse:setDescription("Cadastro e calculos de inss")
    oBrowse:Activate()
    oBrowse:setMenuDef("PLTELINSS")
Return

static function MenuDef()
    local aRotina := {}
    ADD OPTION aRotina TITLE "Calculo de inss" ACTION "u_MSDialog"  OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.PLTINSS"  OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.PLTINSS"  OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.PLTINSS"  OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.PLTINSS"  OPERATION 4 ACCESS 0
return aRotina

static function ModelDef()
    local oModel
    local oStructZZ1 := FWFormStruct(1,"ZZ1")
    oModel := MPFormModel():new("ModelCalcInss")
    oModel:AddFields("MasterZZ1", nil, oStructZZ1)
    oModel:setDescription("calculo de inss")
    oModel:setPrimaryKey({})

return oModel

static function ViewDef()
    local oView
    local oStructZZ1 := FWFormStruct(2,"ZZ1")
    local oModel := FWLoadModel("PLTINSS")
    oView := FWFormView():new()
    oView:setModel(oModel)
    oView:AddField("ViewZZ1", oStructZZ1, "MasterZZ1")
    oView:CreateHorizontalBox("Box", 100)
    oView:setOwnerView("ViewZZ1", "Box")

return oView

