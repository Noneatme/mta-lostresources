-- #######################################
-- ## Project: lightning bolt			##
-- ## Name: Bolt.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Bolt = {};
Bolt.__index = Bolt;

--[[

]]

	
cSetting["textures"] = {
	dxCreateTexture("files/textures/beam_crack_05.png"),
	dxCreateTexture("files/textures/beam_streak_01.png"),
	false,
	dxCreateTexture("files/textures/groundcracks_light.png"),
	dxCreateTexture("files/textures/ground_scorch.png"),
}

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Bolt:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// RenderBolt 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Bolt:Render()
	-- Render Bolt 1, Background Bold --
	
	local curTick = getTickCount()
	
	local x, y, z = self.pos[1], self.pos[2], self.pos[3]
	
	local z2 = z;
	
		
--	z = getGroundPosition(x, y, z)
	
	if not(z) then
		z = z2
	end
	
	local a = 255/(self.impactTime)*(curTick-self.startTick)
	
	
	if(a >= 255) then
		a = 255
	end
	
	-- Render Ground Cracks --

	if(curTick-self.startTick > 300) then
	
	
		dxDrawMaterialLine3D(x, y+self.randSize, z+0.1, x, y-self.randSize, z+0.1, self.textures[4], self.randSize*2, tocolor(255, 255, 255, 100), x, y, z+10000)
	
		dxDrawMaterialLine3D(x, y+self.randSize, z+0.1, x, y-self.randSize, z+0.1, self.textures[5], self.randSize*2, tocolor(255, 255, 255, 200), x, y, z+10000)

	end
	
	
	dxDrawMaterialLine3D(x, y, z+50, x, y, z+50-self.removeDis[1], self.textures[2], 2, tocolor(255, 255, 255, -a))
	
	if(self.removeDis[1] < self.removeDisMax[1]) then
		self.removeDis[1] = ((self.removeDisMax[1]/300)*(curTick-self.startTick))
	end
	
	
	-- Render Bolt 2, Bold --
	
	local r1, g1, b1, r2, g2, b2 = getSkyGradient()
	
	local c = (r1+g1+b1+r2+g2+b2)/6
	
	dxDrawMaterialLine3D(x, y, z+50, x, y, z+50-self.removeDis[2], self.textures[1], 7, tocolor(c, c, c, -a))
	
	
	if(self.removeDis[2] < self.removeDisMax[2]) then
		self.removeDis[2] = ((self.removeDisMax[2]/300)*(curTick-self.startTick))
	end
	
	self.groundPos = {x, y, z}
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Bolt:Constructor(typ, x, y, z, target)
	self.renderFunc = function() self:Render() end;
	
	
	-- CreateBollardLight
	-- Erstellt den Aufschlag-Lichteffekt. (Bollardlights FTW)
	self.createBollardLight = function()
		local x, y, z = self.groundPos[1], self.groundPos[2], self.groundPos[3]
		
		for i = 1, 10, 1 do
		
			self.ele.bollard = createObject(1215, x, y, z)
			setObjectScale(self.ele.bollard, 0)
			setElementCollisionsEnabled(self.ele.bollard, false)
			setTimer(destroyElement, 200, 1, self.ele.bollard)
			
		end
		
		
					
		for i = 1, 5, 1 do
			self.ele.bollard = createObject(1215, x+i, y+i, z)
			setObjectScale(self.ele.bollard, 0)
			setElementCollisionsEnabled(self.ele.bollard, false)
			setTimer(destroyElement, 200, 1, self.ele.bollard)
		end
		
		for i = 1, 5, 1 do
			self.ele.bollard = createObject(1215, x-i, y-i, z)
			setObjectScale(self.ele.bollard, 0)
			setElementCollisionsEnabled(self.ele.bollard, false)
			setTimer(destroyElement, 200, 1, self.ele.bollard)
		end
		
		for i = 1, 5, 1 do
			self.ele.bollard = createObject(1215, x+i, y-i, z)
			setObjectScale(self.ele.bollard, 0)
			setElementCollisionsEnabled(self.ele.bollard, false)
			setTimer(destroyElement, 200, 1, self.ele.bollard)
		end
		
		for i = 1, 5, 1 do
			self.ele.bollard = createObject(1215, x-i, y+i, z)
			setObjectScale(self.ele.bollard, 0)
			setElementCollisionsEnabled(self.ele.bollard, false)
			setTimer(destroyElement, 200, 1, self.ele.bollard)
		end
		-- Particles --
		
		
				
		fxAddSparks(x, y, z, 0, 0, 3, 3, 500, 0, 0, 3, false, 2, 3)
		
		
		setTimer(function()
			local damage = false;
			
			if(target == localPlayer) then
				damage = true;
			end
			
			createExplosion(x, y, z, 5, true, -5.0, damage)
		end, 50, 1)
		
		
		-- E Bolts
		for i = 1, 5, 1 do
			Electricity_Bold:New(x+math.random(-35, 35)/10, y+math.random(-35, 35)/10, z, 50, 0.5, {100, 100, 255, 255}, 2, 30, 2, true, 1)
		end
	end
	
	-- CreateParticleFunc
	-- Erstellt die Partikel. Benoetigt Custom Particle Objects
	self.createParticleFunc = function()
		local x, y, z = self.groundPos[1], self.groundPos[2], self.groundPos[3]

		self.ele.partikel = {}
		
		self.ele.partikel.groundSmoke = createObject(2035, x, y, z)
		self.ele.partikel.bigSmoke = createObject(2044, x, y, z)
		self.ele.partikel.groundSmoke2 = createObject(2054, x, y, z)
		
		for index, object in pairs(self.ele.partikel) do
			setTimer(destroyElement, 1500, 1, object)
		end
		
		for i = 1, 5, 1 do
		
			setTimer(function()
				self.ele.partikel.dingens = createObject(2059, x, y, z+5-i)
				setTimer(destroyElement, 2500, 1, self.ele.partikel.dingens )
			end, 75*i, 1)
		end
	end
	
	-- CreateSoundFunction
	-- Erstellt die Sounds
	
	self.createSoundFunc = function()
		local x, y, z = self.groundPos[1], self.groundPos[2], self.groundPos[3]
				
		if(typ == "weatherbolt") then
			-- Wenn es ein Wetterblitz ist, ein Zusatzsound abspielen (Klingt viel Besser)
			-- Nur bei Wetterblitzen, wenn es bei mehreren Stellen gleichzeitig verwendet werden, klingt es nicht gut
			local s = playSound3D("files/sounds/bold4.mp3", x, y, z);
			setSoundMaxDistance(s, 450)

			
		end
		setTimer(function()
			-- Aufschlag Sound
			local s1 = playSound3D("files/sounds/explo"..math.random(1, 3)..".mp3", x, y, z, false)
			setSoundMaxDistance(s1, 50)
			setSoundVolume(s1, 0.75)
			
			
			
			-- Der Blitz
			local s2 = playSound3D("files/sounds/bold"..math.random(2, 3)..".mp3", x, y, z, false)		
			setSoundMaxDistance(s2, 350)
	
			-- Statische Elektrizitaet, klingt besser
			local s3 = playSound3D("files/sounds/static_field.mp3", x, y, z, false)
			setSoundMaxDistance(s3, 500)

		end, 250, 1)
	end
	
	-- Vision
	-- Checkt ob der Blitz in der Naehe ist.
	-- Wenn ja, laesst er den Himmel aufleuchten.
	
	self.checkVisionFunc = function()
		if(isTimer(self.waitVisionTimer)) then return end
	
		local r1, g1, b1, r2, g2, b2 = getSkyGradient() 
		
		local x2, y2, z2 = getElementPosition(localPlayer)
		
		if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 500) then
			if(isTimer(self.waitVisionTimer)) then return end

		
			setSkyGradient(255, 255, 255, 255, 255, 255) 
			
			self.waitVisionTimer = setTimer(function()
				setSkyGradient(r1, g1, b1, r2, g2, b2)
			end, math.random(100, 250), 1)
		end
	end
	
	-- Instanzen
	self.pos = {x, y, z}
	self.groundPos = {x, y, z}
	self.ele = {}
	
	self.textures = cSetting["textures"]
	
	self.startTick = getTickCount()
	
	self.impactTime = 2000
	self.randSize = math.random(6, 9)
	
	self.removeDis = {}
	self.removeDisMax = {}
	
	self.removeDis[1] = 0;
	self.removeDisMax[1] = 50;
	
	self.removeDis[2] = 0;
	self.removeDisMax[2] = 50;
	
	addEventHandler("onClientRender", getRootElement(), self.renderFunc);
	
	-- 1215

	
	if(typ == "weatherbolt") then
		self.createSoundFunc()
		
		setTimer(self.createBollardLight, 250, 1)
		setTimer(self.createParticleFunc, 150, 1)
	
	else
		self.createSoundFunc()
			
		setTimer(self.createBollardLight, 250, 1)
		setTimer(self.createParticleFunc, 150, 1)
	end
	
	self.checkVisionFunc()
	
	outputDebugString("[CALLING] Bolt: Constructor");
	
	setTimer(function() self:Destructor() end, 15000, 1)
end

-- ///////////////////////////////
-- ///// Destructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Bolt:Destructor()
	removeEventHandler("onClientRender", getRootElement(), self.renderFunc);
	outputDebugString("[CALLING] Bolt: Destructor");	
end

-- EVENT HANDLER --
