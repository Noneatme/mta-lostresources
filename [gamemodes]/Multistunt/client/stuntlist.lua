local Guivar = 0

local Fenster = {}
local Knopf = {}
local Label = {}
local Grid = {}
local Bild = {}

local stunts = {
	[1] = "Airport SF",
	[2] = "Kartbahn",
	[3] = "Skatepark",
	[4] = "Dunedrop",
	[5] = "Startower",
	[6] = "Hightjump",
	[7] = "Mt.Chilliad",
	[8] = "Airport LV 2",
	[9] = "Airport LS",
	[10] = "Waterpark",
	[11] = "Golden Gate SF",
	[12] = "Desert Rollercoaster",
	[13] = "Speedo 1",
	[14] = "Stuntpark LS",
	[15] = "Los Santos Stunts",
	[16] = "Skinshop",
	[17] = "Obstmarkt",
}
local stuntorte = {
	["Airport SF"] = "Der Spawnpunkt jedes Users. Hier \nkoennen mehr als 4 Stunts durchgefuehrt\nwerden.|airportSF.jpg",
	["Kartbahn"] = "Lust auf ne Runde Kartfahren?\nDann ist das hier genau das richtige \nfuer dich!|kartbahn.jpg",
	["Skatepark"] = "Falls du der Motorrad-\nLiebhaber bist, bist du hier richtig.|skatepark.jpg",
	["Dunedrop"] = "Runter und rauf,\nrunter und rauf.|dunedrop.jpg",
	["Startower"] = "Perfekt zum Fallschirm-\nspringen!|startower.jpg",
	["Hightjump"] = "Eine steile Strasse, die linear\nnach Unten verlaeuft.|hightjump.jpg",
	["Mt.Chilliad"] = "Viele Stunts auf dem Berg.|chilliad.jpg",
	["Airport LV 2"] = "Der verlassene Flughafen.|airportlv2.jpg",
	["Airport LS"] = "Man kann auch mit dem Auto\nfliegen!|airportls.jpg",
	["Waterpark"] = "Hier kannst du mit dem Boot\nviel Stunten.|waterpark.jpg",
	["Golden Gate SF"] = "Auf dem Wasser mit dem\nAuto? Kein Problem.|goldengatesf.jpg",
	["Obstmarkt"] = "Hier kannst du Obst\nin anderes Obst umtauschen.|obstmarkt.jpg",
	["Skinshop"] = "Here you can choose\nyour own skin.|skinshop.jpg",
	["Desert Rollercoaster"] = "A Nice Rollercoaster.|drollercoaster.jpg",
	["Speedo 1"] = "Here you can drive\nreally fast.|speedo1.jpg",
	["Stuntpark LS"] = "Some Stunts in\nLos Santos 1.|stuntparkls.jpg",
	["Los Santos Stunts"] = "Some Stunts in\nLos Santos 2.|lossantosstunts.jpg",
}
	
function createStuntListGui()
	if(isPlayerEingeloggt(gMe) == false) then return end
	if(Guivar == 1) then 
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	return end
	Guivar = 1
	setGuiState(1)
	showCursor(true)
	local X, Y, Width, Height = getMiddleGuiPosition(550,330)
	
	Fenster[1] = guiCreateWindow(X, Y, Width, Height,"Stuntliste",false)
	Label[1] = guiCreateLabel(10,24,123,15,"_________________",false,Fenster[1])
	guiLabelSetColor(Label[1],0, 255, 255)
	Label[2] = guiCreateLabel(16,43,436,17,"Stunts: Waehle ein Ort aus, und klicke auf 'OK', um zu diesem Ort zu gelangen.",false,Fenster[1])
	guiLabelSetColor(Label[2],255, 255, 255)
	guiSetFont(Label[2],"default-bold-small")
	Grid[1] = guiCreateGridList(14,68,219,256,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],1)

	guiGridListAddColumn(Grid[1],"Ort",0.75)
	Label[3] = guiCreateLabel(243,67,160,16,"Vorschau & Beschreibung:",false,Fenster[1])
	guiSetFont(Label[3],"default-bold-small")
	Bild[1] = guiCreateStaticImage(260,93,224,122,"data/images/dot_schwarz.png",false,Fenster[1])
	Label[4] = guiCreateLabel(247,225,237,46,"-",false,Fenster[1])
	guiSetFont(Label[4],"default-bold-small")
	Knopf[1] = guiCreateButton(247,285,128,35,"OK",false,Fenster[1])
	Knopf[2] = guiCreateButton(392,285,128,35,"Abbrechen",false,Fenster[1])
	Label[5] = guiCreateLabel(10,24,123,15,"_________________",false,Fenster[1])
	guiLabelSetColor(Label[5],0,255,255)
	Label[6] = guiCreateLabel(243,70,170,14,"_____________________________",false,Fenster[1])
	guiLabelSetColor(Label[6],0,255,255)
	for i = 1, #stunts, 1 do
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, stunts[i], false, false)
	end
	
	addEventHandler ( "onClientGUIClick", Knopf[1], 
	function()
		local ort = guiGridListGetItemText ( Grid[1], guiGridListGetSelectedItem ( Grid[1] ), 1 )
		if(ort == "") then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000Du musst ein Punkt auswaehlen!", 0, 0, 0, true) return end
		fadeCamera(false, 1.0)
		
		setTimer(triggerServerEvent, 1000, 1, "onMultistuntTeleport", gMe, ort)
		Guivar = 0
		destroyElement(Fenster[1])
		setGuiState(0)
		showCursor(false)
	end, false )
	
	
	addEventHandler ( "onClientGUIClick", Knopf[2], 
	function()
		Guivar = 0
		destroyElement(Fenster[1])
		setGuiState(0)
		showCursor(false)
	end, false )
	
	addEventHandler ( "onClientGUIClick", Grid[1], 
	function()
	local ort = guiGridListGetItemText ( Grid[1], guiGridListGetSelectedItem ( Grid[1] ), 1 )
	if(ort == " ") or (ort == "") then guiSetText(Label[4], "-") guiStaticImageLoadImage(Bild[1], "data/images/dot_schwarz.png") return end
		local beschreibung = gettok(stuntorte[ort], 1, "|")
		local pfad = gettok(stuntorte[ort], 2, "|")
		if(beschreibung) then guiSetText(Label[4], beschreibung) end
		if(fileExists("data/images/orte/"..pfad)) then guiStaticImageLoadImage(Bild[1], "data/images/orte/"..pfad) end
	end, false )
end

addCommandHandler("stunts", createStuntListGui)
addCommandHandler("teleports", createStuntListGui)
bindKey("F4", "down", createStuntListGui)
