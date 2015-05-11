local label, bild
lastStuntTime = 0

function stuntTagRender ()
	local x, y, z, x1, y1, z1, sx, sy
	for index, key in pairs ( getElementsByType("colshape", getRootElement(), true) ) do
		if not(getElementData(key, "ms.stunttype")) then return end
			x, y, z = getElementPosition(key)
			if(x) and (y) and (z) then
				x1, y1, z1 = getElementPosition(gMe)
				local distance = getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
				if(distance < 50) then
					sx, sy = getScreenFromWorldPosition ( x, y, z, 800, true )
					if sx and sy then
						if(getElementData(key, "ms.stunttype") == "start") then
							dxDrawImage ( sx, sy, 64, 64, "data/images/stuntstart.png" )
						elseif(getElementData(key, "ms.stunttype") == "finish") then
							dxDrawImage ( sx, sy, 64, 64, "data/images/stuntfinish.png" )
						end
					end
				end
			end
		end
	end
addEventHandler ( "onClientRender", getRootElement(), stuntTagRender )
local function changeGuiState(var)
	if(var == 0) then
		guiSetVisible(label, false)
		guiSetVisible(bild, false)
	else
		guiSetVisible(label, true)
		guiSetVisible(bild, true)
		guiLabelSetColor(label, 0, 0, 0)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	label = guiCreateLabel(0.3818,0.0046,0.2224,0.0389,"00:00:00",true)
	guiLabelSetVerticalAlign(label,"center")
	guiLabelSetHorizontalAlign(label,"center",false)
	guiSetFont(label, "default-bold-small")
	guiLabelSetColor(label, 0, 0, 0)
	bild = guiCreateStaticImage(0.4615,0.0093,0.0682,0.0296,"data/images/stunttime.png",true)
	guiMoveToBack(bild)
	changeGuiState(0)
end)

local startTick, endTick, enabled

addEvent("onMultistuntStuntStart", true)
addEventHandler("onMultistuntStuntStart", getRootElement(), function(theStunt)
	startTick = getTickCount()
	enabled = true
	changeGuiState(1)
end)

addEvent("onMultistuntStuntFail", true)
addEventHandler("onMultistuntStuntFail", getRootElement(), function()
	enabled = false
	setTimer(changeGuiState, 1000, 1, 0)
	guiLabelSetColor(label, 255, 0, 0)
end)

addEvent("onMultistuntStuntFinish", true)
addEventHandler("onMultistuntStuntFinish", getRootElement(), function(theStunt)
	enabled = false
	setTimer(changeGuiState, 2500, 1, 0)
	guiLabelSetColor(label, 0, 255, 0)
	outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #00FF00Time: "..guiGetText(label), 0, 0, 0, true)
	triggerServerEvent("onMultistuntStuntlistCheck", gMe, theStunt, getElementData(gMe, "ms.temptime"))
end)

addEventHandler("onClientRender", getRootElement(), function()
	if(enabled == true) then
		local tick = getTickCount()
		local time = tick-startTick
		guiSetText(label, msToTimeStr(time))
		setElementData(gMe, "ms.temptime", time, false)
		lastStuntTime = time
	end
end)
