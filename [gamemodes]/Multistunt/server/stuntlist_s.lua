local ortliste = {
	["Airport SF"] = "-1368.8778076172, -179.89527893066, 14.1484375",
	["Kartbahn"] = "540.23504638672, 126.45542907715, 22.191761016846",
	["Skatepark"] = "1864.3826904297, -1381.8419189453, 13.488510131836",
	["Dunedrop"] = "743.97241210938, -2103.4858398438, 552.55535888672, true",
	["Startower"]= "1541.2800292969, -1363.4973144531, 329.796875",
	["Hightjump"] = "-1947.2933349609, 436.59085083008, 283.92098999023, true",
	["Mt.Chilliad"] = "-2338.8073730469, -1639.5502929688, 483.703125",
	["Airport LV 2"] = "388.80627441406, 2532.7180175781, 16.5390625",
	["Airport LS"] = "2094.15625, -2631.5676269531, 13.630687713623",
	["Waterpark"] = "-2077.7136230469, -2824.8405761719, 3",
	["Golden Gate SF"] = "-2610.4643554688, 1453.5478515625, 7.5730533599854",
	["Obstmarkt"] = "1027.2067871094, -1914.4079589844, 12.848532676697",
	["Skinshop"] = "-1704.4429931641, 951.94842529297, 24.890625",
	["Speedo 1"] = "-949.93701171875, 445.59963989258, 2269.4116210938, true",
	["Los Santos Stunts"] = "2051.9958496094, -1612.5974121094, 13.3828125",
	["Stuntpark LS"] = "1183.818359375, -1796.9272460938, 33.946891784668",
	["Desert Rollercoaster"] = "-60.610668182373, 1169.1628417969, 502.23220825195, true",
}

local vehicleData = {
	["Airport SF"] = "airportsf",
	["Kartbahn"] = "kartbahn",
	["Skatepark"] = "skatepark",
	["Dunedrop"] = "dunedrop",
	["Startower"] = "startower",
	["Hightjump"] = "hightjump",
	["Waterpark"] = "waterpark",
	["Airport LS"] = "airportls",
	["Airport LV 2"] = "airportlv2",
	["Speedo 1"] = "speedo1",
	["Los Santos Stunts"] = "lsstunts",
	["Stuntpark LS"] = "stuntparkls",
	["Desert Rollercoaster"] = "drollercoaster",
}

local stuntRespawns = {}
function respawnNearbyStuntVehicles(theStunt)
	if not(vehicleData[theStunt]) then return end
	if(stuntRespawns[theStunt] == true) then return end
	stuntRespawns[theStunt] = true
	setTimer(function() stuntRespawns[theStunt] = false end, 5000, 1)

	for index, car in pairs(getElementsByType("vehicle")) do
		if(getElementData(car, "mv.stuntcar") == vehicleData[theStunt]) then
			if(getVehicleOccupant(car)) then return end
			respawnVehicle(car)
			setVehicleLocked(car, false)
		end
	end
end


addEvent("onMultistuntTeleport", true)
addEventHandler("onMultistuntTeleport", getRootElement(), function(theStunt)
	if not(theStunt) or not(ortliste[theStunt]) then return end
	local theElement
	if(isPedInVehicle(source)) then theElement = getPedOccupiedVehicle(source) fadeCamera(source, true) else theElement = source fadeCamera(source, true) end
	setElementPosition(theElement, gettok(ortliste[theStunt], 1, ","), gettok(ortliste[theStunt], 2, ","), gettok(ortliste[theStunt], 3, ","))
	if(gettok(ortliste[theStunt], 4, ",")) then
		setElementFrozen(theElement, true)
		setTimer(setElementFrozen, 1000, 1, theElement, false)
		if(getElementType(theElement) == "player") then
			toggleAllControls(theElement, false)
			setTimer(toggleAllControls, 1000, 1, theElement, true)
			
		end
		
	end
	respawnNearbyStuntVehicles(theStunt)
end)
