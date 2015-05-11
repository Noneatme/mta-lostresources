-- #######################################
-- ## Project: 	Electricity Resource	##
-- ## Name: Electricity_Bold.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Electricity_Bold = {};
Electricity_Bold.__index = Electricity_Bold;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Electricity_Bold:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Electricity_Bold:Render()
	for i = 1, self.length, self.abstand do
		if(self.renderPos[i]) and (self.renderPos[i+self.abstand]) then
		
			local x1, y1, z1 = self.renderPos[i][1], self.renderPos[i][2], self.renderPos[i][3]
			local x2, y2, z2 = self.renderPos[i+self.abstand][1], self.renderPos[i+self.abstand][2], self.renderPos[i+self.abstand][3]
			
			if(x1 and y1 and z1 and getTickCount()-self.startTick > self.renderPos[i][4]) then
				dxDrawLine3D(x1, y1, z1, x2, y2, z2, tocolor(self.color[1], self.color[2], self.color[3], self.alpha), self.width)
			end
		end
	end
	
	if(self.alpha > 0) then
		self.alpha = self.alpha-self.life;
		
		if(self.alpha <= 0) then
			self:Destructor()
		end
	else
		self:Destructor()
	end 
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Electricity_Bold:Constructor(x, y, z, length, abstand, color, width, spread, life, upcoming, upcomingtime)
	self.renderFunc = function() self:Render() end;
	self.progressBoltFunc = function(i)
		self.renderPos[i] = {x+math.random(-10, 10)/self.spread, y+math.random(-10, 10)/self.spread, (z+self.length)-i};
		if(i == self.length) then
			self.renderPos[i] = {x, y, z};
			self.renderPos[i+1] = {x, y, z};
			
		end
		
		self.renderPos[i][4] = self.upcomingtime*i;
		
		fxAddDebris (self.renderPos[i][1], self.renderPos[i][2], self.renderPos[i][3], 255, 255, 255, 255, 0.05, 1 )
		fxAddBulletImpact (self.renderPos[i][1], self.renderPos[i][2], self.renderPos[i][3], 0, 0, 1, 5, 5, 5 )
	end;
	
	assert(x and y and z);
	-- length: integer representing the ingame coordinates
	
	length = (length or 10);
	
	self.renderPos = {}
	self.length = length;
	z = z-1
	self.color = (color or {0, 0, 255, 255});
	self.width = (width or 1);
	self.spread = (spread or 30);
	self.life = (life or 2);
	
	self.alpha = (self.color[4] or 255)
	
	self.abstand = (abstand or 0.5)
	
	self.endPos = {x, y, z+length};
	
	self.upcoming = (upcoming or true);
	
	self.upcomingtime = (upcomingtime or 25);
	
	self.startTick = getTickCount();
	
	for i = 0, self.length, self.abstand do
		self.progressBoltFunc(i);
	end
	
	addEventHandler("onClientPreRender", getRootElement(), self.renderFunc)
	outputDebugString("[CALLING] Electricity_Bold: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Electricity_Bold:Destructor()
	removeEventHandler("onClientPreRender", getRootElement(), self.renderFunc)
	outputDebugString("[CALLING] Electricity_Bold: Destructor");
end

-- EVENT HANDLER --
