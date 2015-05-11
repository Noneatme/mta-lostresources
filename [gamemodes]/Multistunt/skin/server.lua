
addEvent("onClothesShopStart", true)
addEventHandler("onClothesShopStart", getRootElement(),
function()
	setElementPosition(source, 211.20121765137, -4.8271918296814, 1001.2109375)
	setPedRotation(source, 90)
	setElementData(source, "atClothes", true)
	triggerClientEvent(source, "onClothesShopStartBack", source)
	setElementFrozen(source, true)
end)

addEvent("onClothesShopAbbrechen", true)
addEventHandler("onClothesShopAbbrechen", getRootElement(),
function()
	setElementData(source, "atClothes", false)
	setElementFrozen(source, false)
	setElementModel(source, tonumber(getElementData(source, "ms.skin")))
end)

addEvent("onClothesShopBuy", true)
addEventHandler("onClothesShopBuy", getRootElement(),
function(skin)
	setElementData(source, "ms.skin", skin)
	setElementData(source, "atClothes", false)
	setElementFrozen(source, false)
	setElementModel(source, getElementData(source, "ms.skin"))
end)