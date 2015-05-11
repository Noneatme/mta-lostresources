--[[
	##########################################################################
	##      																##
	## Project: 'Carball' - Gamemode for MTA: San Andreas PROJECT X 		##
	##      Developer: Noneatme     										##
	##   License: See LICENSE in the top level directory    				##
	##     																 	##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


addEvent("onClientCarballStadiumLeave", true)

local cFunc = {}
local cSetting = {}

local sx, sy = guiGetScreenSize()
local aesx, aesy = 1366, 768

cSetting["enabled"] = false

cSetting["start_area"] = 1
cSetting["ausgewaehlt"] = 1

addEvent("onClientCarballStadiumLeave", true)

local cm = {3690.1740722656, -2284.4914550781, 14.224618911743, 3740.1516113281, -2198.9453125, 0.65559768676758}

cSetting["areas"] = {
	{"Area 1", "A big area.", "1"},
	{"Area 1 Training", "Training Area for the area 1.\n\nTRAINING MODE", "1"},
	{"Area 2", "This are is triangle-formed and has some \nramps in the middle.", "2"},
	{"Area 2 Training", "This are is triangle-formed and has some \nramps in the middle.\n\nTRAINING MODE", "2"},
	{"Arena 3", "A normal area.", "3"},
	{"Arena 3 Training", "A normal area.\n\nTRAINING MODE", "3"},
}

cSetting["buttons"] = {}
cSetting["buttons_hover"] = {}

-- FUNCTIONS --

cSetting["destroy_all_buttons"] = function()
	for index, knopf in pairs(cSetting["buttons"]) do
		if(isElement(knopf)) then
			destroyElement(knopf)
		end
	end
	cSetting["buttons"] = {}
	
end

cFunc["settoselection"] = function()
	if(cSetting["enabled"] == false) then
		cSetting["enabled"] = true
		
		cSetting["destroy_all_buttons"]()
		
		cFunc["build_selection"]()
		triggerServerEvent("onCarballPlayerLeave", localPlayer)
		
		setCameraMatrix(cm[1], cm[2], cm[3], cm[4], cm[5], cm[6])
		
		disableHud()
		
		
	end
end


cFunc["delete_selection"] = function()
	cSetting["destroy_all_buttons"]()
	
	cSetting["enabled"] = false
	
	unbindKey("mouse_wheel_down", "down", cFunc["move_up"])
	unbindKey("mouse_wheel_up", "down", cFunc["move_down"])
	
	showCursor(false)
	
	destroyElement(cSetting["loginsound"])
end

cFunc["refresh_buttons"] = function()
	cSetting["destroy_all_buttons"]()
	local add = 0
	local increment = 100/aesy*sy
		
	for i = cSetting["start_area"], cSetting["start_area"]+10, 1 do
		if(cSetting["areas"][i]) then

			cSetting["buttons"][i] = guiCreateButton(8/aesx*sx, (191/aesy*sy)+add/2, 326/aesx*sx, 41/aesy*sy, i, false)
			add = add+increment
			cSetting["buttons_hover"][i] = false
			guiSetAlpha(cSetting["buttons"][i], 0)
			
			-- EVENT HANDLER --
			addEventHandler("onClientMouseEnter", cSetting["buttons"][i], function()
				cSetting["buttons_hover"][i] = true
				playSoundFrontEnd(42)
			end, false)
			
			addEventHandler("onClientMouseLeave", cSetting["buttons"][i], function()
				cSetting["buttons_hover"][i] = false
			end, false)
			
			addEventHandler("onClientGUIClick", cSetting["buttons"][i], function()
				cSetting["buttons_hover"][i] = true
				cSetting["ausgewaehlt"] = i
				playSoundFrontEnd(41)
			end, false)
		end
	end

	cSetting["buttons"]["join"] = guiCreateButton(1042/aesx*sx, 217/aesy*sy, 306/aesx*sx, 39/aesy*sy, "", false)
	-- EVENT HANDLER --
	i = "join"
	addEventHandler("onClientMouseEnter", cSetting["buttons"]["join"], function()
		cSetting["buttons_hover"]["join"] = true
		playSoundFrontEnd(42)
	end, false)
			
	addEventHandler("onClientMouseLeave", cSetting["buttons"]["join"], function()
		cSetting["buttons_hover"]["join"] = false
	end, false)
			
	addEventHandler("onClientGUIClick", cSetting["buttons"]["join"], function()
		cSetting["buttons_hover"]["join"] = true
		--cSetting["ausgewaehlt"] = i
		cFunc["delete_selection"]()
		playSoundFrontEnd(41)
		triggerServerEvent("onCarballPlayerJoin", localPlayer, cSetting["ausgewaehlt"])
	end, false)
	guiSetAlpha(cSetting["buttons"]["join"], 0)

		
	cSetting["buttons"]["joinspec"] = guiCreateButton(1042/aesx*sx, 266/aesy*sy, 306/aesx*sx, 39/aesy*sy, "", false)
	-- EVENT HANDLER --

	addEventHandler("onClientMouseEnter", cSetting["buttons"]["joinspec"], function()
		cSetting["buttons_hover"]["joinspec"] = true
		playSoundFrontEnd(42)
	end, false)
			
	addEventHandler("onClientMouseLeave", cSetting["buttons"]["joinspec"], function()
		cSetting["buttons_hover"]["joinspec"] = false
	end, false)
			
	addEventHandler("onClientGUIClick", cSetting["buttons"]["joinspec"], function()
		cSetting["buttons_hover"]["joinspec"] = true
		--cSetting["ausgewaehlt"] = i
		triggerServerEvent("onCarballPlayerJoin", localPlayer, cSetting["ausgewaehlt"], true)
		playSoundFrontEnd(41)
		cFunc["delete_selection"]()
	end, false)
	
		guiSetAlpha(cSetting["buttons"]["joinspec"], 0)
	
end

cFunc["move_up"] = function()
	if(cSetting["start_area"] < #cSetting["areas"]) then
		cSetting["start_area"] = cSetting["start_area"]+1
	else
		cSetting["start_area"] = #cSetting["areas"]+1
	end
	cFunc["refresh_buttons"]()
end

cFunc["move_down"] = function()
	if(cSetting["start_area"] > 2) then
		cSetting["start_area"] = cSetting["start_area"]-1
	else
		cSetting["start_area"] = 1
	end
	cFunc["refresh_buttons"]()
end



cFunc["build_selection"] = function()
	cSetting["enabled"] = true
	
	bindKey("mouse_wheel_down", "down", cFunc["move_up"])
	bindKey("mouse_wheel_up", "down", cFunc["move_down"])
	
	cFunc["refresh_buttons"]()
	
	if(isElement(cSetting["loginsound"])) then
		destroyElement(cSetting["loginsound"])
	end
	
	cSetting["loginsound"] = playSound("http://yourdawi.de/noneatme/worms.mp3", true)
	
	setCameraMatrix(cm[1], cm[2], cm[3], cm[4], cm[5], cm[6])
end

cFunc["render_selection"] = function()
	if(cSetting["enabled"]) then
		showCursor(true)
		dxDrawRectangle(0/aesx*sx, 0/aesy*sy, 1365/aesx*sx, 182/aesy*sy, tocolor(255, 255, 255, 125), true)
		dxDrawText("Carsoccer V1", 327/aesx*sx, 48/aesy*sy, 959/aesx*sx, 118/aesy*sy, tocolor(0, 0, 0, 255), 3/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
		dxDrawRectangle(0/aesx*sx, 181/aesy*sy, 345/aesx*sx, 586/aesy*sy, tocolor(0, 0, 0, 118), true)
		dxDrawRectangle(345/aesx*sx, 182/aesy*sy, 1020/aesx*sx, 585/aesy*sy, tocolor(0, 0, 0, 160), true)
		dxDrawText("Preview:", 355/aesx*sx, 241/aesy*sy, 681/aesx*sx, 327/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "center", "center", false, false, true, false, false)
		dxDrawImage(686/aesx*sx, 203/aesy*sy, 336/aesx*sx, 177/aesy*sy, "data/images/selection"..cSetting["areas"][cSetting["ausgewaehlt"]][3]..".jpg", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawText(cSetting["areas"][cSetting["ausgewaehlt"]][2], 392/aesx*sx, 395/aesy*sy, 1345/aesx*sx, 734/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "bankgothic", "left", "top", false, false, true, false, false)
     	local r, g, b = 0, 0, 0
		local i = "joinspec"
		if(cSetting["buttons_hover"][i] == true) then
			r, g, b = 50, 50, 50
		end
     	dxDrawRectangle(1042/aesx*sx, 266/aesy*sy, 306/aesx*sx, 39/aesy*sy, tocolor(r, g, b, 160), true)
		dxDrawText("Join as spectator", 1042/aesx*sx, 266/aesy*sy, 1347/aesx*sx, 304/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
		local r, g, b = 0, 0, 0
		local i = "join"
		if(cSetting["buttons_hover"][i] == true) then
			r, g, b = 50, 50, 50
		end
		dxDrawRectangle(1042/aesx*sx, 217/aesy*sy, 306/aesx*sx, 39/aesy*sy, tocolor(r, g, b, 160), true)
		dxDrawText("Join", 1042/aesx*sx, 218/aesy*sy, 1347/aesx*sx, 256/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
						
		-- AREAS --
		local add = 0
		local increment = 100/aesy*sy
		for i = cSetting["start_area"], cSetting["start_area"]+10, 1 do
			if(cSetting["areas"][i]) then
				local r, g, b = 0, 0, 0
				if(cSetting["buttons_hover"][i] == true) then
					r, g, b = 50, 50, 50
				end
				dxDrawRectangle(8/aesx*sx, (191/aesy*sy)+add/2, 326/aesx*sx, 41/aesy*sy, tocolor(r, g, b, 160), true)
				r, g, b = 255, 255, 255
				if(cSetting["ausgewaehlt"] == i) then
					r, g, b = 0, 255, 0
				end
				dxDrawText(cSetting["areas"][i][1], 8/aesx*sx, (191/aesy*sy)+add, 335/aesx*sx, 231/aesy*sy, tocolor(r, g, b, 255), 1/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
				
				add = add+increment
			end
		end
	end
end
cFunc["build_selection"]()
-- EVENT HANDLERS --
addEventHandler("onClientRender", getRootElement(), cFunc["render_selection"])

bindKey("F2", "down", cFunc["settoselection"])