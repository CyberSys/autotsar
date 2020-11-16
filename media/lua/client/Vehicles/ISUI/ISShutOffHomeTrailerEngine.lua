require "TimedActions/ISBaseTimedAction"

ISShutOffHomeTrailerEngine = ISBaseTimedAction:derive("ISShutOffHomeTrailerEngine")

function ISShutOffHomeTrailerEngine:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and
		vehicle:isEngineRunning()
end

function ISShutOffHomeTrailerEngine:update()
	self:forceComplete()
end

function ISShutOffHomeTrailerEngine:start()
end

function ISShutOffHomeTrailerEngine:stop()
	ISBaseTimedAction.stop(self)
end

function ISShutOffHomeTrailerEngine:perform()
	local vehicle = self.character:getVehicle()
	vehicle:shutOff()
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISShutOffHomeTrailerEngine:new(character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.maxTime = -1
	return o
end