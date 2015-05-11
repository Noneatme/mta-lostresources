local Guivar = 0

local function createNeonGui()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	
	local Fenster = {}
	local Knopf = {}
	local Label = {}
	local Radio = {}

	local X, Y, Width, Height = getMiddleGuiPosition(320,233)
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Neonmenue",false)
	Label[1] = guiCreateLabel(12,22,337,39,"In this menu you can glue neon under your car..",false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Knopf[1] = guiCreateButton(12,191,95,32,"Save",false,Fenster[1])
	Knopf[2] = guiCreateButton(110,192,95,31,"Discard",false,Fenster[1])
	Label[2] = guiCreateLabel(15,62,73,17,"Color:",false,Fenster[1])
	guiSetFont(Label[2],"default-bold-small")
	Label[3] = guiCreateLabel(14,65,55,14,"___________",false,Fenster[1])
	guiLabelSetColor(Label[3],0, 255, 255)
	Radio[1] = guiCreateRadioButton(16,95,100,17,"Red",false,Fenster[1])
	guiSetFont(Radio[1],"default-bold-small")
	Radio[2] = guiCreateRadioButton(16,112,100,17,"Green",false,Fenster[1])
	guiSetFont(Radio[2],"default-bold-small")
	Radio[3] = guiCreateRadioButton(16,128,100,17,"Blue",false,Fenster[1])
	guiSetFont(Radio[3],"default-bold-small")
	Radio[4] = guiCreateRadioButton(16,144,100,17,"Yellow",false,Fenster[1])
	guiSetFont(Radio[4],"default-bold-small")
	Radio[5] = guiCreateRadioButton(16,161,100,17,"White",false,Fenster[1])
	guiRadioButtonSetSelected(Radio[5],true)
	guiSetFont(Radio[5],"default-bold-small")
	Knopf[3] = guiCreateButton(180,95,95,31,"Remove neon",false,Fenster[1])
	if(isPedInVehicle(gMe) == false) then
		guiSetEnabled(Knopf[3], false)
		guiSetEnabled(Knopf[1], false)
	end
	
	addEventHandler("onClientGUIClick", Knopf[3], function()
		triggerServerEvent("onMultistuntNeonRemove", gMe)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		local radio1, radio2, radio3, radio4, radio5 = guiRadioButtonGetSelected(Radio[1]), guiRadioButtonGetSelected(Radio[2]), guiRadioButtonGetSelected(Radio[3]), guiRadioButtonGetSelected(Radio[4]), guiRadioButtonGetSelected(Radio[5])
		local veh = getPedOccupiedVehicle(gMe)
		if not(veh) then return end
		local dis = getElementDistanceFromCentreOfMassToBaseOfModel(veh)
		if(radio1 == true) then
			triggerServerEvent("onMultistuntNeonSet", gMe, 1, dis)
		end
		if(radio2 == true) then
			triggerServerEvent("onMultistuntNeonSet", gMe, 2, dis)
		end
		if(radio3 == true) then
			triggerServerEvent("onMultistuntNeonSet", gMe, 3, dis)
		end
		if(radio4 == true) then
			triggerServerEvent("onMultistuntNeonSet", gMe, 4, dis)
		end
		if(radio5 == true) then
			triggerServerEvent("onMultistuntNeonSet", gMe, 5, dis)
		end
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[2], function()
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end, false)
end

addCommandHandler("neon", createNeonGui)