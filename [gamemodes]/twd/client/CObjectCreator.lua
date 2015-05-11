-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: ObjectCreator				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings



--[[

]]


cFunc["create_objects"] = function()
	-- Logger --
	logger = Logger:New();
	
	-- Alles Moegliche
	fontManager = FontManager:New();
	cameraMover = CameraMover:New();
	soundManager = SoundManager:New();
	
	messageBox = CG.MessageBox:New();
	optionBox = CG.OptionBox:New();
	
	importer = Importer:New();
	world = World:New();
	ego = Ego:New();
	ausdauerManager = AusdauerManager:New();
	
	expManager = ExpManager:New();
	
	renderUserbar = RenderUserbar:New();
	
	chatBox = ChatBox:New();
	chatBox:AddGroup("System", true);
	chatBox:AddGroup("Local chat", false, 255, 255, 0);
	chatBox:AddGroup("Global chat", false, 255, 255, 255);
	chatBox:AddGroup("Support chat", false, 0, 255, 255);
	
	chatBox:SelectGroup("System");
	
	chatBox:Hide();
	
	outputChatBox("Welcome to MTA:The Walking Death!", 255, 255, 255);
	outputChatBox("");
	outputChatBox("Key Shortcuts:", 255, 255, 255);
	outputChatBox("#FFFF00L - Local Chat #FFFFFF| G - Global Chat", 255, 255, 255);
	outputChatBox("#00FFFFH - Help  Chat #FFFFFF| M - System Chat", 255, 255, 255)
	outputChatBox("#FFFFFFPress #00FF00't'#FFFFFF to chat.", 255, 255, 255);
	-- Register Manager
	registerManager = RegisterManager:New();

	registerManager:Open();
	
end

-- EVENT HANDLER --

cFunc["create_objects"]();