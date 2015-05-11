-- #######################################
-- ## Project: MTA Prop Hunt##
-- ## For MTA: San Andreas##
-- ## Name: MapLoader.lua##
-- ## Author: Noneatme##
-- ## Version: 1.0##
-- ## License: See top Folder##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};-- Local Functions
local cSetting = {};-- Local Settings

MapLoader = {};
MapLoader.__index = MapLoader;

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
-- ///// LoadMapObjectsAsTable////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MapLoader:LoadMapObjectsAsTable()
	outputDebugString("Loading map datas...");
	local resourceName = getResourceName(getThisResource())
	if resourceName then
		local metaRoot = xmlLoadFile(':'..resourceName..'/meta.xml')
		if metaRoot then
			local i_maps = 0

			for i, v in ipairs( xmlNodeGetChildren( metaRoot ) ) do
				if xmlNodeGetName( v ) == 'custommap' then
					
					local mapPath = xmlNodeGetAttribute(v,'src')
					local mapRoot = xmlLoadFile(':'..resourceName..'/'..mapPath)
					if mapRoot then
						i_maps = i_maps+1;

						self.mapData[mapPath] = {}
						local i_objects = 0;

						for i, v in ipairs( xmlNodeGetChildren( mapRoot ) ) do

							local typ = xmlNodeGetName( v )
							if typ == 'object' then

								i_objects = i_objects+1;

								table.insert( self.mapData[mapPath], { typ, -- 1
									xmlNodeGetAttribute(v,'interior'), -- 2
									xmlNodeGetAttribute(v,'alpha'), -- 3
									xmlNodeGetAttribute(v,'doublesided'), -- 4
									xmlNodeGetAttribute(v,'model'), -- 5
									xmlNodeGetAttribute(v,'scale'), -- 6
									xmlNodeGetAttribute(v,'dimension'), -- 7
									xmlNodeGetAttribute(v,'posX'), -- 8
									xmlNodeGetAttribute(v,'posY'), -- 9
									xmlNodeGetAttribute(v,'posZ'), -- 10
									xmlNodeGetAttribute(v,'rotX'),-- 11
									xmlNodeGetAttribute(v,'rotY'), -- 12
									xmlNodeGetAttribute(v,'rotZ') } ) -- 13
							end
							
						end
						
						outputDebugString(mapPath..", Total objects: "..i_objects);
						xmlUnloadFile( mapRoot )
					end
				end
			end
			
			outputDebugString(i_maps.. " Maps loaded.");
			xmlUnloadFile( metaRoot )
		end
	end
end

-- ///////////////////////////////
-- ///// Constructor //////
-- ///// Returns: void//////
-- ///////////////////////////////

function MapLoader:Constructor(...)
	-- Instanzen
	self.mapData = {}
	-- Funktionen

	-- Events
	self:LoadMapObjectsAsTable();
	outputDebugString("[CALLING] MapLoader: Constructor");
end

-- EVENT HANDLER --
