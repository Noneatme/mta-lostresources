-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## Name: Script.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings


cFunc["create_objects"] = function()
	-- OBJECTS 
	-- SOUND MANAGER
	soundManager = SoundManager:New();
	soundManager:AddCategory("sounds");
	soundManager:AddCategory("music");
	
	
	-- CURSOR --
	cursor = Cursor:New("files/images/cursors/cursor_default.png", 32, 32);
	
	-- RENDER
	renderVersion = RenderVersion:New()
	fontManager = FontManager:New();
	
	mainMenu = MainMenu:New();
	
	messageBox = MessageBox:New();

	
	-- EVENTS
	triggerServerEvent("onPlayerDownloaded", getLocalPlayer())
end


-- EVENT HANDLER --
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), cFunc["create_objects"]);