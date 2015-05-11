-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: Zombie						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

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
addEvent("doZombieWeaponFire", true);

addEvent("doZombieKillVehicle", true);

ressourcenSchonend = false -- Ressourcen schonend? (Gut fuer grosse Server), ist aber weniger schoen :P

cSetting["weaponCols"] = {
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0,
		[7] = 0,
		[8] = 0,
		[9] = 0,
		[10] = 0,
		[11] = 0,
		[12] = 0,
		[13] = 0,
		[14] = 0,
		[15] = 0,
		[16] = 15,
		[17] = 0,
		[18] = 0,
		[19] = 0,
		[20] = 0,
		[21] = 0,
		[22] = 10,
		[23] = 2,
		[24] = 12,
		[25] = 30,
		[26] = 35,
		[27] = 33,
		[28] = 15,
		[29] = 15,
		[30] = 25,
		[31] = 25,
		[32] = 15,
		[33] = 25,
		[34] = 35,
		[35] = 55,
		[36] = 55,
		[37] = 15,
		[38] = 0,
		[39] = 0,
		[40] = 0,
		[41] = 0,
		[42] = 0,
		[43] = 0,
		[44] = 0,
		[45] = 0,
		[46] = 0,
		
	}
	
cSetting["zomb_objects"] = {};
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
	if not(isElement(self.target)) or not(isElement(self.ped)) then
		killTimer(self.updateRunTimer)
		self:SetZombieIdle(true)
		self.state = "waiting"
	end
	if(getElementData(self.ped, "killed") ~= true) then
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
	setElementData(self.ped, "object", self);
end

-- ///////////////////////////////
-- ///// RunToPlayer 	//////
-- ///////////////////////////////

function Zombie:RunToPlayer(target2)
	if(isElement(target2)) and (getElementType(target2) == "player") --[[and (target2 == self.target)]] and (getElementData(self.ped, "killed") ~= true) then
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
		
		logger:OutputInfo("Zombie "..tostring(self.ped).." chasing player: "..getPlayerName(self.target).." (run)");
	end
end

-- ///////////////////////////////
-- ///// SprintToPlayer 	//////
-- ///////////////////////////////

function Zombie:SprintToPlayer(target2)
	if(isElement(target2)) and (getElementType(target2) == "player") and (self.state ~= "sprinting")  and (getElementData(self.ped, "killed") ~= true) then
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
		
		logger:OutputInfo("Zombie "..tostring(self.ped).." chasing player: "..getPlayerName(self.target).." (sprints)");
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
		
		logger:OutputInfo("Zombie "..tostring(self.ped).." lost target");
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
-- ///// StopSyncFunc		//////
-- ///////////////////////////////

function Zombie:StopSyncFunc()
	local syncher = getElementSyncer(self.ped)
	if not(syncher) then
		logger:OutputInfo("Marking Zombie: "..tostring(self.ped).." for deletion, because zombie is not streamed in")
		
		if(isTimer(self.syncStopTimer)) then
			killTimer(self.syncStopTimer);
		end
	
		self.syncStopTimer = setTimer(
		function()
			self:Destructor();
			destroyElement(self.ped);
			
			logger:OutputInfo("Zombie: "..tostring(self.ped).." deleted")
		
		end, 60000, 1)
	end
end

-- ///////////////////////////////
-- ///// StartSyncFunc		//////
-- ///////////////////////////////

function Zombie:StartSyncFunc()
	if(isTimer(self.syncStopTimer)) then
		killTimer(self.syncStopTimer);
		logger:OutputInfo("Zombie: "..tostring(self.ped).." started synching again, timer killed")
	end
end


-- ///////////////////////////////
-- ///// GiveLoot			//////
-- ///////////////////////////////

function Zombie:GiveLoot(theElement)
	if(getElementType(theElement) == "player") then
	
		destroyElement(self.pickup);
		for index, id in pairs(self.loot) do
			theElement:GiveItem(id, 1);
		end
	end
end

-- ///////////////////////////////
-- ///// Loot				//////
-- ///////////////////////////////

function Zombie:Loot()
	
	local function zufallsItem()
		local ids = {4, 100, 101, 102, 150, 151}
		
		return ids[math.random(1, #ids)];
	end

	self.loot = {}
	for i = 1, 5, 1 do
		if(math.random(0, 5) == 1) then
			local item = zufallsItem();
			table.insert(self.loot, item);
		end
	end
	
	local x, y, z = getElementPosition(self.ped)
	self.pickup = createPickup(x, y, z, 3, 1279, 10000)
	
	addEventHandler("onPickupHit", self.pickup, self.pickupHitFunc);
end


-- ///////////////////////////////
-- ///// KillVehicle		//////
-- ///////////////////////////////

function Zombie:KillVehicle(attacker)
	killPed(self.ped);
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
	setElementHealth(self.ped, 50);


	self.devmode = true;
	


	-- Variablen
	do
	
		self.pickupHitFunc = function(...) self:GiveLoot(...) end;
		self.killVehicleFunc = function(...) self:KillVehicle(...) end;
	
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
		
		
		addEventHandler("onColShapeHit", self.bigcol, function(target) 
			if(self.devmode == false) then
				self:CheckIfZombieCanSee(target) 
			end
		end) -- self:SprintToPlayer(target)
			addEventHandler("onColShapeHit", self.smallcol, function(target)
			if(self.devmode == false) then
				self:RunToPlayer(target) 
			end
		end)
		
		addEventHandler("onColShapeLeave", self.bigcol, function(target) self:CancelSprint(target) end)
		addEventHandler("onColShapeLeave", self.smallcol, function(target) self:SprintToPlayer(target) end)
		
		addEventHandler("onPedWasted", self.ped, function(...) self:Destructor(...) end)
		addEventHandler("onElementStopSync", self.ped, function() self:StopSyncFunc() end)
		addEventHandler("onElementStartSync", self.ped, function() self:StartSyncFunc() end)
		
		addEventHandler("onZombieHit", self.ped, function(who)
			if not(self.target) then
				self.target = who;
				self:RunToPlayer(who)
				
				setElementSyncer(self.ped, who);
			end
		end)
		
		addEventHandler("onZombieBigColHit", self.ped, function(who, bool) self:ReplyZombieCanSee(who, bool) end) -- Ob er den sehen kann
		addEventHandler("doZombieKillVehicle", self.ped, self.killVehicleFunc);
	end
	
	self:SetZombieIdle(true)
	
	outputDebugString("Zombie "..tostring(self.ped).." created")
	triggerEvent("onZombieSpawn", self.ped, self) -- // --
	
		
	setElementData(self.ped, "object", self);
	
	cSetting["zomb_objects"][self.ped] = self;
	return self.ped
end


-- ///////////////////////////////
-- ///// Destruktor  		//////
-- ///////////////////////////////

function Zombie:Destructor(ammo, killer)
	-- Destroy Colshapes
	if(isElement(self.smallcol) and isElement(self.bigcol)) then
		destroyElement(self.smallcol)
		destroyElement(self.bigcol)
	end
	

	if(killer) and (getElementType(killer) == "player") then
		self:Loot();
		
		killer:AddEXP(math.random(25, 50))
		
		killer:GivePatronen(math.random(1, 3))
	end
	-- Destroy Timers
	if(isTimer(self.updateRunTimer)) then
		killTimer(self.updateRunTimer)
	end
	if(isTimer(self.idleTimer)) then
		killTimer(self.idleTimer)
	end
	if(isElement(self.ped)) then
		triggerEvent("onZombieWasted", self.ped, self, killer) -- // -- 
		setTimer(function() if(isElement(self.ped)) then destroyElement(self.ped) self = nil end end, 5*60*1000, 1)
		
		triggerClientEvent(getRootElement(), "doZombieSound", getRootElement(), self.ped, "dead"..math.random(1, 2));
	end
end

-- ///////////////////////////////
-- ///// Zombie Wasted 		//////
-- ///////////////////////////////

cFunc["do_zombiewasted"] = function(zombie, anim)
	if(anim == true) and (getElementData(zombie, "killed") ~= true) then
		killPed(zombie, source)
		setPedAnimation(zombie, "ped", "KO_shot_face", 2000, false, true, false)
		setElementData(zombie, "killed", true)
		
		
	else
		killPed(zombie, source)
		setElementData(zombie, "killed", true)
	end
end

cFunc["hit_zombie"] = function(zombie)

	
end

cFunc["spawn_test"] = function(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	
	local zombie = Zombie:New(x, y+2, z, 212).ped
end

cFunc["check_weapon"] = function(weapon)
	local player = source;
	
	local size = cSetting["weaponCols"][weapon];
	if not(size) then
		return
	end
	
	local x, y, z = getElementPosition(player)
	local c = createColSphere(x, y, z, size);
	
	for index, zomb in pairs(getElementsWithinColShape(c, "ped")) do
		if(getElementData(zomb, "zombie") == true) and not(getElementData(zomb, "object").target) and not(isPedDead(zomb)) then
			cSetting["zomb_objects"][zomb]:RunToPlayer(source);
		end
	end
	
	destroyElement(c);
end
-- EVENT HANDLERS ---


addEventHandler("doZombieWasted", getRootElement(), cFunc["do_zombiewasted"])
addEventHandler("doZombieWeaponFire", getRootElement(), cFunc["check_weapon"])
