-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: RegisterFlyManager						##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################

-- FUNCTIONS / METHODS --

local cFunc = {};		-- Local Functions 
local cSetting = {};	-- Local Settings

RegisterFlyManager = {};
RegisterFlyManager.__index = RegisterFlyManager;

--[[

]]

-- ///////////////////////////////
-- ///// New 				//////
-- ///////////////////////////////

function RegisterFlyManager:New(...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(...);
	end
	return obj;
end


-- ///////////////////////////////
-- ///// MoveToNextPoint 	//////
-- ///////////////////////////////

function RegisterFlyManager:MoveToNextPoint()
	local x2, y2, z2, xl2, yl2, zl2, time = self.flyPos[self.currentPosition][1], self.flyPos[self.currentPosition][2], self.flyPos[self.currentPosition][3], self.flyPos[self.currentPosition][4], self.flyPos[self.currentPosition][5], self.flyPos[self.currentPosition][6], self.flyPos[self.currentPosition][7]
	local x1, y1, z1, xl1, yl1, zl1 = self.flyPos[self.currentPosition-1][1], self.flyPos[self.currentPosition-1][2], self.flyPos[self.currentPosition-1][3], self.flyPos[self.currentPosition-1][4], self.flyPos[self.currentPosition-1][5], self.flyPos[self.currentPosition-1][6]
	
	cameraMover:SmoothMoveCamera(x1, y1, z1, xl1, yl1, zl1, x2, y2, z2, xl2, yl2, zl2, time);


	self.currentPosition = self.currentPosition+1;
	
	if not(self.flyPos[self.currentPosition]) then
		self.currentPosition = 2;
	end
	self.timer = setTimer(function() self:MoveToNextPoint() end, time+3000, 1)
end

-- ///////////////////////////////
-- ///// Start	 			//////
-- ///////////////////////////////

function RegisterFlyManager:Start()
	setTime(21, 00);
	setMinuteDuration(60000);
	setWeather(13);
	
	showPlayerHudComponent("all", false);
	showChat(false);
	fadeCamera(true);
	
	self.currentPosition = math.random(2, #self.flyPos);
	
		
	self:MoveToNextPoint();
end

-- ///////////////////////////////
-- ///// Stop	 			//////
-- ///////////////////////////////

function RegisterFlyManager:Stop()
	killTimer(self.timer);
	
	cameraMover:StopCam();
	
	showPlayerHudComponent("crosshair", true);	
end

-- ///////////////////////////////
-- ///// Constructor 		//////
-- ///////////////////////////////

function RegisterFlyManager:Constructor(...)
	self.flyPos = {
		{-2421.45703125, -610.16052246094, 132.43156433105, -2482.3024902344, -530.84484863281, 129.81436157227, 10000},
		{-2585.1826171875, -408.16616821289, 120.08306884766, -2528.4958496094, -330.12405395508, 93.700622558594, 10000},
		{-2409.2199707031, -203.67213439941, 50.799388885498, -2346.5185546875, -126.2219619751, 59.165618896484, 10000},
		{-2224.1396484375, -180.28201293945, 54.065509796143, -2144.5415039063, -239.9940032959, 44.13542175293, 10000},
		{-1797.4462890625, -352.48107910156, 102.87297058105, -1875.0300292969, -291.77462768555, 85.683280944824, 10000},
		{-1797.4462890625, -352.48107910156, 102.87297058105, -1875.0300292969, -291.77462768555, 85.683280944824, 10000},
		{-1617.6850585938, 410.1877746582, 17.410648345947, -1715.0037841797, 426.03247070313, 0.73690032958984, 10000},
		{-1511.6297607422, 534.45178222656, 23.337379455566, -1441.0220947266, 605.24792480469, 24.907827377319, 10000},
		{-1558.0095214844, 859.12066650391, 17.157531738281, -1651.1374511719, 822.72381591797, 15.587108612061, 10000},
		{-1768.7059326172, 829.5439453125, 39.112529754639, -1863.2985839844, 861.82965087891, 42.253021240234, 10000},
		{-2004.5698242188, 845.08612060547, 50.96688079834, -2003.9871826172, 745.08917236328, 50.443389892578, 10000},
		{-2004.9085693359, 329.06494140625, 48.399108886719, -2003.2791748047, 229.0905456543, 46.828678131104, 10000},
		{-1967.4924316406, 190.49234008789, 42.382923126221, -2030.7946777344, 113.86042022705, 31.411560058594, 10000},
		{-2291.3823242188, -38.360778808594, 86.767127990723, -2321.5739746094, -133.17565917969, 96.697242736816, 10000},
		{-2580.0969238281, -253.65232849121, 62.109268188477, -2644.0170898438, -179.75674438477, 40.810188293457, 10000},
		{-2914.5854492188, -326.78280639648, 48.641216278076, -2822.6694335938, -365.94827270508, 52.827995300293, 10000},
		{-3039.2878417969, -791.92694091797, 129.39453125, -2980.9152832031, -873.07989501953, 132.01173400879, 10000},
		{-2301.9506835938, -1395.9398193359, 409.81405639648, -2258.5266113281, -1325.8880615234, 353.18280029297, 10000},
		{-2639.8481445313, -801.82006835938, 234.33581542969, -2574.8142089844, -736.76727294922, 195.10914611816, 10000},
		{-2329.3161621094, -661.0263671875, 165.27005004883, -2358.1647949219, -567.23272705078, 146.021484375, 10000},
	}
	
	self.currentPosition = 2;
	self.renderFunc = function() self:Render() end;
	
	
	logger:OutputInfo("[CALLING] RegisterFlyManager: Constructor");
end

-- EVENT HANDLER --
