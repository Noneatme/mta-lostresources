-- #######################################
-- ## Project: Pointer Resource			##
-- ## Name: Pointer.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Pointer = {};
Pointer.__index = Pointer;

-- Enabled?
local enabled = true;


--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Pointer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// PlayerPoint		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:PlayerPoint(x, y, z, element, button)
	local r, g, b, a = getPlayerNametagColor(source)
	local color = {r, g, b, a};
	
	local typ = 0;
	if(self.typ == 0) then
		typ = 0;
		
		if(element and isElement(element)) then
			typ = 1;
			x, y, z = getElementPosition(element);
		else
			local col = createColSphere(x, y, z, 5);
			for index, ele in pairs(getElementsWithinColShape(col)) do
				if(isElement(ele)) then
					typ = 2;
					break;
				end
			end
			
			destroyElement(col)
		end
	else
		if(button == "left") then
			typ = 1 -- oder 2
		elseif(button == "right") then
			typ = 0
		end
	end
	
	local player = source;
	player = getRootElement()
	
	local blip
	if(isElement(element)) then
		blip = createBlipAttachedTo(element, 0, 2, r, g, b, a, 50);
	else
		blip = createBlip(x, y, z, 0, 2, r, g, b, a, 50)
	end
	
	setTimer(destroyElement, 3000, 1, blip)
	
	return triggerClientEvent(player, "onPointerGetBack", player, x, y, z, source, typ, color, element)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:Constructor(...)
	addEvent("onPlayerPoint", true)
	
	-- Method --
	
	self.typ = 1;		-- Method (1 - Default, 2 - DotA 2)
	
	self.pointEvent = function(...) self:PlayerPoint(...) end;
	
	addEventHandler("onPlayerPoint", getRootElement(), self.pointEvent);
	outputDebugString("[CALLING] Pointer Server: Constructor");
end

-- EVENT HANDLER --

if(enabled) then
	pointer = Pointer:New();
end