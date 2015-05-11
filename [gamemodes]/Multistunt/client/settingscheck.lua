local hvar = 0
function checkMultistuntSettingsData()
	if(isLoggedIn(gMe) == false) then return end
	local data = {}
	data[3] = tonumber(getPlayerSetting(gMe, "fgodmode"))
	data[4] = tonumber(getPlayerSetting(gMe, "radar"))
	data[5] = tonumber(getPlayerSetting(gMe, "hud"))
	data[6] = tonumber(getPlayerSetting(gMe, "chat"))
	data[7] = tonumber(getPlayerSetting(gMe, "realtime"))
	-- Obstbar

	-- Fgodmode
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(data[3] == 1) then
			if(isVehicleDamageProof(veh) == false) then
				setVehicleDamageProof(veh, true)
			end
			
		else
			if(isVehicleDamageProof(veh) == true) then
				setVehicleDamageProof(veh, false)
			end
		end
	end
	if(data[5] == 1) then
		if(hvar == 1) then return end
		hvar = 1
		showPlayerHudComponent("all", true)
		showPlayerHudComponent("money", false)
	else
		if(hvar == 0) then return end
		hvar = 0
		showPlayerHudComponent("all", false)
	end
	if(data[6] == 1) then
		showChat(true)
	else
		showChat(false)
	end
	if(data[7] == 1) then
		if(getMinuteDuration() == 60000) then return end
		local time = getRealTime()
		setTime(time.hour, time.minute)
		setMinuteDuration(60000)
	else
		if(getMinuteDuration() == 60000) then 
			setMinuteDuration(1000)
			
		end
	end
end

setTimer(checkMultistuntSettingsData, 500, 0)

addEventHandler("onClientPlayerDamage", gMe, function()
	if(tonumber(getPlayerSetting(gMe, "godmode")) == 1) then
		cancelEvent()
	end
end)