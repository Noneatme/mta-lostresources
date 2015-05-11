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


addEvent("onClientCarballsGetB", true)
addEvent("onCarballPosUpdate", true)

-- 2912
local cFunc = {}
local cSetting = {}

local last_id = 1

G_ball = {}


cSetting["hit_timer"] = {}

-- FUNCTIONS --

cFunc["hit_ball"] = function(hitElement, force)
	if(isPedInVehicle(localPlayer)) then
		setVehicleDamageProof(getPedOccupiedVehicle(localPlayer), true)
	end
	if(hitElement) and (getElementDimension(hitElement) == getElementDimension(localPlayer)) then
		if(isBall(hitElement)) and not(isTimer(cSetting["hit_timer"][hitElement])) then
			local x, y, z = getElementPosition(hitElement)
			local throw = false
			local s = playSound3D("data/sounds/kick.mp3", x, y, z, false)
			setElementDimension(s, getElementDimension(hitElement))
			setSoundMaxDistance(s, 100)
			setSoundVolume(s, 0.5)
			x, y, z = getElementVelocity(hitElement)
			if(getElementData(hitElement, "throw") == true) then
				local x2, y2, z2 = getElementPosition(hitElement)
				createExplosion(x2, y2, z2, 7)
				outputInfobox("Double throw! Dafuq!", 200, 200, 0)
			end
			if(force > 500) then
				throw = true
				addBigThrow(hitElement)
			end
			if(force > 100) then
				force = 100
				
			end
			local nx, ny, nz = x*(force/30), y*(force/30), z+((force/300)*1.01)
			if(source == getPedOccupiedVehicle(localPlayer)) then
				x, y, z = getElementPosition(hitElement)
				triggerServerEvent("onCarballNewSyncher", localPlayer, hitElement)
				triggerServerEvent("onCarballBallUpdate", localPlayer, hitElement, x, y, z, nx, ny, nz)
				
				if(throw == true) then
					outputInfobox("Wow, that was a throw!", 255, 255, 0)
				end
			end
			setElementVelocity(hitElement, nx, ny, nz)
			
			cSetting["hit_timer"][hitElement] = setTimer(function() end, 250, 1)
		end
	end
end
cFunc["replace"] = function()
	local txd = engineLoadTXD ("data/balltexture.txd")
	engineImportTXD (txd, 2912 )

	local col = engineLoadCOL ( "data/ballcollision.col")
	engineReplaceCOL (col, 2912)
	
	local dff = engineLoadDFF ("data/balltexture.dff", 2912)
	engineReplaceModel (dff, 2912)
	engineSetModelLODDistance (2912, 10000)
	
	triggerServerEvent("onClientCarballsGet", localPlayer)
	
end




cFunc["balls_get"] = function(bs)
	G_ball = bs
	
	for index, ball in pairs(bs) do
		--[[
		local col = createColSphere(-1378.4273681641, -122.171875, 14.1484375, 1)
		attachElements(col, ball, 0, 0, 1)
		setElementData(col, "last_id", last_id)
		
		addEventHandler("onClientColShapeHit", col, cFunc["hit_ball"])]]
		
		last_id = last_id+1
	end
	
end


cFunc["sync_ball"] = function(last_syncher, ball, x, y, z, x2, y2, z2)
	if(last_syncher ~= localPlayer) then
		setElementPosition(ball, x, y, z)
		setElementVelocity(ball, x2, y2, z2)
	end
end

isBall = function(ball)
	return getElementData(ball, "ball")
end

getBallLastSyncher = function(ball)
	return getElementData(ball, "lastsyncher")
end

-- EVENT HANDLERS --

cFunc["replace"]()
addEventHandler("onClientCarballsGetB", getLocalPlayer(), cFunc["balls_get"])
addEventHandler("onClientVehicleCollision", getRootElement(), cFunc["hit_ball"])
addEventHandler("onCarballPosUpdate", getRootElement(), cFunc["sync_ball"])