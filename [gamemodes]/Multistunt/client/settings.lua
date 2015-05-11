----------------------------
-- All scripts by MuLTi!  --
-- Do not Remove credits! --
-- Copyright!             --
----------------------------
gMe = getLocalPlayer()
local sx, sy = guiGetScreenSize()

local sound

addEvent("onClientSoundPos", true)
addEventHandler("onClientSoundPos", getRootElement(),
function(x, y, z, path)
	sound = playSound3D(path, x, y, z)
	setSoundMaxDistance(sound, 20)
end)

addEventHandler ( "onClientPlayerChangeNick", getLocalPlayer(), function ()
	cancelEvent()
	outputChatBox("Error: Please ask an admin, to change your name.", 0, 255, 0)
end)

addEvent("setWaterLevel", true)
addEventHandler("setWaterLevel", getRootElement(),
function(level)
	setWaterLevel(level)
end)

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	local x, y = guiGetScreenSize()
	if(x < 800) and (y < 600) then
		triggerServerEvent("onResoutionKick", gMe)
	end
end)

setTimer( function()
	if(getElementData(gMe, "GUI") == true) then
		showCursor(true)
	end
end, 50, 0)


function disableGhostMode(vehicle)
	local x, y, z = getElementPosition(vehicle)
	local col = createColSphere(x, y, z, 10)
		if(#getElementsWithinColShape(col, "vehicle") > 1) then setTimer(disableGhostMode, 1000, 1, vehicle) destroyElement(col) else
			destroyElement(col)
			setElementAlpha(vehicle, 255)
			for index, car in pairs(getElementsByType("vehicle")) do
				setElementCollidableWith ( vehicle, car, true )
			end
		end
end

local pGhostTimer = {}

function set_ghostmode(vehicle)
	if(isTimer(pGhostTimer[vehicle])) then killTimer(pGhostTimer[vehicle]) end
	setElementAlpha(vehicle, 150)
	for index, car in pairs(getElementsByType("vehicle")) do
		setElementCollidableWith ( vehicle, car, false )
	end
	local veh = vehicle
	pGhostTimer[vehicle] = setTimer(disableGhostMode, 7500, 1, veh)
end

addEvent("onGhostmodeSet", true)
addEventHandler("onGhostmodeSet", getRootElement(), set_ghostmode)

function getMiddleGuiPosition(lol, lol2)

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = lol, lol2
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	return X, Y, Width, Height
end
local moov = 0
local object1, object2
function smoothMoveCamera ( x1, y1, z1, x1t, y1t, z1t, x2, y2, z2, x2t, y2t, z2t, time )
	if(moov == 1) then error("Zu wenig Frames") return end
	object1 = createObject ( 1337, x1, y1, z1 )
	object2 = createObject ( 1337, x1t, y1t, z1t )
	setElementAlpha ( object1, 0 )
	setElementAlpha ( object2, 0 )
	setObjectScale( object1, 0 )
	setObjectScale( object2, 0 )
	moveObject ( object1, time, x2, y2, z2, 0, 0, 0, "InOutQuad" )
	moveObject ( object2, time, x2t, y2t, z2t, 0, 0, 0, "InOutQuad" )
	
	addEventHandler ( "onClientRender", getRootElement(), camRender )
	moov = 1
	setTimer ( removeCamHandler, time, 1 )
	setTimer ( destroyElement, time, 1, object1 )
	setTimer ( destroyElement, time, 1, object2 )
end

function removeCamHandler ()
	moov = 0
	removeEventHandler ( "onClientRender", getRootElement(), camRender )
end

function camRender ()

	local x1, y1, z1 = getElementPosition ( object1 )
	local x2, y2, z2 = getElementPosition ( object2 )
	setCameraMatrix ( x1, y1, z1, x2, y2, z2 )

end

setTimer( function()
	for index, guielement in pairs(getElementChildren(getResourceGUIElement())) do
			if(getElementType(guielement) == "gui-window") then
				if(guiGetVisible(guielement) == true) then
					showCursor(true)
				end
			end
		end
	if(getElementData(gMe, "guistate") == true) and (getElementData(gMe, "atScoreboard") ~= true) then
		
		showCursor(true)
	end
end, 100, 0)
addCommandHandler("rebind", function()
	setElementData(gMe, "guistate", false, false)
	outputChatBox("Rebind erfolgreich!", 0, 255, 0)
end)
function setGuiState(var)
	if(var == 0) then
		if(getElementData(gMe, "guistate") == true) then
			setElementData(gMe, "guistate", false, false)
			showCursor(false)
		end
	else
		if(getElementData(gMe, "guistate") == false) then
			setElementData(gMe, "guistate", true, false)
			guiSetInputMode("no_binds_when_editing")
		end
	end
end

function getGuiState()
	if(getElementData(gMe, "guistate") == true) then return 1; else return 0; end
end

addEventHandler("onClientRender", getRootElement(), function()
	for index, marker in pairs(getElementsByType("marker", getRootElement(), true)) do
		if(getElementData(marker, "leuchtrakete") == true) then
			local x, y, z = getElementPosition(marker)
			fxAddTyreBurst(x, y, z, 0, 0, -1)
			fxAddTyreBurst(x, y, z, 0, 0, -1)
			fxAddTyreBurst(x, y, z, 0, 0, -1)
		end
	end
end)

addEventHandler("onClientVehicleEnter", getRootElement(), function(thePlayer)
	if(thePlayer ~= gMe) then return end
	setRadioChannel(0)
end)

function setVehicleGravityPoint( targetVehicle, pointX, pointY, pointZ, strength )
	if isElement( targetVehicle ) and getElementType( targetVehicle ) == "vehicle" then
		local vehicleX,vehicleY,vehicleZ = getElementPosition( targetVehicle )
		local vectorX = vehicleX-pointX
		local vectorY = vehicleY-pointY
		local vectorZ = vehicleZ-pointZ
		local length = ( vectorX^2 + vectorY^2 + vectorZ^2 )^0.5
 
		local propX = vectorX^2 / length^2
		local propY = vectorY^2 / length^2
		local propZ = vectorZ^2 / length^2
 
		local finalX = ( strength^2 * propX )^0.5
		local finalY = ( strength^2 * propY )^0.5
		local finalZ = ( strength^2 * propZ )^0.5
 
		if vectorX > 0 then finalX = finalX * -1 end
		if vectorY > 0 then finalY = finalY * -1 end
		if vectorZ > 0 then finalZ = finalZ * -1 end
 
		return setVehicleGravity( targetVehicle, finalX, finalY, finalZ )
	end
	return false
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
	return outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] "..colour..text, 0, 0, 0, true)
end

addEventHandler("onClientGUIClick", guiRoot, function()
	local sound = playSound("sounds/click.wav")
end)

-- Rollover, by Multi!! --


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