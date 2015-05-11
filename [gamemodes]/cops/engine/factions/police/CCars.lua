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
	createVehicle(596, 1602.8000488281, -1696.0999755859, 5.6999998092651, 0, 0, 270, "Y5CS GAS"), 
	createVehicle(596, 1602.8000488281, -1692, 5.6999998092651, 0, 0, 270, "YNQD 5VH"), 
	createVehicle(596, 1603, -1687.9000244141, 5.6999998092651, 0, 0, 270, "52AB 3W7"), 
	createVehicle(596, 1603, -1683.9000244141, 5.6999998092651, 0, 0, 270, "AKSC WFO"), 
	createVehicle(596, 1602.6999511719, -1700.0999755859, 5.6999998092651, 0, 0, 270, "LZWH KXY"), 
	createVehicle(596, 1602.5999755859, -1704.0999755859, 5.6999998092651, 0, 0, 270, "DQJC Q3Z"), 
	createVehicle(596, 1595.5, -1711.9000244141, 5.6999998092651, 0, 0, 180, "ML6B RLZ"), 
	createVehicle(596, 1591.5, -1711.8000488281, 5.6999998092651, 0, 0, 180, "ZAU5 JO3"), 
	createVehicle(596, 1587.5, -1711.8000488281, 5.6999998092651, 0, 0, 180, "JJDJ TL0"), 
	createVehicle(596, 1583.5, -1711.6999511719, 5.6999998092651, 0, 0, 180, "MYU9 AU9"), 
	createVehicle(596, 1578.5999755859, -1711.8000488281, 5.6999998092651, 0, 0, 180, "LVGN B9V"), 
	createVehicle(596, 1574.5, -1711.8000488281, 5.6999998092651, 0, 0, 180, "S75M J5T"), 
	createVehicle(596, 1570.5, -1711.6999511719, 5.6999998092651, 0, 0, 180, "BN3Q OBT"), 
	createVehicle(596, 1564.5, -1710.8000488281, 5.6999998092651, 0, 0, 0, "50NC 9D6"), 
	createVehicle(596, 1558.8000488281, -1711.8000488281, 5.6999998092651, 0, 0, 180, "G085 3A3"), 
	createVehicle(490, 1528.9000244141, -1688.0999755859, 6.1999998092651, 0, 0, 270, "JT2F CBP"), 
	createVehicle(490, 1528.9000244141, -1683.9000244141, 6.1999998092651, 0, 0, 270, "EW7B 4FJ"), 
	createVehicle(427, 1545.3000488281, -1684.3000488281, 6.0999999046326, 0, 0, 90, "5MKG OM1"), 
	createVehicle(427, 1545.4000244141, -1680.3000488281, 6.0999999046326, 0, 0, 90, "V8F8 SES"), 
	createVehicle(427, 1545.4000244141, -1676, 6.0999999046326, 0, 0, 90, "O4J9 ICR"), 

}

for index, vehicle in next, cSetting["vehicles"] do
	setVehicleColor(vehicle, 0, 255, 255, 0, 200, 200, 0, 255, 255)
	toggleVehicleRespawn(vehicle, true)
	setVehicleIdleRespawnDelay(vehicle, 120*60*1000)
	setVehicleRespawnDelay(vehicle, 5000)
	
	addEventHandler("onVehicleStartEnter", vehicle, function(thePlayer, seat)
		if(seat == 0) and (isPolice(thePlayer) == false) then
			cancelEvent()
			outputChatBox("You can't enter this vehicle.", thePlayer, 255, 0, 0)
		end
	end)
end


-- EVENT HANDLERS --