-- #######################################
-- ## Project: lightning bolt			##
-- ## Name: BoldUsage.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

BoldUsage = {};
BoldUsage.__index = BoldUsage;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function BoldUsage:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// DoClick			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function BoldUsage:DoClick(button, state, x, y, wx, wy, wz)
	if(button == "middle" and state == "down") and not(isTimer(self.waitTimer)) then
		self.started = getTickCount()
	elseif(button == "middle" and state == "up") and not(isTimer(self.waitTimer)) then
	
		if(getTickCount() - self.started < 100) then
			-- DoBold
			
			triggerServerEvent("onBoltStart", getLocalPlayer(), "weatherbolt", wx, wy, wz)
			
	--		Bolt:New(1, wx, wy, wz)
			
			self.waitTimer = setTimer(function() end, 5000, 1)
		end
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function BoldUsage:Constructor(...)
	self.startBolt = function(typ, ...) Bolt:New(typ, ...) end
	self.adminBoltFunc = function(x, y, z) 
		local s = playSound3D("files/sounds/bold1.mp3", x, y, z)
		setSoundMaxDistance(s, 350)
		
		Electricity_Bold:New(x, y, z, 50, 0.25, {0, 50, 255, 255}, 2, 30, 2, true, 10)
		
	end;

	addEvent("onBoltStartClient", true)
	addEvent("onAdminBoltStartClient", true)

	self.clickFunc = function(...) self:DoClick(...) end;

	addEventHandler("onClientClick", getRootElement(), self.clickFunc)
	addEventHandler("onBoltStartClient", getLocalPlayer(), self.startBolt)
	addEventHandler("onAdminBoltStartClient", getLocalPlayer(), self.adminBoltFunc)
	
	outputDebugString("[CALLING] BoldUsage: Constructor");
end

-- EVENT HANDLER --
