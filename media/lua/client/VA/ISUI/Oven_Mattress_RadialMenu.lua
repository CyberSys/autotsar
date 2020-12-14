require('Vehicles/ISUI/ISTrailerHomeMenu')


local old_ISVehicleMenu_showRadialMenu = ISVehicleMenu.showRadialMenu

function ISVehicleMenu.showRadialMenu(playerObj)

	old_ISVehicleMenu_showRadialMenu(playerObj)

	local isPaused = UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0
	if isPaused then return end

	local vehicle = playerObj:getVehicle()
	if vehicle ~= nil then

		local menu = getPlayerRadialMenu(playerObj:getPlayerNum())
		--menu:clear()

		if menu:isReallyVisible() then
			if menu.joyfocus then
				setJoypadFocus(playerObj:getPlayerNum(), nil)
			end
			menu:undisplay()
			return
		end

		menu:setX(getPlayerScreenLeft(playerObj:getPlayerNum()) + getPlayerScreenWidth(playerObj:getPlayerNum()) / 2 - menu:getWidth() / 2)
		menu:setY(getPlayerScreenTop(playerObj:getPlayerNum()) + getPlayerScreenHeight(playerObj:getPlayerNum()) / 2 - menu:getHeight() / 2)

		local texture = getTexture("media/ui/abutton.png")
		
		local seat = vehicle:getSeat(playerObj)
		
		local oven = vehicle:getPartById("Oven")
		
		local mattress = vehicle:getPartById("Mattress")
		
		if oven and oven:getItemContainer():isActive() and Vehicles.ContainerAccess.Counter(vehicle, oven, playerObj) then
			menu:addSlice(getText("IGUI_Turn_Oven_Off"), getTexture("media/ui/Container_Oven"), ISVehicleMenu.ToggleOven, playerObj)
		end
		if oven and oven:getItemContainer():isActive() == false and Vehicles.ContainerAccess.Counter(vehicle, oven, playerObj) then
			menu:addSlice(getText("IGUI_Turn_Oven_On"), getTexture("media/ui/Container_Oven"), ISVehicleMenu.ToggleOven, playerObj)
		end

		if mattress and (not isClient() or getServerOptions():getBoolean("SleepAllowed")) then
			local doSleep = true;
			if playerObj:getStats():getFatigue() <= 0.3 then
				menu:addSlice(getText("IGUI_Sleep_NotTiredEnough_Mattress"), getTexture("media/ui/mattress.png"), nil, playerObj, vehicle)
				doSleep = false;
			elseif vehicle:getCurrentSpeedKmHour() > 1 or vehicle:getCurrentSpeedKmHour() < -1 then
				menu:addSlice(getText("IGUI_PlayerText_CanNotSleepInMovingCar_Mattress"), getTexture("media/ui/mattress.png"), nil, playerObj, vehicle)
				doSleep = false;
			else
				-- Sleeping pills counter those sleeping problems
				if playerObj:getSleepingTabletEffect() < 2000 then
					-- In pain, can still sleep if really tired
					if playerObj:getMoodles():getMoodleLevel(MoodleType.Pain) >= 2 and playerObj:getStats():getFatigue() <= 0.85 then
						menu:addSlice(getText("ContextMenu_PainNoSleep_Mattress"), getTexture("media/ui/mattress.png"), nil, playerObj, vehicle)
						doSleep = false;
						-- In panic
					elseif playerObj:getMoodles():getMoodleLevel(MoodleType.Panic) >= 1 then
						menu:addSlice(getText("ContextMenu_PanicNoSleep_Mattress"), getTexture("media/ui/mattress.png"), nil, playerObj, vehicle)
						doSleep = false;
						-- tried to sleep not so long ago
					elseif (playerObj:getHoursSurvived() - playerObj:getLastHourSleeped()) <= 1 then
						menu:addSlice(getText("ContextMenu_NoSleepTooEarly_Mattress"), getTexture("media/ui/mattress.png"), nil, playerObj, vehicle)
						doSleep = false;
					end
				end
			end
			if doSleep then
				menu:addSlice(getText("ContextMenu_Sleep_Mattress"), getTexture("media/ui/mattress.png"), ISVehicleMenu.onSleep, playerObj, vehicle);
			end
		end
	end
end

function ISVehicleMenu.ToggleOven(playerObj)
	local vehicle = playerObj:getVehicle()
	if not vehicle then return end
	Vehicles.Use.Oven(vehicle, vehicle:getPartById("Oven"):getItemContainer(), playerObj)
end