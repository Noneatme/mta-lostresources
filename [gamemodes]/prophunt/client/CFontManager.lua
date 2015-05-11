-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: FontManager.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

FontManager = {};
FontManager.__index = FontManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function FontManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// BuildFonts 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FontManager:BuildFonts()
	self.fonts = {}
	self.guiFonts = {};
	
	self.fonts.agency = dxCreateFont("files/fonts/agency.ttf", 64)
	self.guiFonts.agency = guiCreateFont("files/fonts/agency.ttf", 10/(g.aesx+g.aesy)*(g.sx+g.sy))
	
	for index, f in pairs(self.fonts) do
		if not(f) then
			return outputChatBox("URGENT: Font creation failed", 255, 0, 0)
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function FontManager:Constructor(...)
	-- Instanzen
	
	-- Funktionen
	self:BuildFonts();
	-- Events
	
	outputDebugString("[CALLING] FontManager: Constructor");
end

-- EVENT HANDLER --
