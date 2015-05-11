-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: World						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

World = {};
World.__index = World;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function World:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Load		 		//////
-- ///////////////////////////////

function World:Load()
	setWeather(0);
	
	setTimer(function()
		
	
		renderHud = RenderHud:New();
	
		geigerZaehler = GeigerZaehler:New();
		
		inventory = Inventory:New();
	
		renderUserbar:Show();
		
		
		ego:Start();
		
		chatBox:Show();
		
		fadeCamera(true);
		
	end, 1000, 1)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function World:Constructor(...)
	
	logger:OutputInfo("[CALLING] World: Constructor");
end

-- EVENT HANDLER --
