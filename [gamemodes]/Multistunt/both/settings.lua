-- Funktionen bei MuLTi! --



function getFreeDimension(typ)
	local var
	local rand = math.random(1, 65535)
	for index, element in pairs(getElementsByType(typ)) do
		if(var == 1) then return end
		if(getElementDimension(element) == rand) then 
			var = 1
			getFreeDimension(typ)
		else
			var = 0
			return rand;
		end
	end
end

function round(num)
    return math.floor(num + 0.5)
end

function isLoggedIn(thePlayer)
	if(getElementData(thePlayer, "ms.eingeloggt") == true) then return true end
	return false
end

function removePlayerItem(thePlayer, theItem, value)
	if(getPlayerName(thePlayer)) then
		local data = getElementData(thePlayer, theItem)
		if(data) then
			if(tonumber(data) ~= nil) then -- Numeric
				data = tonumber(getElementData(thePlayer, theItem))
				if(data-value < 0) then return end 
				setElementData(thePlayer, theItem, data-value)
			else
				setElementData(thePlayer, theItem, data-value)
			end
		end
	end
end
function givePlayerItem(thePlayer, theItem, value)
	if(getPlayerName(thePlayer)) then
		local data = getElementData(thePlayer, theItem)
		if(data) then
			if(tonumber(data) ~= nil) then -- Numeric
				data = tonumber(getElementData(thePlayer, theItem))
				setElementData(thePlayer, theItem, data+value)
			else
				setElementData(thePlayer, theItem, data+value)
			end
		end
	end
end

function getPlayerAdminlevel(thePlayer)
	return tonumber(getElementData(thePlayer, "ms.adminlevel"))
end

function isPlayerEingeloggt(thePlayer)
	if(getElementData(thePlayer, "ms.eingeloggt") == true) then return true else return false end
end

function getPlayerItem(thePlayer, theItem)
	if(getPlayerName(thePlayer)) then
		local data = getElementData(thePlayer, theItem)
		return data
	end
end
function getPlayerSetting(thePlayer, value)
	return getElementData(thePlayer, "mss."..value)
end
function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

function setElementSpeed(element, unit, speed) 
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then 
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
 
	return false
end

function getDistanceBetweenElements(element1, element2)
	local x, y, z = getElementPosition(element1)
	local x1, y1, z1 = getElementPosition(element2)
	return getDistanceBetweenPoints3D(x, y, z, x1, y1, z1)
end

function getPlayerArchievement(thePlayer, number)
	return tonumber(getElementData(thePlayer, "msa."..number))
end

function givePlayerArchievement(thePlayer, number)
	setElementData(thePlayer, "msa."..number, 1)
	
end

function getFormatDate()
		local time = getRealTime()
		local day = time.monthday
		local month = time.month+1
		local year = time.year+1900
		local hour = time.hour
		local minute = time.minute
		return day.."."..month.."."..year.." "..hour..":"..minute;
end

badge_names = {
	[0] = "Not existing",
	[1] = "Old rabbit",
	[2] = "House owner",
	[3] = "Business man",
	[4] = "Collector I",
	[5] = "Collector II",
	[6] = "Collector III",
	[7] = "Collector IV",
	[8] = "Collector V",
	[9] = "Playtime I",
	[10] = "Playtime II",
	[11] = "Playtime III",
	[12] = "Playtime IV",
	[13] = "Playtime V",
	[14] = "Beta Tester",
	[15] = "Summer 2012",
	[16] = "Scripter",
	[17] = "Nice brain",
	[18] = "Bad brain",
}

badge_description = {
	[0] = "This Badge does not exist.\nLOL.",
	[1] = "This user is very\nlong here.",
	[2] = "This user bought a house.",
	[3] = "This user bought a \nbusiness.",
	[4] = "Collect a\narchievement.",
	[5] = "Collect 3\narchievements.",
	[6] = "Collect 6\narchievements.",
	[7] = "Collect 9\narchievements.",
	[8] = "Collect all(11)\narchievements.",
	[9] = "Play more than\n1 Hour.",
	[10] = "Play more than\n10 Hour.",
	[11] = "Play more than\n50 Hours.",
	[12] = "Play more than\n100 Hours.",
	[13] = "Play more than\n200 Hours.",
	[14] = "This user played\non this Server during\nthe beta test.",
	[15] = "Sun, beach and\nmore!",
	[16] = "If you have an Idea\nthat makes the server\nbetter, say it!",
	[17] = "This user has very\ngood ideas.",
	[18] = "This user really has\nno good ideas.",
}
max_badges = #badge_names