-- #######################################
-- ## Project: MTA Prophunt				##
-- ## Name: Cursor						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Cursor = {};
Cursor.__index = Cursor;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns:	object	//////
-- ///////////////////////////////

function Cursor:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns:	void	//////
-- ///////////////////////////////

function Cursor:Render()
	if(isCursorShowing()) or (isMainMenuActive()) or (isMTAWindowActive()) then
		if(fileExists(self.file)) then
			local x, y = getCursorPosition()
			
			local sx, sy = guiGetScreenSize()
			
			if(x and y) then
				x = sx*x
				y = sy*y
				
				dxDrawImage(x, y, self.width, self.height, self.file, 0, 0, 0, tocolor(255, 255, 255, 255), true);
				setCursorAlpha(0)
				
				if(isMainMenuActive()) then
					setCursorAlpha(255)
				end
			end
		end
	end
end

-- ///////////////////////////////
-- ///// SetCursor	 		//////
-- ///// Returns:	void	//////
-- ///////////////////////////////

function Cursor:SetCursor(file, width, height)
	self.file = file;
	
	self.width = (width or self.width);
	self.height = (height or self.height);
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns:	void	//////
-- ///////////////////////////////

function Cursor:Constructor(file, width, height)
	-- Instancen
	self.renderFunc = function(...) self:Render() end;
	self.file = file;
	
	self.width = width;
	self.height = height;
	
	-- Events
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	
	outputDebugString("[CALLING] Cursor: Constructor");
end

-- EVENT HANDLER --

cursor = Cursor:New("files/images/cursor.png", 32, 32)
