local KEY_FOR_OPEN_DEBUG = 11 -- KEY_0

local function OpenDebug(key)
	if key == KEY_FOR_OPEN_DEBUG then
		print(Go_To:Debug())
	end
end
	
Events.OnKeyKeepPressed.Add(OpenDebug)  

local textManager = getTextManager();

local screenX = 65;
local screenY = 1;

local r = 0.1
local g = 0.8
local b = 1

local function getCoords()
	local player = getSpecificPlayer(0)
	if player then

		local playerX = player:getX();
		local playerY = player:getY();
		local playerZ = player:getZ();
		
		local txt = "POS PLAYER: " .. playerX .. " x " .. playerY .. " x " .. playerZ .. "\n"
		
		local v1 = player:getVehicle()
		if not v1 then
			textManager:DrawString(UIFont.Large, screenX, screenY + 7, txt, r, g, b, 1);
			return
		end
	
		local v1Points = { 0, 0 }
		--txt = txt .. "POS CAR get: " .. v1:getX() .. " x " .. v1:getY() .. " x " .. v1:getZ() .. "\n" ..					 
		textManager:DrawString(UIFont.Large, screenX, screenY + 7, txt, r, g, b, 1);
		
	end
end

local function round(_num)
	local number = _num;
	return number <= 0 and floor(number) or floor(number + 0.5);
end

local function init()
	Events.OnPostUIDraw.Add(getCoords);
end

Events.OnGameStart.Add(init)