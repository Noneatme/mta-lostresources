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

BoltUsage = {};
BoltUsage.__index = BoltUsage;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function BoltUsage:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function BoltUsage:Constructor(...)
	self.startBoltFunc = function(typ, x, y, z, target, ...) 
		triggerClientEvent(getRootElement(), "onBoltStartClient", getRootElement(), typ, x, y, z, target, ...); 
	
		if(typ == "weatherbolt") or (typ == "adminbolt") and not(target)  then
			setTimer(function()
				createExplosion(x, y, z, 5)
			end, 300, 1)
		end
	end;
	
	self.boltPlayerFunc = function(thePlayer, cmd, target)
		if(target) and (getPlayerFromName(target)) then
			target = getPlayerFromName(target)
			
			local accName = getAccountName ( getPlayerAccount ( thePlayer ) ) -- get his account name
   		  	if isObjectInACLGroup ("user."..(accName or "niemand"), aclGetGroup ( "Admin" ) ) then -- Does he have access to Admin functions?
   		  		local x, y, z = getElementPosition(target);
   		  		self.startBoltFunc("weatherbolt", x, y, z-1, target)
   		  		
   		  		outputChatBox(getPlayerName(thePlayer).." shocked "..getPlayerName(target), getRootElement(), 255, 0, 0)
   		  	end
		end
	end;
	self.boltAreaFunc = function(thePlayer, cmd)

		local accName = getAccountName ( getPlayerAccount ( thePlayer ) ) -- get his account name
		if isObjectInACLGroup ("user."..(accName or "niemand"), aclGetGroup ( "Admin" ) ) then -- Does he have access to Admin functions?
			local x, y, z = getElementPosition(thePlayer)
			
			setPedAnimation(thePlayer, "CARRY", "crry_prtial", 1, false)
			
			setTimer(setPedAnimation, 1000, 1, thePlayer, false)
			
			setTimer(triggerClientEvent, 1000, 1, getRootElement(), "onAdminBoltStartClient", getRootElement(), x, y, z); 
			
			--setTimer(function()
				local elements = {}
				
				
				local col = createColSphere(x, y, z, 50)
				local maxLimit = 10
				local cur = 0;
				for index, element in pairs(getElementsWithinColShape(col)) do
					if(getElementType(element) ~= "object") and (element ~= thePlayer) then
						if(cur <= maxLimit) then
							local x, y, z = getElementPosition(element)
							setTimer(function()
								self.startBoltFunc("adminbolt", x, y, z-1)
							end, math.random(50, 250), 1)
							cur = cur+1
						end
						
					end
				end
				
				destroyElement(col)
				outputChatBox(getPlayerName(thePlayer).." shocked his/her area.", getRootElement(), 255, 0, 0)
				
			--end, 500, 1)
		end
	end;
	addEvent("onBoltStart", true)
	
	addEventHandler("onBoltStart", getRootElement(), self.startBoltFunc)
	
	-- Commands
	addCommandHandler("boltplayer", self.boltPlayerFunc)
	addCommandHandler("boltarea", self.boltAreaFunc)
	
	outputDebugString("[CALLING] BoldUsage: Constructor");
end

-- EVENT HANDLER --
