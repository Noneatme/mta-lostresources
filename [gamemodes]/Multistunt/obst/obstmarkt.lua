local Marker = createMarker(1027.1708984375, -1907.6433105469, 11.659073638916, "cylinder", 1.5, 0, 255, 0, 200)
local Guivar = 0


local function createObstMenue()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	
	local Fenster = {}
	local Knopf = {}
	local Label = {}
	local Edit = {}
	local Grid = {}

	local X, Y, Width, Height = getMiddleGuiPosition(410,314)
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Obstmarkt",false)
	Label[1] = guiCreateLabel(11,20,337,39,"Willkommen im Obstmarkt!\nHier kannst du Obst in anderes Obst umtauschen.",false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Label[2] = guiCreateLabel(170,69,59,18,"Anzahl:",false,Fenster[1])
	guiSetFont(Label[2],"default-bold-small")
	Edit[1] = guiCreateEdit(169,88,75,28,"",false,Fenster[1])
	Knopf[1] = guiCreateButton(350,23,51,30,"[X]",false,Fenster[1])
	Grid[1] = guiCreateGridList(12,66,150,234,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],2)

	guiGridListAddColumn(Grid[1],"Obst",0.4)

	guiGridListAddColumn(Grid[1],"Vorhanden",0.2)
	Grid[2] = guiCreateGridList(252,65,145,234,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[2],2)

	guiGridListAddColumn(Grid[2],"Obst",0.6)
	Label[3] = guiCreateLabel(281,-117,46,29,"",false,Fenster[1])
	Knopf[2] = guiCreateButton(168,137,74,28,"|>>>>>|",false,Fenster[1])
	Knopf[3] = guiCreateButton(169,174,74,28,"|<<<<<|",false,Fenster[1])
	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end)
end



addEventHandler("onClientMarkerHit", Marker, function(hitElement)
	if(hitElement == gMe) then
		if(Guivar == 1) then return end
		createObstMenue()
	end
end)