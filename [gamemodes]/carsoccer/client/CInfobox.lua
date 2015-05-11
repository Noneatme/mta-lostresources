--[[
#---------------------------------------------------------------#
----*		Project X Script ib_client.lua			*----
#---------------------------------------------------------------#
]]

--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MT-RPG' - Gamemode for MTA: San Andreas PROJECT X          ##
	##                      Developer: Marwin                               ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Marwin, Project X Gaming
]]

local theTexts = {}
local theTextTimer = {}
local activeFade = 0
local alpha
local fadeState

local function destroyTextItem ()
	table.remove(theTexts,1)
	activeFade = 40
	alpha = 160
end

local function checkTimers ()
	if isTimer(theTextTimer["destroy"]) then
		killTimer(theTextTimer["destroy"])
	end
	theTextTimer["destroy"] = setTimer(destroyTextItem,7000,4)
end

local function infoboxActive ()
	if activeFade > 0 then
		return
	end
	activeFade = 40
	fadeState = "down"
	alpha = 160
end

function outputInfobox(text, r, g, b, chatoutput)
	if #theTexts == 4 then
		destroyTextItem()
	end
		table.insert(theTexts,{text,r,g,b})
		checkTimers()
		infoboxActive ()
		outputConsole (text)
		if chatoutput then
			playSound("data/sounds/popup/SNDDautosave.mp3")
		end	
	--	playSound("sounds/popup/SNDDautosave.mp3")
end
addEvent("onMTInfoboxStart", true)
addEventHandler("onMTInfoboxStart", getLocalPlayer(), outputInfobox)



--Draw Part
local screenWidth, screenHeight = guiGetScreenSize()
local boxSpace = dxGetFontHeight(1,"default-bold")+dxGetFontHeight(1,"default-bold")*0.3
addEventHandler("onClientRender", getRootElement(), 
function()
		--fade
			if activeFade > 0 then
				if alpha == 160 then
					fadeState = "down"
				elseif alpha == 0 then
					fadeState = "up"
				end
				if fadeState == "down" then
					alpha = alpha-8
				else
					alpha = alpha+8
				end
				activeFade = activeFade-1
			end
	for id, value in pairs(theTexts) do
			--lol
			local r2, g2, b2
			if #theTexts == 4 or #theTexts == 2 then
				r2,g2,b2 = 19,19,19
				if id == 1 or id == 3 then
					r2,g2,b2 = 55,55,55
				end
			elseif #theTexts == 3 or #theTexts == 1 then
				r2,g2,b2 = 55,55,55
				if id == 1 or id == 3 then
					r2,g2,b2 = 19,19,19
				end
			end
			--draw
			dxDrawRectangle ( screenWidth*0.3, screenHeight-id*boxSpace, screenWidth*0.4, boxSpace, tocolor (r2,g2,b2,alpha) )
			dxDrawText (value[1],screenWidth*0.3, screenHeight-id*boxSpace, screenWidth*0.7, screenHeight-(id-1)*boxSpace, tocolor(value[2],value[3],value[4],alpha), 1, "default-bold", "center", "center", true, false, false, true)
	end
end
)



