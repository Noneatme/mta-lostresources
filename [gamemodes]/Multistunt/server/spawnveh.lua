addEvent("onMultistuntVehicleSpawn", true)
addEvent("onMultistuntVehicleDelete", true)
addEvent("onMultistuntVehicleCall", true)

local function createPlayerCar(thePlayer, id)
	local veh1, veh2, nextveh = getElementData(thePlayer, "msv.1"), getElementData(thePlayer, "msv.2"), getElementData(thePlayer, "msv.nextveh")
	local x, y, z = getElementPosition(thePlayer)
	local int, dim, rotx, roty, rotz = getElementInterior(thePlayer), getElementDimension(thePlayer), getElementRotation(thePlayer)
	if not(nextveh) then
		local veh = createVehicle(id, x, y, z, rotx, roty, rotz, getPlayerName(thePlayer))
		setElementData(thePlayer, "msv.1", veh)
		warpPedIntoVehicle(thePlayer, veh)
		sendInfoMessage("Vehicle sucessfull created!", thePlayer, "green")
		setElementData(thePlayer, "msv.nextveh", 1)
		setElementInterior(veh, int)
		setElementDimension(veh, dim)
		setElementData(veh, "msv.player", thePlayer)
		setElementData(veh, "msv.state", 1)
		setElementData(veh, "msv.veh", true)
	else
		if(tonumber(nextveh) == 1) then
			local veh = createVehicle(id, x, y, z, rotx, roty, rotz, getPlayerName(thePlayer))
			setElementData(thePlayer, "msv.2", veh)
			warpPedIntoVehicle(thePlayer, veh)
			sendInfoMessage("Vehicle sucessfull created!", thePlayer, "green")
			setElementData(thePlayer, "msv.nextveh", 2)
			setElementInterior(veh, int)
			setElementDimension(veh, dim)
			setElementData(veh, "msv.player", thePlayer)
			setElementData(veh, "msv.state", 2)
			setElementData(veh, "msv.veh", true)
		elseif(tonumber(nextveh) == 2) then
			if(isElement(veh1)) then destroyElement(veh1) end
			local veh = createVehicle(id, x, y, z, rotx, roty, rotz, getPlayerName(thePlayer))
			setElementData(thePlayer, "msv.1", veh)
			warpPedIntoVehicle(thePlayer, veh)
			sendInfoMessage("Vehicle sucessfull created!", thePlayer, "green")
			setElementData(thePlayer, "msv.nextveh", 3)
			setElementInterior(veh, int)
			setElementDimension(veh, dim)
			setElementData(veh, "msv.player", thePlayer)
			setElementData(veh, "msv.state", 1)
			setElementData(veh, "msv.veh", true)
		elseif(tonumber(nextveh) == 3) then
			if(isElement(veh2)) then destroyElement(veh2) end
			local veh = createVehicle(id, x, y, z, rotx, roty, rotz, getPlayerName(thePlayer))
			setElementData(thePlayer, "msv.2", veh)
			warpPedIntoVehicle(thePlayer, veh)
			sendInfoMessage("Vehicle sucessfull created!", thePlayer, "green")
			setElementData(thePlayer, "msv.nextveh", 2)
			setElementInterior(veh, int)
			setElementDimension(veh, dim)
			setElementData(veh, "msv.player", thePlayer)
			setElementData(veh, "msv.state", 2)
			setElementData(veh, "msv.veh", true)
		end
	end
	--[[
	if(isElement(veh1)) then
		if(isElement(veh2)) then
			destroyElement(veh1)
			local veh = createVehicle(id, x, y, z, rotx, roty, rotz, getPlayerName(thePlayer))
			setElementData(thePlayer, "msv.1", veh)
			warpPedIntoVehicle(thePlayer, veh)
			sendInfoMessage("Vehicle sucessfull created!", thePlayer, "green")
		else
			local veh = createVehicle(id, x, y, z, rotx, roty, rotz, getPlayerName(thePlayer))
			setElementData(thePlayer, "msv.2", veh)
			warpPedIntoVehicle(thePlayer, veh)
			sendInfoMessage("Vehicle sucessfull created!", thePlayer, "green")
		end
	else
		local veh = createVehicle(id, x, y, z, rotx, roty, rotz, getPlayerName(thePlayer))
		setElementData(thePlayer, "msv.1", veh)
		warpPedIntoVehicle(thePlayer, veh)
		sendInfoMessage("Vehicle sucessfull created!", thePlayer, "green")
	end
	--]]
end


addEventHandler("onElementDestroy", getRootElement(), function()
	if(getElementType(source) == "vehicle") then
		if(getElementData(source, "msv.veh") == true) then
			local player = getElementData(source, "msv.player")
			local veh = getElementData(source, "msv.state")
			setElementData(player, "msv."..veh, nil)
			
		end
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
	if(isElement(getElementData(source, "msv.1"))) then
		destroyElement(getElementData(source, "msv.1"))
	end
	if(isElement(getElementData(source, "msv.2"))) then
		destroyElement(getElementData(source, "msv.2"))
	end
end)


addEventHandler("onMultistuntVehicleSpawn", getRootElement(), function(id)
	createPlayerCar(source, id)
end)

addEventHandler("onMultistuntVehicleCall", getRootElement(), function(id)
	local veh
	if(id == 1) then veh = getElementData(source, "msv.1") elseif(id == 2) then veh = getElementData(source, "msv.2") end
	local x, y, z = getElementPosition(source)
	local int, dim = getElementInterior(source), getElementDimension(source)
	setElementPosition(veh, x, y, z)
	setElementInterior(veh, int)
	setElementDimension(veh, dim)
	warpPedIntoVehicle(source, veh)
	sendInfoMessage("Your vehicle has been warped to you!", source, "green")
end)

addEventHandler("onMultistuntVehicleDelete", getRootElement(), function(id)
	if(id == 1) then
		destroyElement(getElementData(source, "msv.1"))
		setElementData(source, "msv.nextveh", 2)
		sendInfoMessage("Vehicle has been sucessfull deleted!", source, "green")
		triggerClientEvent(source, "onMultistunVehicleListRefresh", source)
	elseif(id == 2) then
		destroyElement(getElementData(source, "msv.2"))
		setElementData(source, "msv.nextveh", 3)
		sendInfoMessage("Vehicle has been sucessfull deleted!", source, "green")
		triggerClientEvent(source, "onMultistunVehicleListRefresh", source)
	end
end)