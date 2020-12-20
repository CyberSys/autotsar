

Trailers = {}
Trailers.CheckEngine = {}
Trailers.CheckOperate = {}
Trailers.ContainerAccess = {}
Trailers.Create = {}
Trailers.Init = {}
Trailers.InstallComplete = {}
Trailers.InstallTest = {}
Trailers.UninstallComplete = {}
Trailers.UninstallTest = {}
Trailers.Update = {}
Trailers.Use = {}

function Trailers.Update.GeneratorGasTank(trailer, part, elapsedMinutes)
	-- print("Trailers.Update.GeneratorGasTank")
	Vehicles.Update.GasTank(trailer, part, elapsedMinutes)
	local amount = part:getContainerContentAmount()
	if elapsedMinutes > 0 and amount > 0 and trailer:isEngineRunning() then
		if trailer:getModData()["generatorObject"] then
			trailer:getModData()["generatorObject"]:setFuel(amount/part:getContainerCapacity() * 100)
		end
	end
	if trailer:getModData()["generatorObject"] then
		trailer:getModData()["generatorObject"]:setCondition(trailer:getPartById("Engine"):getCondition())
		if trailer:getPartById("Engine"):getCondition() < 1 then
			trailer:getModData()["generatorObject"]:setActivated(false)
		end
	end
end

function Trailers.UninstallComplete.GeneratorGasTank(trailer, part, item)
	-- print("Trailers.UninstallComplete.GeneratorGasTank")
	if trailer:getModData()["generatorObject"] then
		trailer:getModData()["generatorObject"]:setFuel(0.0)
		trailer:getModData()["generatorObject"]:setActivated(false)
	end
end

function Trailers.Create.EarthingOn(trailer, part)
	local item = VehicleUtils.createPartInventoryItem(part);
	part:setInventoryItem(nil)
end

function Trailers.Create.EarthingOff(trailer, part)
	local item = VehicleUtils.createPartInventoryItem(part);
end

function Trailers.Create.BatteryCharger(trailer, part)
	local item = VehicleUtils.createPartInventoryItem(part);
	part:setInventoryItem(nil)
end

function Trailers.Update.BatteryCharger(trailer, part, elapsedMinutes)
	if part:getInventoryItem() then
		local chargeOld = part:getInventoryItem():getUsedDelta()
		local charge = chargeOld
		-- Running the engine charges the battery
		if elapsedMinutes > 0 and trailer:isEngineRunning() then
			charge = math.min(charge + elapsedMinutes * 0.0001, 1.0)
		end
		if charge ~= chargeOld then
			part:getInventoryItem():setUsedDelta(charge)
			if VehicleUtils.compareFloats(chargeOld, charge, 2) then
				trailer:transmitPartUsedDelta(part)
			end
		end
	end
end

-- function Trailers.Update.Earthing(trailer, part)

-- end

-- function Trailers.Update.GeneratorEngine(trailer, part, elapsedMinutes)
-- print("Trailers.Update.GeneratorEngine")
	-- Vehicles.Update.Engine(trailer, part, elapsedMinutes)
	-- if trailer:getModData()["generatorObject"] then
		-- trailer:getModData()["generatorObject"]:setCondition(part:getCondition())
	-- end
-- end