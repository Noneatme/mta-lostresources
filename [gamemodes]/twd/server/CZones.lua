-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: Zone						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Zone = {};
Zone.__index = Zone;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function Zone:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ////CreateRadioaktiveZone//////
-- ///////////////////////////////

function Zone:CreateRadioaktiveZone(x, y, z, radius)
	
	self.radius = radius;
	
	self.object = createObject(1222, x, y, z);
	
	self.spraycan = createObject(2052, x, y, z);
	attachElements(self.spraycan, self.object, 0, 0, 0.4, 90, 90, 90);
	
	
	setElementData(self.object, "radioaktiv", true);
	
	
	addEventHandler("onColShapeHit", self.col, self.radioColHitFunc)
end

-- ///////////////////////////////
-- ////StartRadioActivity	//////
-- ///////////////////////////////

function Zone:StartRadioAcitivity(element)
	if(getElementType(element) == "player") then
		triggerClientEvent(element, "doGeigerzaehlerStart", element, self.col, self.radius)
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function Zone:Constructor(typ, x, y, z, radius)
	-- Radioaktiv: 1222
	self.radioColHitFunc = function(who) self:StartRadioAcitivity(who) end;
	
	if not(self.radius) then
		if(radius) then
			self.radius = radius
		else
			self.radius = 25
		end
	end
	
	self.col = createColSphere(x, y, z, self.radius);
	
	if(self.object) then
		attachElements(self.col, self.object);
	end
		
	if(string.lower(typ) == "radioaktiv") then
		self:CreateRadioaktiveZone(x, y, z, radius);
	elseif(string.lower(typ) == "antizombie") then
		self:CreateAntiZombieZone(x, y, z, radius);
	end
	
	
	logger:OutputInfo("[CALLING] Zone: Constructor");
end

-- EVENT HANDLER --
