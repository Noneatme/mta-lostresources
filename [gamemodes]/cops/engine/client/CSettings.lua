--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Bankrob' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


local cFunc = {}
local cSetting = {}


-- FUNCTIONS --

--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Bankrob' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


local cFunc = {}
local cSetting = {}


-- FUNCTIONS --


sx, sy = guiGetScreenSize()
aesx, aesy = 1600, 900




function getMiddleGuiPosition(lol, lol2)

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = lol, lol2
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	return X, Y, Width, Height
end

local sm = {}
sm.moov = 0
sm.object1, sm.object2 = nil, nil

function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	if(sm.moov == 1) then return false end
	sm.object1 = createObject ( 1337, x1, y1, z1 )
	sm.object2 = createObject ( 1337, x1t, y1t, z1t )
	setElementAlpha ( sm.object1, 0 )
	setElementAlpha ( sm.object2, 0 )
	setObjectScale(sm.object1, 0.01)
	setObjectScale(sm.object2, 0.01)
	moveObject ( sm.object1, time, x2, y2, z2, 0, 0, 0, "InOutQuad" )
	moveObject ( sm.object2, time, x2t, y2t, z2t, 0, 0, 0, "InOutQuad" )
	
	addEventHandler ( "onClientPreRender", getRootElement(), camRender )
	sm.moov = 1
	setTimer ( removeCamHandler, time, 1 )
	setTimer ( destroyElement, time, 1, object1 )
	setTimer ( destroyElement, time, 1, object2 )
	return true
end

local function removeCamHandler ()
	if(sm.moov == 1) then
		sm.moov = 0
		removeEventHandler ( "onClientPreRender", getRootElement(), camRender )
	end
end

local function camRender ()
	local x1, y1, z1 = getElementPosition ( sm.object1 )
	local x2, y2, z2 = getElementPosition ( sm.object2 )
	setCameraMatrix ( x1, y1, z1, x2, y2, z2 )
end


function sendInfoMessage(text, color)
	local colour
	if(color == "red") or (color == "Red") then colour = "#FF0000" end
	if(color == "green") or (color == "Green") then colour = "#00FF00" end
	if(color == "blue") or (color == "Blue") then colour = "#0000FF" end
	if(color == "aqua") or (color == "Aqua") then colour = "#00FFFF" end
	if(color == "yellow") or (color == "Yellow") then colour = "#FFFF00" end
	if(color == "White") or (color == "white") then colour = "#FFFFFF" end
	if(color == "black") or (color == "Black") then colour = "#000000" end
	if not(colour) then colur = "#FF0000" end
	return outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] "..colour..text, 0, 0, 0, true)
end


-- Mouse rollover --

local rollover = {}
rollover.state = false
rollover.text = ""

function addMouseRollover(guielement, text)
	addEventHandler("onClientMouseEnter", guielement, function() toggleMouseRollover(true, text) end, false)
	addEventHandler("onClientMouseLeave", guielement, function() toggleMouseRollover(false) end, false)
end

function toggleMouseRollover(state, text)
	rollover.state = state
	if(rollover.state == true) then
		rollover.text = text
	end
end

function showMouseRollover()
	if(rollover.state == true) then
		if(isCursorShowing() == false) then 
			rollover.state = false
			rollover.text = ""
		return end
		local sx2, sy2 = getCursorPosition()
		if not(sx2) or not(sy2) then return end
		sx2, sy2 = sx*sx2, sy*sy2
		dxDrawRectangle(sx2, sy2, -150, 80, tocolor(0, 0, 0, 220), true)
		dxDrawImage(sx2-150, sy2, 150, 80, "data/images/archievement/kasten.png", 0, 0, 0, tocolor(255, 255, 255, 220), true)
		dxDrawText(rollover.text, sx2-148, sy2+3, sx2, sy2,tocolor(255, 255, 255, 220), 1, "default-bold", "left", "top", false, false, true)
	end
end

addEventHandler("onClientRender", getRootElement(), showMouseRollover)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end



function getNearestElementToPlayer(player, element)
	local tbl
	if not(element) then
		element = "all"
		tbl = {
			["vehicle"] = 1,
			["player"] = 1,
			["ped"] = 1,
			["object"] = 1,
		}
	end
	local vehicle
	local minDis = math.huge
	local x, y, z = getElementPosition(player)
	local dis = math.huge
	if not(tbl) then
		for k, v in pairs(getElementsByType(element, getRootElement(), true)) do
			dis = getDistanceBetweenPoints3D(x, y, z, getElementPosition(v))
			if dis < minDis then
				vehicle = v
				minDis = dis
			end
		end
	else
		for index, _ in pairs(tbl) do
			for k, v in pairs(getElementsByType(index, getRootElement(), true)) do
				if(v ~= localPlayer) then
					dis = getDistanceBetweenPoints3D(x, y, z, getElementPosition(v))
					if dis < minDis then
						vehicle = v
						minDis = dis
					end
				end
			end
		end
	end
	
	return vehicle, dis
end

function isPlayerSpawned()
	return true
end
-- EVENT HANDLERS --


-- EVENT HANDLERS --