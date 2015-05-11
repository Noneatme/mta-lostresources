local stuntvar = {}

function setPlayerToStunt(thePlayer, stunt, reward, anzahl, vehicleTyp, vehname )
	if(getElementType(thePlayer) == "player") then
		if(isPedInVehicle(thePlayer) == false) then return end
		if(vehicleTyp == "all") then
		
		elseif(vehicleTyp == "bike") then
			if(getVehicleType(getPedOccupiedVehicle(thePlayer)) ~= "Bike") then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000You need a bike for this stunt.", thePlayer, 0, 0, 0, true) return end
		elseif(vehicleTyp == "car") then
 			if(getVehicleType(getPedOccupiedVehicle(thePlayer)) ~= "Automobile") then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000You need a car for this stunt.", thePlayer, 0, 0, 0, true) return end
		elseif(vehicleTyp == "plane") then
			if(getVehicleType(getPedOccupiedVehicle(thePlayer)) ~= "Plane") then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000You need a plane for this stunt.", thePlayer, 0, 0, 0, true) return end
		elseif(vehicleTyp == "boat") then
			if(getVehicleType(getPedOccupiedVehicle(thePlayer)) ~= "Boat") then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000You need a boat for this stunt.", thePlayer, 0, 0, 0, true) return end
		elseif(vehicleTyp == "custom") then
			if not(vehname) then return end
			if(getVehicleName(getPedOccupiedVehicle(thePlayer)) ~= vehname) then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000You need a '"..vehname.."' for this stunt.", thePlayer, 0, 0, 0, true) return end
		
		end
		if(getElementData(thePlayer, "ms.doingstunt") == true) then
			if(stunt == getElementData(thePlayer, "ms.stunt")) then return end
			if(stuntvar[thePlayer] == true) then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000You must wait a minute, to start another stunt!", thePlayer, 0, 0, 0, true) return end
			setElementData(thePlayer, "ms.doingstunt", false)
			setElementData(thePlayer, "ms.stunt", false)
		end
		if(stuntvar[thePlayer] == true) then outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #FF0000You must wait a minute, to start another stunt!", thePlayer, 0, 0, 0, true) return end
		setElementData(thePlayer, "ms.doingstunt", true)
		setElementData(thePlayer, "ms.stunt", stunt)
		outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #00FF00Stunt started! Reward: "..anzahl.." "..reward, thePlayer, 0, 0, 0, true)
		addSpecialEffect("leuchtrakete", getPedOccupiedVehicle(thePlayer), "blau")

		stuntvar[thePlayer] = true
		setTimer(function() stuntvar[thePlayer] = false end, 60000, 1)
		triggerClientEvent(thePlayer, "onMultistuntStuntStart", thePlayer, getElementData(thePlayer, "ms.stunt"))
	end
end

function finishPlayerStunt(thePlayer, stunt, reward, anzahl)
	if(getElementData(thePlayer, "ms.doingstunt") == true) and (getElementData(thePlayer, "ms.stunt") == stunt) then
		outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #00FF00Stunt finished! Reward: "..anzahl.." "..reward, thePlayer, 0, 0, 0, true)
		addSpecialEffect("leuchtrakete", getPedOccupiedVehicle(thePlayer), "gruen")
		setTimer(addSpecialEffect, 100, 1, "leuchtrakete", getPedOccupiedVehicle(thePlayer), "aqua")
		setTimer(addSpecialEffect, 150, 1, "leuchtrakete", getPedOccupiedVehicle(thePlayer), "rot")
		setTimer(addSpecialEffect, 200, 1, "leuchtrakete", getPedOccupiedVehicle(thePlayer), "gelb")	
		triggerClientEvent(thePlayer, "onMultistuntStuntFinish", thePlayer, getElementData(thePlayer, "ms.stunt"))
		setElementData(thePlayer, "ms.doingstunt", false)
		setElementData(thePlayer, "ms.stunt", false)
		givePlayerStuntObst(thePlayer, reward, anzahl)
	end
end

addEventHandler("onPlayerVehicleExit", getRootElement(), function()
	if(getElementData(source, "ms.doingstunt") == true) then
		setElementData(source, "ms.doingstunt", false)
		setElementData(source, "ms.stunt", false)
		outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #00FF00The stunt has been canceled.", source, 0, 0, 0, true)
		stuntvar[source] = false
		triggerClientEvent(source, "onMultistuntStuntFail", source)
	end
end)

addEventHandler("onPlayerWasted", getRootElement(), function()
	if(getElementData(source, "ms.doingstunt") == true) then
		setElementData(source, "ms.doingstunt", false)
		setElementData(source, "ms.stunt", false)
		stuntvar[source] = false
		outputChatBox("#FFFFFF[#00FF00INFO#FFFFFF] #00FF00The stunt has been canceled.", source, 0, 0, 0, true)
		triggerClientEvent(source, "onMultistuntStuntFail", source)
	end
end)

addEvent("onMultistuntStuntlistCheck", true)
addEventHandler("onMultistuntStuntlistCheck", getRootElement(), function(stunt, time)
	local result = mysql_query(handler, "SELECT * FROM stunts WHERE NAME = '"..stunt.."';")
	if (result and mysql_num_rows( result ) > 0) then 
		local row = mysql_fetch_assoc(result)
		local therow
		if(time ~= 0) then
			if (row['T10'] == "-") or (time < tonumber(row['T10'])) then therow = 'T10' end
			if (row['T9'] == "-") or (time < tonumber(row['T9'])) then therow = 'T9' end
			if (row['T8'] == "-") or (time < tonumber(row['T8'])) then therow = 'T8' end
			if (row['T7'] == "-") or (time < tonumber(row['T7'])) then therow = 'T7' end
			if (row['T6'] == "-") or (time < tonumber(row['T6'])) then therow = 'T6' end
			if (row['T5'] == "-") or (time < tonumber(row['T5'])) then therow = 'T5' end
			if (row['T4'] == "-") or (time < tonumber(row['T4'])) then therow = 'T4' end
			if (row['T3'] == "-") or (time < tonumber(row['T3'])) then therow = 'T3' end
			if (row['T2'] == "-") or (time < tonumber(row['T2'])) then therow = 'T2' end
			if (row['T1'] == "-") or (time < tonumber(row['T1'])) then therow = 'T1' end
		end
		if not(therow) then
			triggerClientEvent(source, "onToplistRefresh", source, row['T1'], row['T1NAME'], row['T2'], row['T2NAME'], row['T3'], row['T3NAME'], row['T4'], row['T4NAME'], row['T5'], row['T5NAME'], row['T6'], row['T6NAME'], row['T7'], row['T7NAME'], row['T8'], row['T8NAME'], row['T9'], row['T9NAME'], row['T10'], row['T10NAME'], stunt)
			mysql_free_result(result)
		else
			local result2 = mysql_query(handler, "UPDATE stunts SET "..therow.."NAME = '"..getPlayerName(source).."' WHERE NAME = '"..stunt.."';")
			mysql_query(handler, "UPDATE stunts SET "..therow.." = '"..time.."' WHERE NAME = '"..stunt.."';")
			if(result2) then
				outputChatBox("New toptime! "..time.." Milliseconds.", source, 0, 255, 0)
				triggerEvent("onMultistuntStuntlistCheck", source, stunt, 0)
				mysql_free_result(result2)
			end
		end
	else
		
		local result2 = mysql_query(handler, "INSERT INTO stunts ( NAME ) VALUES( '"..tostring(stunt).."' ) ")
		if(result2) then
			outputServerLog("Neuer Row in Stunts angelegt: "..stunt)
			mysql_free_result(result2)
		else
			outputServerLog("ERROR: Row kann nicht in Stunts angelegt werden: "..stunt)
		end
	end
end)
