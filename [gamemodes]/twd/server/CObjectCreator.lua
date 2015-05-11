-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: Script						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings



cFunc["createObjects"] = function()
	-- Logger
	logger = Logger:New();
	logger:OutputInfo("");
	logger:OutputInfo("** Starting new Gamemode ***")
	logger:OutputInfo("");
	
	-- Objects --
	antiInjection = AntiInjection:New();
	connectionManager = ConnectionManager:New();
	
	connectionManager:Open();
	
	joinHandler = JoinHandler:New();
	settings = Settings:New();
	spawnManager = SpawnManager:New();
	
	chatBox = ChatBoxServer:New();

	-- RegisterManager
	registerManager = RegisterManager:New();
	
	expManager = ExpManager:New("server");
	
	
	-- Radioaktive zonen
	
	for index, object in pairs(getElementsByType("object")) do
		if(getElementModel(object) == 1222) then
			local x, y, z = getElementPosition(object)
			Zone:New("radioaktiv", x, y, z, 30+math.random(10, 40));
			
			destroyElement(object)
		end
	end
--	Zone:New("radioaktiv", 2585.2841796875, -961.41082763672, 81.1515625, 50)
end

-- EVENT HANDLER --

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), cFunc["createObjects"])