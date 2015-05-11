-- #######################################
-- ## Project: MTA FlappyBird			##
-- ## Name: Script.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

local flappy		= false;

--[[

]]

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	outputChatBox("Pres 'L' to open Flappy Birds!", 0, 255, 255)
	bindKey("l", "down", function()
		if(flappy) then
			flappyBirdGame:Destructor();
			showCursor(false);
		else
			flappyBirdGame	= FlappyBirdGame:New();
		end
		
		flappy = not(flappy)
	end)
end)
	-- EVENT HANDLER --
