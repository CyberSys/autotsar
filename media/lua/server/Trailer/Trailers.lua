

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
	Vehicles.Update.GasTank(trailer, part, elapsedMinutes)
	local amount = part:getContainerContentAmount()
	if elapsedMinutes > 0 and amount > 0 and trailer:isEngineRunning() then
		if trailer:getModData()["generatorObject"] then
			trailer:getModData()["generatorObject"]:setFuel(amount/part:getContainerCapacity() * 100)
		end
	end
end
