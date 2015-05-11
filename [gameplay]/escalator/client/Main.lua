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

local x1, y1, z1 = 2484.693359375, -1665.2385253906, 13.34375

-- FUNCTIONS --

local designer

local enable_designer = true -- Enable/Disable the designer - set to false if the designer should be disabled


do
	if(enable_designer == true) then 
		outputInfobox("Press F2 to open the escalator designer", 0, 255, 0, true)
		cFunc["start_designer"] = function()
			if not(designer) then
				designer = Designer:New();
			end
			if(designer.showstate == false) then
				designer.showstate = true
				designer:Constructor()
				showChat(false)
			else
				designer.showstate = false
				local x, y, z = getCameraMatrix()
				setElementPosition(localPlayer, x, y, z)
				designer:Stop()
				showChat(true)
			end
		end
		-- EVENT HANDLERS --
		
		addCommandHandler("start_designer", cFunc["start_designer"])
		bindKey("F2", "down", cFunc["start_designer"])
	end
end