-- #######################################
-- ## Project: 	MTA Prop Hunt			##
-- ## For MTA: San Andreas				##
-- ## Name: Vars.lua					##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --


g = {};

g.sx, g.sy 		= guiGetScreenSize();
g.aesx, g.aesy 	= 1600, 900;


-- // FUNKTIONEN \\ --


function getColorFromBool(bool, r1, g1, b1, a1, r2, g2, b2, a2)
	if(bool) then
		return tocolor(r1, g1, b1, a1)
	else
		return tocolor(r2, g2, b2, a2)
	end
end
