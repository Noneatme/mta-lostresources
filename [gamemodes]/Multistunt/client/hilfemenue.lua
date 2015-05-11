local Guivar = 0

local Fenster = {}
local TabPanel = {}
local Tab = {}
local Label = {}
local Grid = {}

local hilfethemen = {
	[1] = "Informations",
	[2] = "Rules",
	[3] = "Stunts",
	[4] = "Fruits",
	[5] = "FAQ",
	[6] = "Commands",
	[7] = "Updates",
	[8] = "Bugs",
}

local hilfetext = {
	["Informations"] = "Welcome on Multistunt!\nMultistunt was made by MuLTi, and the gamemode is selfmade.\n\n~4 Maps are downloaded from the internet.\nIcons from www.iconfinder.com\nSounds from www.freesound.org\nUZI textur and .dff data from TheLozza\nDetail-Shader from ?(Wiki)\nThe flying(Superman) resource is made by Alberto Alonso\n(ryden).",
	["Rules"] = "1. Do not be annoying to other players.\n2. Do not insult other players.\n3. Do not use any kinds of cheats.\n4. Respect other people, how you want to be respected.\nDo not create more than 1. Account(For 1 person).\n\nPlease note: An admin can always change the rules.",
	["Stunts"] = "Here are many stunts, which can be executed.\nYou can start a stunt with the right vehicle,\nand finish him, if you drive to the finish.\nThe reward are fruits.\nFruits can be used to buy houses\nor business.\n\nSome stunts you can teleport to are very bad and not so good.\nThis is my mistake, because I copied the objects\nfrom my old gamemode into this one,\nbecause I'm too lazy to map more stunts.\nIf you have good stunt maps, please\ncontact us and we give you some special things.",
	["Fruits"] = "The currency here are fruits.\nThere are 4 different sorts:\nApples, Pears, Bananas and Cherrys.\nCherrys are the valuablest, then bananas,\npears and apples.\nYou can buy things from fruits, like\nHouses or business.\nYou can exchange fruits in the fruitmarket.",
	["FAQ"] = "How do I get fruits?\nYou get fruits, if you play active on this server,\nand do some stunts. You can also get some fruits from\nother players.",
	["Commands"] = "Important commands:\n\n'F4' or /stunts or /teleports -> Opens the teleport-list\nF1 -> The Usermenue\nF3 -> Archievement-menue\n/wallride -> enables/disables wallride\n/neon -> Opens the neon-menue\n/detail -> enables/disables the detail-shader\n/fly -> Let you fly",
	["Updates"] = "Multistunt is in full development.\nTo see updates, upcoming changes and other things,\nfollow @MrMultivan on Twitter.",
	["Bugs"] = "If you see a bug, please contact a admin,\nto report the bug.\nPlease note: bugusing is not allowed.\nYou can see the rules by clicking on 'Rules'.",
}
--[[
local hilfetext = {
	["Informations"] = "Willkommen auf Multistunt!\nMultistunt wurde von MuLTi gescriptet. Es ist ein Selfmade, \naber ein paar Funktionen\ndie es schon gibt, wurden uebernommen.\n\nEtwa 4 Maps stammen von einem gedownloadeten Mappack.\nIcons von www.iconfinder.com\nSound von www.freesound.org\nUZI Textur und .dff Datei von TheLozza\nDetail-Shader von ?(Wiki)",
	["Stunts"] = "Auf dem Server gibt es verschiedene Stunts, die man \nausfuehren kann.\nMit dem richtigen Fahrzeug kann man ein Stunt starten, \nund ihn Beenden, indem\nman sich in das Ziel begibt.\nAls Belohnung bekommt man dann Obst, \nwas die Waehrung ist.\nFuer Obst kann man sich Spaeter \nFahrzeuge, Haeuser oder Gebaeude kaufen.",
	["Fruits"] = "Die Waehrung auf Multistunt ist Obst. \nEs gibt 4 verschiedene Arten:\nAepfel, Birnen, Bananen und Kirschen.\nKirschen sind die Wertvollsten, darunter Banenen, \nBirnen und Aepfel.\nDu kannst dir von Obst Sachen kaufen, \nwie z.b. Autos oder Haeuser.\nAuf dem Flohmarkt kannst du Obst auch umtauschen, \nin ein Wertvolleres Obst.",
	["FAQ"] = "Wie verdiene ich Obst?\nIndem du auf diesem Server aktiv spielst, \nund Stunts erledigst. Du kannst auch\nvon anderen Spielern Obst bekommen.",
	["Commands"] = "Wichtige Befehle:\n\nF1 -> Oeffnet das Usermenue\nF3 -> Oeffnet das Archievement-Menue\n/wallride -> Aktiviert das an der Wand fahren\n/neon -> Erstellt das Neon-Menue\n/detail -> Aktiviert/Deaktiviert den Detail-Shader",
}
--]]

local function createHelpmenue()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	showCursor(true)
	local X, Y, Width, Height = getMiddleGuiPosition(529,339)
	
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Hilfemenue",false)
	Grid[1] = guiCreateGridList(10,24,135,305,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],2)

	guiGridListAddColumn(Grid[1],"Hilfethema",0.7)
	TabPanel[1] = guiCreateTabPanel(153,26,366,300,false,Fenster[1])
	Tab[1] = guiCreateTab("Informationstext",TabPanel[1])
	Label[1] = guiCreateLabel(7,5,356,288,"Welcome in the helpmenu!\nClick on a topic, to see the description.",false,Tab[1])
	guiSetFont(Label[1],"default-bold-small")
	addEventHandler("onClientGUIClick", Grid[1], function()
		local row = guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1)
		if not(row) or (row == "") or (row == " ") then return end
		if not(hilfetext[row]) then return end
		guiSetText(Label[1], hilfetext[row])
	end, false)
	for i = 1, #hilfethemen, 1 do
		local row = guiGridListAddRow(Grid[1])
		
		guiGridListSetItemText(Grid[1], row, 1, hilfethemen[i], false, false)
	end
end

local function toggleHelpmenue()
	if(isPlayerEingeloggt(gMe) == false) then return end
	if(Guivar == 0) then
		createHelpmenue()
		triggerEvent("onMultistuntArchievementCheck", gMe, 3) -- Archievement
	else
		destroyElement(Fenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end
end

bindKey("F9", "down", toggleHelpmenue)