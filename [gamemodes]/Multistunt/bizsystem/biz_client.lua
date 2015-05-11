local var = 0
local bizWaitTime = 86400

addEvent("onMultistuntBizEnter", true)
addEvent("onMultistuntBizGuiRefresh", true)

addEventHandler ( "onClientRender", getRootElement(), function()
	local x, y, z, x1, y1, z1, sx, sy
	for index, key in pairs ( getElementsByType("colshape", getRootElement(), true) ) do

		if (getElementData(key, "biz.state") == true) then
			x, y, z = getElementPosition(key)
			if(x) and (y) and (z) then
				x1, y1, z1 = getElementPosition(gMe)
				local distance = getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
				if(distance < 50) then
					sx, sy = getScreenFromWorldPosition ( x, y, z, 800, true )
					sx2, sy2 = getScreenFromWorldPosition ( x, y, z+0.3, 800, true )
					local width, height = 64-distance, 64-distance
					local fontbig = 1-(distance/50)
					if sx and sy then
						if(getElementData(key, "biz.besitzer") == "niemand") then
							local preis = getElementData(key, "biz.preis")
							local einkommen = tostring(tonumber(getElementData(key, "biz.einkommen")))
							local name = getElementData(key, "biz.name")
							dxDrawImage(sx2, sy2, width, height, "data/images/biz/"..var..".png")
							dxDrawText("Business for sale\nName: "..name.."\nID: "..tostring(getElementData(key, "biz.id")).."\nPrice: "..preis.." pears\nEarn: "..einkommen.." pears/5min", sx, sy, sx, sy, tocolor(255, 255, 255, 255), fontbig, "default-bold", "center")
						else
							local preis = getElementData(key, "biz.preis")
							local einkommen = tostring(tonumber(getElementData(key, "biz.einkommen")))
							local besitzer = getElementData(key, "biz.besitzer")
							local name = getElementData(key, "biz.name")
							dxDrawImage(sx2, sy2, width, height, "data/images/biz/2.png")
							dxDrawText("Business owned by "..besitzer.."\nName: "..name.."\nID: "..tostring(getElementData(key, "biz.id")).."\nPrice: "..preis.." pears\nEarn: "..einkommen.." pears/5min", sx, sy, sx, sy, tocolor(255, 233, 233, 255), fontbig, "default-bold", "center")
						end
					end
				end
			end
			end
		end
end)

setTimer(function()
	if(var == 0) then
		var = 1
	else
		var = 0
	end
end, 2000, 0)
local Guivar = 0
local Fenster ,Bild, Label, Knopf1, Knopf2, Knopf3
addEventHandler("onMultistuntBizEnter", getRootElement(), function(theBiz)
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
		
	local X, Y, Width, Height = getMiddleGuiPosition(339,152)
	Fenster = guiCreateWindow(X, Y, Width, Height, "Business",false)
	Bild = guiCreateStaticImage(10,20,87,85,"data/images/biz/2.png",false,Fenster)
	Label = guiCreateLabel(106,29,204,73,"Bizname: "..tostring(getElementData(theBiz, "biz.name")).."\nOwner: "..tostring(getElementData(theBiz, "biz.besitzer")).."\nPrice: "..tostring(getElementData(theBiz, "biz.preis")).." pears\nEarn: "..tostring(getElementData(theBiz, "biz.einkommen")).." pears\nBuyable: ",false,Fenster)
	guiSetFont(Label,"default-bold-small")
	Knopf1 = guiCreateButton(9,110,122,29,"Buy business",false,Fenster)
	Knopf2 = guiCreateButton(135,111,122,29,"Sell business",false,Fenster)
	Knopf3 = guiCreateButton(260,111,70,29,"[X]",false,Fenster)

	local function reloadKnoepfe()	
		local besitzer = getElementData(theBiz, "biz.besitzer")
		local gekauft = getElementData(theBiz, "biz.gekauft")
		local curtimestamp = getRealTime().timestamp
		if(curtimestamp - gekauft < bizWaitTime) then
			guiSetEnabled(Knopf1, false)
			guiSetText(Label, "Bizname: "..tostring(getElementData(theBiz, "biz.name")).."\nOwner: "..tostring(getElementData(theBiz, "biz.besitzer")).."\nPrice: "..tostring(getElementData(theBiz, "biz.preis")).." pears\nEarn: "..tostring(getElementData(theBiz, "biz.einkommen")).." pears\nBuyable: No")
		else
			guiSetText(Label, "Bizname: "..tostring(getElementData(theBiz, "biz.name")).."\nOwner: "..tostring(getElementData(theBiz, "biz.besitzer")).."\nPrice: "..tostring(getElementData(theBiz, "biz.preis")).." pears\nEarn: "..tostring(getElementData(theBiz, "biz.einkommen")).." pears\nBuyable: Yes")
		end		
		if(besitzer == "niemand") then
			guiSetEnabled(Knopf2, false)
		else
			guiSetEnabled(Knopf1, false)
			if(getPlayerName(gMe) == besitzer) then
				
			else
				guiSetEnabled(Knopf2, false)
			end
		end
	end
	reloadKnoepfe()
	
	addEventHandler("onClientGUIClick", Knopf2, function()
		local preis = tonumber(getElementData(theBiz, "biz.preis"))
		triggerServerEvent("onMultistuntBizSell", gMe, theBiz, preis)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf1, function()
		local mybirnen = tonumber(getPlayerItem(gMe, "ms.birnen"))
		local preis = tonumber(getElementData(theBiz, "biz.preis"))
		if(mybirnen < preis) then
			outputChatBox("You don't have enought pears! You need "..preis-mybirnen.."  more pears!", 255, 0, 0)
			return
		end
		triggerServerEvent("onMultistuntBizBuy", gMe, theBiz, preis)
	end, false)
	addEventHandler("onClientGUIClick", Knopf3, function()
		destroyElement(Fenster)
		Guivar = 0
		setGuiState(0)
		showCursor(false)
	end, false)
end)

addEventHandler("onMultistuntBizGuiRefresh", getRootElement(), function(theBiz)
	if not(Fenster) then return end
		local besitzer = getElementData(theBiz, "biz.besitzer")
		local gekauft = getElementData(theBiz, "biz.gekauft")
		local curtimestamp = getRealTime().timestamp
		if(curtimestamp - gekauft < bizWaitTime) then
			guiSetEnabled(Knopf1, false)
			guiSetText(Label, "Bizname: "..tostring(getElementData(theBiz, "biz.name")).."\nOwner: "..tostring(getElementData(theBiz, "biz.besitzer")).."\nPrice: "..tostring(getElementData(theBiz, "biz.preis")).." pears\nEarn: "..tostring(getElementData(theBiz, "biz.einkommen")).." pears\nBuyable: No")
		else
			guiSetText(Label, "Bizname: "..tostring(getElementData(theBiz, "biz.name")).."\nOwner: "..tostring(getElementData(theBiz, "biz.besitzer")).."\nPrice: "..tostring(getElementData(theBiz, "biz.preis")).." pears\nEarn: "..tostring(getElementData(theBiz, "biz.einkommen")).." pears\nBuyable: Yes")
		end		
		if(besitzer == "niemand") then
			guiSetEnabled(Knopf2, false)
		else
			guiSetEnabled(Knopf1, false)
			if(getPlayerName(gMe) == besitzer) then
				
			else
				guiSetEnabled(Knopf2, false)
			end
		end
end)
