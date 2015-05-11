-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: GameSettings				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

GameSettings = {};
GameSettings.__index = GameSettings;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function GameSettings:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function GameSettings:Constructor(...)

	
	logger:OutputInfo("[CALLING] GameSettings: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///////////////////////////////

function GameSettings:Destructor()
	
end

-- EVENT HANDLER --
