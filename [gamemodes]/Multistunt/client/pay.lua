local Guivar = 0

local Fenster = {}
local Knopf = {}
local Label = {}
local Edit = {}
local Grid = {}
local Bild = {}


local function reloadList()
		guiGridListClear(Grid[1])
		guiGridListClear(Grid[2])
		for index, player in pairs(getElementsByType("player")) do
			local row = guiGridListAddRow(Grid[2])
			guiGridListSetItemText(Grid[2], row, 1, getPlayerName(player), false, false)
		end
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, "Apples", false, false)
		guiGridListSetItemText(Grid[1], row, 2, getPlayerItem(gMe, "ms.aepfel"), false, false)
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, "Pears", false, false)
		guiGridListSetItemText(Grid[1], row, 2, getPlayerItem(gMe, "ms.birnen"), false, false)
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, "Bananas", false, false)
		guiGridListSetItemText(Grid[1], row, 2, getPlayerItem(gMe, "ms.bananen"), false, false)
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, "Cherrys", false, false)
		guiGridListSetItemText(Grid[1], row, 2, getPlayerItem(gMe, "ms.kirschen"), false, false)
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, "Money", false, false)
		guiGridListSetItemText(Grid[1], row, 2, getPlayerItem(gMe, "ms.money"), false, false)
end
	
function createPayGui()
	if(isLoggedIn(gMe) == false) then return end
	if(Guivar == 1) then
		destroyElement(Fenster[1])
		setElementData(gMe, "GUI", false)
		showCursor(false)
		Guivar = 0
	return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	setElementData(gMe, "GUI", true)
	showCursor(true)
	local X, Y, Width, Height = getMiddleGuiPosition(420,340)
	

	
	Fenster[1] = guiCreateWindow(X, Y, Width, Height,"Give items",false)
	Label[1] = guiCreateLabel(10,21,306,16,"Here you can give fruits to other players.",false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Grid[1] = guiCreateGridList(12,57,201,210,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],1)

	guiGridListAddColumn(Grid[1],"Item",0.45)

	guiGridListAddColumn(Grid[1],"How many",0.3)
	Grid[2] = guiCreateGridList(238,57,169,210,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[2],1)

	guiGridListAddColumn(Grid[2],"Player",0.6)
	Edit[1] = guiCreateEdit(282,272,120,21,"",false,Fenster[1])
	Bild[1] = guiCreateStaticImage(243,274,29,19,"data/images/search.png",false,Fenster[1])
	Label[2] = guiCreateLabel(15,271,58,18,"Value:",false,Fenster[1])
	guiSetFont(Label[2],"default-bold-small")
	Label[3] = guiCreateLabel(15,275,58,18,"________",false,Fenster[1])
	guiLabelSetColor(Label[3],0, 255, 255)
	guiSetFont(Label[3],"default-bold-small")
	Edit[2] = guiCreateEdit(13,294,84,23,"",false,Fenster[1])
	Knopf[1] = guiCreateButton(282,298,119,32,"Close",false,Fenster[1])
	Knopf[2] = guiCreateButton(102,293,91,24,"Give",false,Fenster[1])
	Label[4] = guiCreateLabel(13,37,396,16,"________________________________________________________",false,Fenster[1])
	guiLabelSetColor(Label[4],0, 255, 255)
	guiSetFont(Label[4],"default-bold-small")

	reloadList()
	addEventHandler ( "onClientGUIChanged", Edit[1], function()
		local text = guiGetText ( Edit[1] )
		if ( text == "" ) then
			reloadList()
		else
			guiGridListClear(Grid[2])
			for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
					local name = getPlayerName(player)
					guiGridListSetItemText(Grid[2],guiGridListAddRow ( Grid[2] ),1,name,false,false)
				end
			end
		end
	end)
	addEventHandler("onClientGUIClick", Knopf[2], function()
		local item, player, anzahl = guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1), guiGridListGetItemText(Grid[2], guiGridListGetSelectedItem(Grid[2]), 1), tonumber(guiGetText(Edit[2]))
		if(item == "") or (player == "") then outputChatBox("Du musst ein Item und ein Spieler auswaehlen!", 255, 0, 0) return end
		if not(anzahl) or (anzahl < 1) then outputChatBox("Ungueltige Anzahl!", 255, 0, 0) return end
		local data
		if(item == "Apples") then data = "ms.aepfel" end
		if(item == "Pears") then data = "ms.birnen" end
		if(item == "Bananas") then data = "ms.bananen" end
		if(item == "Cherrys") then data = "ms.kirschen" end
		if(item == "Money") then data = "ms.money" end
		local newdata = tonumber(getPlayerItem(gMe, data))
		if(newdata < anzahl) then outputChatBox("Du hast nicht genug "..item.."! Es fehlen dir "..newdata-anzahl.." "..item..".", 255, 0, 0) return end
		if not(getPlayerFromName(player)) then outputChatBox("Spieler ist nichtmehr Online.", 255, 0, 0) return end
		local player2 = getPlayerFromName(player)
		triggerServerEvent("onPlayerPay", gMe, player2, data, anzahl, item)
	end, false)
	addEventHandler("onClientGUIClick", Knopf[1], function()
		destroyElement(Fenster[1])
		setElementData(gMe, "GUI", false)
		showCursor(false)
		Guivar = 0
	end, false)
end
addEvent("onPayGridlistRefresh", true)
addEventHandler("onPayGridlistRefresh", getRootElement(), function()
	reloadList()
end)

addCommandHandler("pay", createPayGui)