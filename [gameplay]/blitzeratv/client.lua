-- OBject: 1215
-- Blitzer script Copyright by MuLTi --
local Guivar = 0
local gMe = getLocalPlayer()
local Fenster = {}
local TabPanel = {}
local Tab = {}
local Knopf = {}
local Checkbox = {}
local Label = {}
local Edit = {}
local Grid = {}

local blitzerobjects = {}
local blip, bliptimer

local blightvar, blight = {}, {}

local function fillTheList()
	
	for index, obs in pairs(blitzerobjects) do
		obs = nil
	end
	if(guiGetSelectedTab(TabPanel[1]) == Tab[1]) then
		guiGridListClear(Grid[1])
	end
	for index, object in pairs(getElementsByType("object")) do
		if(tonumber(getElementData(object, "blitzer.id"))) then
			blitzerobjects[tonumber(getElementData(object, "blitzer.id"))] = object
			if(guiGetSelectedTab(TabPanel[1]) == Tab[1]) then
				local row = guiGridListAddRow(Grid[1])
				guiGridListSetItemText(Grid[1], row, 1, tonumber(getElementData(object, "blitzer.id")), false, false)
				local x, y, z = getElementPosition(object)
				local zone = getZoneName(x, y, z, false)
				guiGridListSetItemText(Grid[1], row, 2, zone, false, false)
			end
		end
	end
end

setTimer(function()
	fillTheList()
	for index, obs in pairs(blitzerobjects) do
		if (blightvar[obs] == nil) then 
			blightvar[obs] = false 
			local x, y, z = getElementPosition(obs)
			blight[obs] = createMarker(x, y, z+0.3, "corona", 1.0, 255, 0, 0, 150)
		end
		if(blightvar[obs] == false) then
			blightvar[obs] = true
			setMarkerColor(blight[obs], 255, 0, 0, 0)
		else
			blightvar[obs] = false
			setMarkerColor(blight[obs], 255, 0, 0, 150)
		end
	end
end, 500, 0)



local function createThisFuckingGui()
	guiSetInputMode("no_binds_when_editing")
	Fenster[1] = guiCreateWindow(744,425,464,307,"Blitzer Management",false)
	TabPanel[1] = guiCreateTabPanel(9,22,446,276,false,Fenster[1])
	Tab[1] = guiCreateTab("Neuen Blitzer erstellen",TabPanel[1])
	Label[1] = guiCreateLabel(246,10,128,15,"Blitzgeschwindigkeit:",false,Tab[1])
	guiSetFont(Label[1],"default-bold-small")
	Label[2] = guiCreateLabel(244,13,61,15,"________",false,Tab[1])
	guiLabelSetColor(Label[2],0, 255, 0)
	Edit[1] = guiCreateEdit(14,136,55,22,"",false,Tab[1])
	guiEditSetReadOnly(Edit[1],true)
	Edit[2] = guiCreateEdit(72,136,55,22,"",false,Tab[1])
	guiEditSetReadOnly(Edit[2],true)
	Edit[3] = guiCreateEdit(129,136,55,22,"",false,Tab[1])
	guiEditSetReadOnly(Edit[3],true)
	Knopf[1] = guiCreateButton(13,165,124,26,"Meine Position",false,Tab[1])
	Knopf[2] = guiCreateButton(14,66,124,26,"Meine Position",false,Tab[1])
	Label[3] = guiCreateLabel(19,9,128,15,"Blitzerobjekt:",false,Tab[1])
	guiSetFont(Label[3],"default-bold-small")
	Label[4] = guiCreateLabel(17,12,61,15,"________",false,Tab[1])
	guiLabelSetColor(Label[4],0,255,0)
	Edit[4] = guiCreateEdit(15,37,55,22,"",false,Tab[1])
	guiEditSetReadOnly(Edit[4],true)
	Edit[5] = guiCreateEdit(73,37,55,22,"",false,Tab[1])
	guiEditSetReadOnly(Edit[5],true)
	Edit[6] = guiCreateEdit(130,37,55,22,"",false,Tab[1])
	guiEditSetReadOnly(Edit[6],true)
	Label[5] = guiCreateLabel(18,108,128,15,"Blitzposition:",false,Tab[1])
	guiSetFont(Label[5],"default-bold-small")
	Label[6] = guiCreateLabel(16,111,61,15,"________",false,Tab[1])
	guiLabelSetColor(Label[6],0,255,0)
	Edit[7] = guiCreateEdit(246,35,123,23,"",false,Tab[1])
	Knopf[3] = guiCreateButton(165,209,128,30,"Blitzer erstellen",false,Tab[1])
	Knopf[4] = guiCreateButton(299,209,128,30,"Schliessen",false,Tab[1])
	Tab[2] = guiCreateTab("Vorhandene Bearbeiten",TabPanel[1])
	Grid[1] = guiCreateGridList(6,4,172,241,false,Tab[2])
	guiGridListSetSelectionMode(Grid[1],1)

	guiGridListAddColumn(Grid[1],"ID",0.2)

	guiGridListAddColumn(Grid[1],"Standort",0.5)
	guiSetFont(Grid[1], "default-bold-small")
	
	-- Fill this fucking list --
	fillTheList()
	Label[7] = guiCreateLabel(187,34,191,19,"Maximale Geschwindkeit:",false,Tab[2])
	guiSetFont(Label[7],"default-bold-small")
	Edit[8] = guiCreateEdit(337,33,65,20,"",false,Tab[2])
	Knopf[5] = guiCreateButton(183,205,112,33,"Uebernehmen",false,Tab[2])
	Knopf[6] = guiCreateButton(298,205,112,33,"Blitzer loeschen",false,Tab[2])
	Checkbox[1] = guiCreateCheckBox(186,167,107,21,"Bestaetigung",false,false,Tab[2])
	guiCheckBoxSetSelected(Checkbox[1],true)
	guiSetFont(Checkbox[1],"default-bold-small")
	guiSetVisible(Fenster[1], false)
	-- Koordinaten --
	addEventHandler("onClientGUIClick", Knopf[1], function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(Edit[1], x)
		guiSetText(Edit[2], y)
		guiSetText(Edit[3], z)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[2], function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(Edit[4], x)
		guiSetText(Edit[5], y)
		guiSetText(Edit[6], z)
	end, false)		
	
	local function LOL(string)
		if(string ~= "") and (tonumber(string) ~= nil) then 
			return true
		else 
			return false
		end
	end
	-- Gridliste --
	addEventHandler("onClientGUIClick",	Grid[1], function()
		local id = tonumber(guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1))
		if(id) then
			local object = blitzerobjects[id]
			if(object) then
				local x, y, z = getElementPosition(object)
				if(isElement(blip)) then destroyElement(blip) end
				if(isTimer(bliptimer)) then killTimer(bliptimer) end
				blip = createBlip(x, y, z, 0, 2, 0, 255, 0, 200, 0, 99999.0)
				bliptimer = setTimer(function() if(isElement(blip)) then destroyElement(blip) end end, 1000, 1)
				guiSetText(Edit[8], getElementData(object, "blitzer.maxspeed"))
			end
		end
	end, false)		
	-- Uebernehmen --
	addEventHandler("onClientGUIClick", Knopf[5], function()
		local id = tonumber(guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1))
		if not(id) then return end
		local object = blitzerobjects[id]
		if(object) then
			local speed = tonumber(guiGetText(Edit[8]))
			setElementData(object, "blitzer.maxspeed", speed)
			setElementData(getElementData(object, "blitzer.col"), "blitzer.maxspeed", speed)
			triggerServerEvent("onBlitzerSpeedSet", gMe, id, speed)
		end
	end, false)		
	-- Blitzer loeschen --
	addEventHandler("onClientGUIClick", Knopf[6], function()
		local id = tonumber(guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1))
		if not(id) then return end
		setElementData(getElementData(blitzerobjects[id], "blitzer.col"), "enabled", false)
		triggerServerEvent("onBlitzerDelete", gMe, id, id)
		Guivar = 0
		guiSetVisible(Fenster[1], false)
		showCursor(false)
	end, false)
	addEventHandler("onClientGUIClick", Knopf[2], function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(Edit[4], x)
		guiSetText(Edit[5], y)
		guiSetText(Edit[6], z)
	end, false)		
	
	-- Blitzer erstellen --
	addEventHandler("onClientGUIClick", Knopf[3], function()

		local x1, y1, z1, x2, y2, z2, speed = guiGetText(Edit[1]), guiGetText(Edit[2]), guiGetText(Edit[3]), guiGetText(Edit[4]), guiGetText(Edit[5]), guiGetText(Edit[6]), guiGetText(Edit[7])
		if(LOL(x1)) and (LOL(y1)) and (LOL(z1)) and (LOL(x2)) and (LOL(y2)) and (LOL(z2)) and (LOL(speed)) then
			triggerServerEvent("onBlitzerCreate", gMe, x1, y1, z1, x2, y2, z2, speed)
			Guivar = 0
			guiSetVisible(Fenster[1], false)
			showCursor(false)
		else
			outputChatBox("Ungueltige Angabe!", 255, 0, 0)
		end
	end, false)
	-- Schliessen -- 
	addEventHandler("onClientGUIClick", Knopf[4], function()
		Guivar = 0
		guiSetVisible(Fenster[1], false)
		showCursor(false)
	end, false)
	
end

addEventHandler("onClientResourceStart", getResourceRootElement(), createThisFuckingGui)


-- Command --
addEvent("onBlitzerCommand", true)
addEventHandler("onBlitzerCommand", getRootElement(), function()
	if(Guivar == 1) then return end
	fillTheList()
	Guivar = 1
	guiSetVisible(Fenster[1], true)
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")
end)
