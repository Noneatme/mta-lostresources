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

cSetting["round_starting"] = {}
cSetting["round_finishtick"] = {}
cSetting["round_starttick"] = {}

addEvent("onCarballPlayerJoin", true)

cSetting["start_match_timer"] = {}

cSetting["team_red"] = {}
cSetting["team_green"] = {}

-- FUNCTIONS --

fx.arena = {}



fx.arena.isRoundRunning = function(arena)
	return (cSetting["round_starting"][arena] or false)
end


fx.arena.getRoundFinishTick = function(arena)
	if(fx.arena.isRoundRunning(arena)) then
		return cSetting["round_starttick"], cSetting["round_finishtick"]
	end
	return 0
end


fx.arena.startRound = function(arena, laenge)
	if not(fx.arena.isRoundRunning(arena)) then
		if not(laenge) then
			laenge = 10*60*1000
		end
		cSetting["round_starttick"][arena] = getTickCount()
		cSetting["round_finishtick"][arena] = cSetting["round_starttick"][arena]+laenge
		cSetting["team_red"][arena] = 0
		cSetting["team_green"][arena] = 0
		cSetting["round_starting"][arena] = true
		for index, player in pairs(getPlayersInArea(arena)) do
			outputGametext(player, "Round #00FF00STARTED!")
			triggerClientEvent(player, "onCarballClientRoundStart", player, cSetting["round_starttick"][arena], cSetting["round_finishtick"][arena],  cSetting["team_red"][arena], cSetting["team_green"][arena])
		end
	end
	return false
end

cFunc["join_check"] = function(arena)
	if not(fx.arena.isRoundRunning(arena)) and not(isTrainingArea(arena)) then
		outputGametext(source, "Starting #00FFFFmatch#FFFFFF in #00FFFF1#FFFFFF Minute.")
		if not(isTimer(cSetting["start_match_timer"][arena])) then
			cSetting["start_match_timer"][arena] = setTimer(fx.arena.startRound, 6000, 1, arena)
		end
	else
		triggerClientEvent(source, "onCarballClientRoundStart", source, cSetting["round_starttick"][arena], cSetting["round_finishtick"][arena], cSetting["team_red"][arena], cSetting["team_green"][arena])
	end
end

-- EVENT HANDLERS --

addEventHandler("onCarballPlayerJoin", getRootElement(), cFunc["join_check"])