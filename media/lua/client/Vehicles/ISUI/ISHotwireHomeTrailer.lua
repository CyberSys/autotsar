require "TimedActions/ISBaseTimedAction"

ISHotwireHomeTrailer = ISBaseTimedAction:derive("ISHotwireHomeTrailer")

function hotwireHomeTrailerEngine(player, args)
	local electricSkill = args.electricSkill;
	player:getVehicle():tryHotwire(electricSkill);
end

function ISHotwireHomeTrailer:isValid()
	local vehicle = self.character:getVehicle()
	return vehicle ~= nil and
		not vehicle:isEngineRunning() and 
		not vehicle:isEngineStarted()
end

function ISHotwireHomeTrailer:update()
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISHotwireHomeTrailer:start()
end

function ISHotwireHomeTrailer:stop()
	ISBaseTimedAction.stop(self)
end

function ISHotwireHomeTrailer:perform()
--	local vehicle = self.character:getVehicle()
	hotwireHomeTrailerEngine (self.character,  {electricSkill=self.character:getPerkLevel(Perks.Electricity)})
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISHotwireHomeTrailer:new(character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.maxTime = 200 - (character:getPerkLevel(Perks.Electricity) * 3);
	return o
end