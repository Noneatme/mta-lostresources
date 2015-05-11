-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: GeigerZaehler						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

GeigerZaehler = {};
GeigerZaehler.__index = GeigerZaehler;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function GeigerZaehler:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// StartCounting 		//////
-- ///////////////////////////////

function GeigerZaehler:StartCounting(targetcol, maxdistance)
	-- if gasmaske und so weiter
	if(self.state == false) then
		self.target = targetcol;
		self.state = true;
		
		self.maxdistance = maxdistance;
		
		local x, y, z = getElementPosition(self.target)
		self.targetPos = {x, y, z};
		
		self.sound = playSound("files/sounds/geiger.mp3", true);
		
		setSoundVolume(self.sound, 0.2);
	end
end

-- ///////////////////////////////
-- ///// StopCounting 		//////
-- ///////////////////////////////

function GeigerZaehler:StopCounting()
	if(self.state == true) then
		self.state = false;
		self.sivert = 0;
	
		if(isElement(self.sound)) then
			destroyElement(self.sound)
		end
	end
end


-- ///////////////////////////////
-- ///// UpdateGeiger 		//////
-- ///////////////////////////////

function GeigerZaehler:UpdateGeiger()
	if(self.state == true) then
		local x1, y1, z1 = getElementPosition(localPlayer)
		local x2, y2, z2 = self.targetPos[1], self.targetPos[2], self.targetPos[3];
		
		local distance = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2);
		
		if(distance >= self.maxdistance) then
			self:StopCounting();
			self.sivert = 0;
		end
		
		self.sivert = 1/distance*self.maxdistance*1.5;
		
		if(self.sivert > 10) then
			self.sivert = 10;
		end
		
		if(isElement(self.sound)) then
			local l1, l2, l3, l4 = getSoundProperties(self.sound);
			--outputChatBox(l2)
			local s = setSoundProperties(self.sound, l1, -10, l3, l4 )
			
		--	outputChatBox(s);
		end
		
		if(getElementHealth(localPlayer) > 0) then
			setElementHealth(localPlayer, getElementHealth(localPlayer)-0.1*self.sivert);
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function GeigerZaehler:Constructor(...)
	self.checkGeigerFunc = function() self:UpdateGeiger() end;
	self.startFunc = function(...) self:StartCounting(...) end;
	
	addEvent("doGeigerzaehlerStart", true)

	self.targetPos = {};
	self.state = false;
	
	self.sivert = 0;
	
	logger:OutputInfo("[CALLING] GeigerZaehler: Constructor");
	
	self.checkTimer = setTimer(self.checkGeigerFunc, 250, -1);
	
	addEventHandler("doGeigerzaehlerStart", getLocalPlayer(), self.startFunc);
end

-- EVENT HANDLER --
