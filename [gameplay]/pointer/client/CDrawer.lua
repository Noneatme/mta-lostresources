-- #######################################
-- ## Project: Pointer Resource			##
-- ## Name: Drawer.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

Drawer = {};
Drawer.__index = Drawer;

-- Enable drawer?

local enabled = true;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function Drawer:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// RenderDrawings		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Drawer:RenderDrawing()
	for index, player in pairs(getElementsByType("player", getRootElement(), true)) do
		local tbl = getElementData(player, "drawing:drawtable");
		local r, g, b, a = getPlayerNametagColor(player)
		
		if not(self.alpha[player]) then
			self.alpha[player] = {}
			self.reversed[player] = {};
		end
		
		if(tbl) then

			for index, drawing in pairs(tbl) do
				if(drawing) then
					if not(self.alpha[player][index]) or (self.alpha[player][index] > 0)then
						for i2, positions in pairs(drawing) do
							
							if(type(drawing[i2+1]) == "table") and(positions) and (positions[1]) and (drawing[i2+1][1]) then
												
								if not(self.alpha[player][index]) then
									self.alpha[player][index] = 255
								end
								
								local alpha = self.alpha[player][index]
		
								
								if(self.reversed[player][index]) then
									alpha = alpha-0.1
		
									self.alpha[player][index] = alpha
								end					
								
								dxDrawLine3D(positions[1], positions[2], positions[3], drawing[i2+1][1], drawing[i2+1][2], drawing[i2+1][3], tocolor(r, g, b, alpha), 2)
							end
						end
					end
				end
			--	outputChatBox(index..", "..drawing)
			end
		
		--	for i2, drawing in pairs(tbl) do
			--	for index, pos in pairs(drawing) do
					--if(tbl[index+1]) and (pos) and (pos[1]) and (tbl[index+1][1]) then
					--	dxDrawLine3D(pos[1], pos[2], pos[3], tbl[index+1][1], tbl[index+1][2], tbl[index+1][3], tocolor(r, g, b, a))
					--end
		--		end
		--	end
		end
	end

end

-- ///////////////////////////////
-- ///// GetCurrentDrawings	//////
-- ///// Returns: int		//////
-- ///////////////////////////////

function Drawer:GetCurrentDrawings(player)
	local tbl = getElementData(player, "drawing:drawtable");
	
	local draws = 0;
	
	for index, drawing in pairs(tbl) do
		if(drawing) then
			draws = draws+1;
		end
	end
	
	return draws;
end

-- ///////////////////////////////
-- ///// StartDraw	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Drawer:StartDraw(button, state, x, y, wx, wy, wz, element)
	if(self.drawing == false) then
	
		if(self:GetCurrentDrawings(localPlayer)+1 >= self.maxDrawings) then
			return
		end

		self.drawing = true;
			
		if(isTimer(self.drawTimer)) then
			killTimer(self.drawTimer)
		end
		self.drawTimer = setTimer(self.syncDrawFunc, self.updateIntervall, -1);
		self.currentID = self.currentID+1;
			
	--	outputChatBox(self.currentID-1)
		local s = playSound("files/sounds/map_start.mp3", false);
		
		self.writeSound = playSound("files/sounds/map_write.mp3", true);
		setSoundVolume(self.writeSound, 0)
		
	end
end


-- ///////////////////////////////
-- ///// StopDraw	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Drawer:StopDraw(button, state, x, y, wx, wy, wz, element)
	if(self.drawing == true) then
		self.drawing = false;
		if(isElement(self.writeSound)) then
			destroyElement(self.writeSound)
		end
			
		local id = self.currentID;
			
		self.reversed[id] = true;
			
		setTimer(function()
			--	self.reversed[id] = true;
				
			outputDebugString("Removed Drawing: "..id)
			local data = getElementData(localPlayer, "drawing:drawtable")
	
			data[id] = nil;
		--	table.remove(data, id);
		
			setElementData(localPlayer, "drawing:drawtable", data)
				
			
			
		end, self.respawnTime, 1)
			
		if(isTimer(self.drawTimer)) then
			killTimer(self.drawTimer)
		end
	end
end


-- ///////////////////////////////
-- ///// DoClick	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Drawer:DoClick(button, state, ...)
	if(button == "middle") and (state == "down") then
		self:StartDraw(button, state, ...)
	elseif(button == "middle") and (state == "up") then
		self:StopDraw(button, state, ...)
	end
end

-- ///////////////////////////////
-- ///// DoSyncDraw	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Drawer:DoSyncDraw()
	if(self.drawing == true) then
		-- Sync my drawing
		local tbl = getElementData(localPlayer, "drawing:drawtable");
		
		if not(tbl) then
			tbl = {}
		end
		
		local x, y, wx, wy, wz = getCursorPosition()
		
		if(wx and wy and wz) then
			
			local cx, cy, cz = getCameraMatrix()
			
			local hit, hx, hy, hz = processLineOfSight(cx, cy, cz, wx, wy, wz, true, true, true, true);
			
			if(hit) then
				wx, wy, wz = hx, hy, hz+0.1
			end
			
			if not(tbl[self.currentID]) then
				tbl[self.currentID] = {}
			end
			

			if(#tbl[self.currentID] <= self.maxDrawLenght) then
				table.insert(tbl[self.currentID], {wx, wy, wz, 255});
				
				setElementData(localPlayer, "drawing:drawtable", tbl)
				
				if(tbl[self.currentID] ~= nil) then
					if(type(tbl[self.currentID]) == "table") then
						local last = #tbl[self.currentID]
						
						if(tbl[self.currentID][last]) and (tbl[self.currentID][last-1]) then
	
							local distance = getDistanceBetweenPoints3D(tbl[self.currentID][last][1], tbl[self.currentID][last][2], tbl[self.currentID][last][3], tbl[self.currentID][last-1][1], tbl[self.currentID][last-1][2], tbl[self.currentID][last-1][3]);
							
							local volume = distance/2
							
							if(volume >= 1) then
								volume = 1
							end
							
							setSoundVolume(self.writeSound, volume);
						end
					end
				end
			end
		end
	end
end

-- ///////////////////////////////
-- ///// BindKeys	 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Drawer:BindKeys()
	
	addEventHandler("onClientClick", getRootElement(), self.clickFunc)
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function Drawer:Constructor(...)
	self.renderFunc = function() self:RenderDrawing() end;
	self.clickFunc = function(...) self:DoClick(...) end;
	self.syncDrawFunc = function() self:DoSyncDraw() end;
	
	
	setElementData(localPlayer, "drawing:drawtable", {});
	
	-- SETTINGS --
	
	self.maxDrawings = 10;		-- Maximum drawings at once per player										Default: 10
	self.maxDrawLenght = 100;	-- Maximum lines per drawing												Default: 100
	self.respawnTime = 5000;	-- Time in milliseconds how long it should take it to respawn the drawings	Default: 5000
	self.updateIntervall = 50;	-- Sync intervall while drawing												Default: 50
--	(Should be not below 50)
	
	-- NO SETTINGS --
	self.drawings = {}
	self.currentID = 1;
	self.reversed = {};
	self.drawing = false;
	
	self.alpha = {}
	
	-- element(player), color
	
	self:BindKeys()
	
	addEventHandler("onClientPreRender", getRootElement(), self.renderFunc)
	outputDebugString("[CALLING] Drawer: Constructor");
end

-- EVENT HANDLER --

if(enabled) then
	drawer = Drawer:New()
end