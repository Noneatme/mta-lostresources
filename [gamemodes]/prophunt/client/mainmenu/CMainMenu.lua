-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: MainMenu.lua				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MainMenu = {};
MainMenu.__index = MainMenu;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MainMenu:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:Render()
	for _, object in ipairs(self.objects) do
		if(object.Render) then
			object:Render();
		end
	end
	
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu:Constructor(...)
	-- Instanzen
	self.objects = {
		-- Reihenfolge beachten!
		[1] = MainMenu_Wallpaper:New(),
		[2] = MainMenu_Buttons:New(),
		[3] = MainMenu_Gamelist:New(),
		[4] = MainMenu_Newgame:New(),
	}
	-- Funktionen
	self.renderFunc = bind(MainMenu.Render, self);
	
	fadeCamera(true)
	showCursor(true)
	
	-- Events
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	outputDebugString("[CALLING] MainMenu: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///// Returns: void		//////   
-- ///////////////////////////////

function MainMenu:Destructor(...)
-- EVENT HANDLER --
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc)
end
