-- #######################################
-- ## Project: 							##
-- ## Name: Script.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings


cFunc["create_objects"] = function()
	boldUsage = BoldUsage:New()
	
	import = Import:New()
	
	
	setWorldSoundEnabled(4, 1, false)
	setWorldSoundEnabled(4, 4, false)
	
	weather = Weather:New()
end


-- EVENT HANDLER --
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), cFunc["create_objects"]);