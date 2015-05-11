--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Custom Escalators' - Resource for MTA: San Andreas         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


local cFunc = {}
local cSetting = {}


Designer = {}
Designer.__index = Designer

local object = nil


local aesx, aesy = 1600, 900
local sx, sy = guiGetScreenSize()

cSetting["elementt_titles"] = {
	["player"] = "Player",
	["object"] = "Object",
	["vehicle"] = "Vehicle",
	["ped"] = "Ped",
	["water"] = "Water",
	["sound"] = "",
}

local Static = {
    edit = {},
    button = {},
    label = {},
    window = {},
}


local Static2 = {
    memo = {},
    button = {},
    radiobutton = {},
    window = {},
}

local Static3 = {
    edit = {},
    button = {},
    label = {},
    window = {},
}


-- FUNCTIONS --

-- //////////////////////////
-- ///// New Designer ///////
-- //////////////////////////

function Designer:New(...)
	local obj = setmetatable({}, {__index = self})
--	obj:Constructor(...)
	object = obj
	obj.showstate = false
	return obj
end

-- //////////////////////////
-- ///////Draw Render////////
-- //////////////////////////

function Designer:Render()
	local sx, sy = guiGetScreenSize()
	-- Crosshair

	-- Col Pos
	local asx, asy = 0, 0
	if(self.state == true) then
		asx = sx/2
		asy = sy/2

		dxDrawImage((sx/2)-64/2, (sy/2)-64/2, 64, 64, "images/crosshair.png")
	else
		asx, asy = getCursorPosition()
		asx = asx*sx
		asy = asy*sy
	end
	local x, y, z = getWorldFromScreenPosition(asx, asy, 50)
	local x2, y2, z2 = getCameraMatrix()
	local hit, x3, y3, z3 = processLineOfSight(x, y, z, x2, y2, z2)
	if(hit) then
		x, y, z = x3, y3, z3
	end
	setElementPosition(self.selectionCol, x, y, z)

	-- Icon Drawing --
	local a = 100
	if(self.iconSelectState[1] == true) then
		a = 150
	end
	dxDrawRectangle(0, 795/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(0, 795/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/stairs.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	
	if(self.iconSelectState[2] == true) then
		a = 150
	end
	dxDrawRectangle(0, (795-130)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(0, (795-130)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/start.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	
	if(self.iconSelectState[3] == true) then
		a = 150
	end
	dxDrawRectangle(0, (795-260)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(0, (795-260)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/end.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	
	if(self.iconSelectState[4] == true) then
		a = 150
	end
	dxDrawRectangle(0, (795-390)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(0, (795-390)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/umkehren.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	
	if(self.iconSelectState[5] == true) then
		a = 150
	end
	dxDrawRectangle(0, (795-510)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(0, (795-510)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/steps.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	
	if(self.iconSelectState[6] == true) then
		a = 150
	end
	dxDrawRectangle(0, (795-640)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(0, (795-640)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/speed.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 150
	
	if(self.iconSelectState[7] == true) then
		a = 150
	end
	dxDrawRectangle(0, (795-770)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(0, (795-770)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/delete.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	
	if(self.iconSelectState[8] == true) then
		a = 150
	end
	dxDrawRectangle(1490/aesx*sx, (795)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(1490/aesx*sx, (795)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/save.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	
	if(self.iconSelectState[9] == true) then
		a = 150
	end
	dxDrawRectangle(1490/aesx*sx, (795-130)/aesy*sy, 110/aesx*sx, 110/aesy*sy, tocolor(0, 0, 0, a-50), true)
	dxDrawImage(1490/aesx*sx, (795-130)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "images/load.png", 0, 0, 0, tocolor(255, 255, 255, a*1.5))
	a = 100
	-- Misc --
	-- Escalator New --
	if(self.newEscalatorStarted == true) or (self.selectedEscalator) then
		local id = (self.usingEscalatorID or self.selectedEscalator)
		for i = 1, 2, 1 do
			if(self.escalatorSettings[id]["pos"..i]) then
				local x, y, z = self.escalatorSettings[id]["pos"..i][1], self.escalatorSettings[id]["pos"..i][2], self.escalatorSettings[id]["pos"..i][3]
				local sx, sy = getScreenFromWorldPosition(x, y, z)
				if(sx and sy) then
					local x1, y1, z1 = getCameraMatrix()
					local dis = getDistanceBetweenPoints3D(x1, y1, z1, x, y, z)
					local scale = 128/dis*20

					dxDrawImage(sx-scale/2, sy-scale/2, scale, scale, "images/arrowdown.png", 0, 0, 0, tocolor(255, 255, 255, 255))
					
				end
			end
		end
		
		if(self.escalatorSettings[id]["pos2"] and self.escalatorSettings[id]["pos2"]) then
			local x1, y1, z1 = self.escalatorSettings[id]["pos1"][1], self.escalatorSettings[id]["pos1"][2], self.escalatorSettings[id]["pos1"][3]
			local x2, y2, z2 = self.escalatorSettings[id]["pos2"][1], self.escalatorSettings[id]["pos2"][2], self.escalatorSettings[id]["pos2"][3]
			dxDrawLine3D(x1, y1, z1+0.5, x2, y2, z2+0.5, tocolor(0, 255, 0, 200), 2)
		end
		
		if(self.endReset == true) then
			ssx, ssy = getCursorPosition()
			if(ssx and ssy) then
				ssx = ssx*sx
				ssy = ssy*sy
				local x1, y1, z1 = getWorldFromScreenPosition(ssx, ssy, 100)

				local x2, y2, z2 = self.escalatorSettings[id]["pos2"][1], self.escalatorSettings[id]["pos2"][2], self.escalatorSettings[id]["pos2"][3]
				dxDrawLine3D(x1, y1, z1, x2, y2, z2+1, tocolor(255, 255, 0, 200), 2)
			end
		end
		if(self.startReset == true) then
			ssx, ssy = getCursorPosition()
			if(ssx and ssy) then
				ssx = ssx*sx
				ssy = ssy*sy
				local x1, y1, z1 = getWorldFromScreenPosition(ssx, ssy, 100)

				local x2, y2, z2 = self.escalatorSettings[id]["pos1"][1], self.escalatorSettings[id]["pos1"][2], self.escalatorSettings[id]["pos1"][3]
				dxDrawLine3D(x1, y1, z1, x2, y2, z2+1, tocolor(255, 255, 0, 200), 2)
			end
		end
	end
	-- Element Drawing
	if(isElement(self.hitelement) or self.selectedIcon or self.message) then
		local title, pos, line2
		if(isElement(self.hitelement)) then
			title = getElementType(self.hitelement)
			title = (cSetting["elementt_titles"][title] or "Unknow")
			pos = {getElementPosition(self.hitelement)}
			line2 = math.floor(pos[1])..", "..math.floor(pos[2])..", "..math.floor(pos[3])
		end
		-- Mouse
		local ssx, ssy = sx/2, sy/2
		if(self.state == true) then
			ssx, ssy = sx/2, sy/2
		else
			ssx, ssy = getCursorPosition()
			ssx = ssx*sx
			ssy = ssy*sy
		end
		-- DRAW --
		if(self.selectedIcon) then
			title = self.hovertext[self.selectedIcon]
			line2 = ""
		end
		if(self.message) then
			title = self.message
			line2 = ""
		end		
		dxDrawText(title.."\n"..line2, ssx, ssy-20, ssx, ssy, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center")
	end
end

-- //////////////////////////
-- ///// Switch State  //////
-- //////////////////////////

function Designer:SwitchState()

	if not(isTimer(self.switchtimer)) then
		self.state = not (self.state)
		self.switchtimer = setTimer(function() end, 50, 1)

		if(self.state == true) then
			showCursor(false)
		else
			showCursor(true)
		end
	end
end


-- //////////////////////////
-- ////	Escalator Creation //
-- //////////////////////////

function Designer:DoCreateEscalator(id)
	local newspeed, newreverse, untereLaenge, obereLaenge = 600, true, 2, 2
	if(self.escalators[id]) then
		newspeed = self.escalators[id].speed
		newreverse = self.escalators[id].reverse
		untereLaenge = self.escalators[id].untereLaenge
		obereLaenge = self.escalators[id].obereLaenge
	end
	self.escalators[id] = Escalator:New(self.escalatorSettings[id]["pos1"][1], self.escalatorSettings[id]["pos1"][2], self.escalatorSettings[id]["pos1"][3], self.escalatorSettings[id]["pos2"][1], self.escalatorSettings[id]["pos2"][2], self.escalatorSettings[id]["pos2"][3], obereLaenge, untereLaenge, newreverse, newspeed)
	
	for index, step in pairs(self.escalators[id]:GetSteps()) do
		setElementData(step, "Escalator:ID", id)
	end
end

-- //////////////////////////
-- ////	Define Click       //
-- //////////////////////////

function Designer:DefineClick(button, state, _, _, x, y, z, ele)
	if(button == "left") and (state == "down") then

		local id = self.usingEscalatorID
		if(self.newEscalatorStarted == true) then
			if(self.escalatorSettings[id]["pos1"]) then
				self.escalatorSettings[id]["pos2"] = {x, y, z}
				self.message = nil
				self:SetButtonsEnabled(true)
				self:DoCreateEscalator(id)
				self.newEscalatorStarted = false
				self.selectedEscalator = id
			else
				self.escalatorSettings[id]["pos1"] = {x, y, z}
				self.message = "Click on the world to define\nthe second position."
			end
		elseif(self.endReset == true) then
			self.escalatorSettings[id]["pos2"] = {x, y, z}
			self:RespawnEscalator(id)
			self.endReset = false
			self:SetButtonsEnabled(true)
			self.message = nil
		elseif(self.startReset == true) then
			self.escalatorSettings[id]["pos1"] = {x, y, z}
			self:RespawnEscalator(id)
			self.startReset = false
			self:SetButtonsEnabled(true)
			self.message = nil
		elseif(ele) and (getElementType(ele) == "object") or (self.hitelement) then
			if not(ele) then
				ele = self.hitelement
			end
			if(isEscalatorObject(ele)) then
				local id = getEscalatorID(ele)
				self.selectedEscalator = id
				self.usingEscalatorID = id
			end
		else
			if not(self.thingClicked == true) and not(isElement(Static.window[1])) and not(isElement(Static2.window[1])) and not(isElement(Static3.window[1])) then
				self.selectedEscalator = nil
				self.usingEscalatorID = nil
			end
		end
	end
end

-- //////////////////////////
-- ////	New Escalator      //
-- //////////////////////////

function Designer:StartNewEscalator()
	self.message = "Click on the world to define\nthe first position."
	
	self.lastEscalatorID = self.lastEscalatorID+1
	self.usingEscalatorID = self.lastEscalatorID
	self.escalatorSettings[self.usingEscalatorID] = {}
	
	self.newEscalatorStarted = true
end

-- //////////////////////////
-- ////	Direction  		   //
-- //////////////////////////

function Designer:InvertDirection(id)
	local escalator = self.escalators[id]
	escalator:SetReverse(not escalator.reverse)
	escalator:Respawn()
end

-- //////////////////////////
-- ////	End & Start  	   //
-- //////////////////////////

function Designer:ResetEnd(id)
	local escalator = self.escalators[id]
	self.endReset = true
	self.message = "Click on the world to define\nthe new end position."
end

function Designer:ResetStart(id)
	local escalator = self.escalators[id]
	self.startReset = true
	self.message = "Click on the world to define\nthe new start position."
end

function Designer:ShowStepCount()
	if not(isElement(Static.window[1])) then
		local X, Y, Width, Height = getMiddleGuiPosition(341, 95)
		
		Static.window[1] = guiCreateWindow(X, Y, Width, Height, "Step count", false)
		guiWindowSetSizable(Static.window[1], false)
		guiSetInputMode("no_binds_when_editing")
		Static.label[1] = guiCreateLabel(10, 23, 99, 15, "Top step count: ", false, Static.window[1])
		guiSetFont(Static.label[1], "default-bold-small")
		Static.label[2] = guiCreateLabel(10, 42, 113, 16, "Ground stop count:", false, Static.window[1])
		guiSetFont(Static.label[2], "default-bold-small")
		Static.edit[1] = guiCreateEdit(139, 21, 199, 18, self.escalators[self.selectedEscalator].obereLaenge, false, Static.window[1])
		Static.edit[2] = guiCreateEdit(139, 42, 199, 18, self.escalators[self.selectedEscalator].untereLaenge, false, Static.window[1])
		Static.button[1] = guiCreateButton(9, 64, 141, 24, "Update", false, Static.window[1])
		guiSetFont(Static.button[1], "default-bold-small")
		guiSetProperty(Static.button[1], "NormalTextColour", "FFAAAAAA")
		Static.button[2] = guiCreateButton(194, 63, 141, 24, "Cancel", false, Static.window[1])
		guiSetFont(Static.button[2], "default-bold-small")
		guiSetProperty(Static.button[2], "NormalTextColour", "FFAAAAAA")
		
		-- EVENT HANDLER --
		addEventHandler("onClientGUIClick", Static.button[2], function()
			destroyElement(Static.window[1])
		end, false)
		
			-- EVENT HANDLER --
		addEventHandler("onClientGUIClick", Static.button[1], function()
			local step1, step2 = tonumber(guiGetText(Static.edit[1])), tonumber(guiGetText(Static.edit[2]))
			
			if(step1) and (step2) then
				step1 = math.floor(step1)
				step2 = math.floor(step2)
				if(step1 >= 0) and (step1 < 100) and (step2 >= 0) and (step2 < 100) then
					self.escalators[self.selectedEscalator].untereLaenge = step2
					self.escalators[self.selectedEscalator].obereLaenge = step1
					self:RespawnEscalator(self.selectedEscalator)
					destroyElement(Static.window[1])
				else
					outputInfobox("Bad input!", 255, 0, 0)
				end
			else
				outputInfobox("Bad input!", 255, 0, 0)
			end
		end, false)
	end
end

-- //////////////////////////
-- ////	Respawn Escalator  //
-- //////////////////////////

function Designer:RespawnEscalator(id)
	local escalator = self.escalators[id]
	escalator:Destructor()
	escalator = nil
	self:DoCreateEscalator(id)
end

-- //////////////////////////
-- ////	Next Speed         //
-- //////////////////////////

function Designer:NextSpeed(id)
	local escalator = self.escalators[id]
	local speed = escalator.speed
	if(speed <= 200) then
		speed = 2000
	else
		speed = speed-200
	end
	escalator.speed = speed
	outputInfobox("New escalator speed: "..speed.."(Default: 500)", 0, 255, 0, false)
	self:RespawnEscalator(id)
end
-- //////////////////////////
-- ////	Do Delete          //
-- //////////////////////////

function Designer:DoDelete()

	if(self.selectedEscalator) then
		local escalator = self.escalators[self.selectedEscalator]
		self.escalators[self.selectedEscalator] = nil
		escalator:Destructor()
		escalator = nil
		self.selectedEscalator = nil
		self.usingEscalatorID = nil
	end
end
-- //////////////////////////
-- ////Col Hit & col Leave //
-- //////////////////////////

function Designer:ColHit(ele)

	self.hitelement = getElementsWithinColShape(source)[1]
end


function Designer:ColLeave(ele)

	self.hitelement = getElementsWithinColShape(source)[1] or nil
end

-- //////////////////////////
-- ////		Build buttons  //
-- //////////////////////////

function Designer:BuildButtons()
	self.button = {}
	self.hovertext = {}
	-- BUTTONS --
	self.button[1] = guiCreateButton(0, 795/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[1] = "Create escalator"
	
	self.button[2] = guiCreateButton(0, (795)-130/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[2] = "Reset start"
	
	self.button[3] = guiCreateButton(0, (795)-260/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[3] = "Reset end"
	
	self.button[4] = guiCreateButton(0, (795)-390/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[4] = "Invert direction"
	
	self.button[5] = guiCreateButton(0, (795)-510/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[5] = "Change steps"
	
	self.button[6] = guiCreateButton(0, (795)-640/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[6] = "Change speed"
	
	self.button[7] = guiCreateButton(0, (795)-770/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[7] = "Delete escalator"
	
	self.button[8] = guiCreateButton(1490/aesx*sx, (795)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[8] = "Output escalators"
	
	self.button[9] = guiCreateButton(1490/aesx*sx, (795-130)/aesy*sy, 110/aesx*sx, 110/aesy*sy, "", false)
	self.hovertext[9] = "Load escalators"
	
	-- VARIABLES & EVENT HANDLRS --
	self.iconSelectState = {}
	self:SetButtonsVisible(false)
	
	for index, button in pairs(self.button) do
		addEventHandler("onClientMouseEnter", button, function()
			self.iconSelectState[index] = true
			playSoundFrontEnd(42)
			self.selectedIcon = index
			self.thingClicked = true
		end)
		
		addEventHandler("onClientMouseLeave", button, function()
			self.iconSelectState[index] = false
			self.selectedIcon = nil
			self.thingClicked = false
		end)
		
		addEventHandler("onClientGUIClick", button, function()
			
			self.iconSelectState[index] = false
			self.selectedIcon = nil
			playSoundFrontEnd(41)
		end)
	end
	-- MANUELL
	addEventHandler("onClientGUIClick", self.button[1], function()
		self:SetButtonsEnabled(false)
		self:StartNewEscalator()
	end)
	--
	addEventHandler("onClientGUIClick", self.button[2], function()
		local id = self.selectedEscalator
		if(id) then
		--	self:SetButtonsEnabled(false)
			self:ResetStart(id)
			self:SetButtonsEnabled(false)
		else
			outputInfobox("Please select/create a escalator first.", 255, 0, 0, true)
		end
	end)
	--
	addEventHandler("onClientGUIClick", self.button[3], function()
		local id = self.selectedEscalator
		if(id) then
		--	self:SetButtonsEnabled(false)
			self:ResetEnd(id)
			self:SetButtonsEnabled(false)
		else
			outputInfobox("Please select/create a escalator first.", 255, 0, 0, true)
		end
	end)
	--
	addEventHandler("onClientGUIClick", self.button[4], function()
		local id = self.selectedEscalator
		if(id) then
		--	self:SetButtonsEnabled(false)
			self:InvertDirection(id)
			
		else
			outputInfobox("Please select/create a escalator first.", 255, 0, 0, true)
		end
	end)
	
	--
	addEventHandler("onClientGUIClick", self.button[5], function()
		local id = self.selectedEscalator
		if(id) then
		--	self:SetButtonsEnabled(false)
			self:ShowStepCount(id)
		else
			outputInfobox("Please select/create a escalator first.", 255, 0, 0, true)
		end
	end)
	--
	addEventHandler("onClientGUIClick", self.button[6], function()
		local id = self.selectedEscalator
		if(id) then
		--	self:SetButtonsEnabled(false)
			self:NextSpeed(id)
		else
			outputInfobox("Please select/create a escalator first.", 255, 0, 0, true)
		end
	end)
	--
	addEventHandler("onClientGUIClick", self.button[7], function()
		local id = self.selectedEscalator
		if(id) then
		--	self:SetButtonsEnabled(false)
			self:DoDelete();
		else
			outputInfobox("Please select/create a escalator first.", 255, 0, 0, true)
		end
	end)
		--
	addEventHandler("onClientGUIClick", self.button[8], function()
		self:OutputCode()
	end)
	--
	addEventHandler("onClientGUIClick", self.button[9], function()
		self:InputCode()
	end)
end

-- //////////////////////////
-- ////		Visible        //
-- //////////////////////////

function Designer:SetButtonsVisible(bool)
	local a = 0
	if(bool == true) then
		a = 255
	end
	for index, button in pairs(self.button) do
		guiSetAlpha(button, a)
	end
end

-- //////////////////////////
-- ////	SetButtonsEnabled  //
-- //////////////////////////

function Designer:SetButtonsEnabled(bool)
	for index, button in pairs(self.button) do
		guiSetEnabled(button, bool)
	end
end

-- //////////////////////////
-- ////	    Output         //
-- //////////////////////////

function Designer:OutputCode()
	if not(isElement(Static2.window[1])) then
		local X, Y, Width, Height = getMiddleGuiPosition(447, 295)
		Static2.window[1] = guiCreateWindow(X, Y, Width, Height, "Escalator Output", false)
		guiWindowSetSizable(Static2.window[1], false)
		
		Static2.memo[1] = guiCreateMemo(9, 41, 429, 213, "", false, Static2.window[1])
		guiMemoSetReadOnly(Static2.memo[1], true)
		Static2.button[1] = guiCreateButton(9, 257, 174, 29, "Close", false, Static2.window[1])
		guiSetFont(Static2.button[1], "default-bold-small")
		guiSetProperty(Static2.button[1], "NormalTextColour", "FFAAAAAA")
		Static2.radiobutton[1] = guiCreateRadioButton(13, 21, 151, 15, "In other resources", false, Static2.window[1])
		guiSetFont(Static2.radiobutton[1], "default-bold-small")
		Static2.radiobutton[2] = guiCreateRadioButton(211, 20, 224, 20, "In this resource(not recommended)", false, Static2.window[1])
		guiSetFont(Static2.radiobutton[2], "default-bold-small")
		guiRadioButtonSetSelected(Static2.radiobutton[1], true)
		Static2.button[2] = guiCreateButton(263, 256, 174, 29, "Copy to clipboard", false, Static2.window[1])
		guiSetFont(Static2.button[2], "default-bold-small")
		guiSetProperty(Static2.button[2], "NormalTextColour", "FFAAAAAA")
		-- FUNCTIONS --
		local reloadCode = function(typ)
			local text = ""
			local pre = "     exports.escalator:"
			if not(typ == "exported") then
				pre = "     "
			end
				text = "local escalators = {\n"
				for index, es in pairs(self.escalators) do
					if(es) then
						local x1, y1, z1 = es.startPos[1], es.startPos[2], es.startPos[3]
						local x2, y2, z2 = es.endPos[1], es.endPos[2], es.endPos[3]
						text = text..pre.."Escalator:New("..x1..", "..y1..", "..z1..", "..x2..", "..y2..", "..z2..", "..es.obereLaenge..", "..es.untereLaenge..", "..tostring(es.reverse)..", "..es.speed.."),\n"
					end
				end
				text = text.."}"

			guiSetText(Static2.memo[1], text)
		end
		-- EVENT HANDLER --
		addEventHandler("onClientGUIClick", Static2.button[1], function()
			destroyElement(Static2.window[1])
		end, false)
		--
		addEventHandler("onClientGUIClick", Static2.button[2], function()
			setClipboard(guiGetText(Static2.memo[1]))
			outputInfobox("Text copied to clipboard.", 0, 255, 0, true)
		end, false)
		--
		addEventHandler("onClientGUIClick", Static2.radiobutton[1], function()
			reloadCode("exported")
		end, false)
		--
		addEventHandler("onClientGUIClick", Static2.radiobutton[2], function()
			reloadCode("this")
		end, false)
		reloadCode("exported")
	end
end

-- //////////////////////////
-- ////	    Input          //
-- //////////////////////////

function Designer:InputCode()
	outputInfobox("In Development - Coming soon", 0, 255, 255, true);
	--[[
	if not(isElement(Static3.window[1])) then
		local X, Y, Width, Height = getMiddleGuiPosition(436, 114)
		Static3.window[1] = guiCreateWindow(X, Y, Width, Height, "Import Escalator", false)
		guiWindowSetSizable(Static3.window[1], false)
		
		Static3.label[1] = guiCreateLabel(9, 23, 347, 15, "Paste the line in the Textbox: (Escalator:New(blablabla))", false, Static3.window[1])
		guiSetFont(Static3.label[1], "default-bold-small")
		Static3.edit[1] = guiCreateEdit(9, 41, 418, 26, "", false, Static3.window[1])
		Static3.button[1] = guiCreateButton(9, 79, 143, 24, "Insert", false, Static3.window[1])
		guiSetFont(Static3.button[1], "default-bold-small")
		guiSetProperty(Static3.button[1], "NormalTextColour", "FFAAAAAA")
		Static3.button[2] = guiCreateButton(281, 77, 143, 24, "Cancel", false, Static3.window[1])
		guiSetFont(Static3.button[2], "default-bold-small")
		guiSetProperty(Static3.button[2], "NormalTextColour", "FFAAAAAA")
		
		-- EVENT HANDLER --
		addEventHandler("onClientGUIClick", Static3.button[2], function()
			destroyElement(Static3.window[1])
		end, false)
		--
		addEventHandler("onClientGUIClick", Static3.button[1], function()
			local input = guiGetText(Static3.edit[1])
			--if(string.find(input, "Escalator:New("))
			outputInfobox("In Development - Coming soon", 0, 255, 255, true)
			destroyElement(Static3.window[1])
		end, false)
	end]]
end
-- //////////////////////////
-- ////	Destroy buttons /////
-- //////////////////////////

function Designer:DestroyButtons()
	for index, button in pairs(self.button) do
		destroyElement(button)
	end
	self.button = {}
end

-- //////////////////////////
-- ///// Constructor ////////
-- //////////////////////////

function Designer:Constructor()
	-- Exports
	call(getResourceFromName("freecam" ), "setFreecamEnabled")
	-- Functions
	outputDebugString("Designer: Constructor")
	toggleAllControls(false)
	
	self.drawFunc = function() self:Render(); end;
	self.colHitFunc = function(...) self:ColHit(...); end;
	self.colLeaveFunc = function(...) self:ColLeave(...); end;
	self.deleteFunc = function(...) self:DoDelete(...); end; 
	self.clickFunc = function(...) self:DefineClick(...); end;
	self.switchStateFunc = function(...) self:SwitchState(...); end;
	
	addEventHandler("onClientRender", getRootElement(), self.drawFunc)

	-- Variables
	local x, y, z = getElementPosition(localPlayer)
	self.selectionCol = createColSphere(x, y, z, 3)
	self.state = true
	if not(self.escalators) then
		self.escalators = {}
		self.lastEscalatorID = 0
		self.escalatorSettings = {}
	end
	self.iconSelectState = {}
	for i = 1, 5, 1 do
		self.iconSelectState[i] = false
	end
	self:BuildButtons()
	-- Event Handlers
	bindKey("f", "down", self.switchStateFunc)
	addEventHandler("onClientColShapeHit", self.selectionCol, self.colHitFunc)
	addEventHandler("onClientColShapeLeave", self.selectionCol, self.colLeaveFunc)
	addEventHandler("onClientClick", getRootElement(), self.clickFunc)
	bindKey("delete", "down", self.deleteFunc)
end


-- //////////////////////////
-- ///// Desctructor ////////
-- //////////////////////////

function Designer:Destructor(...)
	-- Exports
	call(getResourceFromName("freecam" ), "setFreecamDisabled")
	-- Functions
	outputDebugString("Designer: Destructor")
	toggleAllControls(true)
	removeEventHandler("onClientRender", getRootElement(), self.drawFunc)
	
	showCursor(false)
	-- Methods
	self:DestroyButtons()
	-- Variables --
	destroyElement(self.selectionCol)
	-- Event Handlers
	unbindKey("f", "down", self.switchStateFunc)
	removeEventHandler("onClientClick", getRootElement(), self.clickFunc)
end

-- //////////////////////////
-- /////// Stop		 ////////
-- //////////////////////////

function Designer:Stop(...)
	self:Destructor(...)
	--	self = nil

	setCameraTarget(localPlayer)
end

-- USEFULL FUNCTIONS --
function isEscalatorObject(object)
	if(isElement(object)) then
		if(getElementData(object, "Escalator.IsStep") == true) then
			return true
		end
	end
	return false
end

function getEscalatorID(object)
	if(getElementData(object, "Escalator.IsStep") == true) then
		return tonumber(getElementData(object, "Escalator:ID"))
	end
	return false
end

function getMiddleGuiPosition(lol, lol2)

	local sWidth, sHeight = guiGetScreenSize()
 
    local Width,Height = lol, lol2
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	return X, Y, Width, Height
end
-- EVENT HANDLERS --