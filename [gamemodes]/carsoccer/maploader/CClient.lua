--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MTA Alan Wake' - Gamemode for Multi Theft Auto San Andreas ##
	##                      Developer: Noneatme & Kreativ                   ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


local mainMapElement = createElement('mainMapElement')

function onServerSendMapContent( mapContent )
	for i2 = 0, 6, 1 do
		if type( mapContent ) == 'table' then
			if #mapContent ~= 0 then
				for i, content in ipairs( mapContent ) do
					if content[1] == 'object' then
						-- OBJ
						local obj = createObject( content[5], content[8], content[9], content[10], content[11], content[12], content[13] )
						setElementInterior(obj, tonumber(content[2] ))
						setElementAlpha( obj, tonumber(content[3] ))
						setElementDoubleSided( obj, toboolean(content[4])) -- 4
						setObjectScale( obj, tonumber(content[6]) )
						-- PARENT
						setElementParent( obj, mainMapElement ) 
						setElementDimension(obj, i2)
						
						if(tonumber(content[5]) == 8172) then
							setElementAlpha(obj, 0)
						end
					elseif content[1] == 'marker' then
						-- OBJ
						local r, g, b, a = getColorFromString(content[3])
						local obj = createMarker( content[8], content[9], content[10], content[5], content[6], r, g, b, a)
						setElementInterior(obj, tonumber(content[2] ))
						-- PARENT
						setElementParent( obj, mainMapElement ) 
						setElementDimension(obj, i2)
	
					end
				end
				
			end
		end
	end
end
addEvent('onServerSendMapContent', true)
addEventHandler('onServerSendMapContent', getRootElement(), onServerSendMapContent)

function toboolean( string )
	if string == 'false' or string == "false" then
		return false
	elseif string == 'true' or string == "true" then
		return true
	end
end

triggerServerEvent("onCarballMapLoad", localPlayer)
