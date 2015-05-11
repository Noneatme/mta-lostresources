-- Spielzeit --
function add_spielzeit ()
	if not(getElementData( gMe, "ms.playtime" ) == nil) then
		
		if(isPlayerEingeloggt(gMe) == false) then return end
		local hours = tonumber(gettok ( getElementData(gMe, "ms.playtime"), 1, ":" ))
		local minutes = tonumber(gettok ( getElementData(gMe, "ms.playtime"), 2, ":" ))
	
		if (minutes > 58) then
		
			hours = hours+1
				
			setElementData ( gMe, "ms.playtime", hours..":00" )
			if(hours > 0) then
				triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 9)
			end
			if(hours > 9) then
				triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 10)
			end
			if(hours > 49) then
				triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 11)
			end
			if(hours > 99) then
				triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 12)
			end
			if(hours > 199) then
				triggerServerEvent("onMultistuntBadgeGive", gMe, gMe, 13)
			end
		else
			minutes = minutes+1	
			setElementData ( gMe, "ms.playtime", hours..":"..minutes)
		
		end
		
	end
				
end

setTimer ( add_spielzeit, 60000, 0 )