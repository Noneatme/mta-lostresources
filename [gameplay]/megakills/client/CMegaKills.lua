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

addEvent("onPlayerKillingSpree", true)	-- Killing Spree
addEvent("onPlayerFirstBlood", true)	-- Blutrausch

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
-- ///// FirstBlood 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:FirstBlood(player)
	self.names.firstBlood	= getPlayerName(player);
	
	self.sounds.firstBlood	= playSound("files/sounds/announcer_1stblood_01.mp3");
	
end

-- ///////////////////////////////
-- ///// AnnounceKillingSpree ////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:AnnounceKillingSpree()

	if(isElement(self.sounds.killingSpreeSoundElement)) then
		destroyElement(self.sounds.killingSpreeSoundElement);
	end

	if(self.killingSpreeSounds[self.sounds.killingSpree]) then
		self.sounds.killingSpreeSoundElement= playSound("files/sounds/"..self.killingSpreeSounds[self.sounds.killingSpree]..".mp3", false)
		self.soundschanged.killingSpree	= false;
	end
end

-- ///////////////////////////////
-- ///// AnnounceBlutrausch	 ////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:AnnounceBlutrausch()

	if(isElement(self.sounds.bloodRushSoundElement)) then
		destroyElement(self.sounds.bloodRushSoundElement);
	end
		
	
	self.sounds.bloodRushSoundElement = playSound("files/sounds/"..self.bloodRushSounds[self.sounds.blutrausch]..".mp3", false);
	self.soundschanged.bloodRush	= false;	
end

-- ///////////////////////////////
-- ///// CheckSoundsForTrigger////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:CheckSoundsForTrigger()

	-- Warteschlange abarbeiten:
	
	-- 1. Blutrausch
	-- 2. Killing Spree
	-- 3. Ownage
	if(isElement(self.sounds.firstBlood)) then
		destroyElement(self.sounds.firstBlood);
	end
	-- BLUTRAUSCH ERST
	
	if(self.soundschanged.blutrausch) then
		self:AnnounceBlutrausch();
		addEventHandler("onClientSoundStopped", self.sounds.bloodRushSoundElement, function()
			if(self.soundschanged.killingSpree) then
				self:AnnounceKillingSpree();

			end
		end)
	else
		self:AnnounceKillingSpree();
	end
	
end

-- ///////////////////////////////
-- ///// KillingSpree		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:KillingSpreeEvent(player, spr, spree, blood, bloodrush)

	
	if(spr) and (spree ~= "-") then

		outputChatBox(spree)
		self:KillingSpree(player, spree)
		
	end
	if(blood) then
		self:BloodRush(player, bloodrush);
	else
		self:CheckSoundsForTrigger();
	end
end

function MegaKills:KillingSpree(player, spree) 


	self.sounds.killingSpree 		= spree;
	self.soundschanged.killingSpree	= true;
	
end

-- ///////////////////////////////
-- ///// BloodRush			//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:BloodRush(player, rush)

	self.sounds.blutrausch 			= rush;
	self.soundschanged.blutrausch	= true;

	self:CheckSoundsForTrigger();
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///// Returns: void		//////
-- ///////////////////////////////

function MegaKills:Constructor(...)

	-- Instanzen
	self.sounds 				= {};
	
	self.sounds.killingSpree	= false;	-- Just 1 sound for everyone!
	self.sounds.bloodRush		= false;	-- Also
	self.sounds.ownage			= false;	-- Also
	
	self.sounds.firstBlood		= false;	--
	
	self.soundschanged			= {}; 
	
	
	self.killingSpreeSounds		= {
		["DOUBLE_KILL"]		= "announcer_kill_double_01",
		["TRIPPLE_KILL"]	= "announcer_kill_triple_01",
		["MEGA_KILL"]		= "announcer_kill_mega_01",
		["ULTRA_KILL"]		= "announcer_kill_ultra_01",
		["RAMPAGE"]			= "announcer_kill_rampage_01",
	}
	
	self.bloodRushSounds 		= {
		["KILLING_SPREE"]	= "announcer_kill_spree_01",
		["DOMINATING"]		= "announcer_kill_dominate_01",
		["UNSTOPPABLE"]		= "announcer_kill_unstop_01",
		["WICKED_SICK"]		= "announcer_kill_wicked_01",
		["MONSTER_KILL"]		= "announcer_kill_monster_01",
		["GODLIKE"]			= "announcer_kill_godlike_01",
		["HOLY_SHIT"]		= "announcer_kill_holy_01",
	}
	
	-- ANNOUNCE NAMES --
	self.names					= {}
	self.names.firstblood 		= "-";
	self.names.killingSpree		= "-";
	self.names.bloodRush		= "-";
	
	-- Funktionen
	
	self.killingSpreeFunc	= function(...) self:KillingSpreeEvent(...) end;
	self.firstBloodFunc		= function(...) self:FirstBlood(...) end;
	
	-- Events
	addEventHandler("onPlayerKillingSpree", getRootElement(), self.killingSpreeFunc)
	addEventHandler("onPlayerFirstBlood", getRootElement(), self.firstBloodFunc);
	
	outputDebugString("[CALLING] MegaKills: Constructor");
end

-- EVENT HANDLER --
