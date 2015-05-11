local Guivar = 0

function createVehicleGUIMenue(theVehicle)
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	local Fenster = {}
	local Knopf = {}
	local Label = {}
	local X, Y, Width, Height = getMiddleGuiPosition(394,136)
	
	local besitzer = getElementData(theVehicle, "mv.besitzer")
	if not(besitzer) then besitzer = "N/A" end
	local name = getVehicleName(theVehicle)
	local typ = getElementData(theVehicle, "mv.typ")
	if not(typ) then typ = "N/A" end
	local modelid = getVehicleModelFromName(name)
	local locked
	if(isVehicleLocked(theVehicle)) then locked = "Yes" else locked = "No" end
	
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Vehicle",false)
	Label[1] = guiCreateLabel(11,35,171,18,"Vehiclename: "..name,false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Label[2] = guiCreateLabel(11,53,171,18,"Owner: "..besitzer,false,Fenster[1])
	guiSetFont(Label[2],"default-bold-small")
	Label[3] = guiCreateLabel(6,17,377,14,"_______________________________________________________",false,Fenster[1])
	guiLabelSetColor(Label[3],0, 255, 0)
	guiSetFont(Label[3],"default-bold-small")
	Label[4] = guiCreateLabel(11,71,171,18,"Typ: "..typ,false,Fenster[1])
	guiSetFont(Label[4],"default-bold-small")
	Label[5] = guiCreateLabel(11,89,171,18,"ModelID: "..modelid,false,Fenster[1])
	guiSetFont(Label[5],"default-bold-small")
	Label[6] = guiCreateLabel(11,107,171,18,"Locked: "..locked,false,Fenster[1])
	guiSetFont(Label[6],"default-bold-small")
	Knopf[1] = guiCreateButton(279,95,104,30,"Close",false,Fenster[1])
	Knopf[2] = guiCreateButton(279,59,104,30,"Respawn",false,Fenster[1])
	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end, false)
end
addEvent("onMultistuntVehicleClick", true)
addEventHandler("onMultistuntVehicleClick", getRootElement(), function() if(getElementData(gMe, "guistate") == true) then return end createVehicleGUIMenue(source) end)