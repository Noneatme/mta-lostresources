-- ###############################
-- ## Project: MTA:Speedrace	##
-- ## Name: Splatter			##
-- ## Author: Noneatme			##
-- ## Version: 1.0				##
-- ## License: See top Folder	##
-- ###############################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

LaternenDestroyer = {};
LaternenDestroyer.__index = LaternenDestroyer;

--[[
3057 -- Barrel
2912 - Temp Crate

3046 -- Barrel 2
1222 - barrel 3

1252 -- Bombe

--]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function LaternenDestroyer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// EnterVehicle 		//////
-- ///////////////////////////////

function LaternenDestroyer:EnterVehicle(thePlayer, seat)
	if(thePlayer == localPlayer) and (seat == 0) then
		self:CreateObject();
	end
end

-- ///////////////////////////////
-- ///// LeaveVehicle 		//////
-- ///////////////////////////////

function LaternenDestroyer:ExitVehicle(thePlayer, seat)
	if(thePlayer == getLocalPlayer()) and (seat == 0) then
		self:DestroyObject();
	end
end

-- ///////////////////////////////
-- ///// CreateObjects 		//////
-- ///////////////////////////////

function LaternenDestroyer:CreateObject()
	if(self.state == false) then
		local veh = getPedOccupiedVehicle(localPlayer);
		local x, y, z = getElementPosition(veh);
		
		self.barrel = {createObject(1337, x, y, z), createObject(1337, x, y, z), createObject(1337, x, y, z), createObject(1337, x, y, z)}

		
		local dis = getElementDistanceFromCentreOfMassToBaseOfModel(veh);
		attachElements(self.barrel[1], veh, 0.5, dis*4, 0, 90, 0, 90);
		attachElements(self.barrel[2], veh, -0.5, dis*4, 0, 90, 0, 90);
		
		attachElements(self.barrel[3], veh, 0.5, -dis*4, 0, 90, 0, 90);
		attachElements(self.barrel[4], veh, -0.5, -dis*4, 0, 90, 0, 90);

		self.state = true;
		
		
		for i = 1, #self.barrel, 1 do
			setElementAlpha(self.barrel[i], 0)
		end

	end
end

-- ///////////////////////////////
-- ///// DestroyObjects 	//////
-- ///////////////////////////////

function LaternenDestroyer:DestroyObject()
	if(self.state == true) then
		for i = 1, #self.barrel, 1 do
			destroyElement(self.barrel[i]);
		end
		self.state = false;
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function LaternenDestroyer:Constructor()
	self.enterFunc = function(...)
		self:EnterVehicle(...);
	end
	self.leaveFunc = function(...)
		self:ExitVehicle(...);
	end
	
	self.destroyObjectFunc = function()
		self:DestroyObject();
	end
	
	self.state = false;
	
	self:CreateObject()
	
	addEventHandler("onClientVehicleEnter", getRootElement(), self.enterFunc);
	addEventHandler("onClientVehicleExit", getRootElement(), self.leaveFunc);
	addEventHandler("onClientPlayerWasted", getLocalPlayer(), self.destroyObjectFunc);
	outputDebugString("[CALLING] LaternenDestroyer: Constructor");
	

end

-- EVENT HANDLER --



local obj = LaternenDestroyer:New();