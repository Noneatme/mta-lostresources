-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: SpawnManager				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

SpawnManager = {};
SpawnManager.__index = SpawnManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function SpawnManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// SpawnPlayer 		//////
-- ///////////////////////////////

function SpawnManager:SpawnPlayer(player, x, y, z, int)
	player:Spawn(x, y, z, 0, tonumber(player:GetData("savedthings", "SKIN")), int);
	
	setCameraTarget(player, player);
	
	toggleAllControls(player, true);
	
	local wepString = player:GetData("savedthings", "WEAPONS");
	
	for i = 1, 12, 1 do
		local str = (gettok(wepString, i, "|") or false);
		
		if(str) then
			local weapon, ammo = tonumber(gettok(str, 1, ":")), tonumber(gettok(str, 2, ":"))
			
			if(weapon and ammo) then
				giveWeapon(player, weapon, ammo)
			end
		end
	end
	
	setPedArmor(player, player:GetData("savedthings", "ARMOR") or 0);
	

	if(tonumber(player:GetData("savedthings", "HEALTH")) <= 0) then
		setElementHealth(player, 100);
	else
		setElementHealth(player, player:GetData("savedthings", "HEALTH") or 100);
	end
	
	-- DEBUG
	giveWeapon(player, 25, 99999)
end

-- ///////////////////////////////
-- ///// SpawnPlayerLogin 	//////
-- ///////////////////////////////

function SpawnManager:SpawnPlayerLogin(player)
	local x, y, z, int = tonumber(player:GetData("savedthings", "X")), tonumber(player:GetData("savedthings", "Y")), tonumber(player:GetData("savedthings", "Z")), tonumber(player:GetData("savedthings", "INTERIOR"));
	
	if(x == 0 and y == 0 and z == 0 and int == 0) then
		local rand = math.random(1, #self.randomSpawnPositions);
		x, y, z, int = self.randomSpawnPositions[rand][1], self.randomSpawnPositions[rand][2], self.randomSpawnPositions[rand][3], 0
	end 
	
	self:SpawnPlayer(player, x, y, z, int);
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function SpawnManager:Constructor(...)
	self.randomSpawnPositions = {
		{800.01232910156, 363.13009643555, 19.388034820557},
		{-711.42846679688, 222.85717773438, 2.333815574646},
		{2880.6950683594, -272.79513549805, 1.7026700973511},
		{283.31619262695, -1891.1473388672, 1.5685994625092},
		{-2820, -2451.4287109375, 1.689302444458},
		{8.5712890625, -2537.1430664063, 36.49760055542},
	}
	
	logger:OutputInfo("[CALLING] SpawnManager: Constructor");
end

-- EVENT HANDLER --
