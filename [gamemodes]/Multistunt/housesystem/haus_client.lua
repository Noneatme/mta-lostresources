-- HAUS SYSTEM BEI MULTI! --
-- C 2012 --
-- PLEASE DONT REMOVE CREDITS! --
-- AND DONT COPY ANYTHING WITHOUT PERMISSIONS --

local Guivar = 0
local gMe = getLocalPlayer()
houseTable = {} 

for a = 1, 26, 1 do
houseTable[a] = {}
end

local hX, hY, hZ
local backvar = 0

houseTable[1]["INT"], houseTable[1]["X"], houseTable[1]["Y"], houseTable[1]["Z"] = 3, 2496.02, -1692.10, 1014.74
houseTable[2]["INT"], houseTable[2]["X"], houseTable[2]["Y"], houseTable[2]["Z"] = 1, 223.22, 1287.27, 1082.14
houseTable[3]["INT"], houseTable[3]["X"], houseTable[3]["Y"], houseTable[3]["Z"] = 4, 260.98, 1284.55, 1080.25
houseTable[4]["INT"], houseTable[4]["X"], houseTable[4]["Y"], houseTable[4]["Z"] = 5, 140.21, 1366.91, 1083.85
houseTable[5]["INT"], houseTable[5]["X"], houseTable[5]["Y"], houseTable[5]["Z"] = 9, 82.94, 1322.44, 1083.86
houseTable[6]["INT"], houseTable[6]["X"], houseTable[6]["Y"], houseTable[6]["Z"] = 15, -283.85, 1470.96, 1084.375
houseTable[7]["INT"], houseTable[7]["X"], houseTable[7]["Y"], houseTable[7]["Z"] = 4, -260.60, 1456.62, 1084.37
houseTable[8]["INT"], houseTable[8]["X"], houseTable[8]["Y"], houseTable[8]["Z"] = 8, -42.78, 1405.75, 1084.43
houseTable[9]["INT"], houseTable[9]["X"], houseTable[9]["Y"], houseTable[9]["Z"] = 6, -68.69, 1351.97, 1080.21
houseTable[10]["INT"], houseTable[10]["X"], houseTable[10]["Y"], houseTable[10]["Z"] = 6, 2333.05, -1077.14, 1049.02
houseTable[11]["INT"], houseTable[11]["X"], houseTable[11]["Y"], houseTable[11]["Z"] = 5, 2233.77, -1115.03, 1050.88
houseTable[12]["INT"], houseTable[12]["X"], houseTable[12]["Y"], houseTable[12]["Z"] = 8, 2365.30, -1134.92, 1050.875
houseTable[13]["INT"], houseTable[13]["X"], houseTable[13]["Y"], houseTable[13]["Z"] = 11, 2282.91, -1140.29, 1050.90
houseTable[14]["INT"], houseTable[14]["X"], houseTable[14]["Y"], houseTable[14]["Z"] = 6, 2196.79, -1204.35, 1049.02
houseTable[15]["INT"], houseTable[15]["X"], houseTable[15]["Y"], houseTable[15]["Z"] = 10, 2270.38, -1210.45, 1047.56
houseTable[16]["INT"], houseTable[16]["X"], houseTable[16]["Y"], houseTable[16]["Z"] = 6, 2308.79, -1212.88, 1049.02
houseTable[17]["INT"], houseTable[17]["X"], houseTable[17]["Y"], houseTable[17]["Z"] = 1, 2218.39, -1076.25, 1050.48
houseTable[18]["INT"], houseTable[18]["X"], houseTable[18]["Y"], houseTable[18]["Z"] = 2, 2237.52, -1081.64, 1049.02
houseTable[19]["INT"], houseTable[19]["X"], houseTable[19]["Y"], houseTable[19]["Z"] = 9, 2317.84, -1026.76, 1050.21
houseTable[20]["INT"], houseTable[20]["X"], houseTable[20]["Y"], houseTable[20]["Z"] = 5, 318.60, 1114.48, 1083.88
houseTable[21]["INT"], houseTable[21]["X"], houseTable[21]["Y"], houseTable[21]["Z"] = 5, 1298.85, -797.01, 1084.01
houseTable[22]["INT"], houseTable[22]["X"], houseTable[22]["Y"], houseTable[22]["Z"] = 1, -794.99, 489.29, 1376.20
houseTable[23]["INT"], houseTable[23]["X"], houseTable[23]["Y"], houseTable[23]["Z"] = 18, 1727.04, -1637.84, 20.22
houseTable[24]["INT"], houseTable[24]["X"], houseTable[24]["Y"], houseTable[24]["Z"] = 18, -31.03515625, -91.6103515625, 1003.546875
houseTable[25]["INT"], houseTable[25]["X"], houseTable[25]["Y"], houseTable[25]["Z"] = 6, -26.689453125, -57.8095703125, 1003.546875
houseTable[26]["INT"], houseTable[26]["X"], houseTable[26]["Y"], houseTable[26]["Z"] = 15, 2215.04296875, -1150.5546875, 1025.796875
local Guivar2 = 0
function createHausMenue(col)
	if(Guivar2 == 1) then return end
	Guivar2 = 1
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")

	local HAFenster = {}
	local HAKnopf = {}
	local HALabel = {}
	local HAEdit = {}
	local HAGrid = {}

			local sWidth, sHeight = guiGetScreenSize()
		 
			local Width,Height = 486,157
			local X = (sWidth/2) - (Width/2)
			local Y = (sHeight/2) - (Height/2)

	HAFenster[1] = guiCreateWindow(X, Y, Width, Height, "Hausmenue",false)
	HALabel[1] = guiCreateLabel(35,54,205,14,"Hauskasse: Bitte Warten...",false,HAFenster[1])
	guiSetFont(HALabel[1],"default-bold-small")
	HALabel[2] = guiCreateLabel(206,22,78,19,"Mieter:",false,HAFenster[1])
	guiSetFont(HALabel[2],"default-bold-small")
	HALabel[3] = guiCreateLabel(205,28,91,15,"_____________",false,HAFenster[1])
	guiLabelSetColor(HALabel[3],0, 255, 255)
	guiSetFont(HALabel[3],"default-bold-small")
	HAEdit[1] = guiCreateEdit(58,73,98,20,"",false,HAFenster[1])
	HALabel[4] = guiCreateLabel(9,73,43,17,"Anzahl:",false,HAFenster[1])
	guiSetFont(HALabel[4],"default-bold-small")
	HAKnopf[1] = guiCreateButton(58,98,102,26,"Einzahlen",false,HAFenster[1])
	HAKnopf[2] = guiCreateButton(57,124,102,26,"Auszahlen",false,HAFenster[1])
	HAGrid[1] = guiCreateGridList(203,49,172,100,false,HAFenster[1])
	guiGridListSetSelectionMode(HAGrid[1],1)

	guiGridListAddColumn(HAGrid[1],"Spieler",0.8)
	HALabel[5] = guiCreateLabel(8,21,78,19,"Hauskasse:",false,HAFenster[1])
	guiSetFont(HALabel[5],"default-bold-small")
	HALabel[6] = guiCreateLabel(7,27,91,15,"_____________",false,HAFenster[1])
	guiLabelSetColor(HALabel[6],0,255,255)
	guiSetFont(HALabel[6],"default-bold-small")
	HAKnopf[3] = guiCreateButton(302,20,68,26,"Abbrechen",false,HAFenster[1])
	HAKnopf[4] = guiCreateButton(390,63,79,25,"Essen",false,HAFenster[1])
	HAKnopf[5] = guiCreateButton(390,98,79,25,"Heilen",false,HAFenster[1])

	if(getElementData(col, "HBESITZER") == getPlayerName(gMe)) then
		triggerServerEvent("onHouseDataNeed", gMe, getElementData(gMe, "HOUSECOL"))
	else
		guiSetEnabled(HAKnopf[1], false)
		guiSetEnabled(HAKnopf[2], false)
		guiSetText(HALabel[1], "Hauskasse: Nicht oeffentlich")
	end
	if(getElementData(col, "HBESITZER") == getPlayerName(gMe)) then
	
	else
		local mieter = getElementData(col, "HMIETER")
		local me = getPlayerName(gMe)
		local mieter1 = gettok(mieter, 1, "|")
		local mieter2 = gettok(mieter, 2, "|")
		local mieter3 = gettok(mieter, 3, "|")
		local mieter4 = gettok(mieter, 4, "|")
		local mieter5 = gettok(mieter, 5, "|")
		if(mieter1 == me) or (mieter2 == me) or (mieter3 == me) or (mieter4 == me) or (mieter5 == me) then
		
		else
			guiSetEnabled(HAKnopf[4], false)
			guiSetEnabled(HAKnopf[5], false)
		end
	end
	addEventHandler("onClientGUIClick", HAKnopf[4],
	function()
		setPedAnimation(gMe, "food", "EAT_Burger",1,true,false,true)
		triggerEvent("setPlayerHunger", gMe, "Full")
	end, false)
	
	addEventHandler("onClientGUIClick", HAKnopf[5],
	function()
		if(getElementHealth(gMe) > 99) then return end
		setElementHealth(gMe, getElementHealth(gMe)+10)
		setPedAnimation(gMe, "food", "EAT_Burger",1,true,false,true)
	end, false)
	
	addEvent("onHouseDataNeedBack", true)
	addEventHandler("onHouseDataNeedBack", getRootElement(),
	function(dollar)
		guiSetText(HALabel[1], "Hauskasse: "..dollar.." Birnen")
	end)
	addEventHandler("onClientGUIClick", HAKnopf[3],
	function()
		Guivar2 = 0
		showCursor(false)
		guiSetVisible(HAFenster[1], false)
	end, false)
	addEventHandler("onClientGUIClick", HAKnopf[2],
	function()
		local text = tonumber(guiGetText(HAEdit[1]))
		if(text == nil) then outputChatBox("Ungueltige Anzahl!", 200, 0, 0, false) return end
		triggerServerEvent("onHouseSysAuszahl", gMe, getElementData(gMe, "HOUSECOL"), text)
	end, false)
	addEventHandler("onClientGUIClick", HAKnopf[1],
	function()
		local text = tonumber(guiGetText(HAEdit[1]))
		if(text == nil) then outputChatBox("Ungueltige Anzahl!", 200, 0, 0, false) return end
		if(tonumber(getElementData(gMe, "ms.birnen")) < text) then outputChatBox("Du hast nicht soviel Geld!", 200, 0, 0, false) return end
		if(text < 0) then outputChatBox("Du kannst keine Negativen Zahlen auszahlen!", 200, 0, 0, false) return end
		triggerServerEvent("onHouseSysEinzahl", gMe, getElementData(gMe, "HOUSECOL"), text)
	end, false)
end

bindKey("F5", "down",
function()
		for index, col in pairs(getElementsByType("colshape")) do
			if(isElementWithinColShape(gMe, col) == true) then
				if(getElementData(col, "HAUSCOL") == true) then
					if(getElementDimension(col) == getElementDimension(gMe)) then
					setElementData(gMe, "HOUSECOL", getElementData(col, "HID"))
					createHausMenue(col)
					end
					
			end
		end
	end
end)
		
function createHausErstellenGui()
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	local HAUSFenster = {}
	local HAUSKnopf = {}
	local HAUSLabel = {}
	local HAUSEdit = {}
	local HAUSGrid = {}

		local sWidth, sHeight = guiGetScreenSize()
	 
		local Width,Height = 691,253
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)

	HAUSFenster[1] = guiCreateWindow(X, Y, Width, Height, "Create a Haus",false)
	HAUSKnopf[1] = guiCreateButton(17,216,84,24,"Abbrechen",false,HAUSFenster[1])
	HAUSKnopf[2] = guiCreateButton(249,217,84,24,"Haus erstellen",false,HAUSFenster[1])
	HAUSLabel[1] = guiCreateLabel(10,29,53,16,"X, Y, Z:",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[1],"default-bold-small")
	HAUSEdit[1] = guiCreateEdit(10,47,122,23,"x",false,HAUSFenster[1])
	HAUSEdit[2] = guiCreateEdit(10,73,122,23,"y",false,HAUSFenster[1])
	HAUSEdit[3] = guiCreateEdit(10,98,122,23,"z",false,HAUSFenster[1])
	HAUSKnopf[3] = guiCreateButton(24,128,97,29,"Meine Position",false,HAUSFenster[1])
	HAUSLabel[2] = guiCreateLabel(226,33,82,19,"Interior:",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[2],"default-bold-small")
	HAUSEdit[4] = guiCreateEdit(224,50,56,19,"int",false,HAUSFenster[1])
	HAUSLabel[3] = guiCreateLabel(227,71,56,23,"INT X, Y, Z:",false,HAUSFenster[1])
	HAUSEdit[5] = guiCreateEdit(224,88,122,23,"xi",false,HAUSFenster[1])
	HAUSEdit[6] = guiCreateEdit(224,114,122,23,"yi",false,HAUSFenster[1])
	HAUSEdit[7] = guiCreateEdit(225,139,122,23,"zi",false,HAUSFenster[1])
	HAUSLabel[4] = guiCreateLabel(227,167,80,25,"Preis:",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[4],"default-bold-small")
	HAUSEdit[8] = guiCreateEdit(226,191,122,23,"preis",false,HAUSFenster[1])
	guiEditSetMaxLength(HAUSEdit[8],9999)
	HAUSLabel[5] = guiCreateLabel(354,195,23,19," Birnen",false,HAUSFenster[1])
	HAUSLabel[6] = guiCreateLabel(7,168,217,17,"Typ: (0 = Klein, 1 = Normal, 2 = Gross)",false,HAUSFenster[1])
	guiSetFont(HAUSLabel[6],"default-bold-small")
	HAUSEdit[9] = guiCreateEdit(32,188,122,23,"",false,HAUSFenster[1])
	guiEditSetMaxLength(HAUSEdit[9],1)
	HAUSGrid[1] = guiCreateGridList(364,24,318,220,false,HAUSFenster[1])
	guiGridListSetSelectionMode(HAUSGrid[1],1)
	guiGridListAddColumn(HAUSGrid[1],"POS",0.2)

	guiGridListAddColumn(HAUSGrid[1],"INT",0.2)

	guiGridListAddColumn(HAUSGrid[1],"X",0.2)

	guiGridListAddColumn(HAUSGrid[1],"Y",0.2)

	guiGridListAddColumn(HAUSGrid[1],"Z",0.2)
	HAUSKnopf[4] = guiCreateButton(294,40,65,26,"Select ->",false,HAUSFenster[1])
	HAUSKnopf[5] = guiCreateButton(470,209,65,26,"INT Testen",false,HAUSFenster[1])
	addEventHandler("onClientGUIClick", HAUSGrid[1],
	function()
		guiBringToFront(HAUSKnopf[5])
	end, false)
	addEventHandler("onClientGUIClick", HAUSKnopf[5],
	function()
		if(getElementInterior(gMe) == 0) then backvar = 1 local x, y, z = getElementPosition(gMe) hX, hY, hZ = x, y, z end
		local int = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]), 2)
		local x = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]), 3)
		local y = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]), 4)
		local z = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]), 5)
		if(int == "") or (int == " ") then return end
		triggerServerEvent("onHouseCreatePos", gMe, x, y, z, int)
	end, false)
	local hvar = 0
	for a = 1, 26, 1 do
		local row = guiGridListAddRow(HAUSGrid[1])
		hvar = hvar+1
		guiGridListSetItemText(HAUSGrid[1], row, 1, hvar, false, false)
		guiGridListSetItemText(HAUSGrid[1], row, 2, houseTable[hvar]["INT"], false, false)
		guiGridListSetItemText(HAUSGrid[1], row, 3, houseTable[hvar]["X"], false, false)
		guiGridListSetItemText(HAUSGrid[1], row, 4, houseTable[hvar]["Y"], false, false)
		guiGridListSetItemText(HAUSGrid[1], row, 5, houseTable[hvar]["Z"], false, false)
	end
	addEventHandler("onClientGUIClick", HAUSKnopf[4],
	function()
		local int = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]),2)
		local x = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]), 3)
		local y = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]), 4)
		local z = guiGridListGetItemText(HAUSGrid[1], guiGridListGetSelectedItem(HAUSGrid[1]), 5)
		if(int == "") or (int == " ") then return end
		guiSetText(HAUSEdit[4], int)
		guiSetText(HAUSEdit[5], x)
		guiSetText(HAUSEdit[6], y)
		guiSetText(HAUSEdit[7], z)
	end, false)
	
	addEventHandler("onClientGUIClick", HAUSKnopf[2],
	function()
		local x, y, z, int, intx, inty, intz, preis, typ = tonumber(guiGetText(HAUSEdit[1])), tonumber(guiGetText(HAUSEdit[2])), tonumber(guiGetText(HAUSEdit[3])), tonumber(guiGetText(HAUSEdit[4])), tonumber(guiGetText(HAUSEdit[5])), tonumber(guiGetText(HAUSEdit[6])), tonumber(guiGetText(HAUSEdit[7])), tonumber(guiGetText(HAUSEdit[8])), tonumber(guiGetText(HAUSEdit[9]))
		if(typ < 0) or (typ > 2) then return end
		triggerServerEvent("onHausSystemCreateHaus", gMe, x, y, z, int, intx, inty, intz, preis, typ)
	end, false)
	
	
	addEventHandler("onClientGUIClick", HAUSKnopf[3],
	function()
		local x, y, z = getElementPosition(gMe)
		guiSetText(HAUSEdit[1], x)
		guiSetText(HAUSEdit[2], y)
		guiSetText(HAUSEdit[3], z)
	end, false)
	
	addEventHandler("onClientGUIClick", HAUSKnopf[1],
	function()
		Guivar = 0
		destroyElement(HAUSFenster[1])
		showCursor(false)
		setGuiState(0)
	end, false)

end

addCommandHandler("back", 
function()
	if(backvar == 0) then return end
	triggerServerEvent("onMultistuntHouseBack", gMe, hX, hY, hZ)
end)

addCommandHandler("createhaus", 
function()
	if(tonumber(getElementData(gMe, "ms.adminlevel")) > 3) then
		createHausErstellenGui()
	end
end)




addEventHandler( 'onClientRender', root, function()
if(isPlayerEingeloggt(gMe) == false) then return end
	for i, v in pairs( getElementsByType( 'colshape', getRootElement(), true )) do
	if getElementData( v, "HAUS")  == true then

      local x, y, z = getElementPosition( v );
      local cx, cy, cz = getCameraMatrix();
      if isLineOfSightClear( cx, cy, cz, x, y, z, true, false, false, false, false, false, false, v ) then
				local distance = getDistanceBetweenElements(gMe, v)
				if(distance > 50) then return end
				sx, sy = getScreenFromWorldPosition ( x, y, z, 800, true )
				sx2, sy2 = getScreenFromWorldPosition ( x, y, z+0.3, 800, true )
				local width, height = 64-distance, 64-distance
				local fontbig = 1-(distance/50)
				if(sx) and (sy) then else return end
				local miettext = "N/A"
				local mieter = getElementData(v, "HMIETER")
				local mieter1 = gettok(mieter, 1, "|")
				local mieter2 = gettok(mieter, 2, "|")
				local mieter3 = gettok(mieter, 3, "|")
				local mieter4 = gettok(mieter, 4, "|")
				local mieter5 = gettok(mieter, 5, "|")
				if not(mieter1) or not(mieter2) or not(mieter3) or not(mieter4) or not (mieter5) then return end
				if(mieter1 ~= "-") then miettext = mieter1 end
				
				if(mieter2 ~= "-") then miettext = miettext..", "..mieter2 end
				
				if(mieter3 ~= "-") then miettext = miettext..", "..mieter3 end
			
				if(mieter4 ~= "-") then miettext = miettext..", "..mieter4 end
				
				if(mieter5 ~= "-") then miettext = miettext..", "..mieter5 end
				
				local abgeschlossen
				if(tonumber(getElementData(v, "HLOCKED")) == 0) then abgeschlossen = "Nein" else abgeschlossen = "Ja" end
				local mietend 
				if(tonumber(getElementData(v, "HMIETEND")) == 0) then mietend = "Nein" else mietend = "Ja" end
				local id = getElementData(v, "HID")
				dxDrawText( "Haus(ID "..id..") im Besitz von:\n"..getElementData(v, "HBESITZER").."\nPreis: "..tonumber(getElementData(v, "HPREIS")).." Birnen\nMieter: "..miettext.."\nAbgeschlossen: "..abgeschlossen.."\nZu Vermieten: "..mietend.."\nMietpreis: "..tonumber(getElementData(v, "HMIETPREIS")).." Birnen", sx2, sy2, sx2, sy2, tocolor( 255, 255, 255, 233 ), fontbig, "default-bold", 'center', 'center', false, false )

			  end
    end
  end
end )
