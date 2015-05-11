-- ###############################
-- ## Name: CZombie.lua			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## Lizenz: Freie Benutzung	##
-- ###############################

-- CZombie.lua - Superclass fuer die nebenklassen


--[[
	Methoden:
		New() Halt
	
	Instanzen:
		Spaeter

--]]

Zombie = {}
Zombie.__index = Zombie

local cFunc = {}
local cSetting = {}

addEvent("onZombieHit", true)

addEvent("onZombieSpawn", true)
addEvent("onZombieWasted", true)
addEvent("onZombieIdle", true)
addEvent("onZombieAttack", true)

addEvent("doZombieWasted", true)
addEvent("onZombieBigColHit", true)


ressourcenSchonend = false -- Ressourcen schonend? (Gut fuer grosse Server), ist aber weniger schoen :P

-- FUNCTIONS --

-- ///////////////////////////////
-- ///// New Zombie 		//////
-- ///////////////////////////////

function Zombie:New(...)
	local obj = setmetatable({}, {__index = self})
	if obj.Constructor then
		obj:Constructor(...)
	end
	return obj
end

-- ///////////////////////////////
-- ///// NewIdlePos 		//////
-- ///////////////////////////////

function Zombie:NewIdlePos()
	if(self.state == "waiting") then
		local ped = self.ped
		setPedRotation(ped, math.random(0, 360)) -- Yay :D
		setPedAnimation(ped, "ped", "WALK_fatold", 2500, true, true, true)
		
		for index, player in pairs(getElementsWithinColShape(self.bigcol, "player")) do
			self:CheckIfZombieCanSee(player)
		end
		
		if(math.random(0, 2) == 1) then

			triggerClientEvent(getRootElement(), "doZombieSound", getRootElement(), self.ped, "groawl"..math.random(1, 3));
			
		end
	end
end

-- ///////////////////////////////
-- ///// SetZombieIdle 		//////
-- ///////////////////////////////

function Zombie:SetZombieIdle(bool)
	if(bool) then
		if(self.state == "waiting") then
			if(isTimer(self.idleTimer)) then
				killTimer(self.idleTimer)
			end
			self.idleTimer = setTimer(function() self:NewIdlePos() end, math.random(9000, 11000), -1)
			self:NewIdlePos()
			outputDebugString("Zombie "..tostring(self.ped).." going inactive")
			triggerEvent("onZombieIdle", self.ped, self) -- // -- 
		end
	else
		if(self.state ~= "waiting") then
			if(isTimer(self.idleTimer)) then
				killTimer(self.idleTimer)
			end
		end
	end
end

-- ///////////////////////////////
-- ///// UpdateSprint    	//////
-- ///////////////////////////////

function Zombie:UpdateSprint()
	if not(isElement(self.target)) then
		killTimer(self.updateRunTimer)
		self:SetZombieIdle(true)
		self.state = "waiting"
	end

		if(self.state == "sprinting") and (getElementData(self.ped, "jumping") ~= true) then
			local x1, y1, z1 = getElementPosition(self.ped)
			local x2, y2, z2 = getElementPosition(self.target)
			local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
			rot = rot-90
			setPedRotation(self.ped, rot)
			setPedAnimation(self.ped, "ped", "sprint_panic", -1, true, true, true)
		elseif(self.state == "running")and (getElementData(self.ped, "jumping") ~= true) then
			local x1, y1, z1 = getElementPosition(self.ped)
			local x2, y2, z2 = getElementPosition(self.target)
			local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
			rot = rot-90
			setPedRotation(self.ped, rot)
			setPedAnimation(self.ped, "ped", "JOG_maleA", -1, true, true, true)
			
			local dis = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
			if(dis < 2) then
				-- attack
				setPedAnimation(self.ped)
				self.attacking = true
				triggerClientEvent(getRootElement(), "onZombieAttack", getRootElement(), self.ped, true, self.target)
			else
				if(self.attacking == true) then
					self.attacking = false
					triggerClientEvent(getRootElement(), "onZombieAttack", getRootElement(), self.ped, false, self.target)
				end
			end
		end
		-- // Jump Digens // --
		local x1, y1, z1 = getElementPosition(self.ped)
		local x2, y2, z2 = getElementPosition(self.target)
		
		if(ressourcenSchonend) then
			if(z1-z2 < -1) then
				triggerClientEvent(getRootElement(), "onZombieWall", getRootElement(), self.ped, self.target)
			end
		else
			triggerClientEvent(getRootElement(), "onZombieWall", getRootElement(), self.ped, self.target)
		end
end

-- ///////////////////////////////
-- ///// RunToPlayer 	//////
-- ///////////////////////////////

function Zombie:RunToPlayer(target2)
	if(isElement(target2)) and (getElementType(target2) == "player") and (target2 == self.target) then
		if(isTimer(self.updateRunTimer)) then
			killTimer(self.updateRunTimer)
		end
		self.state = "running"
		self:SetZombieIdle(false)
		self.target = target2
		
		setElementData(self.ped, "target", self.target2);
		
		local x1, y1, z1 = getElementPosition(self.ped)
		local x2, y2, z2 = getElementPosition(self.target)
		local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
		rot = rot-90
		setPedRotation(self.ped, rot)
		setPedAnimation(self.ped, "ped", "JOG_maleA", -1, true, true, true)
		
		self.updateRunTimer = setTimer(function() self:UpdateSprint() end, 500, -1)
		
		triggerClientEvent(getRootElement(), "doZombieSound", getRootElement(), self.ped, "groawl"..math.random(1, 3));
	end
end

-- ///////////////////////////////
-- ///// SprintToPlayer 	//////
-- ///////////////////////////////

function Zombie:SprintToPlayer(target2)
	if(isElement(target2)) and (getElementType(target2) == "player") and (self.state ~= "sprinting") then
		if(isTimer(self.updateRunTimer)) then
			killTimer(self.updateRunTimer)
		end
		self.state = "sprinting"
		self.target = target2
		self:SetZombieIdle(false)
		
		setElementData(self.ped, "target", self.target);
		
		local x1, y1, z1 = getElementPosition(self.ped)
		local x2, y2, z2 = getElementPosition(self.target)
		local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
		rot = rot-90
		setPedRotation(self.ped, rot)
		setPedAnimation(self.ped, "ped", "sprint_panic", -1, true, true, true)
		
		self.updateRunTimer = setTimer(function() self:UpdateSprint() end, 500, -1)
		triggerEvent("onZombieAttack", self.ped, self, target2)
	end
end

-- ///////////////////////////////
-- ///// Cancel Sprint  	//////
-- ///////////////////////////////

function Zombie:CancelSprint(target2)
	if(self.target == target2) then
		if(isTimer(self.updateRunTimer)) then
			killTimer(self.updateRunTimer)
		end
		self.state = "waiting"
		self:SetZombieIdle(true)
		self.target = nil;
		
		self:NewIdlePos()
	end
end

-- ///////////////////////////////
-- ///// ReplyZombieCanSee	//////
-- ///////////////////////////////

function Zombie:ReplyZombieCanSee(player, bool)
	if(bool == true) then
		self:SprintToPlayer(player);
	end
end

-- ///////////////////////////////
-- ///// CheckIfZombieCanSee//////
-- ///////////////////////////////

function Zombie:CheckIfZombieCanSee(attacker)
	if(getElementType(attacker) == "vehicle") then
		if(getVehicleOccupant(attacker)) then
			self:ReplyZombieCanSee(getVehicleOccupant(attacker), true);
		end
	elseif(getElementType(attacker) == "player") then
		triggerClientEvent(attacker, "doZombieCanSeeCheck", attacker, self.ped);
	end
end

-- ///////////////////////////////
-- ///// Konstruktor 		//////
-- ///////////////////////////////

function Zombie:Constructor(x, y, z, model, dim, int)
	-- Assertion
	if not(dim) then
		dim = 0
	end
	if not(int) then
		int = 0
	end
	
	-- Ped halt
	self.ped = createPed(model, x, y, z)
	assert(isElement(self.ped))
	setElementDimension(self.ped, dim)
	setElementInterior(self.ped, int)
	setElementData(self.ped, "zombie", true)

	-- Variablen
	do
		self.target = nil
		self.attacking = false
		self.state = "waiting"
	--	self.object = self
		
		-- Col Shapes
		-- Um dem Zombie werden 2 Colshapes erstellt, ein mit kleinem Radius und ein mit Grossem.
		-- Dies dient zum Sprinten/Erkennen.
		
		self.bigcol = createColSphere(x, y, z, 20)
		self.smallcol = createColSphere(x, y, z, 5)
		setElementDimension(self.bigcol, dim)
		setElementInterior(self.bigcol, int)
		setElementDimension(self.smallcol, dim)
		setElementInterior(self.smallcol, int)
		
		attachElements(self.bigcol, self.ped)
		attachElements(self.smallcol, self.ped)
		
		-- Datas --
	--	setElementData(self.ped, "object", self)
		-- Event handler -
		
		
		addEventHandler("onColShapeHit", self.bigcol, function(target) self:CheckIfZombieCanSee(target) end) -- self:SprintToPlayer(target)
		addEventHandler("onColShapeHit", self.smallcol, function(target) self:RunToPlayer(target) end)
		
		addEventHandler("onColShapeLeave", self.bigcol, function(target) self:CancelSprint(target) end)
		addEventHandler("onColShapeLeave", self.smallcol, function(target) self:SprintToPlayer(target) end)
		
		addEventHandler("onPedWasted", self.ped, function(ammo, killer) self:Destructor(killer) end)
		
		
		addEventHandler("onZombieHit", self.ped, function(who)
			self.target = who;
			self:RunToPlayer(who)
		end)
		
		addEventHandler("onZombieBigColHit", self.ped, function(who, bool) self:ReplyZombieCanSee(who, bool) end) -- Ob er den sehen kann
	end
	
	self:SetZombieIdle(true)
	
	outputDebugString("Zombie "..tostring(self.ped).." created")
	triggerEvent("onZombieSpawn", self.ped, self) -- // --
	
		
	setElementData(self.ped, "object", self);
	return self.ped
end


-- ///////////////////////////////
-- ///// Destruktor  		//////
-- ///////////////////////////////

function Zombie:Destructor(killer)
	-- Destroy Colshapes
	if(isElement(self.smallcol) and isElement(self.bigcol)) then
		destroyElement(self.smallcol)
		destroyElement(self.bigcol)
	end
	
	-- Destroy Timers
	if(isTimer(self.updateRunTimer)) then
		killTimer(self.updateRunTimer)
	end
	if(isTimer(self.idleTimer)) then
		killTimer(self.idleTimer)
	end
	triggerEvent("onZombieWasted", self.ped, self, killer) -- // -- 
	setTimer(function() if(isElement(self.ped)) then destroyElement(self.ped) self = nil end end, 5*60*1000, 1)
	
	triggerClientEvent(getRootElement(), "doZombieSound", getRootElement(), self.ped, "dead"..math.random(1, 2));
			
end

-- ///////////////////////////////
-- ///// Zombie Wasted 		//////
-- ///////////////////////////////

cFunc["do_zombiewasted"] = function(zombie)
	killPed(zombie, source)
end

cFunc["hit_zombie"] = function(zombie)

	
end

cFunc["spawn_test"] = function(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	
	local zombie = Zombie:New(x, y+2, z, 212).ped
end



-- EVENT HANDLERS ---


addEventHandler("doZombieWasted", getRootElement(), cFunc["do_zombiewasted"])
