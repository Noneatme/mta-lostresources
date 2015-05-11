-- Scoreboard, sowie alle sachen von Multistunt stehen unter meinem (MuLTi) Uhrheberecht! --

local scoreboard = {}
local sx, sy = guiGetScreenSize()

local wr, wg, wb = 1, 1, 1
local curframerate = 1 
local wrd, wgd, wbd = false, false, false


local grid
grid = guiCreateGridList ( sx/2-290, sy/2-165, 600, 300, false ) --+ 20
addEventHandler("onClientGUIClick", grid, function()
		guiMoveToBack(grid)
end, false)
guiSetAlpha(grid, 0.8)
guiSetFont(grid, "default-bold-small")
guiGridListSetSelectionMode ( grid, 1 )


scoreboard.state = false
scoreboard.expandstate = tonumber(getElementData(gMe, "mss.scb.legend"))
if not(scoreboard.expandstate) then scoreboard.expandstate = 1 end
scoreboard.expandvar = 0
scoreboard.expanddoing = 0
scoreboard.expandalpha = 200
guiGridListAddColumn( grid, "Player", 0.2 )
guiGridListAddColumn( grid, "Playtime", 0.2 )
guiGridListAddColumn( grid, "Resolution", 0.2 )
guiGridListAddColumn( grid, "Area", 0.25 )
guiGridListAddColumn( grid, "Ping", 0.1 )

guiSetVisible(grid, false)

local teamcolor = {
	[0] = {255, 255, 255},
	[1] = {255, 255, 0},
	[2] = {255, 155, 0},
	[3] = {255, 0, 0},
	[4] = {255, 0, 0},
	[5] = {255, 0, 0},
	[6] = {255, 0, 0},
}

local function reloadScoreboard()
	guiGridListClear(grid)
	for index, player in pairs(getElementsByType("player")) do
		local row = guiGridListAddRow(grid)
		local playtime = tostring(getElementData(player, "ms.playtime"))
		local resolution = tostring(getElementData(player, "ms.resolution"))
		local x, y, z = getElementPosition(player)
		local zone = getZoneName(x, y, z, false)
		local ping = getPlayerPing(player)
		 -- REINMACHEN!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		if(isPlayerEingeloggt(player) == false) then
			playtime = "N/A"
			zone = "Connecting..."
		end
		guiGridListSetItemText(grid, row, 1, getPlayerName(player), false, false)
		guiGridListSetItemText(grid, row, 2, playtime, false, false)
		guiGridListSetItemText(grid, row, 3, resolution, false, false)
		guiGridListSetItemText(grid, row, 4, tostring(zone), false, false)
		guiGridListSetItemText(grid, row, 5, ping, false, false)
		-- Farbe --
		local adminlevel = tonumber(getElementData(player, "ms.adminlevel"))
		local r, g, b
		if not(adminlevel) then r, g, b = 200, 200, 200 end -- Connecting, warscheinlich
		if(teamcolor[adminlevel]) then
			r, g, b = teamcolor[adminlevel][1], teamcolor[adminlevel][2], teamcolor[adminlevel][3]
		else
			r, g, b = 0, 255, 0
		end
		if(adminlevel == 0) then
			local vip = getElementData(player, "ms.team")
			if(vip) and (vip == "VIP") then
				r, g, b = 150, 0, 255
			end
		end
		for i = 1, 5, 1 do
			guiGridListSetItemColor ( grid, row, i, r, g, b, 255 )
		end
	end
end

bindKey("tab", "down", function()
	setElementData(gMe, "guistate", true, false)
	setElementData(gMe, "atScoreboard", true, false)
	scoreboard.state = true
	guiSetVisible(grid, true)
	reloadScoreboard()
	scoreboard.expand = guiCreateStaticImage(sx/2-285, sy/2+115, 14, 14, "data/images/scoreboard/expand.jpg", false)
	guiSetAlpha(scoreboard.expand, 0.5)
	
	addEventHandler("onClientMouseEnter", scoreboard.expand, function() guiSetAlpha(scoreboard.expand, 1) end)
	addEventHandler("onClientMouseLeave", scoreboard.expand, function() guiSetAlpha(scoreboard.expand, 0.5) end)
	
	addEventHandler("onClientGUIClick", scoreboard.expand, function()
		if(scoreboard.expanddoing == 1) then return end
		if(scoreboard.expandvar == 0) then
			scoreboard.expandvar = 1
			setElementData(gMe, "mss.scb.legend", 0)
		else
			scoreboard.expandvar = 0
			setElementData(gMe, "mss.scb.legend", 1)
			scoreboard.expandstate = 1
		end
	end, false)
end)

bindKey("tab", "up", function()
	scoreboard.state = false
	guiSetVisible(grid, false)
	destroyElement(scoreboard.expand)
	setElementData(gMe, "guistate", false, false)
	setElementData(gMe, "atScoreboard", false, false)
end)

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	setElementData(gMe, "ms.resolution", sx.."x"..sy)
end)

addEventHandler("onClientRender", getRootElement(), function()
	if(scoreboard.state == true) then
		if(wr > 0) and (wrd == false)then
			wr = wr+curframerate
			if(wb ~= 1) then
				wb = wb-curframerate
			end
			if(wr > 254) then
				wr = 255
				wrd = true
			end
		
		elseif(wg > 0) and (wgd == false)then
			wg = wg+curframerate
			wr = wr-curframerate
			if(wg > 254) then
				wg = 255
				wgd = true
			end

		elseif(wb > 0) and (wbd == false)then
			wb = wb+curframerate
			wg = wg-curframerate
			if(wb > 254) then
				wbd = false
				wrd = false
				wgd = false
				wb = 255
				wr = 1
				wg = 1
			end
		end
		-- Rahmen und Background --
		dxDrawImage(sx/2-290, sy/2-165, 600, 300, "data/images/scoreboard/background.png", 0, 0, 0, tocolor(wr, wg, wb, 200), true)
		dxDrawImage(sx/2-290, sy/2-165, 600, 300, "data/images/scoreboard/rahmen.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)
		dxDrawText("Toggle legend", sx/2-265, sy/2+115, sx/2, sy/2, tocolor(255, 255, 255, 255), 1, "default-bold")
		-- Expand --
		if(scoreboard.expandvar == 1) then
			if(scoreboard.expandalpha < 5) then
				scoreboard.expandalpha = 0
				if(scoreboard.expanddoing == 1) then
					scoreboard.expanddoing = 0
					scoreboard.expandstate = 0
				end
			else
				scoreboard.expandalpha = scoreboard.expandalpha-4
				
			end
		else
			if(scoreboard.expandalpha > 195) then
				if(scoreboard.expanddoing == 1) then
					scoreboard.expanddoing = 0
					scoreboard.expandstate = 1
				end
				scoreboard.expandalpha = 200
			else
				scoreboard.expandalpha = scoreboard.expandalpha+4
			end
		end
		-- -- 
		if(scoreboard.expandstate == 1) then
			-- Legende --
			dxDrawImage(sx/2-290, sy/2+133, 600, 50, "data/images/scoreboard/rahmen2.png", 0, 0, 0, tocolor(255, 255, 255, scoreboard.expandalpha), true)
			dxDrawRectangle(sx/2-290, sy/2+133, 600, 50, tocolor(0, 0, 0, scoreboard.expandalpha))
			
			dxDrawText("Legende:", sx/2-277, sy/2+153, sx/2, sy/2, tocolor(0, 0, 0, scoreboard.expandalpha), 1.1, "default-bold")
			dxDrawText("Legende:", sx/2-275, sy/2+150, sx/2, sy/2, tocolor(255, 255, 255, scoreboard.expandalpha), 1.1, "default-bold")
			-- Teams --
			-- Inhaber --
			dxDrawText("Inhaber u. Admin,", sx/2-191, sy/2+151, sx/2, sy/2, tocolor(0, 0, 0, scoreboard.expandalpha), 1, "default-bold")
			dxDrawText("Inhaber u. Admin,", sx/2-190, sy/2+152, sx/2, sy/2, tocolor(255, 0, 0, scoreboard.expandalpha), 1, "default-bold")
			-- Super Mod --
			dxDrawText("S. Mod,", sx/2-86, sy/2+151, sx/2, sy/2, tocolor(0, 0, 0, scoreboard.expandalpha), 1, "default-bold")
			dxDrawText("S. Mod,", sx/2-85, sy/2+152, sx/2, sy/2, tocolor(255, 150, 0, scoreboard.expandalpha), 1, "default-bold")
			-- Mod --
			dxDrawText("Moderator,", sx/2-36, sy/2+151, sx/2, sy/2, tocolor(0, 0, 0, scoreboard.expandalpha), 1, "default-bold")
			dxDrawText("Moderator,", sx/2-35, sy/2+152, sx/2, sy/2, tocolor(255, 255, 0, scoreboard.expandalpha), 1, "default-bold")
			-- Normal --
			dxDrawText("Normal,", sx/2+36, sy/2+151, sx/2, sy/2, tocolor(0, 0, 0, scoreboard.expandalpha), 1, "default-bold")
			dxDrawText("Normal,", sx/2+35, sy/2+152, sx/2, sy/2, tocolor(255, 255, 255, scoreboard.expandalpha), 1, "default-bold")
			-- VIP --
			dxDrawText("VIP", sx/2+86, sy/2+151, sx/2, sy/2, tocolor(0, 0, 0, scoreboard.expandalpha), 1, "default-bold")
			dxDrawText("VIP", sx/2+85, sy/2+152, sx/2, sy/2, tocolor(150, 0, 255, scoreboard.expandalpha), 1, "default-bold")
			--
		end
	end
end)