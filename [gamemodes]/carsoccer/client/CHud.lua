--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Carball' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


local cFunc = {}
local cSetting = {}

cSetting["enabled"] = false

addEvent("onClientCarballStadiumEnter", true)
addEvent("onClientCarballStadiumLeave", true)
addEvent("onCarballClientRoundStart", true)

local aesx, aesy = 1600, 900
local sx, sy = guiGetScreenSize()

cSetting["jump_value"] = 100

cSetting["frames"] = 0
cSetting["temp_frames"] = 0
cSetting["last_tick"] = getTickCount()

cSetting["start_tick"] = 0
cSetting["end_tick"] = 0
cSetting["team_red"] = 0
cSetting["team_green"] = 0

cSetting["round_started"] = false

-- FUNCTIONS --

cFunc["stadion_enter"] = function()
	cSetting["enabled"] = true
end

cFunc["stadion_leave"] = function()
 	cSetting["enabled"] = false
end

cFunc["render_hud"] = function()
	if(cSetting["enabled"] == true) then
        dxDrawRectangle(0, 0, aesx, 35/aesy*sy, tocolor(0, 0, 0, 122), true)
        dxDrawText("FPS: "..cSetting["frames"], 5/aesx*sx, 4/aesy*sy, 113/aesx*sx, 29/aesy*sy, tocolor(0, 216, 242, 255), 0.5/(aesx+aesy)*(sx+sy), "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText(cSetting["team_red"], 142/aesx*sx, 4/aesy*sy, 250/aesx*sx, 29/aesy*sy, tocolor(243, 0, 0, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText(cSetting["team_green"], 252/aesx*sx, 4/aesy*sy, 360/aesx*sx, 29/aesy*sy, tocolor(23, 242, 0, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawText("/", 241/aesx*sx, 2/aesy*sy, 262/aesx*sx, 30/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawLine(0/aesx*sx, 33/aesy*sy, aesx, 34/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), true)
        local count = "00:00:00"
        if(cSetting["round_started"] == true) then
        	count = msToTimeStr(cSetting["end_tick"]-getTickCount())
        end
        dxDrawText(count, 452/aesx*sx, 3/aesy*sy, 607/aesx*sx, 30/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawImage(428/aesx*sx, 7/aesy*sy, 21/aesx*sx, 19/aesy*sy, "data/images/clock1.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) -- Zeit Uebrig
        dxDrawText(getPlayerName(localPlayer), 1408/aesx*sx, 4/aesy*sy, 1562/aesx*sx, 28/aesy*sy, tocolor(0, 216, 242, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "right", "center", false, false, true, false, false)
        dxDrawImage(134/aesx*sx, 7/aesy*sy, 24/aesx*sx, 21/aesy*sy, "data/images/flag.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) -- Punktestand
        
        dxDrawImage(1567/aesx*sx, 5/aesy*sy, 25/aesx*sx, 23/aesy*sy, "data/images/ich.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) -- Name
        dxDrawText(getFormatTime(), 1088/aesx*sx, 2/aesy*sy, 1244/aesx*sx, 28/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "center", "center", false, false, true, false, false)
        dxDrawImage(1060/aesx*sx, 7/aesy*sy, 24/aesx*sx, 19/aesy*sy, "data/images/clock2.png", 0, 0, 0, tocolor(255, 255, 255, 255), true) -- Uhrzeit
        
        -- Aufladung -- 
        dxDrawRectangle(655/aesx*sx, 4/aesy*sy, cSetting["jump_value"]/100*(354/aesx*sx), 24/aesy*sy, tocolor(150, 150, 150, 150), true)
		
		if(getTickCount()-cSetting["last_tick"] > 1000) then
			cSetting["frames"] = cSetting["temp_frames"] 
			cSetting["temp_frames"] = 0
			cSetting["last_tick"] = getTickCount()
		else
			cSetting["temp_frames"] = cSetting["temp_frames"]+1
		end
	end
end

function disableHud()
	cSetting["enabled"] = false
end

doJumpMe_Func = function()
	cSetting["jump_value"] = 0
	setTimer(function()
		setTimer(function()
			cSetting["jump_value"] = cSetting["jump_value"]+5
		end, 50, 20)
	end, 4000, 1)
end

cFunc["update_roundsettings"] = function(starttick, endtick, teamred, teamblue)
	if(endtick and starttick and teamred and teamblue) then
		cSetting["start_tick"] = getTickCount()
		cSetting["end_tick"] = getTickCount()+(endtick-starttick)
		cSetting["team_red"] = teamred
		cSetting["team_green"] = teamblue
		cSetting["round_started"] = true
	else
		cSetting["round_started"] = false
	end
end

-- EVENT HANDLERS --

addEventHandler("onClientCarballStadiumEnter", getLocalPlayer(), cFunc["stadion_enter"])
addEventHandler("onClientCarballStadiumLeave", getLocalPlayer(), cFunc["stadion_leave"])
addEventHandler("onClientRender", getRootElement(), cFunc["render_hud"])

addEventHandler("onCarballClientRoundStart", getLocalPlayer(), cFunc["update_roundsettings"])