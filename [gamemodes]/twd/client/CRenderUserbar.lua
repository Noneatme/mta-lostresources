-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: RenderUserbar						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderUserbar = {};
RenderUserbar.__index = RenderUserbar;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderUserbar:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// Render				//////
-- ///////////////////////////////

function RenderUserbar:Render()
	if(self.state) then

		-- Rahmen --
		self.rm:dxDrawRectangle(0, 0, 1599, 66, tocolor(0, 0, 0, 126), true)
		self.rm:dxDrawRectangle(0, 65, 1598, 2, tocolor(0, 0, 0, 255), true)
		
		-- FPS --
		self.rm:dxDrawText(self.fps.." FPS", 7, 6, 104, 60, tocolor(255, 255, 255, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)
		
		-- Ausdauer --
		self.rm:dxDrawRectangle(158, 18, 319, 27, tocolor(0, 169, 175, 155), true)
		
		local hp = ausdauerManager.ausdauer
		
		local r2, g2, b2 = 255, 255, 255
		if(hp <= 0) then
			r2, g2, b2 = 255, 0, 0
		else
			hp = math.abs(hp - 0.01)
			r2, g2, b2 = (100 - hp) * 2.55 / 2, hp * 2.55, 0
		end
			
		
		self.rm:dxDrawRectangle(158, 18, 319/100*ausdauerManager.ausdauer, 27, tocolor(r2, g2, b2, 150), true)
		self.rm:dxDrawText(math.floor(ausdauerManager.ausdauer).."%", 158, 18, 477, 43, tocolor(255, 255, 255, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)
		
		-- EXP Bar --
		self.rm:dxDrawImage(618, 4, 424, 21, ":twd/files/images/expbar-1.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		self.rm:dxDrawImage(618, 4, self.renderBarValue, 21, ":twd/files/images/expbar-2.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)
		
		self.rm:dxDrawText("EXP: "..math.floor(self.curEXP)..".00 / "..math.floor(self.maxEXP)..".00", 618, 4, 1043, 25, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
			
		-- Unter XP Bar --
		-- AVATAR --
		self.rm:dxDrawImage(619, 27, 35, 33, ":twd/files/images/icons/user.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		self.rm:dxDrawText(getPlayerName(localPlayer), 666, 29, 904, 61, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center", false, false, true, false, false)
		
		-- LEVEL --

		self.rm:dxDrawImage(908, 29, 36, 33, ":twd/files/images/level.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)
		
		self.rm:dxDrawText(self.level, 908, 29, 944, 62, tocolor(255, 255, 255, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)
		
		-- CLOCK --
		self.rm:dxDrawText(self.time, 1374, 7, 1589, 57, tocolor(255, 255, 255, 255), 2, "bankgothic", "center", "center", false, false, true, false, false)

		-- Patronen --
		self.rm:dxDrawImage(1082, 10, 156, 42, ":twd/files/images/icons/patrone.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		self.rm:dxDrawText(self.patronen, 1082, 8, 1238, 52, tocolor(0, 0, 0, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)

		-- Kamerastativ --
		self.rm:dxDrawImage(1267, 10, 82, 48, ":twd/files/images/icons/cam-"..self.camStatus..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		self.rm:dxDrawText("Y", 1281, 9, 1332, 54, tocolor(255, 255, 255, 200), 1, "pricedown", "center", "center", false, false, true, false, false)
		
		
		
		-- DATEN AKTUALISIERUNG -- 
		
		local hour, min = getTime()
		
		if(hour < 10) then
			hour = "0"..hour
		end
		if(min < 10) then
			min = "0"..min
		end
		
		self.time = hour..":"..min;
		
		
		if(getTickCount()-self.fpsTime >= 1000) then
			self.fpsTime = getTickCount()
			
			self.fps = self.tempFPS;
			
			self.tempFPS = 0;
		else
			self.tempFPS = self.tempFPS+1;
		end
		
		
		self.curEXP = (getElementData(localPlayer, "account:EXP") or 0);
		self.maxEXP = expManager:GetMaxEXP(tonumber(getElementData(localPlayer, "account:Level") or 0));
		
		self.level = (getElementData(localPlayer, "account:Level") or 1)
		self.patronen = (getElementData(localPlayer, "account:Patronen") or 0)
		
		local val = (424/self.maxEXP*self.curEXP);
		
		if(self.renderBarValue < val) then
			self.renderBarValue = self.renderBarValue+0.25
		end
		
		if(self.lastlevel ~= self.level) then
			self.renderBarValue = 0
		end
		
		if(ego.egoState == true) then
			self.camStatus = 2;
		else
			self.camStatus = 1;
		end
		
		self.lastlevel = self.level
	end
end

-- ///////////////////////////////
-- ///// Show		 		//////
-- ///////////////////////////////

function RenderUserbar:Show()
	if(self.state == false) then
		self.state = true;
		
		addEventHandler("onClientHUDRender", getRootElement(), self.renderFunc)
	end
end

-- ///////////////////////////////
-- ///// Hide		 		//////
-- ///////////////////////////////

function RenderUserbar:Hide()
	if(self.state == true) then
		self.state = false;
		
		removeEventHandler("onClientHUDRender", getRootElement(), self.renderFunc)
	end
end


-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderUserbar:Constructor(...)
	self.renderFunc = function() self:Render() end
	self.toggleHudFunc = function()
	
		if(self.state == true) then
			self:Hide()
		else
			self:Show()
		end
	end;
	
	self.state = false;
	
	self.rm = RenderManager:New(1600, 900);
	
	self.tempFPS = 0;
	self.fps = 0;
	self.fpsTime = getTickCount();
	
	self.ausdauer = 100;


	self.curEXP = 0;
	self.maxEXP = 1000;
	
	self.level = 1;
	self.patronen = 0;
	self.camStatus = 2;
	
	self.renderBarValue = 0;
	
	self.time = "12:00";
	
	--logger:OutputInfo("[CALLING] RenderUserbar: Constructor");
	
	
	addCommandHandler("hidehud", self.toggleHudFunc);
end

-- EVENT HANDLER --
