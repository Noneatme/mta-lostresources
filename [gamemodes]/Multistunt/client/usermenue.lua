local Guivar = 0

local Fenster = {}
local TabPanel = {}
local Tab = {}
local Knopf = {}
local Memo = {}
local Checkbox = {}
local Label = {}
local Edit = {}
local Grid = {}
local Radio = {}
local Bild = {}

local buttonAktionen = {
	[1] = "Nothing",
	[2] = "Speedboost",
	[3] = "Nitro",
	[4] = "Repair",
	[5] = "Jump",
	[6] = "Spin",
	[7] = "Flip"
}
	
function createUserMenueGui()
	if(Guivar == 1) then return end
	Guivar = 1
	guiSetInputMode("no_binds_when_editing")
	setGuiState(1)
	showCursor(true)
	

	local X, Y, Width, Height = getMiddleGuiPosition(506,328)
	Fenster[1] = guiCreateWindow(X, Y, Width, Height, "Usermenue",false)
	TabPanel[1] = guiCreateTabPanel(11,22,486,297,false,Fenster[1])
	Tab[1] = guiCreateTab("Announcements",TabPanel[1])
	Memo[1] = guiCreateMemo(6,6,473,212,"",false,Tab[1])
	guiMemoSetReadOnly(Memo[1], true)
	if(getPlayerAdminlevel(gMe) > 2) then
		Knopf[1] = guiCreateButton(7,225,102,30,"Edit",false,Tab[1])
		Knopf[2] = guiCreateButton(119,225,102,30,"Discard",false,Tab[1])
		addEventHandler("onClientGUIClick", Knopf[1], function()
			if(guiGetText(Knopf[1]) == "Edit") then
				guiSetText(Knopf[1], "Save")
				guiMemoSetReadOnly(Memo[1], false)
			elseif(guiGetText(Knopf[1]) == "Save") then
				guiSetText(Knopf[1], "Edit")
				guiMemoSetReadOnly(Memo[1], true)
				local text = guiGetText(Memo[1])
				triggerServerEvent("onUsermenueAnkuendigungenChange", gMe, text)
			end
		
		end, false)
		addEventHandler("onClientGUIClick", Knopf[2], function()
			if(guiGetText(Knopf[1]) == "Edit") then return end
			guiSetText(Knopf[1], "Edit")
			guiMemoSetReadOnly(Memo[1], true)
			triggerServerEvent("onUsermenueDataNeed", gMe)
		end, false)
	end
	local playtime = getElementData(gMe, "ms.playtime")
	local tode = tonumber(getElementData(gMe, "ms.tode"))
	local aepfel = tonumber(getElementData(gMe, "ms.aepfel"))
	local birnen = tonumber(getElementData(gMe, "ms.birnen"))
	local bananen = tonumber(getElementData(gMe, "ms.bananen"))
	local kirschen = tonumber(getElementData(gMe, "ms.kirschen"))
	local skinid = getElementModel(gMe)
	local adminlevel = getPlayerAdminlevel(gMe)
	if not(playtime) then playtime = "N/A" end
	if not(tode) then tode = "N/A" end
	if not(aepfel) then aepfel = "N/A" end
	if not(birnen) then birnen = "N/A" end
	if not(bananen) then bananen = "N/A" end
	if not(kirschen) then kirschen = "N/A" end
	if not(skinid) then skinid = "N/A" end
	if not(adminlevel) then adminlevel = "N/A" end
	Tab[2] = guiCreateTab("Statistics",TabPanel[1])
	Label[1] = guiCreateLabel(7,6,276,17,"Statistics for Player "..getPlayerName(gMe)..":",false,Tab[2])
	guiSetFont(Label[1],"default-bold-small")
	Label[2] = guiCreateLabel(7,10,195,17,"______________________________",false,Tab[2])
	guiLabelSetColor(Label[2],0 ,255, 255)
	guiSetFont(Label[2],"default-bold-small")
	Label[3] = guiCreateLabel(11,33,156,15,"Playtime: "..playtime,false,Tab[2])
	guiSetFont(Label[3],"default-bold-small")
	Label[4] = guiCreateLabel(11,48,196,16,"Registration Date: n/a",false,Tab[2])
	guiSetFont(Label[4],"default-bold-small")
	Label[5] = guiCreateLabel(11,64,196,16,"Deaths: "..tode,false,Tab[2])
	guiSetFont(Label[5],"default-bold-small")
	Label[6] = guiCreateLabel(11,80,196,16,"Apples: "..aepfel,false,Tab[2])
	guiSetFont(Label[6],"default-bold-small")
	Label[7] = guiCreateLabel(11,96,196,16,"Pears: "..birnen,false,Tab[2])
	guiSetFont(Label[7],"default-bold-small")
	Label[8] = guiCreateLabel(11,112,196,16,"Bananas: "..bananen,false,Tab[2])
	guiSetFont(Label[8],"default-bold-small")
	Label[9] = guiCreateLabel(11,128,196,16,"Cherrys: "..kirschen,false,Tab[2])
	guiSetFont(Label[9],"default-bold-small")
	Label[10] = guiCreateLabel(11,144,196,16,"SkinID: "..skinid,false,Tab[2])
	guiSetFont(Label[10],"default-bold-small")
	Label[11] = guiCreateLabel(11,160,196,16,"Adminlevel: "..adminlevel,false,Tab[2])
	guiSetFont(Label[11],"default-bold-small")
	Grid[1] = guiCreateGridList(294,33,172,229,false,Tab[2])
	guiGridListSetSelectionMode(Grid[1],1)

	guiGridListAddColumn(Grid[1],"Spieler",0.6)
	for index, player in pairs(getElementsByType("player")) do
		guiGridListSetItemText(Grid[1], guiGridListAddRow(Grid[1]), 1, getPlayerName(player), false, false)
	end
	Label[12] = guiCreateLabel(283,10,153,13,"Or choose a player:",false,Tab[2])
	guiSetFont(Label[12],"default-bold-small")
	Tab[3] = guiCreateTab("Settings",TabPanel[1])
	Label[13] = guiCreateLabel(13,13,66,15,"__________",false,Tab[3])
	guiLabelSetColor(Label[13],0, 255, 255)
	guiSetFont(Label[13],"default-bold-small")
	Label[14] = guiCreateLabel(13,9,66,15,"Settings:",false,Tab[3])
	guiSetFont(Label[14],"default-bold-small")
	Checkbox[1] = guiCreateCheckBox(19,38,124,18,"Godmode",false,false,Tab[3])
	guiSetFont(Checkbox[1],"default-bold-small")
	Checkbox[2] = guiCreateCheckBox(19,61,124,18,"Speedboost",false,false,Tab[3])
	guiSetFont(Checkbox[2],"default-bold-small")
	Label[15] = guiCreateLabel(115,61,79,19,"Value:(0-50)",false,Tab[3])
	guiSetFont(Label[15],"default-bold-small")
	Edit[1] = guiCreateEdit(200,60,87,20,getPlayerSetting(gMe, "speedboostfaktor"),false,Tab[3])
	Checkbox[3] = guiCreateCheckBox(19,86,124,18,"Auto Login",false,false,Tab[3])
	guiSetFont(Checkbox[3],"default-bold-small")
	Checkbox[4] = guiCreateCheckBox(19,109,124,18,"Show fruitbar",false,false,Tab[3])
	guiSetFont(Checkbox[4],"default-bold-small")
	Checkbox[5] = guiCreateCheckBox(19,133,132,18,"Vehicle-Godmode",false,false,Tab[3])
	guiSetFont(Checkbox[5],"default-bold-small")
	Checkbox[6] = guiCreateCheckBox(19,157,132,18,"Radar",false,false,Tab[3])

	guiSetFont(Checkbox[6],"default-bold-small")
	Checkbox[7] = guiCreateCheckBox(19,180,132,18,"Show hud",false,false,Tab[3])

	guiSetFont(Checkbox[7],"default-bold-small")
	Checkbox[8] = guiCreateCheckBox(19,203,132,18,"Show chat",false,false,Tab[3])

	guiSetFont(Checkbox[8],"default-bold-small")
	Checkbox[9] = guiCreateCheckBox(19,227,132,18,"Show Nametags",false,false,Tab[3])

	guiSetFont(Checkbox[9],"default-bold-small")
	Checkbox[10] = guiCreateCheckBox(194,33,132,18,"Realtime-Time",false,false,Tab[3])

	guiSetFont(Checkbox[10],"default-bold-small")
	triggerServerEvent("onUsermenueDataNeed", gMe)
	if(tonumber(getPlayerSetting(gMe, "godmode")) == 1) then
		guiCheckBoxSetSelected(Checkbox[1], true)
	end
	if(tonumber(getPlayerSetting(gMe, "speedboost")) == 1) then
		guiCheckBoxSetSelected(Checkbox[2], true)
	end
	if(tonumber(getPlayerSetting(gMe, "obstbar")) == 1) then
		guiCheckBoxSetSelected(Checkbox[4], true)
	end
	if(tonumber(getPlayerSetting(gMe, "fgodmode")) == 1) then
		guiCheckBoxSetSelected(Checkbox[5], true)
	end
	if(tonumber(getPlayerSetting(gMe, "radar")) == 1) then
		guiCheckBoxSetSelected(Checkbox[6], true)
	end
	if(tonumber(getPlayerSetting(gMe, "hud")) == 1) then
		guiCheckBoxSetSelected(Checkbox[7], true)
	end
	if(tonumber(getPlayerSetting(gMe, "chat")) == 1) then
		guiCheckBoxSetSelected(Checkbox[8], true)
	end
	if(tonumber(getPlayerSetting(gMe, "nametags")) == 1) then
		guiCheckBoxSetSelected(Checkbox[9], true)
	end
	if(tonumber(getPlayerSetting(gMe, "realtime")) == 1) then
		guiCheckBoxSetSelected(Checkbox[10], true)
	end
	Grid[2] = guiCreateGridList(310,86,150,170,false,Tab[3])
	guiGridListSetSelectionMode(Grid[2],1)

	guiGridListAddColumn(Grid[2],"Action",0.6)

	guiGridListAddColumn(Grid[2],"ID",0.2)
	Label[16] = guiCreateLabel(174,110,103,20,"Buttonmanagement:",false,Tab[3])
	guiSetFont(Label[16],"default-bold-small")
	Radio[1] = guiCreateRadioButton(175,134,125,17,"Left mouse button",false,Tab[3])
	guiSetFont(Radio[1],"default-bold-small")
	Radio[2] = guiCreateRadioButton(175,151,125,17,"Right mouse button",false,Tab[3])
	guiSetFont(Radio[2],"default-bold-small")
	Knopf[3] = guiCreateButton(334,9,118,23,"Freecam",false, Tab[3])
	Knopf[4] = guiCreateButton(333,37,118,23,"Stop freecam",false, Tab[3])
	
	addEventHandler("onClientGUIClick", Knopf[3], function()
		if(isFreecamEnabled()) then return end
		setFreecamEnabled()
		sendInfoMessage("Freecam enabled!", "green")
		setElementFrozen(gMe, true)
	end, false)
	
	addEventHandler("onClientGUIClick", Knopf[4], function()
		if(isFreecamEnabled() == true) then
			setFreecamDisabled()
			sendInfoMessage("Freecam disabled.", "aqua")
			setElementFrozen(gMe, false)
			setCameraTarget(gMe)
		end
	end, false)
	
	for i = 1, #buttonAktionen, 1 do
		local row = guiGridListAddRow(Grid[2])
		guiGridListSetItemText(Grid[2], row, 1, buttonAktionen[i], false, false)
		guiGridListSetItemText(Grid[2], row, 2, i, false, false)
	end
	addEventHandler("onClientGUIClick", Grid[2], function()
		local text = guiGridListGetItemText(Grid[2], guiGridListGetSelectedItem(Grid[2]), 1)
		if(text == "") or (text == " ") then return end
		if(guiRadioButtonGetSelected(Radio[1]) == true) then
			setElementData(gMe, "mss.lmb", guiGridListGetItemText(Grid[2], guiGridListGetSelectedItem(Grid[2]), 2))
		elseif(guiRadioButtonGetSelected(Radio[2]) == true) then
			setElementData(gMe, "mss.rmb", guiGridListGetItemText(Grid[2], guiGridListGetSelectedItem(Grid[2]), 2))
		end
		
	end)
	addEventHandler("onClientGUIClick", Radio[1], function()
		local data = getPlayerSetting(gMe, "lmb")
		guiGridListSetSelectedItem(Grid[2], tonumber(data)-1, 2)
	end, false)
	addEventHandler("onClientGUIClick", Radio[2], function()
		local data = getPlayerSetting(gMe, "rmb")
		guiGridListSetSelectedItem(Grid[2], tonumber(data)-1, 2)
	end, false)
	-- TAB 4 --
	Tab[4] = guiCreateTab("Badges",TabPanel[1])
	Grid[3] = guiCreateGridList(9,6,161,256,false,Tab[4])
	
	local curbadge = tonumber(getElementData(gMe, "ms.badge"))
	guiGridListSetSelectionMode(Grid[3],1)
	guiGridListAddColumn(Grid[3],"ID",0.2)
	guiGridListAddColumn(Grid[3],"Name",0.5)
	Label[18] = guiCreateLabel(181,11,140,18,"Current wearing: ID: "..curbadge,false,Tab[4])
	guiSetFont(Label[18],"default-bold-small")
	Bild[1] = guiCreateStaticImage(181,38,127,69,"data/images/player/badges/"..curbadge..".png",false,Tab[4])
	Label[19] = guiCreateLabel(179,117,119,22,"Preview:",false,Tab[4])
	guiSetFont(Label[19],"default-bold-small")
	Label[20] = guiCreateLabel(179,13,134,16,"____________________",false,Tab[4])
	guiLabelSetColor(Label[20],0, 255, 0)
	Label[21] = guiCreateLabel(175,118,134,16,"____________________",false,Tab[4])
	guiLabelSetColor(Label[21],0,255,0)
	Bild[2] = guiCreateStaticImage(180,144,131,77,"data/images/player/badges/0.png",false,Tab[4])
	Knopf[5] = guiCreateButton(331,142,109,31,"Wear badge",false,Tab[4])
	Knopf[6] = guiCreateButton(330,180,109,31,"Clear",false,Tab[4])
	local data = getElementData(gMe, "ms.badges")
	
	for i = 2, max_badges, 1 do
		if(tonumber(gettok(data, i, string.byte("|"))) ~= nil) then
			local row = guiGridListAddRow(Grid[3])
			guiGridListSetItemText(Grid[3], row, 1, tonumber(gettok(data, i, string.byte("|"))), false, false)
			guiGridListSetItemText(Grid[3], row, 2, badge_names[tonumber(gettok(data, i, string.byte("|")))], false, false)
		end
	end
	--[[
	for i = 1, max_badges, 1 do
		local data = getElementData(gMe, "ms.badges")
		outputChatBox(i.." "..tostring(tonumber(gettok(data, i, "|"))))
		if(tonumber(gettok(data, i, "|"))) and (tonumber(gettok(data, i, "|")) == i) then
			local row = guiGridListAddRow(Grid[3])
			guiGridListSetItemText(Grid[3], row, 1, i, false, false)
			guiGridListSetItemText(Grid[3], row, 2, badge_names[i], false, false)
		end
	end
	--]]
	--[[
	local data = getElementData(gMe, "ms.badges")
	for i = 1, max_badges-1, 1 do
		if(gettok(data, i, "|")) and (tonumber(gettok(data, i, "|")) == i) then
			local row = guiGridListAddRow(Grid[3])
			guiGridListSetItemText(Grid[3], row, 1, i, false, false)
			guiGridListSetItemText(Grid[3], row, 2, badge_names[i], false, false)
		else
			while(gettok(data, i, "|") and (tonumber(gettok(data, i, "|")) ~= i-1)) do -- ich verwende nie whileschleifen in LUA da ich Endlosschleifen hasse, also nochmal pruefen
				i = i + 1;
			end
			outputChatBox("False: "..tostring(gettok(data, i, "|")))
		end
	end--]]
	addEventHandler("onClientGUIClick", Grid[3], function()
		local item = guiGridListGetItemText(Grid[3], guiGridListGetSelectedItem(Grid[3]), 1)
		if(item ~= "") then
			guiStaticImageLoadImage(Bild[2], "data/images/player/badges/"..tonumber(item)..".png")
		else
			guiStaticImageLoadImage(Bild[2], "data/images/player/badges/0.png")
		end	
	end, false)
	addEventHandler("onClientGUIClick", Knopf[5], function()
		local id = tonumber(guiGridListGetItemText(Grid[3], guiGridListGetSelectedItem(Grid[3]), 1))
		if not(id) then sendInfoMessage("You must select a badge!", "red") return end
		setElementData(gMe, "ms.badge", id)
		sendInfoMessage("You selected badge "..id.."!", "green")
	end, false)
	addEventHandler("onClientGUIClick", Knopf[6], function()
		local badge = tonumber(getElementData(gMe, "ms.badge"))
		if(badge == 0) then sendInfoMessage("You have no badge already!", "red") return end
		setElementData(gMe, "ms.badge", 0)
		sendInfoMessage("You succesfull cleared your badge!", "green")
	end, false)
end

addEvent("onUsermenueDataNeedBack", true)
addEventHandler("onUsermenueDataNeedBack", getRootElement(), function(text, register)
	if(Guivar == 0) then return end
	guiSetText(Memo[1], text)
	guiSetText(Label[4], "Registrierdatum: "..register)
end)

bindKey("F1", "down", function()
	if(isPlayerEingeloggt(gMe) == false) then return end
	if(Guivar == 0) then
		createUserMenueGui()
	else	
		local ch = {}
		for i = 1, #Checkbox, 1 do
			ch[i] = guiCheckBoxGetSelected(Checkbox[i])
		end
		if(ch[1] == true) then -- godmode
			setElementData(gMe, "mss.godmode", 1)
		else
			setElementData(gMe, "mss.godmode", 0)
		end
		if(ch[2] == true) then
			setElementData(gMe, "mss.speedboost", 1)
		else
			setElementData(gMe, "mss.speedboost", 0)
		end
		
		if(ch[4] == true) then
			setElementData(gMe, "mss.obstbar", 1)
			setObstbarState("on")
		else
			setElementData(gMe, "mss.obstbar", 0)
			setObstbarState("off")
		end
		
		if(ch[5] == true) then
			setElementData(gMe, "mss.fgodmode", 1)
		else
			setElementData(gMe, "mss.fgodmode", 0)
		end
		if(ch[6] == true) then
			setElementData(gMe, "mss.radar", 1)
		else
			setElementData(gMe, "mss.radar", 0)
		end
		if(ch[7] == true) then
			setElementData(gMe, "mss.hud", 1)
		else
			setElementData(gMe, "mss.hud", 0)
		end
		if(ch[8] == true) then
			setElementData(gMe, "mss.chat", 1)
		else
			setElementData(gMe, "mss.chat", 0)
		end
		if(ch[9] == true) then
			setElementData(gMe, "mss.nametags", 1)
		else
			setElementData(gMe, "mss.nametags", 0)
		end
		if(ch[10] == true) then
			setElementData(gMe, "mss.realtime", 1)
		else
			setElementData(gMe, "mss.realtime", 0)
		end
		Guivar = 0
		destroyElement(Fenster[1])
		setGuiState(0)
		showCursor(false)
	end
end)

