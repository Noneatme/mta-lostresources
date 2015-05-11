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

cSetting["vehicles"] = {
	createVehicle(482, 1088.8000488281, -1250.1999511719, 16.10000038147, 0, 0, 0, "ZUGKI9D"), 
	createVehicle(482, 1092.4000244141, -1250.1999511719, 16.10000038147, 0, 0, 0, "NMWSBAF"), 
	createVehicle(482, 1096, -1250.1999511719, 16.10000038147, 0, 0, 0, "HB98UJI"), 
	createVehicle(482, 1099.5999755859, -1250.1999511719, 16.10000038147, 0, 0, 0, "09VVO9V"), 
	createVehicle(554, 1104.3000488281, -1249.9000244141, 16, 0, 0, 0, "1DAY2KL"), 
	createVehicle(554, 1108.6999511719, -1249.9000244141, 16, 0, 0, 0, "D4T4HM1"), 
	createVehicle(487, 1132.5999755859, -1221.1999511719, 25.60000038147, 0, 0, 90, "V78FWYE"), 
	createVehicle(487, 1132.8000488281, -1238.3000488281, 25.60000038147, 0, 0, 90, "3LIEEC6"), 
	createVehicle(463, 1108.4000244141, -1224.0999755859, 15.39999961853, 0, 0, 180, "CA0CZBP"), 
	createVehicle(463, 1106.5999755859, -1224.0999755859, 15.39999961853, 0, 0, 180, "VDW5T2V"), 
	createVehicle(463, 1104.6999511719, -1224.0999755859, 15.39999961853, 0, 0, 180, "OVKKVOO"), 
	createVehicle(463, 1102.6999511719, -1224, 15.39999961853, 0, 0, 180, "Y1YXY0N"), 
	createVehicle(468, 1100.8000488281, -1224.0999755859, 15.60000038147, 0, 0, 180, "IXLXLW9"), 
	createVehicle(468, 1099.0999755859, -1224.0999755859, 15.60000038147, 0, 0, 180, "UV6NJYK"), 
	createVehicle(468, 1097.3000488281, -1224.0999755859, 15.60000038147, 0, 0, 180, "ORA11AV"), 
	createVehicle(468, 1095.5, -1224.0999755859, 15.60000038147, 0, 0, 180, "XWYD2I9"), 
}

for index, vehicle in next, cSetting["vehicles"] do
	setVehicleColor(vehicle, 156, 100, 0, 156, 156, 100, 0, 156, 100)
	toggleVehicleRespawn(vehicle, true)
	setVehicleIdleRespawnDelay(vehicle, 120*60*1000)
	setVehicleRespawnDelay(vehicle, 5000)
	
	addEventHandler("onVehicleStartEnter", vehicle, function(thePlayer, seat)
		if(seat == 0) and (isMafia(thePlayer) == false) then
			cancelEvent()
			outputChatBox("You can't enter this vehicle.", thePlayer, 255, 0, 0)
		end
	end)
end


-- EVENT HANDLERS --