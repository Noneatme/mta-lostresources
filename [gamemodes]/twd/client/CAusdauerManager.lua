-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: AusdauerManager						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

AusdauerManager = {};
AusdauerManager.__index = AusdauerManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function AusdauerManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// startSprint 		//////
-- ///////////////////////////////

function AusdauerManager:StartSprint()
	if(self.sprintStatus == false) and (self.ausdauer > 20) then
		self.sprintStatus = true;
		self.regenerate = false;
		toggleControl("sprint", true);
	end
end

-- ///////////////////////////////
-- ///// stopSprint 		//////
-- ///////////////////////////////

function AusdauerManager:StopSprint(zuende)
	if(self.sprintStatus == true) then
		self.sprintStatus = false;

		if(zuende) then
			toggleControl("sprint", false);
		end
	end
end

-- ///////////////////////////////
-- ///// UpdateSprint 		//////
-- ///////////////////////////////

function AusdauerManager:UpdateSprint()

	if(self.sprintStatus == true) then
		if(self.ausdauer > 0) then
			self.ausdauer = self.ausdauer-0.25;
		else
			self:StopSprint(true);

		end
		
					
		if(isTimer(self.regenTimer)) then
			killTimer(self.regenTimer)
		end
		self.regenTimer = setTimer(function()
			self.regenerate = true;
		end, 2500, 1)
	end
	if(self.regenerate == true) then
		if(self.ausdauer < 100) then
			self.ausdauer = self.ausdauer+0.1
		else
			self.regenerate = false;
		end
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function AusdauerManager:Constructor(...)

	
	self.sprintRemoveFunc = function() self:UpdateSprint() end;
	self.startSprint = function() self:StartSprint() end;
	self.stopSprint = function() self:StopSprint() end;
	
	self.timer = setTimer(self.sprintRemoveFunc, 50, -1);
		
	self.sprintStatus = false;
	self.ausdauer = 100;
	
	
	bindKey("sprint", "down", self.startSprint);
	bindKey("sprint", "up", self.stopSprint);
	
	logger:OutputInfo("[CALLING] AusdauerManager: Constructor");
end

-- EVENT HANDLER --
