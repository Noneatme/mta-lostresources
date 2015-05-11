local Bild
local Font = dxCreateFont("data/fonts/berlin.TTF", 12)
local enabled = false
addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	--[[
		Label = guiCreateLabel(0.7786,0.225,0.1771,0.2491,"Aepfel: 0\nBirnen: 0\nBananen: 0\nKirschen: 0",true)
		guiLabelSetHorizontalAlign(Label,"center",false)
		guiSetFont(Label, Font)
		guiLabelSetColor(Label, 179, 255, 100)
	--]]
	Bild = guiCreateStaticImage(0.7966,1-0.0731,0.1792,0.0463,"data/images/obstbar.png",true)
	addMouseRollover(Bild, rollover_names["Obstbar"])
	--guiSetVisible(Label, false)
	guiSetVisible(Bild, false)
	
	local x, y = guiGetScreenSize()
	if(x < 800) and (y < 600) then
		triggerServerEvent("onResoutionKick", gMe)
	end
end)

--[[
local function refreshObstAnzeige()
	local ap = getElementData(gMe, "ms.aepfel")
	local bi = getElementData(gMe, "ms.birnen")
	local ba = getElementData(gMe, "ms.bananen")
	local ki = getElementData(gMe, "ms.kirschen")
	if not(ap) then ap = 0 end
	if not(bi) then bi = 0 end
	if not(ba) then ba = 0 end
	if not(ki) then ki = 0 end
	guiSetText(Label, "Aepfel: "..ap.."\nBirnen: "..bi.."\nBananen: "..ba.."\nKirschen: "..ki)
end
--]]

addEvent("onAccountLoginBack", true)
addEventHandler("onAccountLoginBack", getRootElement(), function(typ)
	if(typ == true) then
		setTimer( function()
			--guiSetVisible(Label, true)
			guiSetVisible(Bild, true)
			showPlayerHudComponent("money", false)
			enabled = true
			--setTimer(refreshObstAnzeige, 1000, 0)
		end, 1000, 1)
	end
end)


-- Funktionen, wie man die Bekommt --

function getObstbarState()
	if(guiGetVisible(Bild) == true) then return true else return false end
end

function setObstbarState(state)
	if(state == "on") then
		if(guiGetVisible(Bild) == true) then return end
		--guiSetVisible(Label, true)
		guiSetVisible(Bild, true)
		enabled = true
	else
		if(guiGetVisible(Bild) == false) then return end
		--guiSetVisible(Label, false)
		guiSetVisible(Bild, false)
		enabled = false
	end
end


addEventHandler("onClientRender", getRootElement(), function()
	if(enabled == true) then
		--[[local sx, sy = guiGetScreenSize()
		local s1, s2, s3, s4 = tostring(tonumber(getElementData(gMe, "ms.aepfel"))), tostring(tonumber(getElementData(gMe, "ms.birnen"))), tostring(tonumber(getElementData(gMe, "ms.bananen"))), tostring(tonumber(getElementData(gMe, "ms.kirschen")))
		dxDrawText("| "..s1.." | "..s2.." | "..s3.." | "..s4.." |", sx/2+sx/3.5+50, sy-100, sx/2, sy/2, tocolor(0, 0, 0, 200), 1, Font)
		dxDrawText("| "..s1.." | "..s2.." | "..s3.." | "..s4.." |", sx/2+sx/3.5+50, sy-100, sx/2, sy/2, tocolor(255, 255, 255, 200), 1, Font)]]
	end
end)