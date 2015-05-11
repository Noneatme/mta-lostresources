-- #######################################
-- ## Project: Pointer Resource			##
-- ## Name: Blender.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Blender = {};
Blender.__index = Blender;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Blender:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// GetBlendingValue	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Blender:GetBlendingValue(von, bis, time, blendingValue)
	if not(self.startTick) then
		self.startTick = getTickCount()
	end
	local a;
	
	local a1 = interpolateBetween(von, 0, 0, bis, 0, 0, ((getTickCount()-self.startTick)/blendingValue), "InQuad")
	a = a1
	
	if(a1 >= bis) and (getTickCount()-self.startTick > time/2) then
		if not(self.endTick) then
			self.endTick = getTickCount()
		end
		a2 = interpolateBetween(a1, 0, 0, 0, 0, 0, ((getTickCount()-self.endTick)/blendingValue), "OutQuad")
		a = a2
	end

	return a
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Blender:Constructor(...)
	-- Instances --
	self.startTick = false;
	
	outputDebugString("[CALLING] Blender: Constructor");
end

-- EVENT HANDLER --
