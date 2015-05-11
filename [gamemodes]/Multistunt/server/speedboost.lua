addEvent("onMultistuntSpeedboostStart", true)
addEventHandler("onMultistuntSpeedboostStart", getRootElement(), function(veh)
	triggerClientEvent("onMultistuntSpeedboostBack", veh)
end)