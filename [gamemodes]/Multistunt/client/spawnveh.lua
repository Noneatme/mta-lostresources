local Guivar = 0

addEvent("onMultistunVehicleListRefresh", true)

local Fenster = {}
local Knopf = {}
local Label = {}
local Edit = {}
local Grid = {}
	
local disallowed = {
	[425] = true,
	[520] = true,
	[447] = true,
	[435] = true,
	[450] = true,
	[584] = true,
	[591] = true,
	[606] = true,
	[607] = true,
	[608] = true,
	[611] = true,
	[610] = true,
	[432] = true,
}
local function createVehGui()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)

	local X, Y, Width, Height = getMiddleGuiPosition(435,319)

	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Vehiclespawner",false)
	Grid[1] = guiCreateGridList(9,21,175,263,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],1)

	guiGridListAddColumn(Grid[1],"Vehicle",0.5)

	guiGridListAddColumn(Grid[1],"ID",0.2)
	for i = 0, 211, 1 do
		local vehid = 400+i
		local name = getVehicleNameFromModel(vehid)
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, name, false, false)
		guiGridListSetItemText(Grid[1], row, 2, vehid, false, false)
		if(disallowed[vehid]) and (disallowed[vehid] == true) then
			guiGridListSetItemColor(Grid[1], row, 1, 255, 0, 0, 255)
			guiGridListSetItemColor(Grid[1], row, 2, 255, 0, 0, 255)
		end
	end
	guiSetFont(Grid[1], "default-bold-small")
	Edit[1] = guiCreateEdit(11,286,171,24,"",false,Fenster[1])
	Knopf[1] = guiCreateButton(192,275,86,33,"Discard",false,Fenster[1])
	Label[1] = guiCreateLabel(193,28,120,20,"Your vehicles:",false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Label[2] = guiCreateLabel(191,32,148,20,"______________________",false,Fenster[1])
	guiLabelSetColor(Label[2],0, 255, 255)
	Label[3] = guiCreateLabel(192,65,149,19,"Vehicle 1: N/A",false,Fenster[1])
	guiSetFont(Label[3],"default-bold-small")
	Label[4] = guiCreateLabel(191,136,149,19,"Vehicle 2: N/A",false,Fenster[1])
	guiSetFont(Label[4],"default-bold-small")
	Knopf[2] = guiCreateButton(189,86,72,25,"Destroy",false,Fenster[1])
	Knopf[3] = guiCreateButton(270,87,72,25,"Call",false,Fenster[1])
	Knopf[4] = guiCreateButton(190,159,72,25,"Destroy",false,Fenster[1])
	Knopf[5] = guiCreateButton(270,159,72,25,"Call",false,Fenster[1])
	Knopf[6] = guiCreateButton(284,274,139,34,"Spawn vehicle",false,Fenster[1])
	Knopf[7] = guiCreateButton(189,192,160,28,"Vehiclesettings...",false,Fenster[1])
	addEventHandler("onClientGUIChanged",Edit[1], function() 
		local text = guiGetText ( source )
		if ( text == "" ) then
			guiGridListClear(Grid[1])
			for i = 0, 211, 1 do
				local vehid = 400+i
				local name = getVehicleNameFromModel(vehid)
				local row = guiGridListAddRow(Grid[1])
				guiGridListSetItemText(Grid[1], row, 1, name, false, false)
				guiGridListSetItemText(Grid[1], row, 2, vehid, false, false)
				if(disallowed[vehid]) and (disallowed[vehid] == true) then
					guiGridListSetItemColor(Grid[1], row, 1, 255, 0, 0, 255)
					guiGridListSetItemColor(Grid[1], row, 2, 255, 0, 0, 255)
				end
			end
			
		else
		guiGridListClear(Grid[1])
		for i = 0, 211, 1 do
			local vehid = 400+i
			local name = getVehicleNameFromModel(vehid)
			if ( string.find ( string.upper ( name ), string.upper ( text ), 1, true ) ) then
				local row = guiGridListAddRow(Grid[1])
				guiGridListSetItemText(Grid[1], row, 1, name, false, false)
				guiGridListSetItemText(Grid[1], row, 2, vehid, false, false)
				if(disallowed[vehid]) and (disallowed[vehid] == true) then
					guiGridListSetItemColor(Grid[1], row, 1, 255, 0, 0, 255)
					guiGridListSetItemColor(Grid[1], row, 2, 255, 0, 0, 255)
				end
			end
		end
	end
	end, false)	
	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[6], function()
		local veh = tonumber(guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 2))
		if not(veh) then sendInfoMessage("You need to choose a vehicle!", "red") return end
		if(disallowed[veh]) and (disallowed[veh] == true) then sendInfoMessage("This vehicle is not allowed.", "red") return end
		triggerServerEvent("onMultistuntVehicleSpawn", gMe, veh)
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[2], function() -- fahrzeug 1 loeschen
		if(isElement(getElementData(gMe, "msv.1"))) then
			triggerServerEvent("onMultistuntVehicleDelete", gMe, 1)
		else
			sendInfoMessage("You don't have a vehicle in Slot 1!", "red")
		end
	end, false)
	addEventHandler("onClientGUIClick", Knopf[3], function() -- fahrzeug 1 rufen
		if(isPedInVehicle(gMe)) then sendInfoMessage("Please exit your vehicle.", "red") return end
		if(isElement(getElementData(gMe, "msv.1"))) then
			triggerServerEvent("onMultistuntVehicleCall", gMe, 1)
			destroyElement(Fenster[1])
			Guivar = 0
			setGuiState(0)
			showCursor(false)
		else
			sendInfoMessage("You don't have a vehicle in Slot 1!", "red")
		end
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[5], function() -- fahrzeug 2 rufen
		if(isPedInVehicle(gMe)) then sendInfoMessage("Please exit your vehicle.", "red") return end
		if(isElement(getElementData(gMe, "msv.2"))) then
			triggerServerEvent("onMultistuntVehicleCall", gMe, 2)
			destroyElement(Fenster[1])
			Guivar = 0
			setGuiState(0)
			showCursor(false)
		else
			sendInfoMessage("You don't have a vehicle in Slot 2!", "red")
		end
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[4], function() -- fahrzeug 2 loeschen
		if(isElement(getElementData(gMe, "msv.2"))) then
			triggerServerEvent("onMultistuntVehicleDelete", gMe, 2)
		else
			sendInfoMessage("You don't have a vehicle in Slot 2!", "red")
		end
	end, false)
	
	if(isElement(getElementData(gMe, "msv.1"))) then
		guiSetText(Label[3], "Vehicle 1: "..getVehicleName(getElementData(gMe, "msv.1")))
	end
	
	if(isElement(getElementData(gMe, "msv.2"))) then
		guiSetText(Label[4], "Vehicle 2: "..getVehicleName(getElementData(gMe, "msv.2")))
	end
end


addEventHandler("onMultistuntVehicleListRefresh", getRootElement(), function()
	if(isElement(getElementData(gMe, "msv.1"))) then
		guiSetText(Label[3], "Vehicle 1: "..getVehicleName(getElementData(gMe, "msv.1")))
	else
		guiSetText(Label[3], "Vehicle 1: N/A")
	end
	
	if(isElement(getElementData(gMe, "msv.2"))) then
		guiSetText(Label[4], "Vehicle 2: "..getVehicleName(getElementData(gMe, "msv.2")))
	else
		guiSetText(Label[4], "Vehicle 1: N/A")
	end
end)

addCommandHandler("veh", function(cmd, id)
	if not(id) or (id == "") or (id == " ") then 
		createVehGui()
	return end
	if(tonumber(id) == nil) then
		id = getVehicleModelFromName(id)
		if not(id) then
			sendInfoMessage("Unknow Vehicle Name/ID!", "red")
		return end
	else
		if(tonumber(id) < 401) or (tonumber(id) > 610) then
			sendInfoMessage("Unknow Vehicle Name/ID!", "red")
		return end
	end
	if(disallowed[id]) and (disallowed[id] == true) then sendInfoMessage("This vehicle is not allowed.", "red") return end
	triggerServerEvent("onMultistuntVehicleSpawn", gMe, id)
end)