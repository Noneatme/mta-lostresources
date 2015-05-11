local Guivar = 0

local LOFenster = {}
local LOTabPanel = {}
local LOTab = {}
local LOKnopf = {}
local LOLabel = {}
local LOEdit = {}
local LORadio = {}
local LOGrid = {}
local LOBild = {}
local LOCheckbox = {}
local regtimer
local var = 0

local logx, logy
local logenabled = false
local sx, sy = guiGetScreenSize()

local function RegisterCam5()
	local time = 15000
	local cx, cy, cz = -1367.8703613281, -230.87857055664, 27.223207473755
	local cpx, cpy, cpz = -1341.7835693359, -193.08999633789, 26.44739151001
	local mx, my, mz = -1273.8870849609, -160.75019836426, 66.499824523926
	local mpx, mpy, mpz = -1298.6859130859, -170.58930969238, 55.297901153564
	smoothMoveCamera(cx, cy, cz, cpx, cpy, cpz, mx, my, mz, mpx, mpy, mpz, time)
end
local function RegisterCam4()
	local time = 15000
	local cx, cy, cz = -1382.2127685547, -194.97300720215, 14.608203887939
	local cpx, cpy, cpz = -1384.3962402344, -200.00028991699, 15.542324066162
	local mx, my, mz = -1367.8703613281, -230.87857055664, 27.223207473755
	local mpx, mpy, mpz = -1341.7835693359, -193.08999633789, 26.44739151001
	smoothMoveCamera(cx, cy, cz, cpx, cpy, cpz, mx, my, mz, mpx, mpy, mpz, time)
	regtimer = setTimer(RegisterCam5, time+500, 1)
end

local function RegisterCam3()
	local time = 10000
	local cx, cy, cz = -1365.5775146484, -162.90522766113, 14.1484375
	local cpx, cpy, cpz = -1370.7231445313, -172.73434448242, 14.1484375
	local mx, my, mz = -1382.2127685547, -194.97300720215, 14.608203887939
	local mpx, mpy, mpz = -1384.3962402344, -200.00028991699, 15.542324066162
	smoothMoveCamera(cx, cy, cz, cpx, cpy, cpz, mx, my, mz, mpx, mpy, mpz, time)
	regtimer = setTimer(RegisterCam4, time+500, 1)
end

local function RegisterCam2()
	local time = 15000
	local cx, cy, cz = -1318.1286621094, -201.91647338867, 38.064167022705
	local cpx, cpy, cpz = -1311.9683837891, -146.56993103027, 32.547946929932
	local mx, my, mz = -1365.5775146484, -162.90522766113, 14.1484375
	local mpx, mpy, mpz = -1370.7231445313, -172.73434448242, 14.1484375
	smoothMoveCamera(cx, cy, cz, cpx, cpy, cpz, mx, my, mz, mpx, mpy, mpz, time)
	regtimer = setTimer(RegisterCam3, time+500, 1)
end
local function RegisterCam1()
	local time = 15000
	local cx, cy, cz = -1401.4956054688, -96.972099304199, 31.413959503174
	local cpx, cpy, cpz = -1364.1003417969, -109.31205749512, 27.005350112915
	local mx, my, mz = -1318.1286621094, -201.91647338867, 38.064167022705
	local mpx, mpy, mpz = -1311.9683837891, -146.56993103027, 32.547946929932
	smoothMoveCamera(cx, cy, cz, cpx, cpy, cpz, mx, my, mz, mpx, mpy, mpz, time)
	regtimer = setTimer(RegisterCam2, time+500, 1)
end

local function startRegisterCam()
	local time = 15000
	local cx, cy, cz = -1292.4255371094, -32.088066101074, 37.304420471191
	local cpx, cpy, cpz = -1291.1051025391, -127.7647857666, 18.832454681396
	local mx, my, mz = -1401.4956054688, -96.972099304199, 31.413959503174
	local mpx, mpy, mpz = -1364.1003417969, -109.31205749512, 27.005350112915
	smoothMoveCamera(cx, cy, cz, cpx, cpy, cpz, mx, my, mz, mpx, mpy, mpz, time)
	regtimer = setTimer(RegisterCam1, time+500, 1)
end

local function removeRegisterCam()
	if(isTimer(regtimer)) then killTimer(regtimer) end
	removeCamHandler ()
end

function createEinloggMenue()
	if(Guivar == 1) then return end
	Guivar = 1
	showCursor(true)
	guiSetInputMode("no_binds_when_editing")


	local X, Y, Width, Height = getMiddleGuiPosition(540,376)
	LOFenster[1] = guiCreateWindow(X, Y, Width, Height,"Welcome to Multistunt!",false)
	LOTabPanel[1] = guiCreateTabPanel(9,22,525,345,false,LOFenster[1])
	LOTab[1] = guiCreateTab("Login",LOTabPanel[1])
	LOBild[1] = guiCreateStaticImage(5,2,507,80,"data/images/logo.png",false,LOTab[1])
	LOLabel[1] = guiCreateLabel(8,87,505,58,"Welcome to Multistunt!\nYour account exist, please log in!\nIf you don't have an account, please choose a other name.\nIf you lost your password, please ask an admin!",false,LOTab[1])
	guiLabelSetHorizontalAlign(LOLabel[1],"center",false)
	guiSetFont(LOLabel[1],"default-bold-small")
	LOLabel[2] = guiCreateLabel(232,182,79,18,"Password:",false,LOTab[1])
	guiSetFont(LOLabel[2],"default-bold-small")
	LOLabel[3] = guiCreateLabel(10,139,507,19,"_____________________________________________________________________________",false,LOTab[1])
	guiLabelSetColor(LOLabel[3],0, 255, 0)
	LOEdit[1] = guiCreateEdit(102,203,333,35,"12345",false,LOTab[1]) -- Login
	guiEditSetMasked(LOEdit[1],true)
	LOKnopf[1] = guiCreateButton(189,244,149,29,"Login",false,LOTab[1])
	LOTab[2] = guiCreateTab("Register",LOTabPanel[1])
	LOBild[2] = guiCreateStaticImage(5,2,509,84,"data/images/logo.png",false,LOTab[2])
	LOLabel[4] = guiCreateLabel(8,86,443,18,"Welcome to Multistunt! You don't have an account, please register one!",false,LOTab[2])
	guiSetFont(LOLabel[4],"default-bold-small")
	LOLabel[5] = guiCreateLabel(22,143,192,16,"Name: "..getPlayerName(gMe),false,LOTab[2])
	guiSetFont(LOLabel[5],"default-bold-small")
	LOLabel[6] = guiCreateLabel(22,167,45,16,"Age:",false,LOTab[2])
	guiSetFont(LOLabel[6],"default-bold-small")
	LOEdit[2] = guiCreateEdit(67,164,52,22,"",false,LOTab[2]) -- Alter
	LOLabel[7] = guiCreateLabel(17,112,321,19,"_____________________________________________",false,LOTab[2])
	guiLabelSetColor(LOLabel[7],0, 255, 255)
	guiSetFont(LOLabel[7],"default-bold-small")
	LOLabel[8] = guiCreateLabel(21,193,99,19,"Password:(2x)",false,LOTab[2])
	guiSetFont(LOLabel[8],"default-bold-small")
	LOEdit[3] = guiCreateEdit(21,212,106,24,"",false,LOTab[2]) -- PW1
	guiEditSetMasked(LOEdit[3],true)
	LOEdit[4] = guiCreateEdit(21,243,106,24,"",false,LOTab[2]) -- PW2
	guiEditSetMasked(LOEdit[4],true)
	LOLabel[9] = guiCreateLabel(181,142,74,16,"Country:",false,LOTab[2])
	guiSetFont(LOLabel[9],"default-bold-small")
	LOGrid[1] = guiCreateGridList(174,159,157,117,false,LOTab[2])
	guiGridListSetSelectionMode(LOGrid[1],1)

	guiGridListAddColumn(LOGrid[1],"Land",0.6)

	local row = guiGridListAddRow(LOGrid[1])
	guiGridListSetItemText(LOGrid[1], row, 1, "Germany", false, false)
	local row = guiGridListAddRow(LOGrid[1])
	guiGridListSetItemText(LOGrid[1], row, 1, "Austria", false, false)
	local row = guiGridListAddRow(LOGrid[1])
	guiGridListSetItemText(LOGrid[1], row, 1, "Switzerland", false, false)
	local row = guiGridListAddRow(LOGrid[1])
	guiGridListSetItemText(LOGrid[1], row, 1, "USA", false, false)
	local row = guiGridListAddRow(LOGrid[1])
	guiGridListSetItemText(LOGrid[1], row, 1, "Australia", false, false)
	local row = guiGridListAddRow(LOGrid[1])
	guiGridListSetItemText(LOGrid[1], row, 1, "France", false, false)
	local row = guiGridListAddRow(LOGrid[1])
	guiGridListSetItemText(LOGrid[1], row, 1, "Other", false, false)
	LOLabel[10] = guiCreateLabel(342,141,89,19,"Sex:",false,LOTab[2])
	guiSetFont(LOLabel[10],"default-bold-small")
	LORadio[1] = guiCreateRadioButton(342,164,112,22,"Male",false,LOTab[2])
	LORadio[2] = guiCreateRadioButton(342,183,112,22,"Female",false,LOTab[2])
	guiRadioButtonSetSelected(LORadio[1],true)
	LOKnopf[2] = guiCreateButton(361,218,127,31,"Register",false,LOTab[2])
	LOKnopf[3] = guiCreateButton(361,253,127,31,"Cancel",false,LOTab[2])
	
	LOCheckbox[1] = guiCreateCheckBox(27,249,106,21,"Auto-Login",false,false,LOTab[1])
	guiSetFont(LOCheckbox[1],"default-bold-small")
	LOCheckbox[2] = guiCreateCheckBox(27,270,129,25,"Save password",false,false,LOTab[1])
	guiSetFont(LOCheckbox[2],"default-bold-small")
	if not(fileExists("register/settings.txt")) then
		local file = fileCreate("register/settings.txt")
		fileWrite(file, "0|0|0")
		fileFlush(file)
		fileClose(file)
	end
	local file = fileOpen("register/settings.txt")
	local text = fileRead(file, 100)
	local autologin = tonumber(gettok(text, 1, "|"))
	if(autologin == 1) then
		triggerServerEvent("onMultistuntRegisterAutologin", gMe)
		guiCheckBoxSetSelected(LOCheckbox[1], true)
	end
	local speichern = tonumber(gettok(text, 2, "|"))
	
	if(speichern == 1) then
		local password = gettok(text, 3, "|")
		guiSetText(LOEdit[1], password)
		guiCheckBoxSetSelected(LOCheckbox[2], true)
	end
	fileClose(file)
	guiSetVisible(LOFenster[1], false)
	startRegisterCam()
	addEventHandler("onClientGUIClick", LOEdit[1],
	function()
		local passwort = guiGetText(LOEdit[1])
		if(passwort == "12345") then guiSetText(LOEdit[1], "") end
	end, false)
	
	addEventHandler("onClientGUIClick", LOKnopf[1],
	function()
		local passwort = guiGetText(LOEdit[1])
		triggerServerEvent("onAccountLogin", gMe, passwort)
		showCursor(false)
		outputChatBox("Please wait...", 0, 255, 255)
		local ch1 = guiCheckBoxGetSelected(LOCheckbox[1])
		local ch2 = guiCheckBoxGetSelected(LOCheckbox[2])
		if(ch1 == true) then -- Auto Login
			local file = fileOpen("register/settings.txt")
			local text = fileRead(file, 100)
			local autologin = tonumber(gettok(text, 1, "|"))
			local speichern = tonumber(gettok(text, 2, "|"))
			local pw = gettok(text, 3, "|")
			fileClose(file)
			fileDelete("register/settings.txt")
			fileCreate("register/settings.txt")
			local file = fileOpen("register/settings.txt")
			fileWrite(file, "1|"..speichern.."|"..pw)
			fileFlush(file)
			fileClose(file)
		end
		
		if(ch2 == true) then -- Speichern
			local file = fileOpen("register/settings.txt")
			local text = fileRead(file, 100)
			local autologin = tonumber(gettok(text, 1, "|"))
			local speichern = tonumber(gettok(text, 2, "|"))
			local pw = guiGetText(LOEdit[1])
			fileClose(file)
			fileDelete("register/settings.txt")
			fileCreate("register/settings.txt")
			local file = fileOpen("register/settings.txt")
			fileWrite(file, autologin.."|1|"..pw)
			fileFlush(file)
			fileClose(file)
		end
	end, false)
	addEvent("onAccountLoginBack", true)
	addEventHandler("onAccountLoginBack", getRootElement(),
	function(sucess)
		if(sucess == true) then
			logenabled = false
			destroyElement(LOFenster[1])
			Guivar = 0
			showCursor(false)
			setTimer(removeRegisterCam, 1000, 1)
			local data = tonumber(getPlayerSetting(gMe, "obstbar"))
			if(data == 1) then
				setObstbarState("on")
			else
				setObstbarState("off")
			end
		else
		
		end
	end)
	addEventHandler("onClientGUIClick", LOKnopf[2],
	function()
		local alter = tonumber(guiGetText(LOEdit[2]))
		local pw1, pw2 = guiGetText(LOEdit[3]), guiGetText(LOEdit[4])
		local maennlich, weiblich = guiRadioButtonGetSelected(LORadio[1]), guiRadioButtonGetSelected(LORadio[2])
		local geschlecht = 0
		if(maennlich == true) then geschlecht = 1
		elseif(weiblich == true) then geschlecht = 2 end
		local land = guiGridListGetItemText(LOGrid[1], guiGridListGetSelectedItem(LOGrid[1]), 1)
		if not(alter) then outputChatBox("Bad age!", 255, 0, 0) return end
		if (alter < 14) or (alter > 99) then outputChatBox("Bad age!", 255, 0, 0) return end
		if(string.len(pw1) < 4) or (string.len(pw1) > 20) then outputChatBox("Your password must be 20 characters long, and minimal 4 characters short!", 255, 0, 0, 0) return end
		if(pw1 == "12345") or (pw1 == "1234") or (pw1 == "123") or (pw1 == "123456") or (pw1 == "1234567") or (pw1 == "12345678") or (pw1 == "Hallo") then outputChatBox("You can't use this password!", 255, 0, 0, false) return end
		if(pw1 ~= pw2) then outputChatBox("The first passwort don't match the second one!", 255, 0, 0, false) return end
		if(land == "") or (land == " ") then outputChatBox("Please choose your country!", 255, 0, 0, false) return end
		local landvar = 0
		if(land == "Germany") then landvar = 1 end
		if(land == "Austria") then landvar = 2 end
		if(land == "Switzerland") then landvar = 3 end
		if(land == "USA") then landvar = 4 end
		if(land == "Australia") then landvar = 5 end
		if(land == "France") then landvar = 6 end
		if(land == "Other") then landvar = 7 end
		if(landvar == 0) then outputChatBox("Error!", 255, 0, 0, false) return end
		triggerServerEvent("onAccountRegister", gMe, alter, pw1, geschlecht, landvar)
		showCursor(false)
		outputChatBox("Please wait...", 0, 255, 255)
	end, false)
	addEvent("showLoginCursor", true)
	addEventHandler("showLoginCursor", getRootElement(), function() showCursor(true) end)
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	createEinloggMenue()
	logenabled = true
	logx, logy = 100, 0
	if(getElementData(gMe, "ms.eingeloggt") ~= true) then
		triggerServerEvent("onLoginDataNeed", gMe)
		addEvent("onLoginDataNeedBack", true)
		addEventHandler("onLoginDataNeedBack", getRootElement(),
		function(rofl)
			guiSetVisible(LOFenster[1], true)
			if(rofl == true) then -- Account gibt es
				guiSetEnabled(LOTab[2], false)
				guiSetSelectedTab(LOTabPanel[1], LOTab[1])
			else -- Account gibt es nicht
				guiSetEnabled(LOTab[1], false)
				guiSetSelectedTab(LOTabPanel[1], LOTab[2])
			end
		end)
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	if(logenabled == true) then
		logx = logx+4
		dxDrawText("Welcome to Multistunt!", sx-logx, sy/2-sy/3, sx, sy, tocolor(0, 255, 0, 200), 1, dxCreateFont("data/fonts/berlin.TTF", 15))	
		if(logx > sx+400) then logx = -100 end
	end
end)