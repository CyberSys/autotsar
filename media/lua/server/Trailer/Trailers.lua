

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


-- function Trailers.Update.GeneratorEngine(trailer, part, elapsedMinutes)
-- print("Trailers.Update.GeneratorEngine")
	-- Vehicles.Update.Engine(trailer, part, elapsedMinutes)
	-- if trailer:getModData()["generatorObject"] then
		-- trailer:getModData()["generatorObject"]:setCondition(part:getCondition())
	-- end
-- end