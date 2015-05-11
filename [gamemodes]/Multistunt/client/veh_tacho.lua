-- Tacho bei MuLTi -

local sx, sy = guiGetScreenSize()
local enabled = true
local font1 = dxCreateFont("data/fonts/digital.ttf", 9, true)

setTimer(function()
	showPlayerHudComponent ( "ammo", false )
	showPlayerHudComponent ( "clock", false )
	showPlayerHudComponent ( "armour", false )
	showPlayerHudComponent ( "breath", false )
	showPlayerHudComponent ( "clock", false )
	showPlayerHudComponent ( "health", false )
	showPlayerHudComponent ( "weapon", false )
end, 1000, 0)

local COLORHEALTH = "0, 255, 0"
local COLORARMOUR = "121, 143, 145"
local COLORSPEED = "255, 150, 0"
local COLORDAMAGE = "255, 0, 0"
local DAMAGEVALUE = 0

addEventHandler("onClientRender", getRootElement(), function()
	if(enabled == true) and(isPlayerEingeloggt(gMe) == true) then
		local fontbig = {}
		-- Background --
		local x, y = sx/2, sy/2
		local fx, fy = sx-sx/5-20, 15
		dxDrawImage(fx, fy, sx/5, sy/7, "data/images/tacho/background.png")
		-- Uhr --
		fontbig.uhr = 2/1920*sx
		local time = getRealTime()
		local fx2, fy2 = sx-sx/12, 30/1080*sy
		local hour, minute, second = time.hour, time.minute, time.second
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		if(hour < 10) then hour = "0"..hour end
		if(minute < 10) then minute = "0"..minute end
		if(second < 10) then second = "0"..second end
		-- Tag
		dxDrawText(day.."."..month.."."..year, fx2+2, fy2+2, fx2, fy2, tocolor(0, 0, 0, 200), fontbig.uhr, font1)
		dxDrawText(day.."."..month.."."..year, fx2, fy2, fx2, fy2, tocolor(255, 255, 255, 200), fontbig.uhr, font1)
		-- Datum --
		dxDrawText(hour..":"..minute..":"..second, fx2+2, fy2+30/1080*sy+2, fx2, fy2+30, tocolor(0, 0, 0, 200), fontbig.uhr, font1)
		dxDrawText(hour..":"..minute..":"..second, fx2, fy2+30/1080*sy, fx2, fy2+30, tocolor(255, 255, 255, 200), fontbig.uhr, font1)
		-- Leben --
		local WIDTH, HEIGHT = 120, 20
		local NWIDTH, NHEIGHT = WIDTH/1920*sx-1, HEIGHT/1080*sy-5
		NWIDTH = NWIDTH/100*getElementHealth(gMe)
		dxDrawRectangle(fx2, fy2+70/1080*sy, WIDTH/1920*sx, HEIGHT/1080*sy, tocolor(gettok(COLORHEALTH, 1, string.byte(",")), gettok(COLORHEALTH, 2, string.byte(",")), gettok(COLORHEALTH, 3, string.byte(",")), 150))
		dxDrawRectangle(fx2, fy2+72.5/1080*sy, NWIDTH, NHEIGHT, tocolor(gettok(COLORHEALTH, 1, string.byte(",")), gettok(COLORHEALTH, 2, string.byte(",")), gettok(COLORHEALTH, 3, string.byte(",")), 255))
		-- Armour --
		local WIDTH2, HEIGHT2 = 120, 20
		local NWIDTH2, NHEIGHT2 = WIDTH2/1920*sx-1, HEIGHT2/1080*sy-5
		NWIDTH2 = NWIDTH2/100*getPedArmor(gMe)
		dxDrawRectangle(fx2, fy2+100/1080*sy, WIDTH2/1920*sx, HEIGHT2/1080*sy, tocolor(gettok(COLORARMOUR, 1, string.byte(",")), gettok(COLORARMOUR, 2, string.byte(",")), gettok(COLORARMOUR, 3, string.byte(",")), 150))
		dxDrawRectangle(fx2, fy2+102.5/1080*sy, NWIDTH2, NHEIGHT2, tocolor(gettok(COLORARMOUR, 1, string.byte(",")), gettok(COLORARMOUR, 2, string.byte(",")), gettok(COLORARMOUR, 3, string.byte(",")), 255))
		-- Fahrzeug --
		local veh
		fontbig.vehicle = 1.2/1920*sx
		if(isPedInVehicle(gMe)) then
			-- Name 
			veh = getPedOccupiedVehicle(gMe)
			if(veh) then
				local vehname = getVehicleName(veh)
				local fx3, fy3 = sx-sx/5, 8/1080*sy
				dxDrawText("Vehicle: "..vehname, fx3+2, fy3+30/1080*sy+2, fx3, fy3+30, tocolor(0, 0, 0, 200), fontbig.vehicle, font1)
				dxDrawText("Vehicle: "..vehname, fx3, fy3+30/1080*sy, fx3, fy3+30, tocolor(255, 255, 255, 200), fontbig.vehicle, font1)
				-- Geschwindigkeit --
				local WIDTH3, HEIGHT3 = 180, 20
				local NWIDTH3, NHEIGHT3 = WIDTH3/1920*sx-1, HEIGHT3/1080*sy-5
				NWIDTH3 = NWIDTH3/100*getElementSpeed(veh)/2.5
				if(NWIDTH3 > WIDTH3) then NWIDTH3 = WIDTH3 end
				local r, g, b = gettok(COLORSPEED, 1, string.byte(",")), gettok(COLORSPEED, 2, string.byte(",")), gettok(COLORSPEED, 3, string.byte(","))
				dxDrawRectangle(fx3, fy3+70/1080*sy, WIDTH3/1920*sx, HEIGHT3/1080*sy, tocolor(r, g, b, 150))
				dxDrawRectangle(fx3, fy3+72.5/1080*sy, NWIDTH3, NHEIGHT3, tocolor(r, g, b, 255))
				dxDrawText(math.floor(getElementSpeed(veh)/1.5).." KM/H", sx-sx/5, 8/1080*sy+71/1080*sy, fx2, fy2+30, tocolor(255, 255, 255, 200), fontbig.vehicle, font1)
				dxDrawText(math.floor(getElementSpeed(veh)/1.5).." KM/H", sx-sx/5+2, 8/1080*sy+71/1080*sy+2, fx2, fy2+30, tocolor(0, 0, 0, 200), fontbig.vehicle, font1)
				-- Damage --
				local WIDTH4, HEIGHT4 = 180, 20
				local NWIDTH4, NHEIGHT4 = WIDTH4/1920*sx-1, HEIGHT4/1080*sy-5
				NWIDTH4 = NWIDTH4/1000*getElementHealth(veh)
				local r, g, b = gettok(COLORDAMAGE, 1, string.byte(",")), gettok(COLORDAMAGE, 2, string.byte(",")), gettok(COLORDAMAGE, 3, string.byte(","))
				-- Damagevalue --
				if(DAMAGEVALUE > 0) then
					DAMAGEVALUE = DAMAGEVALUE-3
				end
				b = b+DAMAGEVALUE
				r = r-DAMAGEVALUE
				dxDrawRectangle(fx3, fy3+100/1080*sy, WIDTH4/1920*sx, HEIGHT4/1080*sy, tocolor(r, g, b, 150))
				dxDrawRectangle(fx3, fy3+102.5/1080*sy, NWIDTH4, NHEIGHT4, tocolor(r, g, b, 255))
				dxDrawText(math.floor(getElementHealth(veh)*0.1).." %", sx-sx/5, 8/1080*sy+101/1080*sy, fx2, fy2+30, tocolor(255, 255, 255, 200), fontbig.vehicle, font1)
				dxDrawText(math.floor(getElementHealth(veh)*0.1).." %", sx-sx/5+2, 8/1080*sy+101/1080*sy+2, fx2, fy2+30, tocolor(0, 0, 0, 200), fontbig.vehicle, font1)
			end
		end
	end
end)

addEventHandler("onClientVehicleCollision", getRootElement(), function(hit, force)
	if(source == getPedOccupiedVehicle(gMe)) then
		local fDamageMultiplier = getVehicleHandling(source).collisionDamageMultiplier
		if(force > 200) then
			DAMAGEVALUE = 255
		end
	end
end)



--[[
local sx, sy = guiGetScreenSize( )
local scale = (sx/1152 + sy/864)/2
--local font2 = dxCreateFont("digital.ttf", 9, false)


local tacho = guiCreateStaticImage(sx-352,sy-222, 352, 222, "data/images/tacho/tacho.png", false)
local leuchten = guiCreateStaticImage(sx-352,sy-222, 352, 222, "data/images/tacho/leuchten.png", false)
guiSetVisible(tacho, false)
guiSetVisible(leuchten, false)
guiSetAlpha(tacho, 1)
local nposx, nposy = guiGetPosition(tacho, false)
local anvar = false
guiMoveToBack(tacho)

local function setTachoEnabled()
	guiSetVisible(tacho, true)
	anvar = true
end

local function setTachoDisabled()
	guiSetVisible(tacho, false)
	guiSetVisible(leuchten, false)
	anvar = false
end

addEventHandler("onClientRender", root, function()
	if(isPedInVehicle(gMe)) and(anvar == true) then
	if not(getPedOccupiedVehicle(gMe)) then
		anvar = false
		guiSetVisible(tacho, false)
		guiSetVisible(leuchten, false)
	return end
	local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(gMe))
	-- Nadel --
	local speed = math.floor(math.sqrt(vx^2 + vy^2 + vz^2) * 180)
	local rspeed = math.floor(math.sqrt(vx^2 + vy^2 + vz^2) * 180)
	local r, g, b = 255, 255, 255
	if(speed < 0) then speed = 0 end
	if(speed > 250) then rspeed = 250 r, g, b = 255, 0, 0 end
	local needlespeed = rspeed*0.4
	-- Nadelfarbe
	
	-- Text --
	dxDrawText ( speed.." km/h", sx-335, sy - 100, sx, sy, tocolor ( 255, 255, 255, 200 ), 1, "default-bold","center","top",false,false,true )
	dxDrawRectangle (sx-200, sy - 102, 65, 20, tocolor ( 0, 0, 0, 150 ) )
	dxDrawImage ( sx-200, sy - 102, 65, 20, "data/images/tacho/kasten.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)
	-- Bild --
	dxDrawImage(nposx+60, nposy+30, 250, 250, "data/images/tacho/nadel.png", needlespeed*2, 0, 0, tocolor ( r, g, b, 255 ), true)
	-- Leuchten --
	local hour, minute = getTime()
	if(hour > 21) or (hour < 6) then
		if(guiGetVisible(leuchten) == true) then else
			guiSetVisible(leuchten, true)
		end
	else
		if(guiGetVisible(leuchten) == true) then
			guiSetVisible(leuchten, false)
		end
	end
	guiMoveToBack(tacho)
	else
		return
	end
end)


addEventHandler("onClientVehicleEnter", getRootElement(), function(thePlayer) if(thePlayer == gMe) then setTachoEnabled() end end)
addEventHandler("onClientVehicleStartExit", getRootElement(), function(thePlayer) if(thePlayer == gMe) then setTachoDisabled() end end)
addEventHandler("onClientVehicleExit", getRootElement(), function(thePlayer) if(thePlayer == gMe) then setTachoDisabled() end end)
addEventHandler("onClientPlayerWasted", gMe, function()setTachoDisabled() end)


--- nicht drinne
local label1, label2, bild
local font1, font2 = guiCreateFont("data/fonts/digital.ttf", 14), guiCreateFont("data/fonts/digital.ttf", 19)
local function setTachoEnabled()
	guiSetVisible(label1, true)
	guiSetVisible(label2, true)
	guiSetVisible(bild, true)
end

local function setTachoDisabled()
	guiSetVisible(label1, false)
	guiSetVisible(label2, false)
	guiSetVisible(bild, false)
end
local function checkTacho()
	if(isPedInVehicle(gMe) == true) then
		local veh = getPedOccupiedVehicle(gMe)
		if not(veh) then return end
		local name = getVehicleName(veh)
		local speed = round(getElementSpeed(veh)/1.3)
		guiSetText(label2, "KM/H: "..speed)
		guiSetText(label1, name)
	end
end

addEventHandler("onClientPlayerVehicleEnter", gMe, setTachoEnabled)
addEventHandler("onClientPlayerVehicleExit", gMe, setTachoDisabled)
addEventHandler("onClientPlayerWasted", gMe, setTachoDisabled)

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	label1 = guiCreateLabel(0.8417,0.84,0.1563,0.0398,"Fahrzeugname",true)
	guiLabelSetHorizontalAlign(label1,"center",false)
	guiLabelSetVerticalAlign(label1,"center")
	guiSetFont(label1, font1)
	guiLabelSetColor(label1, 0, 0, 0)
	label2 = guiCreateLabel(0.8417,0.8861,0.1563,0.0898,"0 Km/h",true)
	guiLabelSetVerticalAlign(label2,"center")
	guiLabelSetHorizontalAlign(label2,"center",false)
	guiSetFont(label2, font2)
	guiLabelSetColor(label2, 0, 0, 0)
	bild = guiCreateStaticImage(0.8427,0.8315,0.1552,0.1593,"data/images/tachobackground.png",true)
	guiMoveToBack(bild)
	setTachoDisabled()
	addEventHandler("onClientRender", getRootElement(), checkTacho)
end)
---
--]]