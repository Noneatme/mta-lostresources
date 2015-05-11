-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: Zombie Creator				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################


Creator = {}
Creator.__index = Creator

-- FUNCTIONS & METHODS --

addEvent("doSpawnZombie", true)

local cFunc = {}
local cSetting = {}


cSetting["spawn_randomly"] = true -- Auf true stellen, sodass die Zombies zufaellig auf der Map Spawnen



cSetting["check_intervall"] = 60000  -- In welchen Zyclen Zombies erstellt werden (Default 60000, sollte so bleiben da das der Brennpunkt der Ressourcen ist)

cSetting["area_zombies"] = {}

cSetting["zombies"] = {};


-- ///////////////////////////////
-- ///// Zombie Spawn    	//////
-- ///////////////////////////////

spawnSomeZombies = function(x, y, player, area)
	assert(isElement(player), "Player is not given")
	for i = 1, math.random(5, 50), 1 do
		local rx, ry
		if(math.random(0, 1) == 0) then
			if(math.random(0, 1) == 0) then
				rx, ry = x + math.random(10, 150), y + math.random(10, 150)
			else
				rx, ry = x + math.random(10, 150), y - math.random(10, 150)
			end
		else
			if(math.random(0, 1) == 0) then
				rx, ry = x - math.random(10, 150), y - math.random(10, 150)
			else
				rx, ry = x + math.random(10, 150), y - math.random(10, 150)
			end
		end
		triggerClientEvent(player, "onZombieSpawnPosGet", player, rx, ry, area)
	end
end


-- ///////////////////////////////
-- ///// CheckRegion    	//////
-- ///////////////////////////////

cFunc["check_regions"] = function()
	local usedAreas = {}
	
	for index, player in pairs(getElementsByType("player")) do
		local x, y, z = getElementPosition(player)
		local area = getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true)
		usedAreas[area] = player
	end
	for area, player in pairs(usedAreas) do
		if not(cSetting["area_zombies"][area]) then
			cSetting["area_zombies"][area] = {}
			cSetting["area_zombies"][area]["intervall"] = 0
			cSetting["area_zombies"][area]["zombies"] = {}
		end
		if(cSetting["area_zombies"][area]["intervall"] < 5) then
			cSetting["area_zombies"][area]["intervall"] = cSetting["area_zombies"][area]["intervall"]+1
			
			-- // Zombie Creation --
			if(cSetting["area_zombies"][area]["intervall"] == 1) then
				local x, y, z = getElementPosition(player)
				spawnSomeZombies(x, y, player, area)
				outputDebugString("Spawning Zombies at "..area)
			end
		else
			for index, zombie in pairs(cSetting["area_zombies"][area]["zombies"]) do
				if(isElement(zombie.ped)) then
					zombie:Destructor()
				end
			end
			cSetting["area_zombies"][area]["intervall"] = 0
			cSetting["area_zombies"][area]["zombies"] = {}
		end
	end
end


-- ///////////////////////////////
-- ///// SpawnZombie    	//////
-- ///////////////////////////////

cFunc["spawn_zombie_func"] = function(x, y, z, area)
	local zombie = Zombie:New(x, y, z, getRandomZombieSkin())
	if(area) then
		cSetting["area_zombies"][area]["zombies"][zombie] = zombie
	end
	
	if(math.random(1, 5) == 3) then
		local randweapon = getRandomZombieWeapon()
		giveWeapon(zombie.ped, randweapon, 9999)
	end
end

-- ///////////////////////////////
-- ///// OnStart    		//////
-- ///////////////////////////////

cFunc["on_start"] = function()
	if(cSetting["spawn_randomly"] == true) then
		if(ressourcenSchonend) then
			setTimer(cFunc["check_regions"], 5*60*1000, -1)
		else
			setTimer(cFunc["check_regions"], 30000, -1)
		
		end
		setTimer(function()
			cFunc["check_regions"]()
		end, 10000, 1)
	else
		cFunc["spawn_zombies_over_map"]()
	end
end

-- ///////////////////////////////
-- ///// SpawnZombiesOverMap//////
-- ///////////////////////////////

cFunc["spawn_zombies_over_map"] = function()
	outputDebugString("Warning: Spawning Zombies NOW!");
	--[[
	local posx, posy, posx2, posy2 = 0, 0, 0, 0
	for i = 1, 5400, 10 do
	
		posx = posx+10
		posy = posy+10
		
		posx2 = posx2-10
		posy2 = posy2-10
		
		local zombie = Zombie:New(posx, posy, 100, getRandomZombieSkin());
		setElementHealth(zombie.ped, 99999);
		
		table.insert(cSetting["zombies"], zombie);
		
		local zombie = Zombie:New(posx, posy2, 100, getRandomZombieSkin());
		setElementHealth(zombie.ped, 99999);
		
		table.insert(cSetting["zombies"], zombie);
		
		local zombie = Zombie:New(posx2, posy, 100, getRandomZombieSkin());
		setElementHealth(zombie.ped, 99999);
		
		table.insert(cSetting["zombies"], zombie);
		
		local zombie = Zombie:New(posx2, posy2, 100, getRandomZombieSkin());
		setElementHealth(zombie.ped, 99999);
		
		table.insert(cSetting["zombies"], zombie);
	end
	
	setTimer(function()
		for index, zombie in pairs(cSetting["zombies"]) do
			if(isElementInWater(zombie.ped)) or (isPedDead(zombie.ped)) then
				zombie:Destructor();
			end
		end
	end, 10000, 1)]]
end


-- ///////////////////////////////
-- ///// getRandomZombieSkin//////
-- ///////////////////////////////

getRandomZombieSkin = function()
	local skins = {108,126,127,188,195,206,209,258,264,56,68,92}
	return skins[math.random(1, #skins)]
end

getRandomZombieWeapon = function()
	local weapons = {6, 7, 8, 9}
	
	return weapons[math.random(1, #weapons)]
end
-- EVENT HANDLER --

addEventHandler("onResourceStart", getResourceRootElement(), cFunc["on_start"])
addEventHandler("doSpawnZombie", getRootElement(), cFunc["spawn_zombie_func"])