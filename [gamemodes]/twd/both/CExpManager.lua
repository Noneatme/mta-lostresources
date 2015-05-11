-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: ExpManager						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

ExpManager = {};
ExpManager.__index = ExpManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function ExpManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// GetMaxEXP	 		//////
-- ///////////////////////////////

function ExpManager:GetMaxEXP(level)
	return (self.levelEXP[level] or 0);
end

-- ///////////////////////////////
-- ///// AddServerFunctions	//////
-- ///////////////////////////////

function ExpManager:AddServerFunctions()

	function self:AddPlayerEXP(player, exp)
		local expvorhanden = player:GetEXP();
		local level = player:GetLevel();
	
		if(level) then
			local max = self:GetMaxEXP(level)
			local newexp = expvorhanden+exp;
			
			if(newexp >= max) then
				newexp = newexp-max
				 
				if(level == #self.levelEXP) then
					-- Max level
					newexp = 0;
				end 
				player:LevelUp()
			end
			
			player:SetData("account", "EXP", newexp);
			return true;
		end
		return false;
	end

end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function ExpManager:Constructor(typ)
	self.levelEXP = {
		[1] = 250,
		[2] = 300,
		[3] = 350,
		[4] = 410,
		[5] = 460,
		[6] = 510,
		[7] = 580,
		[8] = 620,
		[9] = 680,
		[10] = 730,
		[11] = 770,
		[12] = 830,
		[13] = 850,
		[14] = 970,
		[15] = 950,
		[16] = 1000,
		[17] = 1100,
		[18] = 1200,
		[19] = 1300,
		[20] = 1400,
		[21] = 1500,
		[22] = 1600,
		[23] = 1700,
		[24] = 1800,
		[25] = 1900,
		[26] = 2000,
		[27] = 2100,
		[28] = 2200,
		[29] = 2300,
		[30] = 2400,
		[31] = 2500,
		[32] = 2600,
		[33] = 2700,
		[34] = 2800,
		[35] = 2900,
		[36] = 3000,
		[37] = 3200,
		[38] = 3400,
		[39] = 3600,
		[40] = 3800,
		[41] = 4000,
		[42] = 4100,
		[43] = 4200,
		[44] = 4300,
		[45] = 4400,
		[46] = 4500,
		[47] = 4600,
		[48] = 4700,
		[49] = 4800,
		[50] = 5000,
	
	
	
	}
	
	if(typ == "server") then
		self:AddServerFunctions();
	end
	logger:OutputInfo("[CALLING] ExpManager: Constructor");
end

-- EVENT HANDLER --
