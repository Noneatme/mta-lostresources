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
	for index, player in pairs(getElementsByType("player")) do
		enew(player, Player)
	end
	
	logger = Logger:New();
	connectionManager = ConnectionManager:New();
	
	lobbyManager = LobbyManager:New();
	
	mapLoader = MapLoader:New();
end


-- EVENT HANDLER --
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), cFunc["create_objects"]);