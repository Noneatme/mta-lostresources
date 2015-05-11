local function giveAdminRecht(thePlayer, recht)
	if(recht == 1) then
		setElementData(thePlayer, "msa.uzi", true)
		giveWeapon(thePlayer, 28, 99999, false)
	elseif(recht == 2) then
		setElementData(thePlayer, "msa.leuchtrakete", true)
		giveWeapon(thePlayer, 22, 99999, false)
	elseif(recht == 3) then
		setElementData(thePlayer, "msa.rocketdrop", true)
		giveWeapon(thePlayer, 31, 99999, false)
	end
end

local adminhut = {}

addCommandHandler("aduty", function(thePlayer)
	local level = tonumber(getElementData(thePlayer, "ms.adminlevel"))
	if(level < 1) then outputChatBox("Du hast keine Rechte.", thePlayer, 200, 0, 0) return end
	if(getElementData(thePlayer, "msa.dienst") == true) then
		setElementData(thePlayer, "msa.dienst", false)
		outputChatBox("Adminduty deaktiviert.", thePlayer, 0, 255, 255)
		-- rechte --
		setElementData(thePlayer, "msa.leuchtrakete", false)
		setElementData(thePlayer, "msa.uzi", false)
		setElementData(thePlayer, "msa.rocketdrop", false)
		destroyElement(adminhut[thePlayer])
	else
		adminhut[thePlayer] = createObject(2372, 0, 0, 0)
		setElementAlpha(adminhut[thePlayer], 0)
		attachElements(adminhut[thePlayer], thePlayer, 0, 0, 1)
		setElementCollisionsEnabled(adminhut[thePlayer], false)
		if(level == 1) then
		
		end
		if(level == 2) then
		
		end
		if(level == 3) then
			giveAdminRecht(thePlayer, 1)
		end
		if(level == 4) then
			giveAdminRecht(thePlayer, 1)
			giveAdminRecht(thePlayer, 2)
		end
		if(level == 5) then
			giveAdminRecht(thePlayer, 1)
			giveAdminRecht(thePlayer, 2)
			giveAdminRecht(thePlayer, 3)
		end
		setElementData(thePlayer, "msa.dienst", true)
		outputChatBox("Adminduty Aktiviert!", thePlayer, 0, 200, 0)
	end
end)
addEventHandler("onPlayerQuit", getRootElement(), function()
	if(isElement(adminhut[source])) then destroyElement(adminhut[source]) end
end)
-- Events --
addEvent("onMultistuntAdminRocketFire", true)
addEventHandler("onMultistuntAdminRocketFire", getRootElement(), function(x, y, z, vx, vy, vz, farbe)
	local rakete = addSpecialEffect("leuchtrakete", source, farbe)
	setElementPosition(rakete, x, y, z)
	setElementVelocity(rakete, vx, vy, vz)
end)
-- Changes --

-- Adminpanel --
addEvent("onMultistuntAdminpanelKick", true)
addEvent("onMultistuntAdminpanelBan", true)
addEvent("onMultistuntAdminpanelMute", true)
addEvent("onMultistuntAdminpanelFreeze", true)
addEvent("onMultistuntAdminpanelKill", true)
addEvent("onMultistuntAdminpanelFahrzeuggeb", true)
addEvent("onMultistuntAdminpanelWaffegeb", true)
addEvent("onMultistuntAdminpanelAdminlevel", true)
addEvent("onMultistuntAdminpanelObstsetzen", true)
addEvent("onMultistuntAdminpanelObstgeben", true)
addEvent("onMultistuntAdminpanelExplode", true)
addEvent("onMultistuntAdminpanelSlap", true)
addEvent("onMultistuntAdminpanelPort", true)
addEvent("onMultistuntAdminpanelPorthere", true)
addEvent("onMultistuntAdminpanelPlayerdata", true)
addEvent("onMultistuntAdminpanelBansGet", true)
addEvent("onMultistuntAdminpanelBanRemove", true)
addEvent("onMultistuntAdminpanelBanAdd", true)
addEvent("onMultistuntAdminpanelTimeStart", true)
addEvent("onMultistuntAdminpanelSetTeam", true)
addEvent("onMultistuntAdminpanelLogGet", true)
addEvent("onMultistuntAdminpanelLogDelete", true)
addEvent("onMultistuntAdminUZIFire", true)
addEvent("onMultistuntAdminRocketDrop", true)
addEvent("onMultistuntAdminpanelReportsGet", true)
addEvent("onMultistuntAdminpanelReportInfo", true)

local curtime = 0
local timeids = {
	["Appletime"] = 1,
	["Peartime"] = 2,
	["Bananatime"] = 3,
	["Cherrytime"] = 4,
	["Grenade Kill Time"] = 5,
	["Minigun Kill Time"] = 6,
	["Raketen Kill Time"] = 7,
	["Raining Vehicles"] = 8,
	["Happy Hour"] = 9,
}
-- Report Info --

addEventHandler("onMultistuntAdminpanelReportInfo", getRootElement(), function(reportid)
	local result = mysql_query ( handler, "SELECT REPORT FROM reports WHERE ID = '"..reportid.."';" )
	if(result) then
		local tab = mysql_fetch_assoc(result)
		triggerClientEvent(source, "onMultistuntAdminpanelReportInfoBack", source, tab['REPORT'])
	end
end)
-- Report gettin --
addEventHandler("onMultistuntAdminpanelReportsGet", getRootElement(), function(typ)
	if(typ == "today") then
		local result = mysql_query ( handler, "SELECT * FROM reports;" )
		local dsatz
		if (result) then
			dsatz = mysql_fetch_assoc(result)
			while dsatz do
				local date = dsatz['DATUM']
				if(gettok(getFormatDate(), 1, " ") == gettok(date, 1, " ")) then
					triggerClientEvent(source, "onMultistuntAdminpanelReportsBack", source, dsatz['ID'], dsatz['DATUM'], dsatz['TYP'], dsatz['WRITER'], dsatz['DONE'], dsatz['ADMIN'])
				end
				dsatz = mysql_fetch_assoc(result)
			end
			mysql_free_result(result)
		end
		
	elseif(typ == "alltime") then
		local result = mysql_query ( handler, "SELECT * FROM reports ;" )
		local dsatz
		if (result) then
			dsatz = mysql_fetch_assoc(result)
			while dsatz do
				triggerClientEvent(source, "onMultistuntAdminpanelReportsBack", source, dsatz['ID'], dsatz['DATUM'], dsatz['TYP'], dsatz['WRITER'], dsatz['DONE'], dsatz['ADMIN'])
				dsatz = mysql_fetch_assoc(result)
			end
			mysql_free_result(result)
		end
		
	end
end)
-- Log delete --

addEventHandler("onMultistuntAdminpanelLogDelete", getRootElement(), function(id, typ)
	local result = mysql_query(handler, "DELETE FROM logs WHERE ID = '"..id.."';")
	if(result) then
		outputServerLog(getPlayerName(source).." deleted mysql_log "..id..".")
		mysql_free_result(result)
		triggerEvent("onMultistuntAdminpanelLogGet", source, typ)
		sendInfoMessage("Server log succesfull deleted!", source, "green")
	else
		sendInfoMessage("Can't delete server log!", source, "red")
		triggerEvent("onMultistuntAdminpanelLogGet", source, typ)
	end
end)

-- Log getting --

addEventHandler("onMultistuntAdminpanelLogGet", getRootElement(), function(typ)
	if(typ == "today") then
		local result = mysql_query ( handler, "SELECT * FROM logs;" )
		local dsatz
		if (result) then
			dsatz = mysql_fetch_assoc(result)
			while dsatz do
				local date = dsatz['DATUM']
				if(gettok(getFormatDate(), 1, " ") == gettok(date, 1, " ")) then
					triggerClientEvent(source, "onMultistuntAdminpanelLogGetBack", source, dsatz['ID'], dsatz['DATUM'], dsatz['NAME'], dsatz['FUNKTION'], dsatz['AKTION'], dsatz['IP'])
				end
				dsatz = mysql_fetch_assoc(result)
			end
		end
		mysql_free_result(result)
	elseif(typ == "alltime") then
		local result = mysql_query ( handler, "SELECT * FROM logs ;" )
		local dsatz
		if (result) then
			dsatz = mysql_fetch_assoc(result)
			while dsatz do
				triggerClientEvent(source, "onMultistuntAdminpanelLogGetBack", source, dsatz['ID'], dsatz['DATUM'], dsatz['NAME'], dsatz['FUNKTION'], dsatz['AKTION'], dsatz['IP'])
				dsatz = mysql_fetch_assoc(result)
			end
		end
		mysql_free_result(result)
	end
end)

-- Set Team --

addEventHandler("onMultistuntAdminpanelSetTeam", getRootElement(), function(theUser, team)
	setElementData(theUser, "ms.team", team)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Your Team has been set to #00FF00"..team.."#FFFFFF!", theUser, 0, 0, 0, true)
	outputChatBox("You set "..getPlayerName(theUser).."'s Team to "..team.."!", source, 0, 255, 0)
end)

-- Time stop --
addEventHandler("onMultistuntAdminpanelTimeStop", getRootElement(), function()
	if(curtime == 0) then sendInfoMessage("No Time has been startet!", source, "red") return end
	curtime = 0
	sendInfoMessage("Time beendet!", source, "green")
end)

-- Time start --

addEventHandler("onMultistuntAdminpanelTimeStart", getRootElement(), function(thetime, wert)
	if(curtime ~= 0) then sendInfoMessage("There is already a time!", source, "red") return end
	local id = timeids[thetime]
	if not(id) then return end
	if(id == 1) or (id == 2) or (id == 3) or (id == 4) or (id == 8) then else
		curtime = id
	end
	if(id == 1) then
		if not(wert) then return end
		for index, player in pairs(getElementsByType("player")) do
			givePlayerItem(player, "ms.aepfel", wert)
			triggerClientEvent(player, "onMultistuntTimeStart", player, "Freie Aepfel! YES!", id)
		end
	elseif(id == 2) then
		if not(wert) then return end
		for index, player in pairs(getElementsByType("player")) do
			givePlayerItem(player, "ms.birnen", wert)
			triggerClientEvent(player, "onMultistuntTimeStart", player, "Birnenzeit! YES!", id)
		end
	elseif(id == 3) then
		if not(wert) then return end
		for index, player in pairs(getElementsByType("player")) do
			givePlayerItem(player, "ms.bananen", wert)
			triggerClientEvent(player, "onMultistuntTimeStart", player, "Bananenzeit! YES!", id)
		end
	elseif(id == 4) then
		if not(wert) then return end
		for index, player in pairs(getElementsByType("player")) do
			givePlayerItem(player, "ms.kirschen", wert)
			triggerClientEvent(player, "onMultistuntTimeStart", player, "Its raining Kirschen! YES!", id)
		end
	elseif(id == 5) then
	
	elseif(id == 6) then
	
	elseif(id == 7) then
	
	elseif(id == 8) then
	
	elseif(id == 9) then
	
	end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin #00FF00"..getPlayerName(source).." #FFFFFFhave startet #00FF00'"..thetime.."' #FFFFFF.", getRootElement(), 0, 0, 0, true)
end)

-- Ban Add --

addEventHandler("onMultistuntAdminpanelBanAdd", getRootElement(),function(name, grund, zeit)
	local result = mysql_query(handler, "SELECT * FROM ban WHERE Name = '"..mysql_escape_string(handler, name).."';")
	if(result and mysql_num_rows( result ) > 0) then
		outputChatBox("Der Spieler ist schon gebannt!", source, 255, 0, 0)
		if(result) then mysql_free_result(result) end
	else
		if(result) then mysql_free_result(result) end
		time = zeit*3600
		local _stamp = getRealTime()
		_stamp = _stamp.timestamp
		local stamp = getRealTime( tonumber(_stamp+time) )
		stamp = stamp.timestamp
		local result2 = mysql_query(handler, "INSERT INTO ban ( Name, Admin, Grund, Datum, IP, Serial ) VALUES ( '"..mysql_escape_string(handler, name).."', '"..mysql_escape_string(handler, getPlayerName(source)).."', '"..grund.."', '"..stamp.."', 'NULL', 'NULL' ); " )
		if(result2) then
			outputChatBox("Spieler gebannt!", source, 0, 255, 0)
			outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin #00FF00"..getPlayerName(source).." #FFFFFFbanned #00FF00"..name.." #FFFFFFfor #00FF00"..zeit.." Hours #FF0000.", getRootElement(), 0, 0, 0, true)
			mysql_free_result(result2)
		else
			outputChatBox("Fehler beim Offlinebannen!", source, 255, 0, 0)
		end
	end
end)


-- Ban remove --
addEventHandler("onMultistuntAdminpanelBanRemove", getRootElement(),function(name)
	local result = mysql_query(handler, "SELECT * FROM ban WHERE Name = '"..mysql_escape_string(handler, name).."';")
	if(result and mysql_num_rows( result ) > 0) then
		mysql_query(handler, "DELETE FROM ban WHERE Name = '"..mysql_escape_string(handler, name).."';")
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin #00FF00"..getPlayerName(source).." #FFFFFFunban #00FF00"..name.." #FF0000.", getRootElement(), 0, 0, 0, true)
	else
		if(result) then mysql_free_result(result) end
		outputChatBox("Spieler mit diesem Namen exestiert in der Datenbank nicht!", source, 255, 0, 0)
	end
end)


-- Bans get --
addEventHandler("onMultistuntAdminpanelBansGet", getRootElement(),function()
	local result = mysql_query(handler, "SELECT * FROM ban;")
	if(result) then
		local dsatz
		dsatz = mysql_fetch_assoc(result)
		while dsatz do
			triggerClientEvent(source, "onMultistuntAdminpanelBansGetBack", source, dsatz['Name'], dsatz['Datum'], dsatz['Grund'], dsatz['Admin']) 
			dsatz = mysql_fetch_assoc(result)
		end
		mysql_free_result(result)
	end
end)

-- Rocket Drop
addEventHandler("onMultistuntAdminRocketDrop", getRootElement(), function(hX, hY, hZ)
	local x, y, z = getElementPosition(source)
	local nx, ny, nz = x+10, y+math.random(10, 20), z+30
	local rocket = createObject(3786, nx, ny, nz)
	moveObject(rocket, 1500, hX, hY, hZ)
	setTimer(createExplosion, 1500, 1, hX, hY, hZ, 2)
	setTimer(createExplosion, 1500, 1, hX, hY, hZ+3, 2)
	setTimer(createExplosion, 1550, 1, hX, hY, hZ+6, 2)
	setTimer(createExplosion, 1600, 1, hX, hY, hZ+9, 2)
	setTimer(createExplosion, 1600, 1, hX, hY, hZ, 7)
	setTimer(destroyElement, 1500, 1, rocket)
end)

-- Uzi fire --
local objectveltimer = {}
addEventHandler("onMultistuntAdminUZIFire", getRootElement(), function(theElement)
	if(getElementType(theElement) ~= "object") then
		local vx, vy, vz = getElementVelocity(theElement)
		setElementVelocity(theElement, vx, vy, vz+0.3)
	else
		if(getElementData(theElement, "movingobject") == true) then return end
		if(objectveltimer[theElement] == true) then return end
		objectveltimer[theElement] = true
		local x, y, z = getElementPosition(theElement)
		moveObject(theElement, 1000, x, y, z+5, 0, 0, 0, "OutQuad")
		setTimer( function()
			moveObject(theElement, 1200, x, y, z, 0, 0, 0, "OutBounce")
			setTimer(function() objectveltimer[theElement] = false end, 1200, 1)
		end, 1000, 1)
	end
end)

-- Playerdata

addEventHandler("onMultistuntAdminpanelPlayerdata", getRootElement(), function(theUser)
	triggerClientEvent(source, "onMultistuntAdminpanelPlayerdataBack", source, getPlayerIP(theUser), getPlayerSerial(theUser))
end)
-- porthere
addEventHandler("onMultistuntAdminpanelPorthere", getRootElement(), function(theUser)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	local x, y, z, dim, int
	if(isPedInVehicle(source)) then
		x, y, z = getElementPosition(getPedOccupiedVehicle(source))
		dim, int = getElementDimension(getPedOccupiedVehicle(source)), getElementInterior(getPedOccupiedVehicle(source))
	else
		x, y, z = getElementPosition(source)
		dim, int = getElementDimension(source), getElementInterior(source)
	end
	if(isPedInVehicle(theUser)) then veh = true end
	if(veh == true) then
		setElementPosition(getPedOccupiedVehicle(theUser), x, y+1, z)
		setElementInterior(getPedOccupiedVehicle(theUser), int)
		setElementDimension(getPedOccupiedVehicle(theUser), dim)
	else
		setElementPosition(theUser, x, y+1, z)
		setElementInterior(theUser, int)
		setElementDimension(theUser, dim)

	end
	outputChatBox("Du wurdest von Admin "..getPlayerName(source).." geportet!", theUser, 0, 255, 0)
	outputChatBox("Du hast "..getPlayerName(theUser).." zu dir geportet!", source, 0, 255, 0)
end)

-- Port
addEventHandler("onMultistuntAdminpanelPort", getRootElement(), function(theUser)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	local x, y, z, dim, int
	if(isPedInVehicle(theUser)) then
		x, y, z = getElementPosition(getPedOccupiedVehicle(theUser))
		dim, int = getElementDimension(getPedOccupiedVehicle(theUser)), getElementInterior(getPedOccupiedVehicle(theUser))
	else
		x, y, z = getElementPosition(theUser)
		dim, int = getElementDimension(theUser), getElementInterior(theUser)
	end
	if(isPedInVehicle(source)) then veh = true end
	if(veh == true) then
		setElementPosition(getPedOccupiedVehicle(source), x, y+1, z)
		setElementInterior(getPedOccupiedVehicle(source), int)
		setElementDimension(getPedOccupiedVehicle(source), dim)
	else
		setElementPosition(source, x, y+1, z)
		setElementInterior(source, int)
		setElementDimension(source, dim)

	end
	outputChatBox("Du hast dich zu "..getPlayerName(theUser).." geportet!", source, 0, 255, 0)
end)

-- Slap
addEventHandler("onMultistuntAdminpanelSlap", getRootElement(), function(theUser, grund)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin #00FF00"..getPlayerName(source).." #00FF00slapped #00FF00"..getPlayerName(theUser).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..grund, getRootElement(), 0, 0, 0, true)
	setElementHealth(theUser, getElementHealth(theUser)-20)
	local x, y, z = getElementVelocity(theUser)
	setElementVelocity(theUser, x, y, z+0.3)
end)
-- Explode


addEventHandler("onMultistuntAdminpanelExplode", getRootElement(), function(theUser, grund)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin #00FF00"..getPlayerName(source).." #FFFFFFexplodet #00FF00"..getPlayerName(theUser).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..grund, getRootElement(), 0, 0, 0, true)
	local x, y, z = getElementPosition(theUser)
	if(isPedInVehicle(theUser)) then blowVehicle(getPedOccupiedVehicle(theUser)) else
		createExplosion(x, y, z, 7)
		setElementHealth(theUser, 0)
	end
end)

-- Obst geben
addEventHandler("onMultistuntAdminpanelObstgeben", getRootElement(), function(theUser, anzahl, obst)
	if not(theUser) or not(anzahl) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	local title, data
	if(obst == 1) then title = "Apples" data = "aepfel" end
	if(obst == 2) then title = "Pears" data = "birnen" end
	if(obst == 3) then title = "Bananas" data = "bananen" end
	if(obst == 4) then title = "Cherrys" data = "kirschen" end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] You got "..anzahl.." "..title.." by Admin "..getPlayerName(source).." !", theUser, 0, 0, 0, true)
	outputChatBox("You have given "..getPlayerName(theUser).." "..title.." "..anzahl.." !", source, 0, 255, 0)
	givePlayerItem(theUser, "ms."..data, tonumber(anzahl))
end)


-- Obst setzen
addEventHandler("onMultistuntAdminpanelObstsetzen", getRootElement(), function(theUser, anzahl, obst)
	if not(theUser) or not(anzahl) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	local title, data
	if(obst == 1) then title = "Apples" data = "aepfel" end
	if(obst == 2) then title = "Pears" data = "birnen" end
	if(obst == 3) then title = "Bananas" data = "bananen" end
	if(obst == 4) then title = "Cherrys" data = "kirschen" end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Your "..title.." has been set to "..anzahl.." by "..getPlayerName(source).." !", theUser, 0, 0, 0, true)
	outputChatBox("Du hast "..getPlayerName(theUser).."'s "..title.." auf "..anzahl.." gesetzt!", source, 0, 255, 0)
	setElementData(theUser, "ms."..data, tonumber(anzahl))
end)

-- Adminlevel --
addEventHandler("onMultistuntAdminpanelAdminlevel", getRootElement(), function(theUser, grund, adminlevel)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin #00FF00"..getPlayerName(source).." #FFFFFFhas given #00FF00"..getPlayerName(theUser).." #FFFFFFAdminrights #00FF00"..adminlevel.." #FFFFFF.", getRootElement(), 0, 0, 0, true)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..grund, getRootElement(), 0, 0, 0, true)
	setElementData(theUser, "ms.adminlevel", adminlevel)
end)

-- Waffe geb --
addEventHandler("onMultistuntAdminpanelWaffegeb", getRootElement(), function(theUser, grund, waffe, muni)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	local result = giveWeapon(theUser, waffe, muni, true)
	if(result) then
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] The Weapon "..waffe.." with "..muni.." ammo has been given to you by "..getPlayerName(source).." .", theUser, 0, 0, 0, true)
		outputChatBox("You gave the weapon "..waffe.." with "..muni.." ammo to "..getPlayerName(theUser).."!", source, 0, 255, 0)
	else
		outputChatBox("Error!", source, 255, 0, 0)
	end
end)


-- Fahrzeug Geb ---
addEventHandler("onMultistuntAdminpanelFahrzeuggeb", getRootElement(), function(theUser, grund, model)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	if(isPedInVehicle(theUser)) then
		local veh = getPedOccupiedVehicle(theUser)
		setElementModel(veh, model)
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin "..getPlayerName(source).." gave you the vehicle "..model..".", theUser, 0, 0, 0, true)
		outputChatBox("You have given "..getPlayerName(theUser).." the vehicle "..model.."!", source, 0, 255, 0)
	else
		local x, y, z = getElementPosition(theUser)
		local int, dim = getElementInterior(theUser), getElementDimension(theUser)
		local veh = createVehicle(model, x, y, z+3)
		setElementInterior(veh, int)
		setElementDimension(veh, dim)
		warpPedIntoVehicle(theUser, veh)
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Admin "..getPlayerName(source).." gave you the vehicle "..model..".", theUser, 0, 0, 0, true)
		outputChatBox("You have given "..getPlayerName(theUser).." the vehicle "..model.."!", source, 0, 255, 0)
	end
end)

-- Kill

addEventHandler("onMultistuntAdminpanelKill", getRootElement(), function(theUser, grund)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Player #00FF00"..getPlayerName(theUser).." #FFFFFFhas been killed by #00FF00"..getPlayerName(source).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..grund, getRootElement(), 0, 0, 0, true)
	setElementHealth(theUser, 0)
end)

-- Freeze

addEventHandler("onMultistuntAdminpanelFreeze", getRootElement(), function(theUser, grund)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	local theElement = theUser
	if(isPedInVehicle(theUser) == true) then theElement = getPedOccupiedVehicle(theUser) end
	if(isElementFrozen(theElement) == false) then
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Player #00FF00"..getPlayerName(theUser).." #FFFFFFhas been frozed by #00FF00"..getPlayerName(source).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..grund, getRootElement(), 0, 0, 0, true)
		setElementFrozen(theElement, true)
		toggleAllControls(theUser, false)
	else
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Player #00FF00"..getPlayerName(theUser).." #FFFFFF has been unfrozed by #00FF00"..getPlayerName(source).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
		setElementFrozen(theElement, false)
		toggleAllControls(theUser, true)
	end
end)

local mutetimer = {}

-- Mute
addEventHandler("onMultistuntAdminpanelMute", getRootElement(), function(theUser, grund, zeit)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	if(isPlayerMuted(theUser) == false) then
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Player #00FF00"..getPlayerName(theUser).." #FFFFFF has been muted for #00FF00"..zeit.." minutes #FFFFFFby "..getPlayerName(source).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..grund, getRootElement(), 0, 0, 0, true)
		setPlayerMuted(theUser, true)
		mutetimer[theUser] = setTimer(setPlayerMuted, 1000*60*zeit, 1, theUser, false)
	else
		if(isTimer(mutetimer[theUser])) then killTimer(mutetimer[theUser]) end
		setPlayerMuted(theUser, false)
		outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Player #00FF00"..getPlayerName(theUser).." #FFFFFFhas been un-muted by Admin #00FF00"..getPlayerName(source).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
		
	end
end)

-- Ban
addEventHandler("onMultistuntAdminpanelBan", getRootElement(),
function(playa, text, zeit)
	if not(playa) then return end
	if not(getPlayerFromName(playa)) then return end
	local playa = getPlayerFromName(playa)
	--kickPlayer(playa, source, text)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Player #00FF00"..getPlayerName(playa).." #FFFFFFhas been banned by Admin #00FF00"..getPlayerName(source).." #FFFFFFfor #FF0000"..zeit.." Hours#FFFFFF .", getRootElement(), 0, 0, 0, true)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..text, getRootElement(), 0, 0, 0, true)
	outputServerLog(getPlayerName(source).." hat "..getPlayerName(playa).." mit dem Grund "..text.." fuer "..zeit.." Stunden gebannt.")
	local name = getPlayerName(source)
	local name2 = getPlayerName(playa)
	local ip = getPlayerIP(playa)
	local serial = getPlayerSerial(playa)
	time = zeit*3600
	local _stamp = getRealTime()
	_stamp = _stamp.timestamp
	local stamp = getRealTime( tonumber(_stamp+time) )
	stamp = stamp.timestamp
	
	local query = "INSERT INTO ban ( Name, Admin, Grund, Datum, IP, Serial ) VALUES ( '"..name2.."', '"..name.."', '"..text.."', '"..stamp.."', '"..ip.."', '"..serial.."'  )"
	local result = mysql_query( handler, query )
	kickPlayer(playa,"You have been banned for "..zeit.." Hours by "..name..". \nReason: "..text)
	
	if result then mysql_free_result(result) return true else return false end
end)

-- Kick
addEventHandler("onMultistuntAdminpanelKick", getRootElement(), function(theUser, grund)
	if not(theUser) then outputChatBox("Fehler!", source, 255, 0, 0) return end
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Player#00FF00"..getPlayerName(theUser).." #FFFFFFhas been kicked by Admin #00FF00"..getPlayerName(source).." #FFFFFF.", getRootElement(), 0, 0, 0, true)
	outputChatBox("#FFFFFF[#FF0000ADMINCMD#FFFFFF] Reason: "..grund, getRootElement(), 0, 0, 0, true)
	if(getPlayerArchievement(theUser, 8) == 0) then
		givePlayerArchievement(theUser, 8)
		givePlayerItem(theUser, "ms.birnen", 10) -- Archievement
	end
	kickPlayer(theUser, source, "Reason: "..grund)
end)

-- Ban --

addEventHandler ( "onPlayerConnect", getRootElement(),
	function (playerNick,playerSerial )
	
		local pname = playerNick
		local pserial = playerSerial
		
		local query = mysql_query( handler, "SELECT Name, Datum FROM ban WHERE Name = '"..mysql_escape_string(handler, pname).."'")
		local _query = mysql_query( handler, "SELECT Name, Datum FROM ban WHERE Serial = '"..pserial.."'")
		
		local rows = mysql_num_rows ( query )
		local _rows = mysql_num_rows ( _query )
		local _stamp = getRealTime()
		_stamp = tonumber(_stamp.timestamp)
		
		if rows > 0 then
		
			local dsatz = mysql_fetch_assoc ( query )
			
			if _stamp > tonumber(dsatz["Datum"]) and tonumber(dsatz["Datum"]) == 0 then
			
				cancelEvent( true, "You have been banned permanently. Please contact an admin." )
			
			elseif _stamp > tonumber(dsatz["Datum"]) then
			
				mysql_query( handler, "DELETE FROM ban WHERE Name = '"..pname.."'")
			
			elseif _stamp < tonumber(dsatz["Datum"]) then
			
				cancelEvent( true, "You have been banned. For questions, ask an admin." )
			
			end
			
			return true
		
		end
		
		if _rows > 0 then
		
			local dsatz = mysql_fetch_assoc ( _query )
			
			if _stamp > tonumber(dsatz["Datum"]) and tonumber(dsatz["Datum"]) == 0 then
			
				cancelEvent( true, "You have been banned permanently. Please contact an admin." )
			
			elseif _stamp > tonumber(dsatz["Datum"]) then
			
				mysql_query( handler, "DELETE FROM ban WHERE Serial = '"..pserial.."'")
			
			elseif _stamp < tonumber(dsatz["Datum"]) then
			
				cancelEvent( true, "You have been banned. For questions, ask an admin." )
			
			end
			
			return true
		
		end
	end )