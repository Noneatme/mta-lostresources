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
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Weather:Constructor(...)
	self.getBoltPosFunc = function(x, y, z)
		
		setTimer(function()
			
			local z2 = getGroundPosition(x, y, z)
			
			if(z2) then
				z = z2;
			end
			
			setTimer(function()
				Bolt:New("weatherbolt", x, y, z)
			end, 250, 1)
		
		end, math.random(50, 5000), 1)
	end;

	addEvent("onBoltPositionGet", true)
	
	addEventHandler("onBoltPositionGet", getLocalPlayer(), self.getBoltPosFunc)
	outputDebugString("[CALLING] Weather: Constructor");
end

-- EVENT HANDLER --
