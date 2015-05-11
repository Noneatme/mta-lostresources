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

cSetting["team_enabled"] = false
cSetting["gui"] = {}

cSetting["gui_hover"] = {}
cSetting["gui_hover"]["police"] = false
cSetting["gui_hover"]["mafia"] = false


cSetting["start_id"] = 1
cSetting["end_id"] = 10

cSetting["oldskin"] = 0

cSetting["highlighted"] = 1

cSetting["enabled"] = false -- SKIN SELECTION

cSetting["aviable_skins"] = {
	["POLICE"] = {
		[1] = {163, "Outfit 1"},
		[2] = {164, "Outfit 2"},
		[3] = {165, "Outfit 3"},
		[4] = {280, "Outfit 4"},
		[5] = {281, "Outfit 5"},
		[6] = {282, "Outfit 6"},
		[7] = {283, "Outfit 7"},
		[8] = {284, "Outfit 8"},
		[9] = {285, "Outfit 9"},
		[10] = {286, "Outfit 10"},
		[11] = {287, "Outfit 11"},
		[12] = {288, "Outfit 12"},
	},
	["MAFIA"] = {
		[1] = {290, "Outfit 1"},
		[2] = {111, "Outfit 2"},
		[3] = {112, "Outfit 3"},
		[4] = {113, "Outfit 4"},
		[5] = {117, "Outfit 5"},
		[6] = {118, "Outfit 6"},
		[7] = {120, "Outfit 7"},
		[8] = {121, "Outfit 8"},
		[9] = {122, "Outfit 9"},
		[10] = {123, "Outfit 10"},
		[11] = {124, "Outfit 11"},
		[12] = {125, "Outfit 12"},
		[13] = {126, "Outfit 13"},
		[14] = {127, "Outfit 14"},
	},
}

-- FUNCTIONS --

cFunc["build_ambience"] = function()
	setCameraMatrix(-2268.6325683594, 64.758354187012, 42.604698181152, -2323.3828125, -14.136032104492, 14.710710525513)
	cSetting["sultan"] = createVehicle(560, -2278.9226074219, 47.707443237305, 35.1640625, 0, 0, 120)
	cSetting["ped1"] = createPed(60, -2280.2175292969, 49.540454864502, 35.1640625, 247)
	cSetting["ped2"] = createPed(126, -2277.7355957031, 48.455760955811, 36.320503234863, 67)
	cSetting["roadtrain"] = createVehicle(getVehicleModelFromName("Roadtrain"), -2286.6955566406, 42.069087982178, 38.3125, 0, 0, 90)
	cSetting["trailer"] = createVehicle(584, -2277.4614257813, 42.142364501953, 38.3125, 0, 0, 90)
	
	setPedAnimation(cSetting["ped1"], "ped", "IDLE_chat")
	
	setTime(12, 00)
end

cFunc["show_auswahl"] = function()
	if(cSetting["team_enabled"] == false) and (cSetting["enabled"] == false) then
		cSetting["team_enabled"] = true
		
		cFunc["build_buttons"](1)
		cFunc["build_ambience"]()
		cSetting["music"] = playSound("files/sounds/intro.mp3", true)
		triggerServerEvent("onCPPlayerJoin", localPlayer)
		fadeCamera(true)
		showPlayerHudComponent("all", false)
	end
end
cFunc["stop_auswahl"] = function(id)	
	for index, ele in pairs(cSetting["gui"]) do
		if(isElement(ele)) then
			destroyElement(ele)
		end
	end
	cSetting["team_enabled"] = false
	
	showCursor(false)
end

cSetting["build_team"] = function()
	setElementPosition(localPlayer, -2581.7277832031, 62.000064849854, 18.065357208252)
	setPedRotation(localPlayer, 9.8)
	
	setCameraMatrix(-2583.3569335938, 66.458831787109, 18.476039886475, -2550.56640625, -27.542495727539, 9.0669727325439)
	toggleAllControls(false)
	cSetting["enabled"] = true
	cFunc["move_list_up"]()
end

cSetting["destroy_ambiente"] = function()
	destroyElement(cSetting["sultan"])
	destroyElement(cSetting["ped1"])
	destroyElement(cSetting["ped2"])
	destroyElement(cSetting["roadtrain"])
	destroyElement(cSetting["trailer"])
	setGameSpeed(1)
	cSetting["build_team"]()
end

cFunc["blow_ambient"] = function()
	setGameSpeed(0.5)
	blowVehicle(cSetting["sultan"])
	setTimer(function()
		createExplosion(-2279.9851074219, 44.233577728271, 35.3125, 7)
		setTimer(function()
			blowVehicle(cSetting["roadtrain"])
			setTimer(function()
				blowVehicle(cSetting["trailer"])
				setTimer(function()
						setCameraTarget(localPlayer)
						cSetting["destroy_ambiente"]()
				end, 750, 1)
			end, 300, 1)
		end, 250, 1)
	end, 250, 1)
end
cFunc["build_buttons"] = function(id)
	for index, ele in pairs(cSetting["gui"]) do
		if(isElement(ele)) then
			destroyElement(ele)
		end
	end
	if(id == 1) then
		cSetting["gui"]["police"] = guiCreateButton(521/aesx*sx, 326/aesy*sy, 283/aesx*sx, 136/aesy*sy, "Police", false)
		cSetting["gui"]["mafia"] = guiCreateButton(813/aesx*sx, 326/aesy*sy, 283/aesx*sx, 136/aesy*sy, "Mafia", false)
		
		guiSetAlpha(cSetting["gui"]["police"], 0)
		guiSetAlpha(cSetting["gui"]["mafia"], 0)
		
		-- EVENT HANDLER --
		
		addEventHandler("onClientMouseEnter", cSetting["gui"]["police"], function()
			cSetting["gui_hover"]["police"] = true
			playSoundFrontEnd(42)
		end)
			
		addEventHandler("onClientMouseLeave", cSetting["gui"]["police"], function()
			cSetting["gui_hover"]["police"] = false
		end)
	
		addEventHandler("onClientGUIClick", cSetting["gui"]["police"], function()
			playSoundFrontEnd(41)
		--	setCameraTarget(localPlayer)
			cFunc["stop_auswahl"](id)
			setTimer(cFunc["blow_ambient"], 1000, 1)
			cSetting["selected_team"] = "POLICE"
		end)
		
		addEventHandler("onClientMouseEnter", cSetting["gui"]["mafia"], function()
			cSetting["gui_hover"]["mafia"] = true
			playSoundFrontEnd(42)
		end)
			
		addEventHandler("onClientMouseLeave", cSetting["gui"]["mafia"], function()
			cSetting["gui_hover"]["mafia"] = false
		end)
		
		addEventHandler("onClientGUIClick", cSetting["gui"]["mafia"], function()
			playSoundFrontEnd(41)
		--	setCameraTarget(localPlayer)
			cFunc["stop_auswahl"](id)
			setTimer(cFunc["blow_ambient"], 1000, 1)
			cSetting["selected_team"] = "MAFIA"
		end)
	end
	showCursor(true)
end

cFunc["render_teamselection"] = function()
	if(cSetting["team_enabled"] == true) then
		local r, g, b = 0, 0, 0
		if(cSetting["gui_hover"]["police"]) then
			if(cSetting["gui_hover"]["police"] == true) then
				r, g, b = 25, 25, 25
			end
		end
		dxDrawRectangle(521/aesx*sx, 326/aesy*sy, 283/aesx*sx, 136/aesy*sy, tocolor(r, g, b, 150), true)
		r, g, b = 0, 0, 0
		if(cSetting["gui_hover"]["mafia"]) then
			if(cSetting["gui_hover"]["mafia"] == true) then
				r, g, b = 25, 25, 25
			end
		end
		dxDrawRectangle(813/aesx*sx, 326/aesy*sy, 283/aesx*sx, 136/aesy*sy, tocolor(r, g, b, 150), true)
		dxDrawText("Police", 521/aesx*sx, 325/aesy*sy, 803/aesx*sx, 462/aesy*sy, tocolor(0, 204, 235, 123), 3/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Mafia", 813/aesx*sx, 325/aesy*sy, 1095/aesx*sx, 462/aesy*sy, tocolor(234, 220, 0, 123), 3/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText("Please select the team your choise!", 522/aesx*sx, 278/aesy*sy, 1092/aesx*sx, 322/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
	end
end

-- SKINLIST --


-- FUNCTIONS --

cFunc["draw_skinlist"] = function()
	if(cSetting["enabled"] == true) then
	--  showCursor(true)
		--  BACKGROUND AND TITLE --
		dxDrawRectangle(sx/2+(500/aesx*sx), sy/2+(70/aesy*sy), 260/aesx*sx, 340/aesy*sy, tocolor(0, 0, 0, 100))
		
		dxDrawRectangle(sx/2+(500/aesx*sx), sy/2+(50/aesy*sy), 260/aesx*sx, 20/aesy*sy, tocolor(0, 255, 0, 100))
		
		dxDrawText("Skin selection", sx/2+(600/aesx*sx), sy/2+(52/aesy*sy), 260/aesx*sx, 20/aesy*sy, tocolor(0, 0, 0, 200), 1/aesx*sx, "default-bold", "left")
		
		-- COLUMS --
		dxDrawText("Skin Name", sx/2+(525/aesx*sx), sy/2+(75/aesy*sy), 260/aesx*sx, 20/aesy*sy, tocolor(255, 255, 255, 200), 1/aesx*sx, "default-bold", "left")
		
		dxDrawText("Faction", sx/2+(690/aesx*sx), sy/2+(75/aesy*sy), 260/aesx*sx, 20/aesy*sy, tocolor(255, 255, 255, 200), 1/aesx*sx, "default-bold", "left")
		
		dxDrawRectangle(sx/2+(500/aesx*sx), sy/2+(95/aesy*sy), 260/aesx*sx, 2/aesy*sy, tocolor(0, 0, 0, 150))
		
		-- INFORMATION --
		dxDrawText("Use the arrow keys to scroll up/down.\n'Enter' to accept, 'Backspace' to cancel.", sx/2+(525/aesx*sx), sy/2+(15/aesy*sy), 260/aesx*sx, 20/aesy*sy, tocolor(255, 255, 255, 200), 1/aesx*sx, "default-bold", "left")
		
		-- INHALT --

		local increment = 30/aesy*sy
		local add = increment
		
		for index = cSetting["start_id"], cSetting["end_id"], 1 do
			local tbl = (cSetting["aviable_skins"][cSetting["selected_team"]][index] or false)
			if(tbl ~= false) then
				local r, g, b = 255, 255, 255
				if(cSetting["highlighted"] == index) then
					r, g, b= 0, 255, 0
				end
				dxDrawText(tbl[2], sx/2+(525/aesx*sx), (sy/2+(75/aesy*sy))+add, 260/aesx*sx, 20/aesy*sy, tocolor(r, g, b, 200), 1/aesx*sx, "default-bold", "left")
				dxDrawText(cSetting["selected_team"], sx/2+(690/aesx*sx), (sy/2+(75/aesy*sy))+add, 260/aesx*sx, 20/aesy*sy, tocolor(r, g, b, 200), 1/aesx*sx, "default-bold", "left")
				add = add+increment
			end
		end
	end
end

cFunc["move_list_down"] = function()
	if(cSetting["enabled"] == true) then
		if(cSetting["highlighted"] < #cSetting["aviable_skins"][cSetting["selected_team"]]) then
			cSetting["highlighted"] = cSetting["highlighted"]+1
		end
		if(cSetting["highlighted"] > cSetting["end_id"]) then
			cSetting["start_id"] = cSetting["start_id"]+1
			cSetting["end_id"] = cSetting["end_id"]+1
		end
		if(cSetting["aviable_skins"][cSetting["selected_team"]][cSetting["highlighted"]]) then
			setElementModel(localPlayer, cSetting["aviable_skins"][cSetting["selected_team"]][cSetting["highlighted"]][1])
		end
		setPedAnimation(localPlayer, "DANCING", "dnce_M_a", -1, true, false)
	end
end

cFunc["move_list_up"] = function()
	if(cSetting["enabled"] == true) then
		if(cSetting["highlighted"] > 1) then
			cSetting["highlighted"] = cSetting["highlighted"]-1
		end
		if(cSetting["start_id"] > cSetting["highlighted"]) then
			cSetting["start_id"] = cSetting["start_id"]-1
			cSetting["end_id"] = cSetting["end_id"]-1
		end
		
		-- MODIFY CHAR --
		if(cSetting["aviable_skins"][cSetting["selected_team"]][cSetting["highlighted"]]) then
			setElementModel(localPlayer, cSetting["aviable_skins"][cSetting["selected_team"]][cSetting["highlighted"]][1])
		end
		setPedAnimation(localPlayer, "DANCING", "dnce_M_a", -1, true, false)
	end
end

cFunc["accept_list"] = function()
	if(cSetting["enabled"] == true) then
		local model = getElementModel(localPlayer)
		local faction = cSetting["selected_team"]
		triggerServerEvent("onCPSelectionDone", localPlayer, faction, model)
		cSetting["enabled"] = false
		destroyElement(cSetting["music"])
	end
end


cFunc["replace_skintable"] = function(tbl)
	cSetting["aviable_skins"] = tbl
end

-- EVENT HANDLERS --


bindKey("F1", "down", cFunc["show_auswahl"])
addEventHandler("onClientRender", getRootElement(), cFunc["draw_skinlist"])

bindKey("arrow_d", "down", cFunc["move_list_down"])
bindKey("arrow_u", "down", cFunc["move_list_up"])
bindKey("enter", "down", cFunc["accept_list"])

cFunc["show_auswahl"]()
addEventHandler("onClientRender", getRootElement(), cFunc["render_teamselection"])