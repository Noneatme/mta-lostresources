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


cFunc["draw_hud"] = function()
	if(isPlayerSpawned(localPlayer)) then
		dxDrawRectangle(1372/aesx*sx, 63/aesy*sy, 184/aesx*sx, 13/aesy*sy, tocolor(0, 255, 11, 100), true)
		dxDrawRectangle(1372/aesx*sx, 63/aesy*sy, (184/aesx*sx)/100*getElementHealth(localPlayer), 13/aesy*sy, tocolor(11, 255, 0, 200), true)
		
		dxDrawRectangle(1372/aesx*sx, 82/aesy*sy, 184/aesx*sx, 13/aesy*sy, tocolor(0, 0, 0, 100), true)
		dxDrawRectangle(1372/aesx*sx, 82/aesy*sy, (184/aesx*sx)/100*getPedArmor(localPlayer), 13/aesy*sy, tocolor(0, 0, 0, 200), true)
		
		dxDrawImage(1396/aesx*sx, 105/aesy*sy, 130/aesx*sx, 115/aesy*sy, "files/images/waffen/"..getPedWeapon(localPlayer)..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		dxDrawText(getPedAmmoInClip(localPlayer).." / "..getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer), 1358/aesx*sx, 222/aesy*sy, 1562/aesx*sx, 254/aesy*sy, tocolor(255, 255, 255, 255), 1/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
		
		local hour, min = getTime()
		local timeStr = hour..":"..min
		dxDrawText(timeStr, 1371/aesx*sx, 10/aesy*sy, 1554/aesx*sx, 55/aesy*sy, tocolor(255, 255, 255, 255), 2/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
		dxDrawText(timeStr, 1370/aesx*sx, 8/aesy*sy, 1553/aesx*sx, 53/aesy*sy, tocolor(0, 0, 0, 255), 2/(aesx+aesy)*(sx+sy), "pricedown", "center", "center", false, false, true, false, false)
	end
end


-- EVENT HANDLERS --

addEventHandler("onClientRender", getRootElement(), cFunc["draw_hud"])