addEventHandler("onElementClicked", getRootElement(), function(mouse, button, thePlayer)
	if(mouse == "left") and (button == "down") then
		if(source) and (getElementType(source) == "vehicle") then
			triggerClientEvent(thePlayer, "onMultistuntVehicleClick", source)
		end
	end
end)