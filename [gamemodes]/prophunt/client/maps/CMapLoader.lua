-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: MapLoader.lua				##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

MapLoader = {};
MapLoader.__index = MapLoader;


addEvent("onClientPlayerMapDataLoad", true);
--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MapLoader:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// LoadMap			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MapLoader:LoadMap(mapConent, dimension)
	if type( mapContent ) == 'table' then
		if #mapContent ~= 0 then
			local iObjects = 0;
			for i, content in ipairs( mapContent ) do
				if content[1] == 'object' then
				-- OBJ
				if(content[5] and content[8] and content[9] and content[10]) then
					local obj = createObject( content[5], content[8], content[9], content[10], content[11], content[12], content[13] )
					if(obj) then
						setElementInterior(obj, tonumber(content[2] ))
						setElementAlpha( obj, (tonumber(content[3]) or 255))
						setElementDoubleSided( obj, (toboolean(content[4]) or false)) -- 4
						setObjectScale( obj, (tonumber(content[6]) or 1) )
						-- PARENT
						setElementParent( obj, self.mainMapElement )
						setElementDimension(obj, tonumber(dimension))
						iObjects = iObjects+1;
						end
					end
				end
			end
			
			outputDebugString("Loaded map content for dimension "..dimension..", objects: "..iObjects)
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MapLoader:Constructor(...)
	-- Instanzen
	self.mainMapElement = createElement("mainMapElement");
	
	-- Funktionen
	self.loadMapFunc = bind(self.LoadMap, self);
	
	-- Events
	
	addEventHandler("onClientPlayerMapDataLoad", getLocalPlayer(), self.loadMapFunc)
	outputDebugString("[CALLING] MapLoader: Constructor");
end

-- EVENT HANDLER --
