-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: RenderHud						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RenderHud = {};
RenderHud.__index = RenderHud;

local aesx, aesy = 1600, 900
local sx, sy = guiGetScreenSize();

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RenderHud:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// Render		 		//////
-- ///////////////////////////////

function RenderHud:Render()
	if(self.state == true) then
	
		dxDrawRectangle(sx-(aesx-1034), sy-(aesy-726), 563, 171, tocolor(0, 0, 0, 124), true)
		dxDrawRectangle(sx-(aesx-1316), sy-(aesy-812), 277, 79, tocolor(0, 0, 0, 124), true)
		dxDrawRectangle(sx-(aesx-1038), sy-(aesy-812), 277, 79, tocolor(0, 0, 0, 124), true)
		dxDrawRectangle(sx-(aesx-1038), sy-(aesy-730), 277, 79, tocolor(0, 0, 0, 124), true)
		dxDrawRectangle(sx-(aesx-1316), sy-(aesy-730), 277, 79, tocolor(0, 0, 0, 124), true)
	
		local hp = getElementHealth(localPlayer)
		local r2, g2, b2 = 255, 255, 255
		if(hp <= 0) then
			r2, g2, b2 = 255, 0, 0
		else
			hp = math.abs(hp - 0.01)
			r2, g2, b2 = (100 - hp) * 2.55 / 2, hp * 2.55, 0
		end
			
		dxDrawImage(sx-(aesx-1126), sy-(aesy-820), (185/100*hp), 60, "files/images/aero-title.png", 0, 0, 0, tocolor(r2, g2, b2, 181), true)
		
		dxDrawImage(sx-(aesx-1043), sy-(aesy-817), 81, 68, "files/images/hp.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawRectangle(sx-(aesx-1126), sy-(aesy-821), 186, 63, tocolor(0, 0, 0, 122), true)
		
		hp = getPedArmor(localPlayer)
		local r2, g2, b2 = 255, 255, 255
		if(hp <= 0) then
			r2, g2, b2 = 255, 0, 0
		else
			hp = math.abs(hp - 0.01)
			r2, g2, b2 = (100 - hp) * 2.55 / 2, hp * 2.55, 0
		end
		dxDrawImage(sx-(aesx-1398), sy-(aesy-820), (185/100*hp), 60, "files/images/aero-title.png", 0, 0, 0, tocolor(r2, g2, b2, 181), true)
		dxDrawImage(sx-(aesx-1322), sy-(aesy-817), 67, 68, "files/images/armor.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawRectangle(sx-(aesx-1398), sy-(aesy-818), 186, 63, tocolor(0, 0, 0, 122), true)
	
		if(fileExists("files/images/weapons/"..self.weapon..".png")) then
			dxDrawImage(sx-(aesx-1042), sy-(aesy-733), 268, 71, "files/images/weapons/"..self.weapon..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		end
		dxDrawText(self.weaponAmmo, sx-(aesx-1175), sy-(aesy-765), sx-(aesx-1310), sy-(aesy-804), tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawImage(sx-(aesx-1321), sy-(aesy-734), 85, 67, "files/images/weapons/grenade.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawText(self.granaten, sx-(aesx-1428), sy-(aesy-749), sx-(aesx-1563), sy-(aesy-788), tocolor(255, 255, 255, 255), 1, "pricedown", "center", "center", false, false, true, false, false)
		dxDrawImage(sx-(aesx-1034), sy-(aesy-683), 563, 41, "files/images/aero-title.png", 0, 0, 0, tocolor(255, 255, 255, 113), true)
		dxDrawText(self.time,sx-(aesx- 1034), sy-(aesy-683), sx-(aesx-1223), sy-(aesy-724), tocolor(0, 0, 0, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawImage(sx-(aesx-1227), sy-(aesy-685), 42, 37, "files/images/sivert.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		
		if(geigerZaehler.state == false) then
			if(geigerZaehler.sivert > 0) then
				geigerZaehler.sivert = geigerZaehler.sivert-0.01
			else
				 geigerZaehler.sivert = 0
			end
		end
		dxDrawText((math.floor(geigerZaehler.sivert) or 0).." µSv",sx-(aesx- 1272), sy-(aesy-686), sx-(aesx-1378), sy-(aesy-720), tocolor(0, 0, 0, 255), 1, "bankgothic", "center", "center", false, false, true, false, false)
		
		hp = geigerZaehler.sivert * 10
		
		local r2, g2, b2 = 255, 255, 255
		if(hp <= 0) then
			r2, g2, b2 = 0, 255, 0
		else
			hp = math.abs(hp - 0.01)
			r2, g2, b2 =  hp * 2.55, (100 - hp) * 2.55 / 2, 0
		end
		
		dxDrawImage(sx-(aesx-1396), sy-(aesy-687), 193, 32, "files/images/aero-title.png", 0, 0, 0, tocolor(r2, g2, b2, 255), true)
		
		
		-- Update Things --
		local time = getRealTime()
		if(time.hour < 10) then
			self.time = "0"..time.hour
		else
			self.time = time.hour;
		end
		if(time.minute < 10) then
			self.time = self.time..":0"..time.minute
		else
			self.time = self.time..":"..time.minute
		end
		
		self.weapon = getPedWeapon(localPlayer)
		
		self.weaponAmmo = getPedAmmoInClip(localPlayer).." / "..getPedTotalAmmo(localPlayer) - getPedAmmoInClip(localPlayer);
		
		self.granaten = getPedTotalAmmo(localPlayer, 8);
		
		
		
		-- Sivert screen
		if(geigerZaehler.sivert > 0) then
	
			dxDrawImage(0, 0, sx, sy, "files/images/radioactivity_screen.png", 0, 0, 0, tocolor(255, 255, 255, (200/10*geigerZaehler.sivert)+math.random(0, 20)));
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RenderHud:Constructor(...)
	self.renderFunc = function() self:Render() end
	self.hideHudFunc = function() self.state = not(self.state) end;

	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	
--	logger:OutputInfo("[CALLING] RenderHud: Constructor");

	self.time = "12:00"
	self.sivert = 0
	
	self.weapon = 0;
	self.weaponAmmo = 0;
	
	self.granaten = 0;
	
	self.state = true;
	
	addCommandHandler("hidehud", self.hideHudFunc);
end

-- EVENT HANDLER --


