-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: MainMenu_Gamelist.lua		##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MainMenu_Gamelist = {};
MainMenu_Gamelist.__index = MainMenu_Gamelist;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MainMenu_Gamelist:New(...)
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

function MainMenu_Gamelist:Render()
	if(self.enabled == true) then
		self.rm:dxDrawRectangle(404, 27, 1160, 844, tocolor(0, 0, 0, 193), true)
		self.rm:dxDrawRectangle(414, 37, 279, 50, tocolor(255, 255, 255, 133), true)
		self.rm:dxDrawRectangle(708, 37, 279, 50, tocolor(255, 255, 255, 133), true)
		self.rm:dxDrawText(strings.mainmenu.gamelist.btnGameList, 414, 36, 693, 88, tocolor(255, 255, 255, 255), 0.3, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawText(strings.mainmenu.gamelist.btnFav, 708, 37, 987, 89, tocolor(255, 255, 255, 255), 0.3, fontManager.fonts.agency, "center", "center", false, false, true, false, false)
		self.rm:dxDrawRectangle(414, 96, 1141, 768, tocolor(0, 0, 0, 133), true)
	end
end

-- ///////////////////////////////
-- ///// Toggle		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Gamelist:Toggle()
	if(self.enabled) then
		self.enabled = false;
		self:DestroyGui();
	else
		self.enabled = true;
		self:BuildGui();
	end
end

-- ///////////////////////////////
-- ///// BuildGui	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Gamelist:BuildGui()

end

-- ///////////////////////////////
-- ///// DestroyGui	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Gamelist:DestroyGui()

end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Gamelist:Constructor(...)
	-- Instanzen
	self.rm 		= RenderManager:New(g.aesx, g.aesy);
	self.enabled 	= false;
	
	-- Funktionen
	
	-- Events
	
	outputDebugString("[CALLING] MainMenu_Gamelist: Constructor");
end

-- EVENT HANDLER --
