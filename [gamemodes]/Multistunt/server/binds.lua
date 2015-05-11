
-- Jetpack functions --
function toggleJackpack(thePlayer)
	if(isPedInVehicle(thePlayer)) then return end
	if(isPlayerEingeloggt(thePlayer)) then else return end
	if(doesPedHaveJetPack(thePlayer)) then
		removePedJetPack(thePlayer)
	else
		givePedJetPack(thePlayer)
	end
end

function togglePlayerVehicleLights(thePlayer)
	if(isPedInVehicle(thePlayer) == false) then return end
	if(isPlayerEingeloggt(thePlayer)) then else return end
	local locked = isVehicleLocked(getPedOccupiedVehicle(thePlayer))
	setVehicleLocked(getPedOccupiedVehicle(thePlayer), (not locked))
	local praefix = "unlocked"
	if(locked == true) then praefix = "locked" end
	sendInfoMessage("You "..praefix.." your vehicle.", thePlayer, "aqua")
end


addEventHandler("onPlayerJoin", getRootElement(), function()
	if(source) and (getElementType(source) == "player") then
		bindKey(source, "j", "down", toggleJackpack, source)
		bindKey(source, "l", "down", togglePlayerVehicleLights, source)
	end
end)

addEventHandler("onPlayerVehicleStartEnter", getRootElement(), function()
	if(doesPedHaveJetPack(source)) then
		removePedJetPack(source)
	end
end)

addEventHandler("onPlayerWasted", getRootElement(), function()
	if(doesPedHaveJetPack(source)) then
		removePedJetPack(source)
	end
end)
--