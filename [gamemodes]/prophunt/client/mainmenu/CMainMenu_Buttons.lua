-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: MainMenu_Buttons.lua		##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MainMenu_Buttons = {};
MainMenu_Buttons.__index = MainMenu_Buttons;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MainMenu_Buttons:New(...)
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

function MainMenu_Buttons:Render()

	
	self.rm:dxDrawText(strings.mainmenu.buttons.findgame, 45, 195, 517, 262, getColorFromBool(getElementData(self.guiele.btnFindGame, "hover"), 0, 0, 0, 255, 0, 0, 0, 150), 0.4, fontManager.fonts.agency, "left", "center", false, false, true, false, false)
	if(getElementData(self.guiele.btnFindGame, "hover")) then
		self.rm:dxDrawRectangle(45, 195, 517-45, 262-195, tocolor(0, 0, 0, 50), false)
	end
	self.rm:dxDrawText(strings.mainmenu.buttons.newgame, 45, 277, 517, 344, getColorFromBool(getElementData(self.guiele.btnNewGame, "hover"), 0, 0, 0, 255, 0, 0, 0, 150), 0.4, fontManager.fonts.agency, "left", "center", false, false, true, false, false)
	if(getElementData(self.guiele.btnNewGame, "hover")) then
		self.rm:dxDrawRectangle(45, 277, 517-45, 344-277, tocolor(0, 0, 0, 50), false)
	end
	self.rm:dxDrawText(strings.mainmenu.buttons.options, 45, 553, 517, 620, getColorFromBool(getElementData(self.guiele.btnOptions, "hover"), 0, 0, 0, 255, 0, 0, 0, 150), 0.4, fontManager.fonts.agency, "left", "center", false, false, true, false, false)
	if(getElementData(self.guiele.btnOptions, "hover")) then
		self.rm:dxDrawRectangle(45, 553, 517-45, 620-553, tocolor(0, 0, 0, 50), false)
	end
	
end

-- ///////////////////////////////
-- ///// BuildGui			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Buttons:BuildGui()

	self.guiele.btnFindGame 	= self.rm:guiCreateButton(45, 195, 517-45, 262-195, "", false, nil, true, rstrings.sounds.buttons.hover, rstrings.sounds.buttons.click);
	self.guiele.btnNewGame		= self.rm:guiCreateButton(45, 277, 517-45, 344-277, "", false, nil, true, rstrings.sounds.buttons.hover, rstrings.sounds.buttons.click);
	self.guiele.btnOptions		= self.rm:guiCreateButton(45, 553, 517-45, 620-553, "", false, nil, true, rstrings.sounds.buttons.hover, rstrings.sounds.buttons.click);
	
	
	for index, ele in pairs(self.guiele) do
		guiSetAlpha(ele, 0);
	end
	
	addEventHandler("onClientGUIClick", self.guiele.btnFindGame, self.btnFindGameFunc);
	addEventHandler("onClientGUIClick", self.guiele.btnNewGame, self.btnNewGameFunc);
	addEventHandler("onClientGUIClick", self.guiele.btnOptions, self.btnOptionsFunc);
	
end

-- ///////////////////////////////
-- ///// FindGame	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Buttons:FindGame()
	if(mainMenu.objects[4].enabled) then
		mainMenu.objects[4]:Toggle();
	end
	mainMenu.objects[3]:Toggle();
end

-- ///////////////////////////////
-- ///// NewGame	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Buttons:NewGame()
	if(mainMenu.objects[3].enabled) then
		mainMenu.objects[3]:Toggle();
	end
	mainMenu.objects[4]:Toggle();
end

-- ///////////////////////////////
-- ///// Options	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Buttons:Options()

end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Buttons:Constructor(...)
	-- Instanzen
	self.rm = RenderManager:New(g.aesx, g.aesy);
	self.guiele = {};
	
	-- Funktionen
	self.btnFindGameFunc = bind(self.FindGame, self);
	self.btnNewGameFunc = bind(self.NewGame, self);
	self.btnOptionsFunc = bind(self.Options, self);
	
	self:BuildGui();
	-- Events
	
	outputDebugString("[CALLING] MainMenu_Buttons: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Buttons:Destructor()
	for index, ele in pairs(self.guiele) do
		destroyElement(ele);
	end
end

-- EVENT HANDLER --
