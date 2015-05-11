--[[
	##########################################################################
	##                                                                      ##
	## Project: 'Carball' - Gamemode for MTA: San Andreas PROJECT X         ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
	[C] Copyright 2013-2014, Noneatme
]]


local cFunc = {}
local cSetting = {}

fx.ballsync = {}

cSetting["ball_syncher"] = {}

addEvent("onCarballSyncUpdateServer", true)
addEvent("onCarballNewSyncher", true)
addEvent("onCarballPlayerLeave", true)

-- FUNCTIONS --

fx.ballsync.findNewBallSyncher = function(ball)
	local lastdis = math.huge
	local x, y, z = getElementPosition(ball)
	local lastplayer = false
	for index, player in pairs(getElementsByType("player")) do
		if(getElementDimension(player) == getElementDimension(ball)) then
			local x2, y2, z2 = getElementPosition(player)
			if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < lastdis) then
				lastdis = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
				lastplayer = player
			end
		end
	end
	if(lastplayer ~= false) then
		fx.ballsync.setNewBallSyncher(ball, lastplayer)
		outputDebugString("Sync: Found new Syncher: "..getPlayerName(lastplayer).." for ball "..tostring(ball)..".")
	else
		outputDebugString("Sync: Syncher for ball "..tostring(ball).." not found.")
	end
end


fx.ballsync.setNewBallSyncher = function(ball, syncher)
	setElementData(ball, "syncher", syncher)
	cSetting["ball_syncher"][fx.ballsync.getBallSyncher(ball)] = nil
	cSetting["ball_syncher"][syncher] = ball
	return true
end

fx.ballsync.getBallSyncher = function(ball)
	return getElementData(ball, "syncher")
end

fx.ballsync.getPlayerSynchedBall = function(player)
	if(isElement(cSetting["ball_syncher"][player])) then
		return cSetting["ball_syncher"][player]
	else
		return false
	end
end

fx.ballsync.doesPlayerSyncAnyBall = function(player)
	if(isElement(cSetting["ball_syncher"][player])) then
		return true
	else
		return false
	end
end

cFunc["p_quit"] = function()
	if(fx.ballsync.doesPlayerSyncAnyBall(source) == true) then
		outputDebugString("Sync: Syncher for ball: "..tostring(ball).." left, searching for new one.")
		local ball = fx.ballsync.getPlayerSynchedBall(source)
		fx.ballsync.findNewBallSyncher(ball)
	end
end

cFunc["sync_balls"] = function()
	for index, player in pairs(getElementsByType("player")) do
		if(fx.ballsync.doesPlayerSyncAnyBall(player) == true) then
			local ball = fx.ballsync.getPlayerSynchedBall(player)
			if(fx.ballsync.getBallSyncher(ball) == player) then
				triggerClientEvent(player, "onCarballSyncUpdateClient", player, ball)
			end
		end
	end
end

cFunc["sync_ball_back"] = function(ball, tbl)
	triggerClientEvent("onCarballPosUpdate", getRootElement(), source, ball, tbl[1], tbl[2], tbl[3], tbl[4], tbl[5], tbl[6])
end

cFunc["sync_new_ball"] = function(ball)
	fx.ballsync.setNewBallSyncher(ball, source)
	outputDebugString("Sync: Found new Syncher: "..getPlayerName(source).." for ball "..tostring(ball)..".")
end

-- EVENT HANDLERS --

addEventHandler("onPlayerQuit", getRootElement(), cFunc["p_quit"])
addEventHandler("onCarballSyncUpdateServer", getRootElement(), cFunc["sync_ball_back"])
addEventHandler("onCarballNewSyncher", getRootElement(), cFunc["sync_new_ball"])
addEventHandler("onCarballPlayerLeave", getRootElement(), cFunc["p_quit"])

setTimer(cFunc["sync_balls"], 250, -1)