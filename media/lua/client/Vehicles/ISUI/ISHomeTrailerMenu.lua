require('TowingCar/TowingUI')


local old_ISVehicleMenu_showRadialMenu = ISVehicleMenu.showRadialMenu

function ISVehicleMenu.showRadialMenu(playerObj)

	old_ISVehicleMenu_showRadialMenu(playerObj)

	local vehicle = playerObj:getVehicle()
	if vehicle ~= nil then
		local menu = getPlayerRadialMenu(playerObj:getPlayerNum())
		
		local seat = vehicle:getSeat(playerObj)
		if string.match(vehicle:getScript():getName(), "HomeTrailer") and seat == 1 then
			--print("AUTOTSAR: ACTION IS -4")

			if vehicle:isEngineRunning() then
				menu:addSlice(getText("ContextMenu_VehicleShutOff"), getTexture("media/ui/vehicles/vehicle_ignitionOFF.png"), ISVehicleMenu.onShutOffHomeTrailerEngine, playerObj)
				--print("AUTOTSAR: ACTION IS -2")
			else
				if vehicle:isEngineStarted() then
					--print("AUTOTSAR: ACTION IS -1")
	--				menu:addSlice("Ignition", getTexture("media/ui/vehicles/vehicle_ignitionON.png"), ISVehicleMenu.onStartEngine, playerObj)
				else
					--print("AUTOTSAR: ACTION IS 0")
					if (SandboxVars.VehicleEasyUse) then
						--print("AUTOTSAR: ACTION IS 1")
						menu:addSlice(getText("ContextMenu_VehicleStartEngine"), getTexture("media/ui/vehicles/vehicle_ignitionON.png"), ISVehicleMenu.onStartHomeTrailerEngine, playerObj)
					elseif not vehicle:isHotwired() and (playerObj:getInventory():haveThisKeyId(vehicle:getKeyId()) or vehicle:isKeysInIgnition()) then
						--print("AUTOTSAR: ACTION IS 2")
						menu:addSlice(getText("ContextMenu_VehicleStartEngine"), getTexture("media/ui/vehicles/vehicle_ignitionON.png"), ISVehicleMenu.onStartHomeTrailerEngine, playerObj)
					elseif not vehicle:isHotwired() and ((playerObj:getPerkLevel(Perks.Electricity) >= 1 and playerObj:getPerkLevel(Perks.Mechanics) >= 2) or playerObj:HasTrait("Burglar"))then
	--					menu:addSlice("Hotwire Vehicle", getTexture("media/ui/vehicles/vehicle_ignitionON.png"), ISVehicleMenu.onHotwire, playerObj)
					elseif vehicle:isHotwired() then
						--print("AUTOTSAR: ACTION IS 3")
						menu:addSlice(getText("ContextMenu_VehicleStartEngine"), getTexture("media/ui/vehicles/vehicle_ignitionON.png"), ISVehicleMenu.onStartHomeTrailerEngine, playerObj)
					else
	--					menu:addSlice("You need keys or\nelectricity level 1 and\nmechanic level 2\nto hotwire", getTexture("media/ui/vehicles/vehicle_ignitionOFF.png"), nil, playerObj)
					end
				end
			end
			--print("TSARCRAFT: 1111test")
			if not vehicle:isHotwired() and
					not vehicle:isEngineStarted() and
					not vehicle:isEngineRunning() and
					not SandboxVars.VehicleEasyUse and
					not vehicle:isKeysInIgnition() and
					not playerObj:getInventory():haveThisKeyId(vehicle:getKeyId()) then
				--print("TSARCRAFT: hotwire")
				if ((playerObj:getPerkLevel(Perks.Electricity) >= 1 and playerObj:getPerkLevel(Perks.Mechanics) >= 2) or playerObj:HasTrait("Burglar")) then
					--print("TSARCRAFT: 1 hotwire")
					menu:addSlice(getText("ContextMenu_VehicleHotwire"), getTexture("media/ui/vehicles/vehicle_ignitionON.png"), ISVehicleMenu.onHotwireHomeTrailer, playerObj)
				else
					--print("TSARCRAFT: 2 hotwire")
					menu:addSlice(getText("ContextMenu_VehicleHotwireSkill"), getTexture("media/ui/vehicles/vehicle_ignitionOFF.png"), nil, playerObj)
				end
			end
			
			if vehicle:isTrunkLocked() then
				menu:addSlice(getText("ContextMenu_Open_trunk"), getTexture("media/ui/vehicles/vehicle_open_home_trunk.png"), ISVehicleMenu.onToggleTrunkLocked, playerObj)
			else
				menu:addSlice(getText("ContextMenu_Close_trunk"), getTexture("media/ui/vehicles/vehicle_open_home_trunk.png"), ISVehicleMenu.onToggleTrunkLocked, playerObj)
			end
		end

		menu:addToUIManager()

	end
end

function ISVehicleMenu.onStartHomeTrailerEngine(playerObj)
	ISTimedActionQueue.add(ISStartHomeTrailerEngine:new(playerObj))
end

function ISVehicleMenu.onShutOffHomeTrailerEngine(playerObj)
	ISTimedActionQueue.add(ISShutOffHomeTrailerEngine:new(playerObj))
end

function ISVehicleMenu.onHotwireHomeTrailer(playerObj)
	ISTimedActionQueue.add(ISHotwireHomeTrailer:new(playerObj))
end

