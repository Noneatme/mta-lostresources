local Guivar = 0
	
local Fenster = {}
local Knopf = {}
local Label = {}
local Grid = {}

	
archievements_table = {
	[1] = "Welcome!",
	[2] = "Noob Stunter",
	[3] = "Faster, please",
	[4] = "We have time",
	[5] = "Hospitalvisitor",
	[6] = "Businessman",
	[7] = "Own shelter",
	[8] = "GTFO",
	[9] = "Check the help",
	[10] = "Master of the air",
	[11] = "Highway to hell",
}

archievements_numbers = {
	["Welcome!"] = 1,
	["Noob Stunter"] = 2,
	["Faster, please"] = 3,
	["We have time"] = 4,
	["Hospitalvisitor"] = 5,
	["Businessman"] = 6,
	["Own shelter"] = 7,
	["GTFO"] = 8,
	["Check the help"] = 9,
	["Master of the air"] = 10,
	["Highway to hell"] = 11,
}

local archievements_beschreibung = {
	["Welcome!"] = "Visit our\nMultistunt-server.",
	["Noob Stunter"] = "Do your\nfirst stunt.",
	["Faster, please"] = "Finish a stunt\nunder 2 seconds.",
	["We have time"] = "Finish a stunt\nin over 4 minutes.",
	["Hospitalvisitor"] = "Die more than\n1500 times.",
	["Businessman"] = "Buy your own\nbusiness.",
	["Own shelter"] = "Buy your fist\nhouse.",
	["GTFO"] = "Get kicked by\nan admin.",
	["Check the help"] = "Use the\nhelpmenue.",
	["Master of the air"] = "Make it to\nthe top.",
	["Highway to hell"] = "Drive faster\nthan 500 km/h.",
}

archievements_belohnung = {
	[1] = 20,
	[2] = 5,
	[3] = 20,
	[4] = 25,
	[5] = 40,
	[6] = 25,
	[7] = 30,
	[8] = 10,
	[9] = 25,
	[10] = 20,
	[11] = 20,
}


local arch = {}
arch.state = false
local sx, sy = guiGetScreenSize()
arch.mx = 0
arch.goingin = true
arch.waittimer = false
arch.waitvar = 0
arch.auszeichnung = ""
arch.sound = nil

function showArchievement(name)
	if(isElement(arch.sound)) then destroyElement(arch.sound) end
	arch.sound = playSound("sounds/archievement_get.mp3", false)
	arch.state = true
	arch.mx = 0
	arch.goingin = false
	arch.waitvar = 0
	arch.auszeichnung = name
	if(isTimer(arch.waittimer)) then killTimer(arch.waittimer) end
	setTimer(function()
		arch.goingin = true
	end, 2000, 1)
	local archs = 0
	for i = 1, 11, 1 do
		local data = tonumber(getElementData(gMe, "msa."..i))
		if(data) and (data == 1) then
			archs = archs+1
		end
	end
	if(archs > 0) then
		triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 4)
	end
	if(archs > 2) then
		triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 5)
	end
	if(archs > 5) then
		triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 6)
	end
	if(archs > 9) then
		triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 7)
	end
	if(archs == 11) then
		triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 8)
	end
end

addEventHandler("onClientRender", getRootElement(), function()
	if(arch.state == true) then
		if(arch.mx < sx/2+100) then
			arch.mx = arch.mx+12
		else
			if(arch.waitvar == 1) then
				arch.mx = arch.mx+12
				if(arch.mx > sx+250) then
					 arch.state = false 
					 goingon = true
				end
			else
				if(isTimer(arch.waittimer)) then else
					arch.waitvar = 0
					arch.waittimer = setTimer(function() arch.waitvar = 1 end, 4000, 1)
				end
			end
		end
		dxDrawRectangle(sx-arch.mx, sy/2-sx/5, 300, 90, tocolor(0, 0, 0, 150))
		dxDrawImage(sx-arch.mx, sy/2-sx/5, 300, 90, "data/images/archievement/kasten.png")
		dxDrawImage(sx-arch.mx+20, sy/2-sx/5+10, 64, 64, "data/images/archievement/pokal.png")
		dxDrawText("Archievement get!", sx-arch.mx+100, sy/2-sx/5+10, sx-arch.mx, sy/2-sx/5, tocolor(255, 255, 255, 255), 1, "default-bold")
		dxDrawText(arch.auszeichnung, sx-arch.mx+330, sy/2-sx/5+45, sx-arch.mx, sy/2-sx/5, tocolor(255, 255, 255, 255), 1.15, "default-bold", "center")
	end
end)


local function createArchGui()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)

	local X, Y, Width, Height = getMiddleGuiPosition(442,233)
	Fenster[1] = guiCreateWindow(X, Y, Width, Height,"Archievements",false)
	Grid[1] = guiCreateGridList(9,21,300,203,false,Fenster[1])
	guiGridListSetSelectionMode(Grid[1],1)

	guiGridListAddColumn(Grid[1],"Name",0.6)

	guiGridListAddColumn(Grid[1],"Done",0.2)
	guiSetFont(Grid[1], "default-bold-small")
	Label[1] = guiCreateLabel(315,22,115,26,"Info:",false,Fenster[1])
	guiSetFont(Label[1],"default-bold-small")
	Label[2] = guiCreateLabel(314,25,88,16,"_________",false,Fenster[1])
	guiLabelSetColor(Label[2],0, 255, 255)
	Knopf[1] = guiCreateButton(317,189,110,31,"Close",false,Fenster[1])
	Label[3] = guiCreateLabel(315,57,119,123,"Description:\n-",false,Fenster[1])
	guiSetFont(Label[3],"default-bold-small")
	for i = 1, #archievements_table, 1 do
		local name = archievements_table[i]
		local row = guiGridListAddRow(Grid[1])
		guiGridListSetItemText(Grid[1], row, 1, name, false, false)
		guiGridListSetItemColor(Grid[1], row, 1, 155, 255, 0, 255)
		local sucess = getElementData(gMe, "msa."..archievements_numbers[archievements_table[i]])
		if(tonumber(sucess) == 1) then
			guiGridListSetItemText(Grid[1], row, 2, "Yes", false, false)
		else
			guiGridListSetItemText(Grid[1], row, 2, "No", false, false)
		end
	end
	addEventHandler("onClientGUIClick", Grid[1], function()
		local row = guiGridListGetItemText(Grid[1], guiGridListGetSelectedItem(Grid[1]), 1)
		if(row == "") then return end
		guiSetText(Label[3], "Description:\n\n"..archievements_beschreibung[row])
	end, false)	
	addEventHandler("onClientGUIClick", Knopf[1], function()
		destroyElement(Fenster[1])
		setGuiState(0)
		Guivar = 0
		showCursor(false)
	end, false)
end

bindKey("F3", "down", function()
	if(isPlayerEingeloggt(gMe) == false) then return end
	if(Guivar == 0) then 
		createArchGui()
	else
		destroyElement(Fenster[1])
		setGuiState(0)
		Guivar = 0
		showCursor(false)
	end
end)

-- ARCHIEVEMENTS CHECK --
addEvent("onMultistuntArchievementCheck", true)
addEventHandler("onMultistuntArchievementCheck", getRootElement(), function(int)
	if(int == 1) then
		if(getPlayerArchievement(gMe, 6) == 0) then
			givePlayerArchievement(gMe, 6)
			showArchievement(archievements_table[6])
			givePlayerItem(gMe, "ms.birnen", archievements_belohnung[6]) -- Biz 
		end
	elseif(int == 2) then
		if(getPlayerArchievement(gMe, 7) == 0) then
			givePlayerArchievement(gMe, 7)
			showArchievement(archievements_table[7])
			givePlayerItem(gMe, "ms.birnen", archievements_belohnung[7]) -- Biz 
		end
	elseif(int == 3) then
		if(getPlayerArchievement(gMe, 9) == 0) then
			givePlayerArchievement(gMe, 9)
			showArchievement(archievements_table[9])
			givePlayerItem(gMe, "ms.birnen", archievements_belohnung[9]) -- Hilfemenue
		end
	elseif(int == 4) then
		if(getPlayerArchievement(gMe, 10) == 0) then
			givePlayerArchievement(gMe, 10)
			showArchievement(archievements_table[10])
			givePlayerItem(gMe, "ms.birnen", archievements_belohnung[10]) -- Meister Luefte
		end
	elseif(int == 5) then
		if(getPlayerArchievement(gMe, 11) == 0) then
			givePlayerArchievement(gMe, 11)
			showArchievement(archievements_table[11])
			givePlayerItem(gMe, "ms.birnen", archievements_belohnung[11]) -- Speed
		end
	end
end)
addEventHandler ( "onClientPlayerSpawn", gMe, function()
	if(getPlayerArchievement(gMe, 1) == 0) then
		givePlayerArchievement(gMe, 1)
		showArchievement(archievements_table[1])
		givePlayerItem(gMe, "ms.birnen", archievements_belohnung[1]) -- Welcome 
	end
	if(tonumber(getElementData(gMe, "ms.tode")) > 1500) then
		givePlayerArchievement(gMe, 5)
		showArchievement(archievements_table[5])
		givePlayerItem(gMe, "ms.birnen", archievements_belohnung[5]) -- Krankenhausbesucher
	end
end)

addEvent("onMultistuntStuntFinish", true)
addEventHandler("onMultistuntStuntFinish", getRootElement(), function()
	if(getPlayerArchievement(gMe, 2) == 0) then
		givePlayerArchievement(gMe, 2)
		showArchievement(archievements_table[2])
		givePlayerItem(gMe, "ms.birnen", archievements_belohnung[2]) -- Noob Stunter
	end
	if(getPlayerArchievement(gMe, 3) == 0) then
		if(lastStuntTime) and (lastStuntTime < 2000) then
			givePlayerArchievement(gMe, 3)
			showArchievement(archievements_table[3])
			givePlayerItem(gMe, "ms.birnen", archievements_belohnung[3]) -- Gehts noch schneller
		end
	end
	if(lastStuntTime) and (lastStuntTime/10000 > 2) then
		givePlayerArchievement(gMe, 4)
		showArchievement(archievements_table[4])
		givePlayerItem(gMe, "ms.birnen", archievements_belohnung[4]) -- Noch vor Ostern, bitte
	end
end)