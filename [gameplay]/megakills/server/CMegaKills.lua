-- #######################################
-- ## Project: MTA Mega Kills			##
-- ## For MTA: San Andreas				##
-- ## Name: MegaKills.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions
local cSetting = {};	-- Local Settings

MegaKills = {};
MegaKills.__index = MegaKills;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///// Returns: Object	//////
-- ///////////////////////////////

function MegaKills:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end

-- ///////////////////////////////
-- ///// PlayerKill 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:PlayerKill(ammo, killer)
	if(killer) and (getElementType(killer) == "player") then
		local player = source;

		-- Reset player stats, player killed


		self.playerKillCount[player] = 0;
		self.playerTempCount[player] = 0;


		-- Set killer stats

		if not(self.playerKillCount[killer]) then
			self.playerKillCount[killer] = 0;
			self.playerTempCount[killer] = 0;
			self.playerTickCount[killer] = getTickCount();

			self.playerMegaKill[killer] = "-";

		end

		self.playerKillCount[killer] = self.playerKillCount[killer]+1;
		self.playerTempCount[killer] = self.playerTempCount[killer]+1;

		if(getTickCount()-self.playerTickCount[killer] > 5000) then
			self.playerTempCount[killer] = 0;
		end

		
		self.playerTickCount[killer] = getTickCount();

		self:UpdatePlayerTitle(killer, source);
	end
end


-- ///////////////////////////////
-- ///// UpdatePlayerTitle	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:UpdatePlayerTitle(player, victim)
	local temp_kills	= self.playerTempCount[player];
	local rampage_kills = #getElementsByType("player")-1;
	local kills			= self.playerKillCount[player];
	local old_megakill = self.playerMegaKill[player];
	

	-- FIRSTBLOOD --

	if(self.firstBloodDone == false) then
		self:AnnounceFirstBlood(player, victim);
		self.firstBloodDone = true;
	end
	
	-- SERIEN --
	local old_megakill = self.playerMegaKill[player];
	
		if(temp_kills == 2) then
			self.playerMegaKill[player]		= "DOUBLE_KILL";
		elseif(temp_kills == 3) then
			self.playerMegaKill[player]		= "TRIPPLE_KILL";
		end
		
		-- Mega kills erst ab 5 spieler, da man diese boni schon bekommen wuerde
		-- Wenn man die Haelfter der Spieler killt
		-- Und bei 2-3 spielern ist das nicht viel.
		if(rampage_kills >= 5) then
			if(temp_kills >= rampage_kills/2) then
				self.playerMegaKill[player]		= "MEGA_KILL";
			elseif(temp_kills == rampage_kills-1) then
				self.playerMegaKill[player]		= "ULTRA_KILL";
			elseif(temp_kills >= rampage_kills) then
				self.playerMegaKill[player]		= "RAMPAGE";
			end
		end


	-- KILLS --
	local old_killstreak = self.playerKillStreak[player];

	if(self.playerMegaKill[player] ~= "-") then
		if(kills == 3) then
			self.playerKillStreak[player]	= "KILLING_SPREE";
		elseif(kills == 4) then
			self.playerKillStreak[player]	= "DOMINATING";
		elseif(kills == 6) then
			self.playerKillStreak[player]	= "UNSTOPPABLE";			
		elseif(kills == 7) then
			self.playerKillStreak[player]	= "WICKED_SICK";
		elseif(kills == 8) then
			self.playerKillStreak[player]	= "MONSTER_KILL";
		elseif(kills == 9) then
			self.playerKillStreak[player]	= "GODLIKE";
		elseif(kills > 9) then
			self.playerKillStreak[player]	= "HOLY_SHIT";
		end
	end
	
	-- kill streak
	local kill_streak
	local mega_kill
		
	if(self.playerKillStreak[player] ~= old_killstreak) then
		kill_streak = true;
		outputChatBox("Player: "..getPlayerName(player).." is on a "..self.playerKillStreak[player].." kill streak!", getRootElement(), 0, 255, 255)
		
	end
	
	if(kills > 5) then
		self.playerOwnage[player] = true;
	else
		self.playerOwnage[player] = false;
	end

	
	-- ANNOUNCE 
	
	if(old_megakill == self.playerMegaKill[player]) then
		-- Do Nothing
	else
		mega_kill = true;
		outputChatBox("Player: "..getPlayerName(player).." has a "..self.playerMegaKill[player].."!", getRootElement(), 0, 255, 255)
		
	end
	
	
	triggerClientEvent(getRootElement(), "onPlayerKillingSpree", getRootElement(), player, mega_kill, self.playerMegaKill[player], kill_streak, self.playerKillStreak[player]);
	
end

-- ///////////////////////////////
-- ///// AnnounceFirstBlood	//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:AnnounceFirstBlood(player)
	-- FIRST BLOOD!
	triggerClientEvent(getRootElement(), "onPlayerFirstBlood", getRootElement(), player);
end

-- ///////////////////////////////
-- ///// ResetVars()								//////
-- ///// Returns: void								//////
-- ///// Resets first blood and player variables	//////
-- ///////////////////////////////

function MegaKills:ResetVars()
	this.firstBloodDone = false;
	
	-- Instanzen
	self.playerKillCount	= {};	-- All in count for killing sprees
	self.playerTempCount	= {};	-- Temp count for mega kills

	self.playerMegaKill		= {};	-- Player mega kill
	self.playerKillStreak	= {};	-- Player kill streak
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:Constructor(...)
	outputChatBox("[MegaKills] Geladen!", getRootElement(), 255, 255, 0)
	-- Instanzen
	self.playerKillCount	= {};	-- All in count for killing sprees
	self.playerTempCount	= {};	-- Temp count for mega kills
	self.playerTickCount	= {};	-- Player Tick Count

	self.playerMegaKill		= {};	-- Player mega kill
	self.playerKillStreak	= {};	-- Player kill streak
	self.playerOwnage		= {};	-- Player Ownage? (5+ kills in a row)

	self.firstBloodDone		= false;	-- First Blood

	-- Funktionen
	self.playerKillFunc		= function(...) self:PlayerKill(...) end;
	self.resetKillStreak	= function(player) self:ResetKillSteak(player) end;

	-- Events

	--addEventHandler("onPedWasted", getRootElement(), self.playerKillFunc);
	addEventHandler("onPlayerWasted", getRootElement(), self.playerKillFunc);
	
	outputDebugString("[CALLING] MegaKills: Constructor");
end

-- EVENT HANDLER --
