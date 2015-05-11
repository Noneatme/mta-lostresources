-- Alle Scripts bei MuLTi [C]! --


addEventHandler("onClientRender", getRootElement(), function()
	for index, key in pairs(getElementsByType("player")) do
		if(key ~= gMe) then
			setPlayerNametagShowing(key, false)
			if(getDistanceBetweenElements(gMe, key) < 50) then
				local x, y, z = getElementPosition(key)
				local x2, y2, z2 = getElementPosition(gMe)
				local sx, sy = getScreenFromWorldPosition(x, y, z+1.2)
				local distanz = getDistanceBetweenElements(key, gMe)
				if(sx) and (sy) then
					if(isLineOfSightClear(x, y, z, x2, y2, z2, true, false, false, true)) then
						-- Rahmen
						if(isPedInVehicle(key)) then
							local hp = math.floor(((getElementHealth(getPedOccupiedVehicle(key))-250)/750)*100)
							local r, g, b
							if hp <= 0 then
								r, g, b = 0, 0, 0
								
							else
								hp = math.abs ( hp - 0.01 )
								r, g, b = ( 100 - hp ) * 2.55 / 2, ( hp * 2.55 ), 0
							end
							-- Rahmen und Schaden --
							dxDrawRectangle ( sx-50, sy, 170-distanz*2, 33-(distanz/2), tocolor(r, g, b, 150))
							dxDrawImage(sx-50, sy, 170-distanz*2, 33-(distanz/2), "data/images/nametags/rahmen.png")
						end
							-- Name --
							local fontbig = 1.5-(distanz/50)
							local name = getPlayerName(key)
							if(isPedInVehicle(key)) then else
								dxDrawRectangle ( sx-50+distanz/2, sy, 150-distanz*2, 33-(distanz/2), tocolor(0, 0, 0, 100))
							end
							dxDrawText(name, sx+56-distanz, sy+7-(distanz/25), sx, sy, tocolor(0, 0, 0, 200), fontbig, "default-bold", "center")
							dxDrawText(name, sx+54-distanz, sy+5-(distanz/25), sx, sy, tocolor(255, 255, 255, 200), fontbig, "default-bold", "center")
							
					end
				end
			end
		end
	end
end)