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

mafiaTeam = createTeam("Mafia", 150, 100, 0)
policeTeam = createTeam("Police", 0, 255, 255)

setFPSLimit(0)
-- FUNCTIONS --


-- MODELL HANDLING --
for i = 411, 611, 1 do
	local h = getModelHandling(i)
	setModelHandling(i, "maxVelocity", h["maxVelocity"]*5)
	setModelHandling(i, "engineAcceleration", h["engineAcceleration"]*1.5)
	setModelHandling(i, "tractionBias", h["tractionBias"]/1.5)
	setModelHandling(i, "tractionLoss", h["tractionLoss"]*1.5)
end

addEventHandler("onResourceStop", getResourceRootElement(), function()
	for i = 411, 611, 1 do
		local h = getOriginalHandling(i)
		for index, data in pairs(h) do
			setModelHandling(i, index, data)
		end
	end
end)

-- EVENT HANDLERS --

cFunc["chat"] = function(thePlayer, msg, typ)
		for index, player in pairs(getElementsByType("player")) do
			if(getElementData(player, "team") == getElementData(thePlayer, "team")) then
				outputChatBox("["..getPlayerName(thePlayer)..": "..msg.."]", player, 255, 255, 255)
			end 
		end
end

addCommandHandler("t", function(thePlayer, cmd, ...)
	cFunc["chat"](thePlayer, table.concat({...}, " "))
end)
addEventHandler( "onPlayerChat", getRootElement(), cFunc["chat"])