--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme & Kreativ                   ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]

addEvent("onCarballMapLoad", true)

local map_dimensions = {
	['maps/carball-arena1.map'] = 1,
	['maps/carball-arena2.map'] = 3,
	['maps/carball-arena3.map'] = 5,
}

function loadResourceMap( player, resource, map )
	local resourceName = getResourceName( resource )
		if resourceName then
		local metaRoot = xmlLoadFile(':'..resourceName..'/meta.xml')
			if metaRoot then
				for i, v in ipairs( xmlNodeGetChildren( metaRoot ) ) do 
					if xmlNodeGetName( v ) == 'custommap' then
					local mapPath = xmlNodeGetAttribute(v,'src')
					local mapRoot = xmlLoadFile(':'..resourceName..'/'..mapPath)
						if mapRoot then
						local mapContent = {}
						local dim = map_dimensions[mapPath]
							for i, v in ipairs( xmlNodeGetChildren( mapRoot ) ) do 
							local typ = xmlNodeGetName( v )
								if typ == 'object' then
									table.insert( mapContent, { typ, -- 1
										xmlNodeGetAttribute(v,'interior'), -- 2
										xmlNodeGetAttribute(v,'alpha'), -- 3
										xmlNodeGetAttribute(v,'doublesided'), -- 4
										xmlNodeGetAttribute(v,'model'), -- 5
										xmlNodeGetAttribute(v,'scale'), -- 6
										dim, -- 7
										xmlNodeGetAttribute(v,'posX'), -- 8
										xmlNodeGetAttribute(v,'posY'), -- 9
										xmlNodeGetAttribute(v,'posZ'), -- 10
										xmlNodeGetAttribute(v,'rotX'),-- 11
										xmlNodeGetAttribute(v,'rotY'), -- 12
										xmlNodeGetAttribute(v,'rotZ') } ) -- 13
								elseif(typ == 'marker') then
									table.insert( mapContent, { typ, -- 1
										xmlNodeGetAttribute(v,'interior'), -- 2
										xmlNodeGetAttribute(v,'color'), -- 3
										dim, -- 4
										xmlNodeGetAttribute(v,'typ'), -- 5
										xmlNodeGetAttribute(v,'size'), -- 6
										xmlNodeGetAttribute(v,'alpha'), -- 7
										xmlNodeGetAttribute(v,'posX'), -- 8
										xmlNodeGetAttribute(v,'posY'), -- 9
										xmlNodeGetAttribute(v,'posZ'), -- 10
										xmlNodeGetAttribute(v,'rotX'),-- 11
										xmlNodeGetAttribute(v,'rotY'), -- 12
										xmlNodeGetAttribute(v,'rotZ') } ) -- 13
								end
							end
						triggerClientEvent(player, 'onServerSendMapContent', player, mapContent )
						xmlUnloadFile( mapRoot )
						end
					end
				end
			xmlUnloadFile( metaRoot )
			end
		end
end

addEventHandler("onCarballMapLoad", getRootElement(), function()
	loadResourceMap(source, getThisResource())
end)

-- BETA

--[[
addCommandHandler('leni', function( p )
	loadResourceMap( p, getResourceFromName('rugusxv3'))
end)]]