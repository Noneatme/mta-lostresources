local lift = createObject(969, -1393.8000488281, -254.30000305176, 13.199999809265, 90, 170.78564453125, 238.21441650391)
local torunten = createObject(970, -1386.5, -248.10000610352, 11.699999809265, 0, 0, 318)
local toroben = createObject(970, -1390.6999511719, -253.10000610352, 23, 0, 0, 317)
local tor1status = true
local tor2status = true
setElementData(lift, "movingobject", true)
setElementData(torunten, "movingobject", true)
setElementData(toroben, "movingobject", true)

local schornstein1 = createObject(3258, -1174, -399.79998779297,  13.10000038147, 0, 0, 0) -- X -90, 90
local schornstein2 = createObject(3258, -1208.8000488281, -400.20001220703, 13.10000038147, 0, 0, 0) -- X - 90,90
local kuppel = createObject(3636, -1191.8000488281, -402.5, 21.39999961853, 0, 0, 0) 

setElementData(schornstein1, "movingobject", true)
setElementData(schornstein2, "movingobject", true)
setElementData(kuppel, "movingobject", true)

setTimer(function()
	local x, y, z = getElementPosition(kuppel)
	moveObject(kuppel, 10000, x, y, z, 0, 0, 5000)
end, 10000, 0)

function toggleMSSchranke2()
	local x, y, z = getElementPosition(schornstein1)
	moveObject(schornstein1, 1000, x, y, z, -90, 0, 0, "InOutQuad")
	local x, y, z = getElementPosition(schornstein2)
	moveObject(schornstein2, 1000, x, y, z, 90, 0, 0, "InOutQuad")
	setTimer(toggleMSSchranke1, 1000, 1)
end


function toggleMSSchranke1()
	local x, y, z = getElementPosition(schornstein1)
	moveObject(schornstein1, 1000, x, y, z, 90, 0, 0, "InOutQuad")
	local x, y, z = getElementPosition(schornstein2)
	moveObject(schornstein2, 1000, x, y, z, -90, 0, 0, "InOutQuad")
	setTimer(toggleMSSchranke2, 1000, 1)
end


setTimer(toggleMSSchranke1, 1000, 1)

local function toggleGate1(var)
	if(var ~= "zu") then
		if(tor1status == true) then return end -- wenn es bereits zu ist
		local x, y, z = getElementPosition(torunten)
		moveObject(torunten, 1000, x, y,z-2, 0, 0, 0, "InOutQuad")
		tor1status = true
	else
		if(tor1status == false) then return end -- wenn es bereits offen ist
		local x, y, z = getElementPosition(torunten)
		moveObject(torunten, 1000, x, y,z+2, 0, 0, 0, "InOutQuad")
		tor1status = false
	end
end

local function toggleGate2(var)
	if(var ~= "zu") then
		if(tor2status == true) then return end -- wenn es bereits zu ist
		local x, y, z = getElementPosition(toroben)
		moveObject(toroben, 1000, x, y,z-2, 0, 0, 0, "InOutQuad")
		tor2status = true
	else
		if(tor2status == false) then return end -- wenn es bereits offen ist
		local x, y, z = getElementPosition(toroben)
		moveObject(toroben, 1000, x, y,z+2, 0, 0, 0, "InOutQuad")
		tor2status = false
	end
end
function moveLiftDownAP()
	toggleGate2("zu")
	local x, y, z = getElementPosition(lift)
	moveObject(lift, 3000, x, y, z-11, 0, 0, 0, "InOutQuad")
	setTimer(toggleGate1, 2500, 1, "auf")
	setTimer(moveLiftUpAP, 7500, 1)
end

function moveLiftUpAP()
	toggleGate1("zu")
	local x, y, z = getElementPosition(lift)
	moveObject(lift, 3000, x, y, z+11, 0, 0, 0, "InOutQuad")
	setTimer(toggleGate2, 2500, 1, "auf")
	setTimer(moveLiftDownAP, 7500, 1)
end

moveLiftUpAP()