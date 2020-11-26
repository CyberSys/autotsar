--require 'Vehicles/Vehicles'

function Vehicles.Create.Fridge(vehicle, part)
	--print("TC: Create Fridge")
	local invItem = VehicleUtils.createPartInventoryItem(part);

	if part:getInventoryItem() and part:getItemContainer() then
	if vehicle:getBatteryCharge() > 0.00005 then
		part:getModData().coolerActive = true
	else
		part:getModData().coolerActive = false
	end
		part:getItemContainer():setType("fridge")
		part:getItemContainer():setCustomTemperature(0.2)
	end
end

function Vehicles.Init.Fridge(vehicle, part)
	--print("TC: Init Fridge")
	part:setModelVisible("test", true)
	if vehicle:getBatteryCharge() > 0.00005 then
		part:getModData().coolerActive = true
	else
		part:getModData().coolerActive = false
	end
	
	part:getItemContainer():setType("fridge")
	part:getItemContainer():setCustomTemperature(0.2)
end

function Vehicles.Update.Fridge(vehicle, part, elapsedMinutes)
	--print("TC: Update Fridge")
	if part:getInventoryItem() and part:getItemContainer() and part:getModData().coolerActive then
		--print("ACTIVE")
		local batteryChange = -0.000050;

		if vehicle:getBatteryCharge() <= 0.0 then
			part:getModData().coolerActive = false
		else
			part:getItemContainer():setCustomTemperature(0.2)
			--print("COOLER")
			if not vehicle:isEngineRunning() then
				VehicleUtils.chargeBattery(vehicle, batteryChange * elapsedMinutes)
			end
		end
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


function Vehicles.Init.Oven(vehicle, part)
	--print("TC: Init Oven")
	part:setModelVisible("test", true)
	if part:getInventoryItem() and part:getItemContainer() and part:getItemContainer():isActive() and vehicle:isEngineRunning() then
		part:getItemContainer():setCustomTemperature(2.0)
	else		
		part:getItemContainer():setCustomTemperature(1.0)
	end
	
end

function Vehicles.Use.Oven(vehicle, cont, player)
	--print("TC: Use Fridge")
	local id = vehicle:getId()
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

function Vehicles.Update.Oven(vehicle, part, elapsedMinutes)
	--print("UPDATE OVEN SERVER?")
	local id = vehicle:getId()
	part = vehicle:getPartById("Oven")
	--print(part:getItemContainer():isActive())
	
	if part:getInventoryItem() and part:getItemContainer() and part:getItemContainer():isActive() and vehicle:isEngineRunning() then
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

