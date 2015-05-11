-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: Prophunt_Objects.lua		##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc 	= {};		-- Local Functions 
local cSetting 	= {};	-- Local Settings

map_objects 	= {};
map_spawns		= {};

map_objects["prophunt-airport"] = 
{
	[1215] 	= true,	-- Bollardlight
	[1226] 	= true,	-- Laterne
	[956] 	= true,	-- Automat
	[3657] 	= true,	-- Bank
	[673] 	= true,	-- baum
	[3658] 	= true, -- Airportteil
	[712]	= true,	-- Palme
	[620]	= true,	-- Palme 2
	[1290]	= true,	-- Laterne 2
}

map_spawns["prophunt-airport"]	= 
{
	["props"] = 
	{
		{1568.2053222656, -2251.7436523438, 13.542907714844},
		{1565.9792480469, -2319.1606445313, 13.548401832581},
		{1779.5531005859, -2242.1228027344, 13.550468444824},
			
	},
	
	["hunter"] = 
	{
		{1569.1418457031, -2287.1384277344, -2.9921875},
		{1564.0211181641, -2237.0236816406, 13.546875},
		{1578.9271240234, -2351.5100097656, 13.550580978394},
		{1757.2623291016, -2243.4724121094, 13.545026779175},
		{1779.5920410156, -2330.9182128906, 13.478194236755},
		{1689.4466552734, -2287.2163085938, 14.473649978638},
		
	},
}


-- EVENT HANDLER --
