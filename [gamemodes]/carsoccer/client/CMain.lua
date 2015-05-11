--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Carball' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


local cFunc = {}
local cSetting = {}


cSetting["jump_timer"] = nil

cSetting["publikum"] = nil

addEvent("onClientCarballStadiumEnter", true)
addEvent("onClientCarballStadiumLeave", true)


setMinuteDuration(10000000)
setTime(12, 00)

-- FUNCTIONS --

cFunc["jump_vehicle"] = function()
	local veh = getPedOccupiedVehicle(localPlayer)
	if(veh) and not(isTimer(cSetting["jump_timer"])) then
		local x, y, z = getElementVelocity(veh)
		setElementVelocity(veh, x, y, z+0.5)
		cSetting["jump_timer"] = setTimer(function() end, 5000, 1)
		
		doJumpMe_Func()
	end
end

cFunc["on_start"] = function()
	if(isPedInVehicle(localPlayer) == false) then
		triggerServerEvent("onCBPlayerJoin", localPlayer)
		fadeCamera(true)
		setCameraTarget(localPlayer)

		toggleAllControls(true)
		
		showPlayerHudComponent("all", false)
		
		bindKey("lshift", "down", cFunc["jump_vehicle"])
		cSetting["publikum"] = playSound("http://www.yourdawi.de/noneatme/stadium.mp3", true)
		setSoundVolume(cSetting["publikum"], 0)
	end
end

cFunc["stadion_enter"] = function()
	if not(isDevMode()) then
		setSoundVolume(cSetting["publikum"], 0.7) -- 0.7!!!
	end
end
cFunc["stadion_leave"] = function()
	setSoundVolume(cSetting["publikum"], 0)
end

-- EVENT HANDLERS --

cFunc["on_start"]()
addEventHandler("onClientCarballStadiumEnter", getLocalPlayer(), cFunc["stadion_enter"])
addEventHandler("onClientCarballStadiumLeave", getLocalPlayer(), cFunc["stadion_leave"])