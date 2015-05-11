-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: MainMenu_Wallpaper.lua		##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MainMenu_Wallpaper = {};
MainMenu_Wallpaper.__index = MainMenu_Wallpaper;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MainMenu_Wallpaper:New(...)
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

function MainMenu_Wallpaper:Render()
	if(getTickCount()-self.startTick > 10000) then
		self:ChangeWallpaper();
		self.startTick = getTickCount();
		
		self.changedstate =  not (self.changedstate);
		
		self.changed = true;
	end

	-- Background --
	local asx, asy = 1920, 1080	-- 
	
	if(g.sx > asx) or (g.sy > asy) then	-- Lawl
		asx = g.sx;
		asy = g.sy;
	end
	
	if not(self.changedstate) then
		dxDrawRectangle(0, 0, g.sx, g.sy, tocolor(0, 0, 0, 255), false)
		
		dxDrawImageSection(0, 0, asx, asy, 0, 0, g.sx, g.sy, "files/images/mainmenu/wp-"..self.lastWallpaper..".jpg", 0, 0, 0, tocolor(255, 255, 255, self.lastWallpaperAlpha), false)
		dxDrawImageSection(0, 0, asx, asy, 0, 0, g.sx, g.sy, "files/images/mainmenu/wp-"..self.firstWallpaper..".jpg", 0, 0, 0, tocolor(255, 255, 255, self.firstWallpaperAlpha), false)
		
	else
		dxDrawRectangle(0, 0, g.sx, g.sy, tocolor(0, 0, 0, 255), false)
		
		dxDrawImageSection(0, 0, asx, asy, 0, 0, g.sx, g.sy, "files/images/mainmenu/wp-"..self.firstWallpaper..".jpg", 0, 0, 0, tocolor(255, 255, 255, self.lastWallpaperAlpha), false)
		dxDrawImageSection(0, 0, asx, asy, 0, 0, g.sx, g.sy, "files/images/mainmenu/wp-"..self.lastWallpaper..".jpg", 0, 0, 0, tocolor(255, 255, 255, self.firstWallpaperAlpha), false)
		
	end
		
	if(self.changed == true) then
		if (self.changedstate) then
			self.firstWallpaperAlpha = self.firstWallpaperAlpha+2;
			self.lastWallpaperAlpha = self.lastWallpaperAlpha-2;
			
			if(self.firstWallpaperAlpha >= 255) or (self.lastWallpaperAlpha <= 0) then
				self.changed = false;
				
				self.firstWallpaperAlpha = 255;
				self.lastWallpaperAlpha = 0;
			end
		else
			self.firstWallpaperAlpha = self.firstWallpaperAlpha-2;
			self.lastWallpaperAlpha = self.lastWallpaperAlpha+2;
			
			if(self.lastWallpaperAlpha >= 255) or (self.firstWallpaperAlpha <= 0) then
				self.changed = false;
				
				self.firstWallpaperAlpha = 0;
				self.lastWallpaperAlpha = 255;
			end
		end
	end
	
	-- Logo
	dxDrawImage(1329/g.aesx*g.sx, 12/g.aesy*g.sx, (500/2)/g.aesx*g.sx, (352/2)/g.aesy*g.sy, "files/images/mainmenu/prophunt-"..self.logoID..".png")
	
	
-- outputChatBox(self.firstWallpaperAlpha..", "..self.lastWallpaperAlpha..", "..self.firstWallpaper..", "..self.lastWallpaper)
end

-- ///////////////////////////////
-- ///// ChangeWallpaper 	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Wallpaper:ChangeWallpaper()

	self.firstWallpaper = self.lastWallpaper;
	
	self.lastWallpaper = math.random(1, self.maxWallpaper);
	
	
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Wallpaper:Constructor(...)
	-- Instanzen
	self.maxWallpaper = 5;
	
	self.firstWallpaper = 1;
	self.lastWallpaper = 2;
	
	self.firstWallpaperAlpha = 0;
	self.lastWallpaperAlpha = 0;
	
	self.startTick = getTickCount();
	
	self.changedstate = false;
	self.changed = true;
	
	self.alpha = 0;
	
	self.logoID = math.random(1, 2);
	-- Funktionen

	-- Events

	
	outputDebugString("[CALLING] MainMenu_Wallpaper: Constructor");
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MainMenu_Wallpaper:Destructor(...)

end
-- EVENT HANDLER --
