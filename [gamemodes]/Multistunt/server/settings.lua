local mysqlhost = "localhost"
local mysqluser = "root"
local mysqlpw = ""
local mysqldatabase = "dbs_multistunt"
-- Secondary Connection, if connection 1 doesn't work --

local mysqlhost2 = "127.0.0.1"
local mysqluser2 = "multivan"
local mysqlpw2 = "schnurri12"
local mysqldatabase2 = "dbs_multistunt"

handler = mysql_connect ( mysqlhost, mysqluser, mysqlpw, mysqldatabase )

if not(handler) then outputServerLog("Can't connect to MySQL Host "..mysqlhost..", User: "..mysqluser..", Password: "..mysqlpw..", Database: "..mysqldatabase.."\nTrying second host.") 
	handler = mysql_connect ( mysqlhost2, mysqluser2, mysqlpw2, mysqldatabase2 )
	if not(handler) then
		outputServerLog("Can't Connect to MySQL Secondary host, because Host 1 doesn't work! Shutting down...")
		stopResource(getResourceFromName("Multistunt"))
	end
end

setFPSLimit(100)

IdleCarRespawn = 20

setWeaponProperty ( "uzi", "poor", "weapon_range", 150 )
setWeaponProperty ( "uzi", "std", "weapon_range", 150 )
setWeaponProperty ( "uzi", "pro", "weapon_range", 150 )

setWeaponProperty ( "uzi", "poor", "maximum_clip_ammo", 1000 )
setWeaponProperty ( "uzi", "std", "maximum_clip_ammo", 1000 )
setWeaponProperty ( "uzi", "pro", "maximum_clip_ammo", 1000 )

local fadeP = {}
function setInPosition(thePlayer, x, y, z, interior, typ)
	if not(thePlayer) then return end
	if (getElementType(thePlayer) == "vehicle") then return end
	if(isPedInVehicle(thePlayer)) then return end
	if not(x) or not(y) or not(z) then return end
	if not(interior) then interior = 0 end
	if(fadeP[thePlayer] == 1) then return end
	fadeP[thePlayer] = 1
	fadeCamera(thePlayer, false)
	setElementFrozen(thePlayer, true)
	setTimer(
		function()
		fadeP[thePlayer] = 0
		setElementPosition(thePlayer, x, y, z)
		setElementInterior(thePlayer, interior)
		fadeCamera(thePlayer, true)
		if not(typ) then
			setElementFrozen(thePlayer, false)
		else
			if(typ == true)  then
				setTimer(setElementFrozen, 1000, 1, thePlayer, false)
			end
		end
		end, 1000, 1)
end

addEventHandler("onPlayerJoin", getRootElement(), function()
	if(getElementType(source) == "player") then
		fadeCamera(source, true)
		setCameraMatrix(source, -1380.8830566406, -197.49746704102, 14.869724273682, -1390.7825927734, -98.298355102539, 7.025297164917)
		for i = 1, 10, 1 do
			outputChatBox(" ", source)
		end
	end
end)

addEventHandler("onResourceStart", getResourceRootElement(), function() 
	if(getResourceState(getResourceFromName("helpmanager")) == "running") then 
		stopResource(getResourceFromName("helpmanager")) 
	end
	if(getResourceState(getResourceFromName("scoreboard")) == "running") then 
		stopResource(getResourceFromName("scoreboard")) 
	end
	if(getResourceState(getResourceFromName("interiors")) == "running") then 
		stopResource(getResourceFromName("interiors")) 
	end
	if(getResourceState(getResourceFromName("freeroam")) == "running") then 
		stopResource(getResourceFromName("freeroam")) 
	end
	if(getResourceState(getResourceFromName("joinquit")) == "running") then 
		stopResource(getResourceFromName("joinquit")) 
	end
	setTimer(function()
		outputServerLog("Fahrzeuge: "..#getElementsByType("vehicle"))
		outputServerLog("Objekte: "..#getElementsByType("object"))
	end, 1550, 1)
	setWaterColor(100, 200, 200, 150)
	setGameType("Stunt")
end)

addEventHandler("onPlayerChangeNick", getRootElement(), function()
	cancelEvent(true)
end) 

function o_removePedFromVehicle(thePlayer) -- Total Scheisse --
	if not(thePlayer) then return end
	if not(getElementType(thePlayer) == "player") then return end
	local state = getPedOccupiedVehicleSeat ( thePlayer)
	if(state == 0) or (state == 2) then
		removePedFromVehicle(thePlayer)
		local x, y, z = getElementPosition(thePlayer)
		setElementPosition(thePlayer, x, y-1, z)
		setTimer(setPedAnimation, 500, 1, thePlayer, "ped", "CAR_getout_LHS", 1000, false, true, true)
	else
		removePedFromVehicle(thePlayer)
		local x, y, z = getElementPosition(thePlayer)
		setElementPosition(thePlayer, x, y+1, z)
		setTimer(setPedAnimation, 500, 1, thePlayer, "ped", "CAR_getout_RHS", 1000, false, true, true)	
	end
end
function giveVehicleBetterEngine(theVehicle)
	if(getElementType(theVehicle) == "vehicle") then
		if(getVehicleType(theVehicle) == "Boat") then return end
		setVehicleHandling(theVehicle, "engineAcceleration", (getVehicleHandling(theVehicle)['engineAcceleration']/100*120))
		setVehicleHandling(theVehicle, "maxVelocity", (getVehicleHandling(theVehicle)['maxVelocity']100*120))
	end
end

function giveVehiclePanzerung(theVehicle)
	if(getElementType(theVehicle) == "vehicle") then
		if(tonumber(getVehicleHandling(theVehicle)['collisionDamageMultiplier']) < 0.3) then setVehicleHandling(theVehicle, "collisionDamageMultiplier", 0) else
			setVehicleHandling(theVehicle, "collisionDamageMultiplier", (getVehicleHandling(theVehicle)['collisionDamageMultiplier']-0.3))
		end
	end
end

function givePlayerStuntObst(thePlayer, obst, anzahl)
	if(obst == "Aepfel") or (obst == "aepfel") then
		givePlayerItem(thePlayer, "ms.aepfel", anzahl)
	elseif (obst == "Birnen") or (obst == "birnen") then
		givePlayerItem(thePlayer, "ms.birnen", anzahl)
	elseif (obst == "Bananen") or (obst == "bananen") then	
		givePlayerItem(thePlayer, "ms.bananen", anzahl)
	elseif (obst == "Kirschen") or (obst == "kirschen") then
		givePlayerItem(thePlayer, "ms.kirschen", anzahl)
	end
end

local randPosSpecialEffect = {
	[1] = "0.05",
	[2] = "0.1",
	[3] = "0.15",
	[4] = "0.2",
	[5] = "0.25",
	[6] = "0.3",
	[7] = "0.4",
	[8] = "0.5"
}

function addSpecialEffect(theEffect, theElement, colour)
	if not(isElement(theElement)) then return end
	local x, y, z = getElementPosition(theElement)
	if(theEffect == "leuchtrakete") then
		if(getElementType(theElement) == "vehicle") then z = z+0.5 end
		local r, g, b = 255, 255, 255
		if(colour == "blau") then r, g, b = 0, 0, 255 end
		if(colour == "rot") then r, g, b = 255, 0, 0 end
		if(colour == "gruen") then r, g, b = 0, 255, 0 end
		if(colour == "gelb") then r, g, b = 255, 255, 0 end
		if(colour == "aqua") then r, g, b = 0, 255, 255 end
		local veh = createVehicle(594, x, y, z)
		setElementAlpha(veh, 1)
		local marker = {}
		marker[1] = createMarker(x, y, z, "corona", 1.0, r, g, b, 155)
		marker[2] = createMarker(x, y, z, "corona", 1.0, r, g, b, 155)
		marker[3] = createMarker(x, y, z, "corona", 1.0, r, g, b, 155)
		marker[4] = createMarker(x, y, z, "corona", 1.0, r, g, b, 155)
		marker[5] = createMarker(x, y, z, "corona", 1.0, r, g, b, 155)
		setElementData(marker[1], "leuchtrakete", true)
		for i = 1, 5, 1 do
			
			attachElements(marker[i], veh)
			setTimer(destroyElement, 1500, 1, marker[i])
		end
		
		setElementVelocity(veh, 0, 0, 0.45)
		setTimer(destroyElement, 1500, 1, veh)
		return veh
	end
end

function sendInfoMessage(text, thePlayer, color)
	if(isElement(thePlayer) == false) then return end
	local colour
	if(color == "red") or (color == "Red") then colour = "#FF0000" end
	if(color == "green") or (color == "Green") then colour = "#00FF00" end
	if(color == "blue") or (color == "Blue") then colour = "#0000FF" end
	if(color == "aqua") or (color == "Aqua") then colour = "#00FFFF" end
	if(color == "yellow") or (color == "Yellow") then colour = "#FFFF00" end
	if(color == "White") or (color == "white") then colour = "#FFFFFF" end
	if(color == "black") or (color == "Black") then colour = "#000000" end
	return outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] "..colour..text, thePlayer, 0, 0, 0, true)
end

function givePlayerBadge(thePlayer, id)
	local data = getElementData(thePlayer, "ms.badges")
	local done = false
	for i = 1, max_badges, 1 do
		if(gettok(data, i, "|")) and (tonumber(gettok(data, i, "|")) == id) then
			done = true
			break;
		end
	end
	if(done == true) then return end
	sendInfoMessage("You have received a badge: "..badge_names[id].."!", thePlayer, "green")
	local badges = getElementData(thePlayer, "ms.badges")
	if(badges == "0") then badges = "|0|" end
	setElementData(thePlayer, "ms.badges", badges..id.."|")
	if(source) and (getElementType(source) == "player") then
		outputServerLog(getPlayerName(source).." gab "..getPlayerName(thePlayer).." das Badge "..badge_names[id]..".")
	end
end

addEvent("onMultistuntBadgeGive", true)
addEventHandler("onMultistuntBadgeGive", getRootElement(), givePlayerBadge)
