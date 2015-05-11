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

addEvent("onPointerGetBack", true)

-- Enabled?
local enabled = true;


--[[

]]

local textures = {
	dxCreateTexture("files/images/ping_kreis.png"),
	dxCreateTexture("files/images/ping_baseattacked.png"),
	dxCreateTexture("files/images/ping_danger.png"),
	dxCreateTexture("files/images/ping_minimap.png"),
	dxCreateTexture("files/images/ping_teleporting.png"),
	dxCreateTexture("files/images/ping_world.png"),
}

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
-- ///// StartPoint	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:StartPoint(key, state)
	if(state == "down") then
		showCursor(true);
		self.state = true
	else
		if(drawer) then
			drawer:StopDraw();
		end
		showCursor(false);
		self.state = false;
	end
end


-- ///////////////////////////////
-- ///// Point		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:Point(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	-- GUI Check
	
	for index, element in pairs(getElementsByType("gui-window")) do
		if(isElement(element)) and (guiGetVisible(element) ~= false) then
			return
		end
	end

	if(button == "left") and (state == "down") and (self.state == true) or (button == "right") and (state == "down") and (self.state == true) then
		if(isCursorShowing()) and not(isTimer(self.waitTimer)) then
			if(worldX and worldY and worldZ) then
				
				triggerServerEvent("onPlayerPoint", getLocalPlayer(), worldX, worldY, worldZ, clickedElement, button)
				
				self.waitTimer = setTimer(function() end, (self.delayTime or 500), 1)
			end
		end		

	end
end

-- ///////////////////////////////
-- ///// BindKeys	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:BindKeys()
	bindKey(self.key, "both", self.startPointFunc);
	addEventHandler("onClientClick", getRootElement(), self.pointFunc)
end


-- ///////////////////////////////
-- ///// PointerBack 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:PointerBack(x, y, z, player, typ, color, ele)

	if(isElement(ele)) then
		z = z+getElementDistanceFromCentreOfMassToBaseOfModel(ele);
	end

	self.pointers[self.lastID] = {x, y, z, player, typ, color, ele}

	self.pointerData[self.lastID] = {}
	
	self.pointerData[self.lastID]["kreis1"] = true;
	self.pointerData[self.lastID]["kreis1size"] = 0.1;
	
	self.pointerData[self.lastID]["kreis2"] = false;
	self.pointerData[self.lastID]["kreis2size"] = 0.1;
	
	self.pointerData[self.lastID]["telemarker"] = true;
	self.pointerData[self.lastID]["telesize"] = 0.1
	
	
	self.pointerData[self.lastID]["kreismarker"] = true;
	self.pointerData[self.lastID]["kreissize"] = 0.1
	
	
	self.pointerData[self.lastID]["icon"] = true;
	self.pointerData[self.lastID]["iconsize"] = 0.1
	
	self.pointerData[self.lastID]["startTick"] = getTickCount()
	
	self.pointerData[self.lastID]["blender"] = Blender:New()
	
	local normalX, normalY, normalZ = getNormalXYZ(x, y, z)	
	
	local vectorNormal = Vector(normalX, normalY, normalZ);

	local vecFace = Vector(x, y, z) + Vector((normalX), (normalY), (normalZ));
	local angle = vectorNormal:angle(vecFace)

	
	local id = self.lastID
	
	setTimer(function()
		self.pointerData[id]["inactive"] = true;
	end, 10000, 1)
	-- Sound und so
	
	self.lastID = self.lastID+1;
	
	local using = self.method;
	
	local sound;
	
	if(using == 1) then
		 sound = "ping_defense.mp3";
	else
		 sound = "ping.mp3";
	end

	if(typ == 1) then
		sound = "ping_attack.mp3";
	elseif(typ == 2) then
		sound = "ping_defense.mp3";
	end
	local s = playSound3D("files/sounds/"..sound, x, y, z);
	setSoundMaxDistance(s, 50)
end

-- ///////////////////////////////
-- ///// Render		 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:Render()
	for index, pointer in pairs(self.pointers) do
		if(self.pointerData[index]) then
			local x, y, z, player, typ, color, element = self.pointers[index][1], self.pointers[index][2], self.pointers[index][3], self.pointers[index][4], self.pointers[index][5], self.pointers[index][6], self.pointers[index][7]
			
			if(element) and (isElement(element)) then
				x, y, z = getElementPosition(element)
				
				z = z-getElementDistanceFromCentreOfMassToBaseOfModel(element);
			end
			
			if(self.pointerData[index]["kreis1"] == true) then
			
				local a = 255/3*self.pointerData[index]["kreis1size"]
			
				dxDrawMaterialLine3D(x, y-self.pointerData[index]["kreis1size"], z+0.1, x, y+self.pointerData[index]["kreis1size"], z+0.1, textures[1], self.pointerData[index]["kreis1size"]*2, tocolor(color[1], color[2], color[3], -a), x, y, 9999);
				
				self.pointerData[index]["kreis1size"] = self.pointerData[index]["kreis1size"]+self.increment
				
				if(self.pointerData[index]["kreis1size"] >= 3) then
					self.pointerData[index]["kreis1"] = false
				end
				
				if(self.pointerData[index]["kreis1size"] > 1) then
					if(self.pointerData[index]["kreis2"] == false) then
						self.pointerData[index]["kreis2"] = true;
						self.pointerData[index]["kreis2size"] = 0.1;
						
						--self.pointerData[index]["telemarker"] = true;
					end
				end
			end
			
			if(self.pointerData[index]["kreis2"] == true) then
			
				local a = 255/3*self.pointerData[index]["kreis2size"]
			
				dxDrawMaterialLine3D(x, y-self.pointerData[index]["kreis2size"], z+0.1, x, y+self.pointerData[index]["kreis2size"], z+0.1, textures[1], self.pointerData[index]["kreis2size"]*2, tocolor(color[1], color[2], color[3], -a), x, y, 9999);
				
				self.pointerData[index]["kreis2size"] = self.pointerData[index]["kreis2size"]+self.increment
				
				if(self.pointerData[index]["kreis2size"] >= 3) then
					self.pointerData[index]["kreis2"] = false
				end
			end
			
			if(self.pointerData[index]["telemarker"] == true) then
				local a = (255/3*self.pointerData[index]["telesize"])*2
				
				if(a > 255) then
					a = 255
				end
				
				local texture = self.rotateTexture(textures[5], self.pointerData[index]["telesize"]*450)
				dxDrawMaterialLine3D(x, y-self.pointerData[index]["telesize"], z+0.1, x, y+self.pointerData[index]["telesize"], z+0.1, texture, self.pointerData[index]["telesize"]*2, tocolor(color[1]*1.5, color[2]*1.5, color[3]*1.5, (-a)), x, y+self.pointerData[index]["telesize"], 9999);
					
				if(self.pointerData[index]["telesize"] > 3) then
					self.pointerData[index]["telemarker"] = false;
				end
				
				self.pointerData[index]["telesize"] = self.pointerData[index]["telesize"]+self.increment/3
			end
			
			--
			if(self.pointerData[index]["kreismarker"] == true) then
				local a = (255/3*self.pointerData[index]["kreissize"])*2
				
				if(a > 255) then
					a = 255
				end
				local texture2 = self.rotateTexture2(textures[2], -self.pointerData[index]["kreissize"]*450)
				dxDrawMaterialLine3D(x, y-self.pointerData[index]["telesize"]*2, z+0.1, x, y+self.pointerData[index]["telesize"]*2, z+0.1, texture2, self.pointerData[index]["telesize"]*5, tocolor(color[1]*1.25, color[2]*1.25, color[3]*1.25, (-a)), x, y, 9999);
				
				
				if(self.pointerData[index]["kreissize"] > 3) then
					self.pointerData[index]["kreismarker"] = false;
				end
				
				self.pointerData[index]["kreissize"] = self.pointerData[index]["kreissize"]+self.increment/3
			end
			
			
			-- Image--
			
			local image;
			if(typ == 0) then
				image = "ping_world.png";
			else
				image = "ping_danger.png";
			end
			
			if(self.pointerData[index]["icon"]) then
				--local a = (255/3*self.pointerData[index]["iconsize"])
				
				local a = self.pointerData[index]["blender"]:GetBlendingValue(0, 255, 4000, 750)
				
				if(a >= 255) then
					a = 255
				end
				
				if(element) and (isElement(element)) then
					z = z + getElementDistanceFromCentreOfMassToBaseOfModel(element)*2;
				end
			
			
				local sx, sy = getScreenFromWorldPosition(x, y, z+1);
				
				if(sx and sy) then
				
					local x1, y1, z1 = getElementPosition(localPlayer)
					
					local distance = getDistanceBetweenPoints3D(x1, y1, z1, x, y, z)
					local width, height = 128, 128
					
					width = (128/distance)*10
				
					height = (128/distance)*10
					
					
					if(width >= 128) then
						width = 128
					end
					
					if(height >= 128) then
						height = 128
					end

					dxDrawImage(sx-width/2, (sy-height/2), width, height, "files/images/"..image, 0, 0, 0, tocolor(color[1], color[2], color[3], a))
				
				end
				self.pointerData[index]["iconsize"] = self.pointerData[index]["iconsize"]+self.increment/2
				
				if(self.pointerData[index]["iconsize"] > 3) then
					self.pointerData[index]["icon"] = false
				end
			end
			
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Pointer:Constructor(...)
	-- Instanzen --
	self.startPointFunc = function(...) self:StartPoint(...) end
	self.pointFunc = function(...) self:Point(...) end;
	self.pointerBackFunc = function(...) self:PointerBack(...) end;
	self.renderFunc = function(...) self:Render(...) end;
	self.clearPointers = function()
		local removed = 0;
		for index, pointer in pairs(self.pointers) do
			if(self.pointerData[index]) then
				if(self.pointerData[index]["inactive"] == true) then
					self.pointerData[index] = nil
					table.remove(self.pointers, index);
					removed = removed+1;
				end
			end
		end
		
		outputDebugString(removed.." pointers removed.");
	end
	
	-- Methods
	self.rotateTexture = function (texture, rot)
		dxSetRenderTarget( self.renderTarget, true )
		local tWidth, tHeight = dxGetMaterialSize(texture)
		dxDrawImage( 0, 0, tWidth, tHeight, texture, rot)
		dxSetRenderTarget()
		
		return self.renderTarget
	end
	
	self.rotateTexture2 = function (texture, rot)
		dxSetRenderTarget( self.renderTarget2, true )
		local tWidth, tHeight = dxGetMaterialSize(texture)
		dxDrawImage( 0, 0, tWidth, tHeight, texture, rot)
		dxSetRenderTarget()
		
		return self.renderTarget2
	end

	
	-- Events

	-- X, Y, Z, Player, Typ, Color
	
	--[[
		Typ:
		0 - World
		1 - Element
		2 - Defend
	]]
	self.pointers = {}
	self.lastID = 1;
	self.pointerData = {}
	
	
	-- SETTINGS --
	self.key = "lalt"		-- Mouse key																	Default: "lalt"
	self.method = 1;		-- Settings (1 - Default, 2 - DotA 2)											Default: 1
	self.delayTime = 500;	-- Time in milliseconds how long it should take to use the pointer again		Default: 500
	
	local x, y = guiGetScreenSize()
	
	self.renderTarget = dxCreateRenderTarget(1024, 1024, true)
	self.renderTarget2 = dxCreateRenderTarget(1024, 1024, true)
	
	if not(self.renderTarget) then
		outputChatBox("Could not create rendertarget, please update your grapic card");
		return
	end
	
	
	self.increment = 0.025;
	
	self.colors = Color:new()
	
	self:BindKeys()
	
	setTimer(self.clearPointers, 60000, -1)
	

	addEventHandler("onPointerGetBack", getLocalPlayer(), self.pointerBackFunc)
	addEventHandler("onClientRender", getRootElement(), self.renderFunc)
	outputDebugString("[CALLING] Pointer: Constructor");
end


-- EVENT HANDLER --
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	if(enabled) then
		pointer = Pointer:New()
	end
end)

function getPointFromDistanceRotation(x, y, dist, angle)
 
    local a = math.rad(90 - angle);
 
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
 
    return x+dx, y+dy;
 
end

function getPlaneRotation(x, y, z)
        local x1, y1, z1 = x, y, z-50
        local x2, y2, z2 = x, y, z+50
       
        -- Normalenvektor holen
        local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ = processLineOfSight(x1, y1, z1, x2, y2, z2)
        if not hit then
                return false
        end
       
        -- Normalenvektor und einen beliebigen Vektor, der parallel zur Z-Achse liegt, definieren
        local vecNormal, vecZ = Vector(normalX, normalY, normalZ), Vector(0, 0, 1)


        -- Winkel (mithilfe der Vector-Klasse) zwischen den beiden Vektoren berechnen (in Grad)
        local angle = vecNormal:angle(vecZ)
       
        return angle
end


function getNormalXYZ(x, y, z)
        local x1, y1, z1 = x, y, z-50
        local x2, y2, z2 = x, y, z+50
       
        -- Normalenvektor holen
        local hit, hitX, hitY, hitZ, hitElement, normalX, normalY, normalZ = processLineOfSight(x1, y1, z1, x2, y2, z2)
        if not hit then
                return false
        end
       
      	return normalX, normalY, normalZ
end