local doingSpeedboost = {}
local speedOn = {}
doingSpeedboost["lmb"] = false
doingSpeedboost["rmb"] = false
speedOn["lmb"] = false
speedOn["rmb"] = false


setTimer(function()
	for i = 1, 2, 1 do
		local mouse
		if(i == 1) then mouse = "lmb" else mouse = "rmb" end
		if(doingSpeedboost[mouse] == true) then
			if(isPedInVehicle(gMe)) then
				if(getElementData(gMe, "ms.doingstunt") == true) then
					doingSpeedboost[mouse] = false
					speedOn[mouse] = false
					return
				end
				if(getElementData(gMe, "cursorshowing") == true) then 
					doingSpeedboost[mouse] = false
					speedOn[mouse] = false
					return 
				end
				local veh = getPedOccupiedVehicle(gMe)
				if(math.ceil(getElementSpeed(veh)) < 5) or (math.ceil(getElementSpeed(veh)) > 500000) then return end
				setElementSpeed(veh, "kmh", getElementSpeed(veh)+5)
				if(math.ceil(getElementSpeed(veh)) > 400) then
					triggerEvent("onMultistuntArchievementCheck", gMe, 5) -- Archievement
				end
				local x, y, z = getElementPosition(veh)
				
				fxAddDebris ( x+1, y, z, 255, 255, 255, 255, 0.5, 1 )
				fxAddDebris ( x-1, y, z, 255, 255, 255, 255, 0.5, 1 )
				fxAddDebris ( x, y+1, z, 255, 255, 255, 255, 0.5, 1 )
				fxAddDebris ( x, y-1, z, 255, 255, 255, 255, 0.5, 1 )
			else
				doingSpeedboost[mouse] = false
				speedOn[mouse] = false
			end
		end
	end
end, 50, 0)

local function speed_func(key, keystate)
	if(isPlayerEingeloggt(gMe) == false) then return end
	if(getGuiState() == 1) then return end
	if(isPedInVehicle(gMe) == false) then return end
	if(getElementData(gMe, "ms.doingstunt") == true) then return end
	if(getElementData(gMe, "cursorshowing") == true) then return end
	local mouse
	if(key == "mouse1") then mouse = "lmb" else mouse = "rmb" end
	local id = tonumber(getPlayerSetting(gMe, mouse))
	if(id == 2) then
		if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			if(math.ceil(getElementSpeed(veh)) < 5) or (math.ceil(getElementSpeed(veh)) > 500000) then return end
				if(speedOn[mouse] == true) and(keystate ~= "up") then return end
				if(keystate == "down") then
					speedOn[mouse] = true
				else
					speedOn[mouse] = false
				end
				if(keystate == "down") then
					doingSpeedboost[mouse] = true
				else
					doingSpeedboost[mouse] = false
				end

			end
			
		end
	end
end


function mouse1_function()
	if(isPlayerEingeloggt(gMe) == false) then return end
	if(getGuiState() == 1) then return end
	if(isPedInVehicle(gMe) == false) then return end
	if(getElementData(gMe, "ms.doingstunt") == true) then return end
	if(getElementData(gMe, "cursorshowing") == true) then return end
	local id = tonumber(getPlayerSetting(gMe, "lmb"))
	if(id == 1) then -- nichts
		return
	--[[
	elseif(id == 2) then -- Speedboost
		if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			if(math.ceil(getElementSpeed(veh)) < 5) or (math.ceil(getElementSpeed(veh)) > 500000) then return end
				setElementSpeed(veh, "kmh", getElementSpeed(veh)+20)
				if(math.ceil(getElementSpeed(veh)) > 400) then
					triggerEvent("onMultistuntArchievementCheck", gMe, 5) -- Archievement
				end
			end
			
		end]]
	elseif(id == 3) then -- Nitro
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			addVehicleUpgrade(veh, 1010)
		end
	end
	elseif(id == 4) then -- Repair
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			fixVehicle(veh)
		end
	end
	elseif(id == 5) then -- Sprung
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			local x, y, z = getElementVelocity(veh)
			setElementVelocity(veh, x, y, z+0.5)
			if(z > 3) then
				triggerEvent("onMultistuntArchievementCheck", gMe, 4) -- Archievement
			end
		end
	end
	elseif(id == 6) then -- Drehung
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			local x, y, z = getElementRotation(veh)
			setElementRotation(veh, x, y, z+180)
		end
	end
	elseif(id == 7) then -- Flip
		if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			local x, y, z = getElementRotation(veh)
			setElementRotation(veh, x+180, y, z)
		end
	end
	end
end

function mouse2_function()
	if(isPlayerEingeloggt(gMe) == false) then return end
	if(isPedInVehicle(gMe) == false) then return end
	if(getGuiState() == 1) then return end
	if(getElementData(gMe, "ms.doingstunt") == true) then return end
	if(getElementData(gMe, "cursorshowing") == true) then return end
	local id = tonumber(getPlayerSetting(gMe, "rmb"))
	if(id == 1) then -- nichts
		return
	--[[elseif(id == 2) then -- Speedboost
		if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			if(math.ceil(getElementSpeed(veh)) < 5) or (math.ceil(getElementSpeed(veh)) > 500000) then return end
				setElementSpeed(veh, "kmh", getElementSpeed(veh)+20)
			if(math.ceil(getElementSpeed(veh)) > 400) then
				triggerEvent("onMultistuntArchievementCheck", gMe, 5) -- Archievement
				end
			end
		end]]
	elseif(id == 3) then -- Nitro
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			addVehicleUpgrade(veh, 1010)
		end
	end
	elseif(id == 4) then -- Repair
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			fixVehicle(veh)
		end
	end
	elseif(id == 5) then -- Sprung
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			local x, y, z = getElementVelocity(veh)
			setElementVelocity(veh, x, y, z+0.5)
			if(z > 3) then
				triggerEvent("onMultistuntArchievementCheck", gMe, 4) -- Archievement
			end
		end
	end
	elseif(id == 6) then -- Drehung
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			local x, y, z = getElementRotation(veh)
			setElementRotation(veh, x, y, z+180)
		end
	end
	elseif(id == 7) then -- Flip
		if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			local x, y, z = getElementRotation(veh)
			setElementRotation(veh, x+180, y, z)
		end
	end
	end
end

function triggerSpeedBoost()
	if(isPedInVehicle(gMe)) then
		local veh = getPedOccupiedVehicle(gMe)
		if(getVehicleOccupant(veh) == gMe) then
			if(math.ceil(getElementSpeed(veh)) < 5) or (math.ceil(getElementSpeed(veh)) > 500000) then return end
			setElementSpeed(veh, "kmh", getElementSpeed(veh)+20)
			--triggerServerEvent("onMultistuntSpeedboostStart", gMe)
		end
	end
end

bindKey("mouse1", "down", mouse1_function)
bindKey("mouse2", "down", mouse2_function)

bindKey("mouse1", "both", speed_func)
bindKey("mouse2", "both", speed_func)