-- #######################################
-- ## Project: lightning bolt			##
-- ## Name: Import.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Import = {};
Import.__index = Import;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Import:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// ImportModels 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Import:ImportModels()
	-- 2035
	-- 2044
	-- 2054
	
	local dff1 = engineLoadDFF("files/models/overheat_car.dff", 0);
	local dff2 = engineLoadDFF("files/models/prt_smokeII_3_expand.dff", 0);
	local dff3 = engineLoadDFF("files/models/riot_smoke.dff", 0);
	local dff4 = engineLoadDFF("files/models/shootlight.dff", 0);
	
	
	engineReplaceModel(dff1, 2035)
	engineReplaceModel(dff2, 2044)
	engineReplaceModel(dff3, 2054)
	engineReplaceModel(dff4, 2059)
	
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Import:Constructor(...)
	self:ImportModels()
	
	outputDebugString("[CALLING] Import: Constructor");
end

-- EVENT HANDLER --
