-- #######################################
-- ## Project: lightning bolt			##
-- ## Name: Weather.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Weather = {};
Weather.__index = Weather;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Weather:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// AddBolt	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Weather:AddBolt()

	--[[
	local player = getRandomPlayer()
	if(player) then
		local x, y, z = getElementPosition(player)
		
		local nx, ny, nz = x+math.random(-250, 250), y+math.random(-250, 250), z
		
		triggerClientEvent(player, "onBoltPositionGet", player, nx, ny, nz)
		
		outputDebugString("Adding Bolt @ "..nx..", "..ny..", "..nz);
		
		
		if(isTimer(self.stormTimer)) then
			killTimer(self.stormTimer);
		end
		
		self.stormTimer = setTimer(self.addBoltFunc, math.random(10000, 30000), 1)
	end]]
	
	local players = getElementsByType("player")
	local blitzZonen = {}
	
	for index, player in pairs(players) do
		local x, y, z = getElementPosition(player)
		local zone = getZoneName(x, y, z, false);
		if not(blitzZonen[zone]) then
			blitzZonen[zone] = {x, y, z, player}
		end
	end
	
	for index, zone in pairs(blitzZonen) do
		local rand = math.random(0, 2)
	
		if(rand >= 1) then	-- 75% Warscheinlichkeit
			
			local x, y, z, player = zone[1], zone[2], zone[3], zone[4]
			-- Blitz da:
			
			local nx, ny, nz = x+math.random(-250, 250), y+math.random(-250, 250), z
					
			triggerClientEvent(player, "onBoltPositionGet", player, nx, ny, nz)
			
			outputDebugString("Adding Bolt @ "..index..", "..nx..", "..ny..", "..nz);
		
		end
	end
	
		
	if(isTimer(self.stormTimer)) then
		killTimer(self.stormTimer);
	end
		
	self.stormTimer = setTimer(self.addBoltFunc, math.random(10000, 30000), 1)
end

-- ///////////////////////////////
-- ///// StartStorm 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Weather:StartStorm()
	if(self.storm ~= true) then
		self.storm = true;
		
		
		self.stormTimer = setTimer(self.addBoltFunc, math.random(10000, 30000), 1)
	end
end

-- ///////////////////////////////
-- ///// StopStorm 			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Weather:StopStorm()
	if(self.storm == true) then
		self.storm = false;
		
		if(isTimer(self.stormTimer)) then
			killTimer(self.stormTimer);
		end
	end
end

-- ///////////////////////////////
-- ///// ChangeWeather 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Weather:ChangeWeather(stormy)
	setWeather(self.nextWeather);
	
	if(self.storm == true) then
		self:StopStorm();
		outputDebugString("Stopping Storm");
	end
	
	self.currentWeather = self.nextWeather;
	
	
	outputDebugString("Changing Weather to ID: "..self.nextWeather.." ("..self.names[self.nextWeather]..")");
	
	
	if not(stormy) then
		self.nextWeather = math.random(0, #self.names);
	else
		self.nextWeather = 8
	end
	
	
	if(self.stormy[self.currentWeather]) then
		self:StartStorm()
		outputDebugString("Starting Storm");
	end
	
	outputDebugString("Next Weather: "..self.nextWeather);
	
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Weather:Constructor(...)
	self.changeWeatherFunc = function() self:ChangeWeather() end;
	self.stormFunc = function() self:ChangeWeather(true) end;
	self.addBoltFunc = function(...) self:AddBolt(...) end;


	self.names = { 
		[0]="Fucked up weather",
		[1]="Cloudy",
		[2]="Cloudy",
		[3]="Cloudy",
		[4]="Cloudy",
		[5]="Cloudy",
		[6]="Cloudy",
		[7]="Cloudy",
		[8]="Storm",
		[9]="Foggy and Cloudy",
		[10]="Blue sky",
		[11]="Very very hot",
		[12]="Hazy",
		[13]="Hazy",
		[14]="Hazy",
		[15]="Hazy",
		[16]="Cloudy and verregnet",
		[17]="Sunny and hot",
		[18]="Sunny and hot",
		[19]="SandStorm",
		[20]="Foggy and Cloudy",
		[21]="Dark sky",
		[22]="Dark sky",
		[23]="Sunny and hot",
		[24]="Sunny and hot",
		[25]="Sunny and hot",
		[26]="Sunny and hot",
		[27]="Cloudy",
		[28]="Blue sky",
		[29]="Blue sky",
		[30]="Cloudy",
		[31]="Cloudy",
		[32]="Very foggy",
		[33]="Sunny and hot",
		[34]="Blue sky",
		[35]="Hazy",
		[36]="Hazy",
		[37]="Sunny and hot",
		[38]="Cloudy",
		[39]="Cloudy",
		[40]="Sunny and hot",
		[41]="Sunny and hot",
		[42]="Sandstorm",
		[43]="Cloudy",
		[44]="Black sky",
		[45]="Black sky",
		[46]="Sunny",
		[47]="Sunny",
		[48]="Sunny",
		[49]="Darken"
 	}
 	
 	self.stormy = {
 		[8] = true,
 	}
 	
 	self.currentWeather = 1;
 	
 	self.nextWeather = 1;
 	
 	self.storm = false;
 	
 	self:ChangeWeather()
 	
 	setTimer(self.changeWeatherFunc, 60*60*1000, -1)
 	
 	addCommandHandler("stormy", self.stormFunc)
 	addCommandHandler("boltPlease", self.addBoltFunc)

	outputDebugString("[CALLING] Weather: Constructor");
end

-- EVENT HANDLER --
