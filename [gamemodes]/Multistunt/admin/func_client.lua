local ob, ob2
local wepcheck
local rocketfarbe = "gruen"
local Guivar = 0
local Guivar2 = 0
local AMemo2
local AFenster2
local times = {
	[1] = "Appletime",
	[2] = "Peartime",
	[3] = "Bananatime",
	[4] = "Cherrytime",
	[5] = "Grenade Kill Time",
	[6] = "Minigun Kill Time",
	[7] = "Raketen Kill Time",
	[8] = "Raining Vehicles",
	[9] = "Happy Hour",
}

addEvent("onMultistuntAdminpanelPlayerdataBack", true)
addEvent("onMultistuntAdminpanelBansGetBack", true)
addEvent("onMultistuntTimeStart", true)
addEvent("onMultistuntAdminpanelLogGetBack", true)
addEvent("onMultistuntAdminpanelReportsBack", true)
addEvent("onMultistuntAdminpanelReportInfoBack", true)

-- Times --

local timevar = {}
timevar.enabled = false
timevar.timer = false
timevar.size = 0
timevar.thetime = 0
timevar.id = 0

local function getMSTimeColor()
	if(timevar.id == 1) then return 255, 100, 100 end
	if(timevar.id == 2) then return 200, 200, 0 end
	if(timevar.id == 3) then return 255, 255, 0 end
	if(timevar.id == 4) then return 255, 50, 50 end
	return 255, 255, 255
end

addEventHandler("onMultistuntTimeStart", getRootElement(), function(thetime, id)
	if(isTimer(timevar.timer)) then killTimer(timevar.timer) end
	timevar.enabled = true
	timevar.thetime = thetime
	timevar.size = 1
	timevar.id = id
	timevar.timer = setTimer(function() timevar.enabled = false timevar.size = 0 end, 2500, 1)
end)

addEventHandler("onClientRender", getRootElement(), function()
	local sx, sy = guiGetScreenSize()
	if(timevar.enabled == true) then
		timevar.size = timevar.size+0.005
		local r, g, b = getMSTimeColor(timevar.id)
		dxDrawText(timevar.thetime, sx/2-sx/10, sy/2-sy/3.5, sx, sy, tocolor(r, g, b, 200), timevar.size, dxCreateFont("data/fonts/berlin.TTF", 20))	
	end
end)

addEventHandler("onClientPlayerWeaponSwitch", getRootElement(), function(prev, cur)
	if(cur == 2) and (getPedWeapon(gMe, cur) == 22) then
		if(getElementData(gMe, "msa.leuchtrakete") == true) then
			--outputChatBox("Test!")
			local x, y, z = getPedWeaponMuzzlePosition(gMe)
			local x2, y2, z2 = getPedTargetEnd(gMe)
			ob, ob2 = createObject(1337, x, y, z), createObject(1337, x2, y2, z)
			setElementCollisionsEnabled(ob, false)
			setElementCollisionsEnabled(ob2, false)
			setElementAlpha(ob, 1)
			setElementAlpha(ob2, 1)
			wepcheck = true
		end
	else
		if(wepcheck == true) then
			--outputChatBox("Test2")
			destroyElement(ob)
			destroyElement(ob2)
			wepcheck = false
		end
	end	
end)
addCommandHandler("rocketfarbe", function(cmd, farbe)
	rocketfarbe = tostring(farbe)
	outputChatBox("Farbe geaendert!", 0, 255, 0)
end)
setTimer(function()
	if(wepcheck == true) then
		local x, y, z = getPedWeaponMuzzlePosition(gMe)
		local x2, y2, z2 = getPedTargetEnd(gMe)
		setElementPosition(ob, x, y, z)
		setElementPosition(ob2, x2, y2, z2)
		wepcheck = true
	end
end, 50, 0)


addEventHandler ( "onClientPlayerWeaponFire", getLocalPlayer(), function(weapon, ammo, ammoinclip, hitX, hitY, hitZ, hitElement)
	if(weapon == 22) and (wepcheck == true) then
		local x, y, z = getElementPosition(ob)
		local x2, y2, z2 = getElementPosition(ob2)
		local veh = createVehicle(594, x, y, z)
		setVehicleGravityPoint(veh, x2, y2, z2, 50)
		setTimer(function()
			local vx, vy, vz = getElementVelocity(veh)
			triggerServerEvent("onMultistuntAdminRocketFire", gMe, x, y, z, vx, vy, vz, rocketfarbe)
			destroyElement(veh)
		end, 50, 1)
	end
	if(weapon == 28) and (getElementData(gMe, "msa.uzi") == true) then
		if (hitElement) then
			triggerServerEvent("onMultistuntAdminUZIFire", gMe, hitElement)
		end
	end
	if(hitX) and (hitY) and (hitZ) then
		if(weapon == 31) and (getElementData(gMe, "msa.rocketdrop") == true) then
			triggerServerEvent("onMultistuntAdminRocketDrop", gMe, hitX, hitY, hitZ)
		end
	end
end)
-- Adminpanel --

local AFenster = {}
local ATabPanel = {}
local ATab = {}
local AKnopf = {}
local ALabel = {}
local AEdit = {}
local ARadio = {}
local AGrid = {}
local ACheckbox = {}
	
local function createAdminpanel()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	


	AFenster[1] = guiCreateWindow(656,438,585,352,"Adminpanel",false)
	ATabPanel[1] = guiCreateTabPanel(9,21,567,322,false,AFenster[1])
	-- TAB 1 --
	ATab[1] = guiCreateTab("General",ATabPanel[1])
	AGrid[1] = guiCreateGridList(6,2,135,264,false,ATab[1])
	guiGridListSetSelectionMode(AGrid[1],2)

	guiGridListAddColumn(AGrid[1],"Spieler",0.7)
	for index, player in pairs(getElementsByType("player")) do
		guiGridListSetItemText(AGrid[1], guiGridListAddRow(AGrid[1]), 1, getPlayerName(player), false, false)
	end
	AEdit[1] = guiCreateEdit(6,269,133,20,"",false,ATab[1]) -- Suche
	AEdit[2] = guiCreateEdit(187,5,189,28,"",false,ATab[1])-- grund
	ALabel[1] = guiCreateLabel(145,11,37,17,"Reason:",false,ATab[1])
	guiSetFont(ALabel[1],"default-bold-small")
	ALabel[2] = guiCreateLabel(380,10,37,17,"Time:",false,ATab[1])
	guiSetFont(ALabel[2],"default-bold-small")
	AEdit[3] = guiCreateEdit(415,5,100,27,"",false,ATab[1]) -- Zeit
	ALabel[3] = guiCreateLabel(518,11,47,15,"Hours",false,ATab[1])
	guiSetFont(ALabel[3],"default-bold-small")
	AKnopf[1] = guiCreateButton(148,76,118,42,"Kick",false,ATab[1])
	AKnopf[2] = guiCreateButton(269,75,118,42,"Ban perm.",false,ATab[1])
	AKnopf[3] = guiCreateButton(389,75,118,42,"Ban",false,ATab[1])
	ALabel[4] = guiCreateLabel(147,38,37,17,"Value:",false,ATab[1])
	guiSetFont(ALabel[4],"default-bold-small")
	AEdit[4] = guiCreateEdit(187,35,100,27,"",false,ATab[1]) -- Wert
	AKnopf[4] = guiCreateButton(148,120,100,37,"Mute",false,ATab[1])
	AKnopf[5] = guiCreateButton(251,120,100,37,"(un-)Freeze",false,ATab[1])
	AKnopf[6] = guiCreateButton(354,121,100,37,"Kill",false,ATab[1])
	AKnopf[7] = guiCreateButton(457,121,100,37,"Give vehicle",false,ATab[1])
	AKnopf[8] = guiCreateButton(147,158,100,37,"Give weapon",false,ATab[1])
	AKnopf[9] = guiCreateButton(251,159,100,37,"Set adminlevel",false,ATab[1])
	AKnopf[10] = guiCreateButton(456,161,100,37,"Set fruits",false,ATab[1])
	AKnopf[11] = guiCreateButton(456,202,100,37,"Give fruits",false,ATab[1])
	ARadio[1] = guiCreateRadioButton(355,158,55,15,"Apples",false,ATab[1])
	ARadio[2] = guiCreateRadioButton(355,174,55,15,"Pears",false,ATab[1])
	ARadio[3] = guiCreateRadioButton(355,191,71,14,"Bananas",false,ATab[1])
	ARadio[4] = guiCreateRadioButton(354,205,71,14,"Cherrys",false,ATab[1])
	guiRadioButtonSetSelected(ARadio[4],true)
	AKnopf[12] = guiCreateButton(146,197,100,37,"Explode",false,ATab[1])
	AKnopf[13] = guiCreateButton(249,197,100,37,"Slap",false,ATab[1])
	AKnopf[14] = guiCreateButton(146,236,100,37,"Warp to player",false,ATab[1])
	AKnopf[15] = guiCreateButton(250,236,100,37,"Warp player to you",false,ATab[1])
	AKnopf[15.5] = guiCreateButton(352,236,100,37,"Set Team",false,ATab[1])
	local function getGrund()
		local grund = guiGetText(AEdit[2])
		if(grund == "") or (grund == " ") then return false end
		return grund
	end
	local function getZeit()
		local text = guiGetText(AEdit[3])
		if(text == "") or (text == " ") then return false end
		return text
	end
	local function getWert()
		local text = guiGetText(AEdit[4])
		if(text == "") or (text == " ") then return false end
		return text
	end
	local function getSelectedUser()
		local user = guiGridListGetItemText(AGrid[1], guiGridListGetSelectedItem(AGrid[1]), 1)
		if(user == "") or (user == " ") then return false end
		return user
	end
	-- Suche --
	addEventHandler("onClientGUIChanged",AEdit[1], function() 
		local text = guiGetText ( source )
		if ( text == "" ) then
			guiGridListClear(AGrid[1])
			for index,spieler in pairs ( getElementsByType("player") ) do
				local name = getPlayerName(spieler)
				guiGridListSetItemText(AGrid[1],guiGridListAddRow ( AGrid[1] ),1,name,false,false)
			end
		else
		guiGridListClear(AGrid[1])
		for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
						local name = getPlayerName(player)
						guiGridListSetItemText(AGrid[1],guiGridListAddRow ( AGrid[1] ),1,name,false,false)
				end
			end
		end
	end, false)	
	
	addEventHandler("onClientGUIClick",AKnopf[15], function() -- Zu Poerten
		local user = getSelectedUser()
		if(user == false) then return end
		triggerServerEvent("onMultistuntAdminpanelPorthere", gMe, getPlayerFromName(user))
	end, false)	
	addEventHandler("onClientGUIClick",AKnopf[15.5], function() -- Team Setzen
		local user = getSelectedUser()
		local wert = getWert()
		if(user == false) then return end
		if(wert == "") then return end
		triggerServerEvent("onMultistuntAdminpanelSetTeam", gMe, getPlayerFromName(user), wert)
	end, false)	
	addEventHandler("onClientGUIClick",AKnopf[14], function() -- Zu Poerten
		local user = getSelectedUser()
		if(user == false) then return end
		triggerServerEvent("onMultistuntAdminpanelPort", gMe, getPlayerFromName(user))
	end, false)	
	addEventHandler("onClientGUIClick",AKnopf[13], function() -- Slap
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		triggerServerEvent("onMultistuntAdminpanelSlap", gMe, getPlayerFromName(user), grund)
	end, false)	
	addEventHandler("onClientGUIClick",AKnopf[12], function() -- Explodieren
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		triggerServerEvent("onMultistuntAdminpanelExplode", gMe, getPlayerFromName(user), grund)
	end, false)
	
	addEventHandler("onClientGUIClick",AKnopf[11], function() -- Obst geben
		local user = getSelectedUser()
		if(user == false) then return end
		local wert = tonumber(getWert())
		if not(wert) then return end
		local aepfel, birnen, bananen, kirschen = guiRadioButtonGetSelected(ARadio[1]), guiRadioButtonGetSelected(ARadio[2]), guiRadioButtonGetSelected(ARadio[3]), guiRadioButtonGetSelected(ARadio[4])
		local obst = 0
		if(aepfel == true) then obst = 1 end
		if(birnen == true) then obst = 2 end
		if(bananen == true) then obst = 3 end
		if(kirschen == true) then obst = 4 end
		triggerServerEvent("onMultistuntAdminpanelObstgeben", gMe, getPlayerFromName(user), wert, obst)
	end, false)
	
	addEventHandler("onClientGUIClick",AKnopf[10], function() -- Obst setzen
		local user = getSelectedUser()
		if(user == false) then return end
		local wert = tonumber(getWert())
		if not(wert) then return end
		local aepfel, birnen, bananen, kirschen = guiRadioButtonGetSelected(ARadio[1]), guiRadioButtonGetSelected(ARadio[2]), guiRadioButtonGetSelected(ARadio[3]), guiRadioButtonGetSelected(ARadio[4])
		local obst = 0
		if(aepfel == true) then obst = 1 end
		if(birnen == true) then obst = 2 end
		if(bananen == true) then obst = 3 end
		if(kirschen == true) then obst = 4 end
		triggerServerEvent("onMultistuntAdminpanelObstsetzen", gMe, getPlayerFromName(user), wert, obst)
	end, false)
	
	addEventHandler("onClientGUIClick",AKnopf[9], function() -- Adminlevel
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		local wert = tonumber(getWert())
		if(wert < 0) or (wert > 4) then outputChatBox("Bad value!", 255, 0, 0) return end
		triggerServerEvent("onMultistuntAdminpanelAdminlevel", gMe, getPlayerFromName(user), grund, wert)
	end, false)
	addEventHandler("onClientGUIClick",AKnopf[8], function() -- Waffe
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		local wert = getWert()
		if not(wert) then outputChatBox("Bad value!", 255, 0, 0) return end
		local waffe, muni = gettok(wert, 1, ","), gettok(wert, 2, ",")
		triggerServerEvent("onMultistuntAdminpanelWaffegeb", gMe, getPlayerFromName(user), grund, waffe, muni)
	end, false)
	addEventHandler("onClientGUIClick",AKnopf[7], function() -- Fahrzeug
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		local wert = tonumber(getWert())
		if not(wert) or (wert < 400) or (wert > 611) then outputChatBox("Bad value!", 255, 0, 0) return end
		triggerServerEvent("onMultistuntAdminpanelFahrzeuggeb", gMe, getPlayerFromName(user), grund, wert)
	end, false)
	addEventHandler("onClientGUIClick",AKnopf[6], function() -- Toeten
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		triggerServerEvent("onMultistuntAdminpanelKill", gMe, getPlayerFromName(user), grund)
	end, false)
	addEventHandler("onClientGUIClick",AKnopf[5], function() -- Freezen
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		triggerServerEvent("onMultistuntAdminpanelFreeze", gMe, getPlayerFromName(user), grund)
	end, false)
	addEventHandler("onClientGUIClick",AKnopf[4], function() -- Muten
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		local zeit = tonumber(getZeit())
		if not(zeit) then return end
		triggerServerEvent("onMultistuntAdminpanelMute", gMe, getPlayerFromName(user), grund, zeit)
	end, false)
	addEventHandler("onClientGUIClick",AKnopf[3], function() -- Bannen
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		local zeit = tonumber(getZeit())
		if not(zeit) then return end
		triggerServerEvent("onMultistuntAdminpanelBan", gMe, user, grund, zeit)
	end, false)
		
	addEventHandler("onClientGUIClick",AKnopf[1], function() -- Kicken
		local user = getSelectedUser()
		if(user == false) then return end
		local grund = getGrund()
		if(grund == false) then grund = "N/A" end
		triggerServerEvent("onMultistuntAdminpanelKick", gMe, getPlayerFromName(user), grund)
	end, false)

	-- TAB 2 --
	ATab[2] = guiCreateTab("Playerlist",ATabPanel[1])
	AGrid[2] = guiCreateGridList(4,4,560,290,false,ATab[2])
	guiGridListSetSelectionMode(AGrid[2],1)

	guiGridListAddColumn(AGrid[2],"Playername",0.3)

	guiGridListAddColumn(AGrid[2],"Playtime",0.17)

	guiGridListAddColumn(AGrid[2],"Adminlevel",0.17)

	guiGridListAddColumn(AGrid[2],"Apples,Pears,Bananas,Cherrys",0.3)
	
	for index, thePlayer in pairs(getElementsByType("player")) do
		local row = guiGridListAddRow(AGrid[2])
		-- Name
		guiGridListSetItemText(AGrid[2], row, 1, getPlayerName(thePlayer), false, false)
		-- Spielzeit
		local spielzeit = getPlayerItem(thePlayer, "ms.playtime")
		if not(spielzeit) then spielzeit = "N/A" end
		guiGridListSetItemText(AGrid[2], row, 2, spielzeit, false, false)
		-- Adminlevel
		local level = getPlayerItem(thePlayer, "ms.adminlevel")
		if not(level) or (tonumber(level) == nil) then level = "N/A" end
		guiGridListSetItemText(AGrid[2], row, 3, level, false, false)
		-- Obst
		local aepfel, birnen, bananen, kirschen = tonumber(getPlayerItem(thePlayer, "ms.aepfel")), tonumber(getPlayerItem(thePlayer, "ms.birnen")), tonumber(getPlayerItem(thePlayer, "ms.bananen")), tonumber(getPlayerItem(thePlayer, "ms.kirschen"))
		if(aepfel == nil) then aepfel = 0 end
		if(birnen == nil) then birnen = 0 end
		if(bananen == nil) then bananen = 0 end
		if(kirschen == nil) then kirschen = 0 end
		guiGridListSetItemText(AGrid[2], row, 4, aepfel..", "..birnen..", "..bananen..", "..kirschen, false, false)
	end
	-- TAB 3 --
	ATab[3] = guiCreateTab("Playerinfo",ATabPanel[1])
	AGrid[3] = guiCreateGridList(5,2,147,259,false,ATab[3])
	guiGridListSetSelectionMode(AGrid[3],1)

	guiGridListAddColumn(AGrid[3],"Playername",0.6)
	for index, player in pairs(getElementsByType("player")) do guiGridListSetItemText(AGrid[3], guiGridListAddRow(AGrid[3]), 1, getPlayerName(player), false, false) end
	AEdit[5] = guiCreateEdit(9,265,139,22,"search",false,ATab[3])
	ALabel[5] = guiCreateLabel(161,39,255,18,"Name:",false,ATab[3])
	guiSetFont(ALabel[5],"default-bold-small")
	ALabel[6] = guiCreateLabel(161,5,84,16,"Information:",false,ATab[3])
	guiSetFont(ALabel[6],"default-bold-small")
	ALabel[7] = guiCreateLabel(159,10,89,19,"_____________",false,ATab[3])
	guiLabelSetColor(ALabel[7],0, 255, 255)
	ALabel[8] = guiCreateLabel(161,63,35,17,"IP:",false,ATab[3])
	guiSetFont(ALabel[8],"default-bold-small")
	AEdit[6] = guiCreateEdit(205,60,176,25,"",false,ATab[3]) -- IP
	ALabel[9] = guiCreateLabel(159,91,38,16,"Serial:",false,ATab[3])
	guiSetFont(ALabel[9],"default-bold-small")
	AEdit[7] = guiCreateEdit(204,88,176,25,"",false,ATab[3]) -- Serial
	AKnopf[16] = guiCreateButton(386,61,78,25,"Copy",false,ATab[3])
	AKnopf[17] = guiCreateButton(386,90,78,25,"Copy",false,ATab[3])
	ALabel[10] = guiCreateLabel(159,124,52,18,"Badges:",false,ATab[3])
	guiSetFont(ALabel[10],"default-bold-small")
	ALabel[11] = guiCreateLabel(157,128,89,19,"_____________",false,ATab[3])
	guiLabelSetColor(ALabel[11],0,255,255)
	AGrid["Badge"] = guiCreateGridList(161,148,131,142,false,ATab[3])
	guiGridListSetSelectionMode(AGrid["Badge"],1)

	guiGridListAddColumn(AGrid["Badge"],"ID",0.2)

	guiGridListAddColumn(AGrid["Badge"],"Name",0.5)
	AKnopf[17.5] = guiCreateButton(302,188,89,34,"Give badge",false,ATab[3])
	
	-- Badges --
	for i = 1, max_badges, 1 do
		local row = guiGridListAddRow(AGrid["Badge"])
		guiGridListSetItemText(AGrid["Badge"], row, 1, i, false, false)
		guiGridListSetItemText(AGrid["Badge"], row, 2, badge_names[i], false, false)
	end
	addEventHandler("onClientGUIClick", AKnopf[17.5], function()
		local user, badge = guiGridListGetItemText(AGrid[3], guiGridListGetSelectedItem(AGrid[3]), 1), guiGridListGetItemText(AGrid["Badge"], guiGridListGetSelectedItem(AGrid["Badge"]), 1)
		if(user == "") or (badge == "") then return end
		triggerServerEvent("onMultistuntBadgeGive", gMe, getPlayerFromName(user), tonumber(badge))
		outputChatBox("Badge given to "..user.."!", 0, 255, 0)
	end, false)
	addEventHandler("onClientGUIChanged",AEdit[5], function() 
		local text = guiGetText ( source )
		if ( text == "" ) then
			guiGridListClear(AGrid[3])
			for index,spieler in pairs ( getElementsByType("player") ) do
				local name = getPlayerName(spieler)
				guiGridListSetItemText(AGrid[3],guiGridListAddRow ( AGrid[3] ),1,name,false,false)
			end
		else
		guiGridListClear(AGrid[3])
		for id, player in ipairs ( getElementsByType ( "player" ) ) do
				if ( string.find ( string.upper ( getPlayerName ( player ) ), string.upper ( text ), 1, true ) ) then
						local name = getPlayerName(player)
						guiGridListSetItemText(AGrid[3],guiGridListAddRow ( AGrid[3] ),1,name,false,false)
				end
			end
		end
	end, false)	
	
	addEventHandler("onClientGUIClick", AKnopf[17], function()
		setClipboard(guiGetText(AEdit[7]))
		outputChatBox("Serial copied to clipboard!", 0, 255, 0)
	end, false)
	
	addEventHandler("onClientGUIClick", AKnopf[16], function()
		setClipboard(guiGetText(AEdit[6]))
		outputChatBox("IP copied to clipboard!", 0, 255, 0)
	end, false)
	
	addEventHandler("onClientGUIClick", AGrid[3], function()
		local player = guiGridListGetItemText(AGrid[3], guiGridListGetSelectedItem(AGrid[3]), 1)
		if(player == "") then
			guiSetText(ALabel[5], "Name: ")
			guiSetText(AEdit[6], "")
			guiSetText(AEdit[7], "")
		else
			if not(getPlayerFromName(player)) then return end
			local thePlayer = getPlayerFromName(player)
			guiSetText(ALabel[5], "Name: "..getPlayerName(thePlayer))
			triggerServerEvent("onMultistuntAdminpanelPlayerdata", gMe, thePlayer)
		end
	end, false)
	-- TAB 4 --
	ATab[4] = guiCreateTab("Business",ATabPanel[1])
	ALabel[10] = guiCreateLabel(13,4,85,19,"Create biz:",false,ATab[4])
	guiSetFont(ALabel[10],"default-bold-small")
	ALabel[11] = guiCreateLabel(13,7,81,18,"___________",false,ATab[4])
	guiLabelSetColor(ALabel[11],0, 255, 0)
	ALabel[12] = guiCreateLabel(31,37,90,15,"X, Y, Z Position",false,ATab[4])
	guiSetFont(ALabel[12],"default-bold-small")
	AEdit[8] = guiCreateEdit(23,55,47,26,"",false,ATab[4]) -- x
	AEdit[9] = guiCreateEdit(73,55,47,26,"",false,ATab[4]) -- y
	AEdit[10] = guiCreateEdit(122,55,47,26,"",false,ATab[4]) -- z
	AKnopf[18] = guiCreateButton(172,55,97,28,"My Position",false,ATab[4])
	ALabel[13] = guiCreateLabel(23,87,78,16,"Earn:",false,ATab[4])
	guiSetFont(ALabel[13],"default-bold-small")
	AEdit[11] = guiCreateEdit(22,105,47,26,"",false,ATab[4])
	ALabel[14] = guiCreateLabel(78,109,47,19,"Pears",false,ATab[4])
	guiSetFont(ALabel[14],"default-bold-small")
	ALabel[15] = guiCreateLabel(22,139,56,15,"Price:",false,ATab[4])
	guiSetFont(ALabel[15],"default-bold-small")
	AEdit[12] = guiCreateEdit(22,162,47,26,"",false,ATab[4])
	ALabel[16] = guiCreateLabel(77,167,47,19,"Pears",false,ATab[4])
	guiSetFont(ALabel[16],"default-bold-small")
	ALabel[17] = guiCreateLabel(299,8,85,19,"Delete biz:",false,ATab[4])
	guiSetFont(ALabel[17],"default-bold-small")
	ALabel[18] = guiCreateLabel(299,14,81,18,"___________",false,ATab[4])
	guiLabelSetColor(ALabel[18],0,255,0)
	ALabel[19] = guiCreateLabel(302,44,32,19,"ID:",false,ATab[4])
	guiSetFont(ALabel[19],"default-bold-small")
	AEdit[13] = guiCreateEdit(327,39,47,26,"",false,ATab[4]) -- id
	AKnopf[19] = guiCreateButton(381,38,75,28,"Delete",false,ATab[4])
	ACheckbox[1] = guiCreateCheckBox(315,73,96,25,"Confirm",false,false,ATab[4])
	guiSetFont(ACheckbox[1],"default-bold-small")
	AKnopf[20] = guiCreateButton(21,196,115,32,"Create biz",false,ATab[4])
	ALabel[20] = guiCreateLabel(152,87,120,20,"Name of biz:",false,ATab[4])
	guiSetFont(ALabel[20],"default-bold-small")
	AEdit[14] = guiCreateEdit(151,107,126,25,"",false,ATab[4])
	addEventHandler("onClientGUIClick", AKnopf[18], function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(AEdit[8], x)
		guiSetText(AEdit[9], y)
		guiSetText(AEdit[10], z)
	end, false)
	
	addEventHandler("onClientGUIClick", AKnopf[19], function()
		local id = tonumber(guiGetText(AEdit[13]))
		if not(id) then return end
		if(guiCheckBoxGetSelected(ACheckbox[1]) == false) then outputChatBox("You must confirm this!", 255, 0, 0) return end
		triggerServerEvent("onMultistuntBizDelete", gMe, id)
	end, false)
	
	addEventHandler("onClientGUIClick", AKnopf[20], function()
		local x, y, z = guiGetText(AEdit[8]), guiGetText(AEdit[9]), guiGetText(AEdit[10])
		local einkommen, preis, name = guiGetText(AEdit[11]), guiGetText(AEdit[12]), guiGetText(AEdit[14])
		if (x == "") or (y == "") or (z == "") or (einkommen == "") or (preis == "") or (name == "") then outputChatBox("Unknow entry!", 255, 0, 0) return end
		triggerServerEvent("onMultistuntBizCreate", gMe, x, y, z, einkommen, preis, name)
	end, false)
	-- TAB 5 --
	ATab[5] = guiCreateTab("Bans",ATabPanel[1])
	AGrid[4] = guiCreateGridList(6,5,422,286,false,ATab[5])
	guiGridListSetSelectionMode(AGrid[4],1)

	guiGridListAddColumn(AGrid[4],"Name",0.25)

	guiGridListAddColumn(AGrid[4],"Date",0.25)

	guiGridListAddColumn(AGrid[4],"Reason",0.20)

	guiGridListAddColumn(AGrid[4],"Admin",0.25)
	AKnopf[21] = guiCreateButton(432,46,120,27,"Ban delete",false,ATab[5])
	ACheckbox[2] = guiCreateCheckBox(436,17,117,21,"confirm",false,false,ATab[5])
	guiSetFont(ACheckbox[2],"default-bold-small")
	AKnopf[22] = guiCreateButton(436,236,120,27,"Insert ban",false,ATab[5])
	AEdit[15] = guiCreateEdit(436,110,109,23,"",false,ATab[5])
	ALabel[21] = guiCreateLabel(439,91,106,21,"Name:",false,ATab[5])
	guiSetFont(ALabel[21],"default-bold-small")
	ALabel[22] = guiCreateLabel(438,136,108,19,"Reason:",false,ATab[5])
	guiSetFont(ALabel[22],"default-bold-small")
	AEdit[16] = guiCreateEdit(437,157,109,23,"",false,ATab[5])
	ALabel[23] = guiCreateLabel(438,183,108,19,"Time:(hours)",false,ATab[5])
	guiSetFont(ALabel[23],"default-bold-small")
	AEdit[17] = guiCreateEdit(437,204,109,23,"",false,ATab[5])

	triggerServerEvent("onMultistuntAdminpanelBansGet", gMe)
	local function reloadAdminBans()
		guiGridListClear(AGrid[4])
		triggerServerEvent("onMultistuntAdminpanelBansGet", gMe)
	end
	addEventHandler("onClientGUIClick", AKnopf[21], function()
		local name = guiGridListGetItemText(AGrid[4], guiGridListGetSelectedItem(AGrid[4]), 1)
		if(name == "") then return end
		if(guiCheckBoxGetSelected(ACheckbox[2]) == false) then return end
		triggerServerEvent("onMultistuntAdminpanelBanRemove", gMe, name)
		setTimer(reloadAdminBans, 100, 1)
	end, false)
	addEventHandler("onClientGUIClick", AKnopf[22], function()
		local name = guiGetText(AEdit[15])
		local grund = guiGetText(AEdit[16])
		local zeit = tonumber(guiGetText(AEdit[17]))
		if(name == "") or (grund == "") or not (zeit) then return end
		if(guiCheckBoxGetSelected(ACheckbox[2]) == false) then return end
		
		triggerServerEvent("onMultistuntAdminpanelBanAdd", gMe, name, grund, zeit)
		setTimer(reloadAdminBans, 100, 1)
	end, false)
	-- TAB 6 --
	ATab[6] = guiCreateTab("Times",ATabPanel[1])
	AGrid[5] = guiCreateGridList(7,4,159,280,false,ATab[6])
	guiGridListSetSelectionMode(AGrid[5],1)

	guiGridListAddColumn(AGrid[5],"Timename",0.7)
	guiSetFont(AGrid[5], "default-bold-small")
	AKnopf[23] = guiCreateButton(177,68,103,35,"Start",false,ATab[6])
	AKnopf[24] = guiCreateButton(177,110,103,35,"Quit",false,ATab[6])
	ALabel[24] = guiCreateLabel(178,11,94,26,"Value:",false,ATab[6])
	guiSetFont(ALabel[24],"default-bold-small")
	AEdit[18] = guiCreateEdit(177,33,102,23,"",false,ATab[6])
	for i = 1, #times, 1 do
		local row = guiGridListAddRow(AGrid[5])
		guiGridListSetItemText(AGrid[5], row, 1, times[i], false, false)
	end
	addEventHandler("onClientGUIClick", AKnopf[23], function()
		local item = guiGridListGetItemText(AGrid[5], guiGridListGetSelectedItem(AGrid[5]), 1)
		local wert = tonumber(guiGetText(AEdit[18]))
		if(item == "") then return end
		triggerServerEvent("onMultistuntAdminpanelTimeStart", gMe, item, wert)
	end, false)
	addEventHandler("onClientGUIClick", AKnopf[24], function()
		triggerServerEvent("onMultistuntAdminpanelTimeStop", gMe)
	end, false)
	-- TAB 7 --
	ATab[6] = guiCreateTab("Logs",ATabPanel[1])
	ARadio[5] = guiCreateRadioButton(469,5,86,24,"Today",false,ATab[6])
	guiSetFont(ARadio[5],"default-bold-small")
	ARadio[6] = guiCreateRadioButton(470,28,86,24,"All Time",false,ATab[6])
	guiRadioButtonSetSelected(ARadio[5],true)
	guiSetFont(ARadio[6],"default-bold-small")
	AKnopf[25] = guiCreateButton(466,69,92,29,"Delete Log Entry",false,ATab[6])
	AGrid[5] = guiCreateGridList(7,4,443,283,false,ATab[6])
	guiGridListSetSelectionMode(AGrid[5],1)

	guiGridListAddColumn(AGrid[5],"ID",0.1)

	guiGridListAddColumn(AGrid[5],"Date",0.25)

	guiGridListAddColumn(AGrid[5],"Name",0.2)

	guiGridListAddColumn(AGrid[5],"Function",0.2)

	guiGridListAddColumn(AGrid[5],"Action",0.2)

	guiGridListAddColumn(AGrid[5],"IP",0.2)
	
	triggerServerEvent("onMultistuntAdminpanelLogGet", gMe, "today")
	
	addEventHandler("onClientGUIClick", ARadio[5], function()
		guiGridListClear(AGrid[5])
		triggerServerEvent("onMultistuntAdminpanelLogGet", gMe, "today")
	end, false)
	
	addEventHandler("onClientGUIClick", ARadio[6], function()
		guiGridListClear(AGrid[5])
		triggerServerEvent("onMultistuntAdminpanelLogGet", gMe, "alltime")
	end, false)
	addEventHandler("onClientGUIClick", AKnopf[25], function()
		local id = tonumber(guiGridListGetItemText(AGrid[5], guiGridListGetSelectedItem(AGrid[5]), 1))
		if not(id) then return end
		local selected = guiRadioButtonGetSelected(ARadio[5])
		local typ
		if(selected == true) then typ = "today" else typ = "alltime" end
		triggerServerEvent("onMultistuntAdminpanelLogDelete", gMe, id, typ)
		guiGridListClear(AGrid[5])
	end, false)
	-- Tab 8 --
	ATab[7] = guiCreateTab("Reports",ATabPanel[1])
	AGrid[7] = guiCreateGridList(7,7,555,225,false,ATab[7])
	guiSetFont(AGrid[7], "default-bold-small")
	guiGridListSetSelectionMode(AGrid[7],1)

	guiGridListAddColumn(AGrid[7],"ID",0.1)
	
	guiGridListAddColumn(AGrid[7],"Date",0.2)

	guiGridListAddColumn(AGrid[7],"Typ",0.15)

	guiGridListAddColumn(AGrid[7],"Writer",0.2)

	guiGridListAddColumn(AGrid[7],"Done",0.1)

	guiGridListAddColumn(AGrid[7],"Supported admin",0.15)
	ARadio[7] = guiCreateRadioButton(11,238,92,23,"All Time",false,ATab[7])
	guiSetFont(ARadio[7],"default-bold-small")
	ARadio[8] = guiCreateRadioButton(12,260,92,23,"Today",false,ATab[7])
	guiRadioButtonSetSelected(ARadio[8],true)
	guiSetFont(ARadio[8],"default-bold-small")
	AKnopf[26] = guiCreateButton(106,238,104,31,"Open Report",false,ATab[7])
	triggerServerEvent("onMultistuntAdminpanelReportsGet", gMe, "today")
	
	addEventHandler("onClientGUIClick", ARadio[7], function()
		guiGridListClear(AGrid[7])
		triggerServerEvent("onMultistuntAdminpanelReportsGet", gMe, "alltime")
	end, false)
	addEventHandler("onClientGUIClick", ARadio[8], function()
		guiGridListClear(AGrid[7])
		triggerServerEvent("onMultistuntAdminpanelReportsGet", gMe, "today")
	end, false)
	
	addEventHandler("onClientGUIClick", AKnopf[26], function()
		if(Guivar2 == 1) then return end
		local report = tonumber(guiGridListGetItemText(AGrid[7], guiGridListGetSelectedItem(AGrid[7]), 1))
		if not(report) then return end
		triggerServerEvent("onMultistuntAdminpanelReportInfo", gMe, report)
		Guivar2 = 1

		AFenster2 = guiCreateWindow(756,462,421,261,"Report ID: "..report,false)
		AMemo2 = guiCreateMemo(9,24,403,191,"",false,AFenster2)
		local AKnopf21 = guiCreateButton(13,224,95,29,"Delete Report",false,AFenster2)
		local AKnopf22 = guiCreateButton(111,224,95,29,"Cancel",false,AFenster2)
		local AKnopf23 = guiCreateButton(210,223,95,29,"Reply",false,AFenster2)
		local AKnopf24 = guiCreateButton(308,223,95,29,"Send",false,AFenster2)
		addEventHandler("onClientGUIClick", AKnopf22, function()
			destroyElement(AFenster2)
			Guivar2 = 0
		end, false)
		
	end, false)
	-- Spezielles --
	--[[
	1: Kicken
	2: PermBann
	3: Bann
	4: Muten
	5: Freezen
	6: Toeten
	7: Fahrzeug Geben
	8: Waffe Geben
	9: Adminlevel geben
	10: Obst setzen
	11: Obst geben
	12: Explodieren
	13: Slappen
	14: Zu Spieler Porten
	15: Spieler Herporten
	19: Biz loeschen
	20: Biz Erstellen
	--]]
	for i = 1, #AKnopf, 0.5 do
		if(isElement(AKnopf[i])) then
			guiSetEnabled(AKnopf[i], false)
		end
	end
	guiSetEnabled(AKnopf[16], true)
	guiSetEnabled(AKnopf[17], true) -- IP und Serial kopieren
	guiSetEnabled(AKnopf[18], true) -- Meine Position
	guiSetEnabled(AKnopf[26], true) -- Reports open
	local data = getPlayerAdminlevel(gMe)
	if(data == 1) then -- Moderator
		guiSetEnabled(AKnopf[1], true)
		guiSetEnabled(AKnopf[3], true)
		guiSetEnabled(AKnopf[4], true)
		guiSetEnabled(AKnopf[5], true)
		guiSetEnabled(AKnopf[14], true)
		guiSetEnabled(AKnopf[15], true)
		
	end
	if(data == 2) then -- Super Mod
		guiSetEnabled(AKnopf[1], true)
		guiSetEnabled(AKnopf[2], true)
		guiSetEnabled(AKnopf[3], true)
		guiSetEnabled(AKnopf[4], true)
		guiSetEnabled(AKnopf[5], true)
		guiSetEnabled(AKnopf[6], true)
		guiSetEnabled(AKnopf[10], true)
		guiSetEnabled(AKnopf[11], true)
		guiSetEnabled(AKnopf[13], true)
		guiSetEnabled(AKnopf[14], true)
		guiSetEnabled(AKnopf[15], true)
		guiSetEnabled(AKnopf[15.5], true)
		guiSetEnabled(AKnopf[21], true)
		guiSetEnabled(AKnopf[22], true)
		guiSetEnabled(AKnopf[23], true)
		guiSetEnabled(AKnopf[24], true)
	end
	if(data == 3) then -- Admin
		guiSetEnabled(AKnopf[1], true)
		guiSetEnabled(AKnopf[2], true)
		guiSetEnabled(AKnopf[3], true)
		guiSetEnabled(AKnopf[4], true)
		guiSetEnabled(AKnopf[5], true)
		guiSetEnabled(AKnopf[6], true)
		guiSetEnabled(AKnopf[7], true)
		guiSetEnabled(AKnopf[8], true)
		guiSetEnabled(AKnopf[10], true)
		guiSetEnabled(AKnopf[11], true)
		guiSetEnabled(AKnopf[12], true)
		guiSetEnabled(AKnopf[13], true)
		guiSetEnabled(AKnopf[14], true)
		guiSetEnabled(AKnopf[15], true)
		guiSetEnabled(AKnopf[19], true)
		guiSetEnabled(AKnopf[20], true)
		guiSetEnabled(AKnopf[21], true)
		guiSetEnabled(AKnopf[22], true)
		guiSetEnabled(AKnopf[23], true)
		guiSetEnabled(AKnopf[24], true)
		guiSetEnabled(AKnopf[15.5], true)
		guiSetEnabled(AKnopf[25], true)
		guiSetEnabled(AKnopf[17.5], true)
	end
	if(data == 4) then -- Inhaber
		guiSetEnabled(AKnopf[1], true)
		guiSetEnabled(AKnopf[2], true)
		guiSetEnabled(AKnopf[3], true)
		guiSetEnabled(AKnopf[4], true)
		guiSetEnabled(AKnopf[5], true)
		guiSetEnabled(AKnopf[6], true)
		guiSetEnabled(AKnopf[7], true)
		guiSetEnabled(AKnopf[8], true)
		guiSetEnabled(AKnopf[8], true)
		guiSetEnabled(AKnopf[10], true)
		guiSetEnabled(AKnopf[11], true)
		guiSetEnabled(AKnopf[12], true)
		guiSetEnabled(AKnopf[13], true)
		guiSetEnabled(AKnopf[14], true)
		guiSetEnabled(AKnopf[15], true)
		guiSetEnabled(AKnopf[19], true)
		guiSetEnabled(AKnopf[20], true)
		guiSetEnabled(AKnopf[21], true)
		guiSetEnabled(AKnopf[22], true)
		guiSetEnabled(AKnopf[23], true)
		guiSetEnabled(AKnopf[24], true)
		guiSetEnabled(AKnopf[15.5], true)
		guiSetEnabled(AKnopf[25], true)
		guiSetEnabled(AKnopf[17.5], true)
	end
	if(data > 4) then -- Projektleiter
		guiSetEnabled(AKnopf[1], true)
		guiSetEnabled(AKnopf[2], true)
		guiSetEnabled(AKnopf[3], true)
		guiSetEnabled(AKnopf[4], true)
		guiSetEnabled(AKnopf[5], true)
		guiSetEnabled(AKnopf[6], true)
		guiSetEnabled(AKnopf[7], true)
		guiSetEnabled(AKnopf[8], true)
		guiSetEnabled(AKnopf[9], true)
		guiSetEnabled(AKnopf[10], true)
		guiSetEnabled(AKnopf[11], true)
		guiSetEnabled(AKnopf[12], true)
		guiSetEnabled(AKnopf[13], true)
		guiSetEnabled(AKnopf[14], true)
		guiSetEnabled(AKnopf[15], true)
		guiSetEnabled(AKnopf[19], true)
		guiSetEnabled(AKnopf[20], true)
		guiSetEnabled(AKnopf[21], true)
		guiSetEnabled(AKnopf[22], true)
		guiSetEnabled(AKnopf[23], true)
		guiSetEnabled(AKnopf[24], true)
		guiSetEnabled(AKnopf[15.5], true)
		guiSetEnabled(AKnopf[25], true)
		guiSetEnabled(AKnopf[17.5], true)
	end
end

addEventHandler("onMultistuntAdminpanelLogGetBack", getRootElement(), function(id, date, name, func, action, ip)
	if not(id) or not(date) or not(name) or not(func) or not (action) or not (ip) then return end
	if not(isElement(AFenster[1])) then return end
	local row = guiGridListAddRow(AGrid[5])
	guiGridListSetItemText(AGrid[5], row, 1, id, false, false)
	guiGridListSetItemText(AGrid[5], row, 2, tostring(date), false, false)
	guiGridListSetItemText(AGrid[5], row, 3, tostring(name), false, false)
	guiGridListSetItemText(AGrid[5], row, 4, tostring(func), false, false)
	guiGridListSetItemText(AGrid[5], row, 5, tostring(action), false, false)
	guiGridListSetItemText(AGrid[5], row, 6, tostring(ip), false, false)
end)

addEventHandler("onMultistuntAdminpanelReportsBack", getRootElement(), function(id, datum, typ, writer, done, admin)
	if not(isElement(AFenster[1])) then return end
	local row = guiGridListAddRow(AGrid[7])
	guiGridListSetItemText(AGrid[7], row, 1, id, false, false)
	guiGridListSetItemText(AGrid[7], row, 2, tostring(datum), false, false)
	guiGridListSetItemText(AGrid[7], row, 3, tostring(typ), false, false)
	guiGridListSetItemText(AGrid[7], row, 4, tostring(writer), false, false)
	guiGridListSetItemText(AGrid[7], row, 5, tostring(done), false, false)
	guiGridListSetItemText(AGrid[7], row, 6, tostring(admin), false, false)
end)

addEventHandler("onMultistuntAdminpanelPlayerdataBack", getRootElement(), function(ip, serial)
	guiSetText(AEdit[6], ip)
	guiSetText(AEdit[7], serial)
end)

addEventHandler("onMultistuntAdminpanelReportInfoBack", getRootElement(), function(text)
	guiSetText(AMemo2, text)
end)

addEventHandler("onMultistuntAdminpanelBansGetBack", getRootElement(), function(name, datum, grund, admin)
	local row = guiGridListAddRow(AGrid[4]) -- Name, datum, grund, admin
	guiGridListSetItemText(AGrid[4], row, 1, tostring(name), false, false)
	guiGridListSetItemText(AGrid[4], row, 2, tostring(datum), false, false)
	guiGridListSetItemText(AGrid[4], row, 3, tostring(grund), false, false)
	guiGridListSetItemText(AGrid[4], row, 4, tostring(admin), false, false)
end)
addCommandHandler("manad", function()
	if(Guivar == 0) then
		local level = getPlayerAdminlevel(gMe)
		if(level < 1) then outputChatBox("You have no permissions!", 255, 0, 0) return end
		createAdminpanel()
	else
		destroyElement(AFenster[1])
		Guivar = 0
		setGuiState(0)
		showCursor(false)
		if(Guivar2 == 1) then
			destroyElement(AFenster2)
			Guivar2 = 0
		end
	end
end)

