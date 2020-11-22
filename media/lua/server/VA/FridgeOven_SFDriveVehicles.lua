--require 'Vehicles/Vehicles'

--
-- CREATE PART
--

function Vehicles.Create.Dont(vehicle, part)
	--used for parts that need to be installed never found in cars
end

function Vehicles.Create.Fridge(vehicle, part)
	local invItem = VehicleUtils.createPartInventoryItem(part);

	if part:getInventoryItem() and part:getItemContainer() then
		part:getModData().coolerActive = true
		part:getItemContainer():setType("fridge")
		part:getItemContainer():setCustomTemperature(0.2)
	end
end

function Vehicles.Create.Oven(vehicle, part)
	local invItem = VehicleUtils.createPartInventoryItem(part);

	if part:getInventoryItem() and part:getItemContainer() then
		part:getItemContainer():setType("stove")
		part:getItemContainer():setActive(false)
		part:getModData().ovenActive = false
	end
end

function Vehicles.Create.HalfChance(vehicle, part)
	if ZombRand(100) < 50 then
		local invItem = VehicleUtils.createPartInventoryItem(part);
	end
end

function Vehicles.Create.BadChance(vehicle, part)
	if ZombRand(100) < 25 then
		local invItem = VehicleUtils.createPartInventoryItem(part);
	end
end

function Vehicles.Create.GoodChance(vehicle, part)
	if ZombRand(100) < 75 then
		local invItem = VehicleUtils.createPartInventoryItem(part);
	end
end

--
-- CONTAINER ACCESS
--

function Vehicles.ContainerAccess.Counter(vehicle, part, chr)
	if not part:getInventoryItem() then return false; end
	if chr:getVehicle() == vehicle then
		local seat = vehicle:getSeat(chr)
		-- Can the seated player reach the passenger seat?
		-- Only character in front seat can access it
		return seat == 2 or seat == 3;
	elseif chr:getVehicle() then
		-- Can't reach from inside a different vehicle.
		return false
	else
		return false
	end
end

--
-- INITIALIZE PARTS
--

--
-- REMOVE PARTS
--

--
-- UPDATE PARTS
--

function Vehicles.Update.Fridge(vehicle, part, elapsedMinutes)
	--print("UPDATE FRIDGE?")

	if part:getInventoryItem() and part:getItemContainer() and part:getModData().coolerActive then
		local batteryChange = -0.000050;
		local id = vehicle:getId()

		if isClient() then
			--sendClientCommand(getPlayer(), 'SFDrive', 'updateCarFridge', { id = id, elapsedMinutes = elapsedMinutes, batteryChange = batteryChange })
			if vehicle:getBatteryCharge() <= 0.0 then
				part:getModData().coolerActive = false
				vehicle:transmitPartModData(part)
			else
				part:getItemContainer():setCustomTemperature(0.2)
				vehicle:transmitPartModData(part)

				if not vehicle:isEngineRunning() then
					VehicleUtils.chargeBattery(vehicle, batteryChange * elapsedMinutes)
				end
			end

		elseif isServer() then
			--sendServerCommand('SFDrive', 'updateCarFridge', { id = id, elapsedMinutes = elapsedMinutes, batteryChange = batteryChange })
		else
			if vehicle:getBatteryCharge() <= 0.0 then
				part:getModData().coolerActive = false
			else
				part:getItemContainer():setCustomTemperature(0.2)

				if not vehicle:isEngineRunning() then
					VehicleUtils.chargeBattery(vehicle, batteryChange * elapsedMinutes)
				end
			end
		end
	end
end

function Vehicles.Update.Oven(vehicle, part, elapsedMinutes)
	--print("UPDATE OVEN SERVER?")
	local id = vehicle:getId()
	part = vehicle:getPartById("Oven")
	--print(part:getItemContainer():isActive())
	if isClient() then
		--print("Trying to update client oven")
		sendClientCommand(getPlayer(), 'SFDrive', 'updateCarOven', { id = vehicle:getId() })
	elseif isServer() then
		--print("Trying to update server oven")
		sendServerCommand('SFDrive', 'updateCarOven', { id = id, elapsedMinutes = elapsedMinutes, batteryChange = batteryChange })
	else
	if part:getInventoryItem() and part:getItemContainer() and part:getItemContainer():isActive() then
		local currentTemp = part:getItemContainer():getTemprature()
		--print(tostring(currentTemp))
		local maxTemp = 2.0

		if currentTemp < maxTemp then
			part:getItemContainer():setCustomTemperature(currentTemp + (0.05 * elapsedMinutes))
		elseif currentTemp > maxTemp then
			part:getItemContainer():setCustomTemperature(maxTemp)
		end
	end

	if part:getInventoryItem() and part:getItemContainer() and not part:getItemContainer():isActive() then
		local currentTemp = part:getItemContainer():getTemprature()
		--print(tostring(currentTemp))
		local minTemp = 1.0

		if currentTemp > minTemp then
			part:getItemContainer():setCustomTemperature(currentTemp - (0.05 * elapsedMinutes))
		elseif currentTemp < minTemp then
			part:getItemContainer():setCustomTemperature(minTemp)
		end
	end
	end
end

--
-- USE OR ACTIVATE PARTS
--

function Vehicles.Use.Oven(vehicle, cont, player)
	local id = vehicle:getId()
	if isClient() then
		sendClientCommand(getPlayer(), 'SFDrive', 'useCarOven', { player = player:getUsername(), id = id })
	else
		if cont:isActive() then
			cont:setActive(false)
			player:getEmitter():playSound("PZ_Switch")
			--print("Oven Off")
		elseif vehicle:getBatteryCharge() > 0.00005 then
			cont:setActive(true)
			VehicleUtils.chargeBattery(vehicle, -0.00005)
			player:getEmitter():playSound("PZ_Switch")
			--print("Oven On")
		end
	end
end

function Vehicles.Create.PoliceGunRack(vehicle, part)
	local ranger = true
	local skin = vehicle:getSkinIndex()
	--print("SKIN INDEX " .. tostring(skin))
	if skin > 0 then
		ranger = false
	end
	if ranger then
		local invItem = VehicleUtils.createPartInventoryItem(part);
	end

end

function Vehicles.Create.GunRack(vehicle, part)

	if ZombRand(100) < 50 then
		local invItem = VehicleUtils.createPartInventoryItem(part);
	end

end

function Vehicles.UninstallTest.GunRack(vehicle, part, chr)
	if ISVehicleMechanics.cheat then return true; end
	local keyvalues = part:getTable("uninstall")
	if not keyvalues then return false end
	if not part:getInventoryItem() then return false end
	if not part:getItemType() or part:getItemType():isEmpty() then return false end
	local typeToItem = VehicleUtils.getItems(chr:getPlayerNum())
	if keyvalues.requireUninstalled and (vehicle:getPartById(keyvalues.requireUninstalled) and vehicle:getPartById(keyvalues.requireUninstalled):getInventoryItem()) then
		return false;
	end
	if not VehicleUtils.testProfession(chr, keyvalues.professions) then return false end
	-- allow all perk, but calculate success/failure risk
--	if not VehicleUtils.testPerks(chr, keyvalues.skills) then return false end
	if not VehicleUtils.testRecipes(chr, keyvalues.recipes) then return false end
	if not VehicleUtils.testTraits(chr, keyvalues.traits) then return false end
	if not VehicleUtils.testItems(chr, keyvalues.items, typeToItem) then return false end	
	--print("AMOUNT: " .. tostring((round(part:getContainerContentAmount(), 3))))	
	--print("AMOUNT: " .. tostring((part:getContainerContentAmount())))
	if (part:getContainerContentAmount()) > 0 then return false end
	local seatNumber = part:getContainerSeatNumber()
	local seatOccupied = (seatNumber ~= -1) and vehicle:isSeatOccupied(seatNumber)
	if keyvalues.requireEmpty and seatOccupied then return false end
	-- if doing mechanics on this part require key but player doesn't have it, we'll check that door or windows aren't unlocked also
	if VehicleUtils.RequiredKeyNotFound(part, chr) then
		return false
	end
	return true
end

function Vehicles.ContainerAccess.GunRack(vehicle, part, chr)
	if not part:getInventoryItem() then
        return false
    end
	if chr:getVehicle() == vehicle then
		local seat = vehicle:getSeat(chr)
		-- Can the seated player reach the passenger seat?
		-- Only character in front seat can access it
		return seat == 1 or seat == 0;
	elseif chr:getVehicle() then
		-- Can't reach from inside a different vehicle.
		return false
	else
		-- Standing outside the vehicle.
		if not vehicle:isInArea(part:getArea(), chr) then return false end
		local doorPart = vehicle:getPartById("DoorFrontRight")
		if doorPart and doorPart:getDoor() and not doorPart:getDoor():isOpen() then
			return false
		end
		return true
	end
end

