-- #######################################
-- ## Project:MTA:The Walking Death		##
-- ## Name: Fontmanager					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

FontManager = {};
FontManager.__index = FontManager;


-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function FontManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// GetNFSFont 		//////
-- ///////////////////////////////

function FontManager:GetNFSFont()
	return "default-bold-small";
end

-- ///////////////////////////////
-- ///// GetDT Font 		//////
-- ///////////////////////////////

function FontManager:GetDTFont()
	return self.dtfont;
end
-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function FontManager:Constructor(...)
	self.dtfont = dxCreateFont("files/fonts/Arimo.ttf", 32);

	logger:OutputInfo("[CALLING] FontManager: Constructor");
end

-- EVENT HANDLER --
