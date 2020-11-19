if VehicleZoneDistribution then -- check if the table exists for backwards compatibility

-- Parking Stall, common parking stall with random cars, the most used one (shop parking lots, houses etc.)
VehicleZoneDistribution.parkingstall.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.parkingstall.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 4};
VehicleZoneDistribution.parkingstall.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 2};
VehicleZoneDistribution.parkingstall.vehicles["Base.KbacTrailer"] = {index = -1, spawnChance = 1};


-- Trailer Parks, have a chance to spawn burnt cars, some on top of each others, it's like a pile of junk cars
VehicleZoneDistribution.trailerpark.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.trailerpark.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 4};
VehicleZoneDistribution.trailerpark.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 20};

-- bad vehicles, moslty used in poor area, sometimes around pub etc.
VehicleZoneDistribution.bad.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.bad.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 4};
VehicleZoneDistribution.bad.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 5};

-- medium vehicles, used in some of the good looking area, or in suburbs
VehicleZoneDistribution.medium.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.medium.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 4};
VehicleZoneDistribution.medium.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 5};

-- good vehicles, used in good looking area, they're meant to spawn only good cars, so they're on every good looking house.
VehicleZoneDistribution.good.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.good.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 10};
VehicleZoneDistribution.good.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 5};

-- junkyard, spawn damaged & burnt vehicles, less chance of finding keys but more cars.
-- also used for the random car crash.
VehicleZoneDistribution.junkyard.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 8};
VehicleZoneDistribution.junkyard.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.junkyard.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.junkyard.vehicles["Base.KbacTrailer"] = {index = -1, spawnChance = 1};

-- traffic jam, mostly burnt car & damaged ones.
-- Used either for hard coded big traffic jam or smaller random ones.
VehicleZoneDistribution.trafficjamw.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.trafficjamw.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.trafficjamw.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 5};
VehicleZoneDistribution.trafficjamw.vehicles["Base.KbacTrailer"] = {index = -1, spawnChance = 1};

VehicleZoneDistribution.farm = VehicleZoneDistribution.farm or {}
VehicleZoneDistribution.farm.vehicles = VehicleZoneDistribution.farm.vehicles or {}
VehicleZoneDistribution.farm.vehicles["Base.FirstTrailer"] = {index = -1, spawnChance = 8};
VehicleZoneDistribution.farm.vehicles["Base.SecondTrailer"] = {index = -1, spawnChance = 15};
VehicleZoneDistribution.farm.vehicles["Base.HomeTrailer"] = {index = -1, spawnChance = 15};

end