addEvent("onMultistuntPlayerClick", true)

local Guivar = 0

local Fenster = {}
local Knopf = {}
local Memo = {}
local Label = {}
local Bild = {}
	
function createPlayerClickGui()
	if(getGuiState() == 1) then return end
	if(Guivar == 1) then return end
	Guivar = 1
	setGuiState(1)
	local thePlayer = source
	local skin = getElementModel(thePlayer)
	local slogan = getElementData(thePlayer, "mss.slogan")
	if not(slogan) then slogan = "N/A" end
	local sx, sy = guiGetScreenSize()
	Fenster[1] = guiCreateWindow(sx-296,sy-420,296,427,"Playerinfo",false)
	Label[1] = guiCreateLabel(3,23,126,18,getPlayerName(thePlayer),false,Fenster[1])
	guiLabelSetHorizontalAlign(Label[1],"center",false)
	guiSetFont(Label[1],"default-bold-small")
	Bild[1] = guiCreateStaticImage(9,51,115,119,"data/images/skins/unknow.jpg",false,Fenster[1])
	
	if(skin) then
		if(fileExists("data/images/skins/"..skin..".jpg")) then
			guiStaticImageLoadImage(Bild[1], "data/images/skins/"..skin..".jpg")
		else
			guiStaticImageLoadImage(Bild[1], "data/images/skins/unknow.jpg")
		end
	end
	
	Label[2] = guiCreateLabel(11,186,50,17,"Slogan:",false,Fenster[1])
	guiSetFont(Label[2],"default-bold-small")
	Memo[1] = guiCreateMemo(9,205,117,71,slogan,false,Fenster[1])
	if(thePlayer ~= gMe) then
		guiMemoSetReadOnly(Memo[1], true)
	end
	Label[3] = guiCreateLabel(8,162,114,15,"______________________",false,Fenster[1])
	Label[4] = guiCreateLabel(133,23,126,18,"About this player:",false,Fenster[1])
	guiSetFont(Label[4],"default-bold-small")
	Label[5] = guiCreateLabel(7,26,114,16,"_________________",false,Fenster[1])
	Label[6] = guiCreateLabel(121,26,171,16,"________________________",false,Fenster[1])
	Label[7] = guiCreateLabel(10,278,50,17,"Country:",false,Fenster[1])
	guiSetFont(Label[7],"default-bold-small")
	local country = tonumber(getElementData(thePlayer, "ms.country"))
	if not(country) then country = 7 end
	Bild[2] = guiCreateStaticImage(12,297,113,60,"data/images/player/flags/"..country..".jpg",false,Fenster[1])
	
	Label[8] = guiCreateLabel(5,353,289,16,"_______________________________________________",false,Fenster[1])
	Knopf[1] = guiCreateButton(113,385,103,28,"Report",false,Fenster[1])
	Knopf[2] = guiCreateButton(9,385,103,28,"Say hello",false,Fenster[1])
	Knopf[3] = guiCreateButton(217,385,70,29,"Close",false,Fenster[1])
	local addy = 60
	local pic = 0
	-- Rollover
	addMouseRollover(Bild[2], rollover_country_names[country])
	-- custom badge --
	local badge = tonumber(getElementData(thePlayer, "ms.badge"))
	if(badge ~= 0) then
		Bild[2.5] = guiCreateStaticImage(155,53,102,52,"data/images/player/badges/"..badge..".png",false,Fenster[1])
		addMouseRollover(Bild[2.5], badge_names[badge].."\n\n"..badge_description[badge])
	end
	Bild[3] = guiCreateStaticImage(155,53+addy,102,52,"data/images/player/stunter.jpg",false,Fenster[1])
	addMouseRollover(Bild[3], rollover_names["Stunter"])
	addy = addy+60
	if(tonumber(getPlayerItem(thePlayer, "ms.adminlevel")) > 0) then
		Bild[4] = guiCreateStaticImage(155,53+addy,102,52,"data/images/player/staff.png",false,Fenster[1])
		addy = addy+60
		addMouseRollover(Bild[4], rollover_names["Admin"])
		pic = pic+1
	end
	if(getElementData(thePlayer, "ms.team") == "VIP") then
		Bild[5] = guiCreateStaticImage(155,53+addy,102,52,"data/images/player/vip.png",false,Fenster[1])
		addy = addy+60
		addMouseRollover(Bild[5], rollover_names["VIP"])
		pic = pic+1
	end
	--
	
	
	addEventHandler("onClientGUIClick", Knopf[3], function()
		local slogan = guiGetText(Memo[1])
		if(thePlayer == gMe) then
			setElementData(gMe, "mss.slogan", slogan)
		end
		destroyElement(Fenster[1])
		setGuiState(0)
		showCursor(false)
		Guivar = 0
	end, false)
end

addEventHandler("onMultistuntPlayerClick", getRootElement(), createPlayerClickGui)