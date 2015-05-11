setFPSLimit(70)
addEventHandler("onResourceStart", getResourceRootElement(), function()
	outputServerLog("Starte Script...")
	setTimer( function()
		outputServerLog(#getElementsByType("vehicle").." Fahrzeuge erstellt.")
		outputServerLog(#getElementsByType("object").." Objekte erstellt.")
		outputServerLog("___________________________")
		outputServerLog("")
		outputServerLog("Multistunt bei MuLTi.")
		outputServerLog("")
		outputServerLog("___________________________")
		for index, car in pairs(getElementsByType("vehicle")) do
			if(getElementData(car, "mv.typ") == "Freecar") then
				toggleVehicleRespawn ( car, true )
				setVehicleRespawnDelay ( car, 5000 )
				setVehicleIdleRespawnDelay ( car, IdleCarRespawn*1000*60 )
				giveVehicleBetterEngine(car)
				giveVehiclePanzerung(car)
			end
		end
	end, 1000, 1)
end)

addEventHandler("onPlayerJoin", getRootElement(), function()
	outputChatBox("#00FF00"..getPlayerName(source).."#FFFFFF has joined the server.", getRootElement(), 0, 0, 0, true)
end)
addEventHandler("onPlayerQuit", getRootElement(), function(typ)
	outputChatBox("#FF0000"..getPlayerName(source).."#FFFFFF has left the Server.(#00FFFF"..tostring(typ)..")", getRootElement(), 0, 0, 0, true)
	if(typ == "Timed Out") or (typ == "timed out") or (typ == "Timed out") then
		if(isPedInVehicle(source) == false) then
			if(isPlayerEingeloggt(source) == true) then
				local x, y, z = getElementPosition(source)
				local int, dim = getElementInterior(source), getElementDimension(source)
				mysql_query(handler, "UPDATE settings SET X = '"..x.."', Y = '"..y.."', Z = '"..z.."', LASTINT = '"..int.."', LASTDIM = '"..dim.."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';")
			end 
		end
	end
end)

addEventHandler("onResourceStop", getResourceRootElement(), function()
	for index, player in pairs(getElementsByType("player")) do
		if(isPedInVehicle(player) == false) then
			if(isPlayerEingeloggt(player) == true) then
				local x, y, z = getElementPosition(player)
				local int, dim = getElementInterior(player), getElementDimension(player)
				mysql_query(handler, "UPDATE settings SET X = '"..x.."', Y = '"..y.."', Z = '"..z.."', LASTINT = '"..int.."', LASTDIM = '"..dim.."' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(player)).."';")
			end
		end
		kickPlayer(player, "Console", "Server Restart.")
	end
end)

addEvent("onResoutionKick", true)
addEventHandler("onResoutionKick", getRootElement(), function()
	kickPlayer(source, "Server", "Minimal resolution: 800x600")
end)

--[[
addCommandHandler("cv", function(thePlayer, cmd, param)
	if(param) then
		local x, y, z = getElementPosition(thePlayer)
		local carid
		if(getVehicleModelFromName(param)) then carid = getVehicleModelFromName(param) else carid = tonumber(param) end
		if not (carid) then return end
		local veh = createVehicle(carid, x, y+2, z, 0, 0, 0, getPlayerName(thePlayer))
		warpPedIntoVehicle(thePlayer, veh)
	end
end)--]]