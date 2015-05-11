--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Custom Escalators' - Resource for MTA: San Andreas         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


local cFunc = {}
local cSetting = {}

Escalator = {}
Escalator.__index = Escalator

-- Steps: 1656
-- Test ID: 3586

engineSetModelLODDistance(1656, 50)

-- FUNCTIONS --

-- //////////////////////////
-- ///// New Escalator //////
-- //////////////////////////

function Escalator:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end

-- //////////////////////////
-- ///// Constructor   //////
-- //////////////////////////

function Escalator:Constructor(x1, y1, z1, x2, y2, z2, obereLaenge2, untereLaenge2, reverse2, speed2)
	-- // Assertion
	assert(speed2 >= 50, "Minimum speed 50 MS") 
	-- // Variables 
	self.startPos = {x1, y1, z1}
	self.endPos = {x2, y2, z2}
	self.obereLaenge = obereLaenge2
	self.untereLaenge = untereLaenge2
	self.reverse = reverse2
	self.speed = speed2
	self.steps = {}
	self.stepcount = 0
	self.stepstate = {}
	self.obereSteps = {}
	self.untereSteps = {}
	self.respawnTimer = {}
	self.dis = getDistanceBetweenPoints3D(self.startPos[1], self.startPos[2], self.startPos[3], self.endPos[1], self.endPos[2], self.endPos[3])
	-- // Methoden
	self:CreateSteps()
	self:DoStepsMove()
	
	self.timer = setTimer(function() self:CheckForLastStep() end, (self.speed/2.3), -1)
end


-- //////////////////////////
-- ///// Destructor   //////
-- //////////////////////////

function Escalator:Destructor()
	killTimer(self.timer)
	for index, step in pairs(self.steps) do
		destroyElement(step)
	end
	
	for index, step in pairs(self.obereSteps) do
		destroyElement(step)
	end
	
	for index, step in pairs(self.untereSteps) do
		destroyElement(step)
	end

end

-- // Getters & Setters
-- //////////////////////////
-- ///// SetReverse    //////
-- //////////////////////////

function Escalator:SetReverse(reverse2)
	assert(type(reverse2) == "boolean")
	self.reverse = reverse2
end

-- //////////////////////////
-- ///// SetSpeed      //////
-- //////////////////////////

function Escalator:SetSpeed(speed2)
	assert(type(speed2) == "number")
	self.speed = speed2
end

-- //////////////////////////
-- /////Update Position//////
-- //////////////////////////

function Escalator:UpdatePosition(x1, y1, z1, x2, y2, z2)
	assert(x1 and y1 and z1 and x2 and y2 and z2)
	self.startPos = {x1, y1, z1}
	self.endPos = {x2, y2, z2}
end

-- //////////////////////////
-- /////Steps Creation //////
-- //////////////////////////

function Escalator:CreateSteps(bool)
	local dis = self.dis
	local stepcount = math.floor(dis*2.5)
	self.stepcount = stepcount;
	local rot = findRotation(self.startPos[1], self.startPos[2], self.endPos[1], self.endPos[2])
	local rot2 = findRotation(self.endPos[1], self.endPos[2], self.startPos[1], self.startPos[2])
	local xf, yf, zf = self.endPos[1]-self.startPos[1], self.endPos[2]-self.startPos[2], (self.endPos[3]-self.startPos[3])
	for i = 0, stepcount+1, 1 do
		self.steps[i] = createObject(1656, self.startPos[1]+xf*i/(stepcount), self.startPos[2]+yf*i/(stepcount), self.startPos[3]+zf*i/(stepcount), 0, 0, rot)
		setElementData(self.steps[i], "Escalator.IsStep", true)
		
	end
	if not(bool) then
		-- // Ende und Anfang
		for i = 1, self.obereLaenge, 1 do
			local nx, ny = getPointFromDistanceRotation(self.endPos[1], self.endPos[2], i/2.5, rot*-1)
			self.obereSteps[i] = createObject(1656, nx, ny, self.endPos[3], 0, 0, rot)
		end
		for i = 1, self.untereLaenge, 1 do
			local nx, ny = getPointFromDistanceRotation(self.startPos[1], self.startPos[2], (i/2.5)*-1, rot*-1)
			self.untereSteps[i] = createObject(1656, nx, ny, self.startPos[3], 0, 0, rot)
		end
	end
end


-- //////////////////////////
-- ///// Step Movement //////
-- //////////////////////////

function Escalator:DoMoveStep(step)
	if(isElement(step)) then
		stopObject(step)
		local x, y, z = getElementPosition(step)
		local x2, y2, z2 = self.endPos[1], self.endPos[2], self.endPos[3]
		if(self.reverse == false) then
			x2, y2, z2 = self.startPos[1], self.startPos[2], self.startPos[3]
		end
		local dis = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
		moveObject(step, self.speed*dis, x2, y2, z2)
		self.stepstate[step] = "moving"
		if(self.speed*dis >= 50) then
			setTimer(function()
				self.stepstate[step] = "stopped"
			end, (self.speed*dis), 1)
		else
			self.stepstate[step] = "stopped"
		end
	end
end

-- //////////////////////////
-- ////Respawn Escalator ////
-- //////////////////////////

function Escalator:Respawn()
	local id = false
	-- 
	for index, step in pairs(self.steps) do
		if(getElementData(step, "Escalator:ID")) then
			id = tonumber(getElementData(step, "Escalator:ID"))
			break
		end
	end
	-- 
	--x1, y1, z1, x2, y2, z2, obereLaenge2, untereLaenge2, reverse2, speed2
	local x1, y1, z1 = self.startPos[1], self.startPos[2], self.startPos[3]
	local x2, y2, z2 = self.endPos[1], self.endPos[2], self.endPos[3]
	local obereLaenge = self.obereLaenge
	local untereLaenge = self.untereLaenge
	local reverse = self.reverse
	local speed = self.speed
	self:Destructor()
	self:Constructor(x1, y1, z1, x2, y2, z2, obereLaenge, untereLaenge, reverse, speed)
	for index, step in pairs(self.steps) do
		setElementData(step, "Escalator:ID", id)
	end
end


-- //////////////////////////
-- ////    Respawn Step  ////
-- //////////////////////////

function Escalator:RespawnStep(step)
	if(isElementStreamedIn(step)) then
		local tstep = false
		if(isPlayerStandingOnObject(step)) then
			tstep = true
		end
		if(self.reverse == false) then
			setElementPosition(step, self.endPos[1], self.endPos[2], self.endPos[3])
			if(tstep) then
				setElementPosition(localPlayer, self.startPos[1], self.startPos[2], self.startPos[3]+0.5)
			end
		else
			setElementPosition(step, self.startPos[1], self.startPos[2], self.startPos[3])
			if(tstep) then
				setElementPosition(localPlayer, self.endPos[1], self.endPos[2], self.endPos[3]+0.5)
			end
		end
		self:DoMoveStep(step)
	end
end

-- //////////////////////////
-- /////// Step Check  //////
-- //////////////////////////

function Escalator:CheckForLastStep()
	local done = false
	for index, step in pairs(self.steps) do
		if(self.stepstate[step] == "stopped") then
			self:RespawnStep(step)
			done = true
			break;
		end
	end
	if(done == false) then -- If a step is missing
		self:Respawn()
		outputDebugString("Escalator: Respawning Escalator, step is missing")
	end
	
end


-- //////////////////////////
-- ///// DoMoveStep    //////
-- //////////////////////////

function Escalator:DoStepsMove()
	--self.stepsMoveTimer = setTimer(function() self:UpdateSteps() end, self.speed, -1)
	--addEventHandler("onClientPreRender", getRootElement(), function() self:CheckForFinish() end)
	for index, step in pairs(self.steps) do
		self:DoMoveStep(step)
	end
end


-- //////////////////////////
-- /// Usefull Functions ////
-- //////////////////////////

function Escalator:GetSteps()
	return self.steps
end

function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end;
	return t;
end


function isPlayerStandingOnObject(objekt)
	local x, y, z = getElementPosition(localPlayer)
	local hit, _, _, _, ele = processLineOfSight ( x, y, z, x, y, z-2, false, false, false, true)
	if(hit) and (ele == objekt) and (getPedSimplestTask(localPlayer) == "TASK_SIMPLE_PLAYER_ON_FOOT") then
		return true
	else
		return false
	end
end

function getPointFromDistanceRotation(x, y, dist, angle)
 
    local a = math.rad(90 - angle);
 
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
 
    return x+dx, y+dy;
 
end

_moveObject = moveObject

function moveObject(ele, time, x1, y1, z1, ...)
	if(time >= 50) then
	--	setTimer(setElementPosition, time, 1, ele, x1, y1, z1)
	end
	return _moveObject(ele, time, x1, y1, z1, ...)
end

function getDistanceBetweenElements(ele1, ele2)
	local x, y, z = getElementPosition(ele1)
	local x2, y2, z2 = getElementPosition(ele2)
	return getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
end
-- EVENT HANDLERS --
