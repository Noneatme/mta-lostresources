addEventHandler("onElementClicked", getRootElement(), function(mouse, button, thePlayer)
	if(mouse == "left") and (button == "down") then
		if(source) and (getElementType(source) == "player") then
			triggerClientEvent(thePlayer, "onMultistuntPlayerClick", source)
		end
	end
end)