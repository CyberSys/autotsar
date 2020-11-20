require "Vehicles/VehicleDistributions"

local distributionTable = VehicleDistributions[1]

VehicleDistributions.AutotsarTrailer = {
	TruckBed =
	{
		rolls = 1,
		items = {
			"LugWrench", 5,
			"TirePump", 5,
			"NormalTire2", 5,
			"Jack", 5,
			"Wrench", 5,
			"Screwdriver", 5,
			"CarBattery2", 5,
			"FirstAidKit", 5,
			"DuctTape", 3,
			"Twine", 3,
			"Tarp", 3,
			"EmptySandbag", 3,
			"LeadPipe", 1,
			"MetalPipe", 1,
			"PipeWrench", 1,
			"BaseballBat", 1,
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
			"Crisps",5,
			"Crisps2", 5,
			"Crisps3", 5,
			"Crisps4", 5,
			"Cereal", 5,
			"Dogfood", 5,
			"TVDinner",5,
			"TinnedSoup", 5,
			"TinnedBeans", 5,
			"CannedCornedBeef", 2,
			"Macandcheese", 2,
			"CannedChili", 2,
			"CannedBolognese", 2,
			"CannedCarrots2", 2,
			"CannedCorn", 2,
			"CannedMushroomSoup", 2,
			"CannedPeas", 2,
			"CannedPotato2", 2,
			"CannedSardines", 2,
			"CannedTomato2", 2,
			"ShotgunShellsBox", 3,
			"ShotgunShellsBox", 3,
			"Shotgun", 0.8,
			"DoubleBarrelShotgun", 1,
			"Pillow", 0.8,
			"SmokeBomb", 0.5,
			"FlameTrap", 0.5,
			"Aerosolbomb", 0.5,
			"camping.CampfireKit", 0.9,
			"farming.CarrotBagSeed", 0.5,
			"farming.BroccoliBagSeed", 0.5,
			"farming.RedRadishBagSeed", 0.5,
			"farming.StrewberrieBagSeed", 0.5,
			"farming.TomatoBagSeed", 0.5,
			"farming.PotatoBagSeed", 0.5,
			"farming.CabbageBagSeed", 0.5,
			"farming.HandShovel", 0.5,
			"farming.Shovel", 5,
			"farming.WateredCan", 2,
			"BookFarming1", 0.5,
			"BookForaging1", 0.5,
			"BookForaging2", 0.5,
			"BookForaging3", 0.7,
			"BookForaging4", 0.5,
			"BookForaging5", 0.3,
			"FarmingMag1", 0.5,
			"BookFarming2", 0.5,
			"BookFarming3", 0.5,
			"BookFarming4", 0.5,
			"BookFarming5", 0.6,
			"CompostBag", 1,
			"Fertilizer", 1,
			}
	}
}

VehicleDistributions.AutotsarKbac = {
	TruckBed =
	{
		rolls = 1,
		items = {
			"Base.EmptyPetrolCan", 101,
			"LugWrench", 5,
			"TirePump", 5,
			"NormalTire2", 5,
			"Jack", 5,
			"Wrench", 5,
			"Screwdriver", 5,
			"CarBattery2", 5,
			"FirstAidKit", 5,
			"DuctTape", 3,
			"Twine", 3,
			"Tarp", 3,
			"EmptySandbag", 3,
			"LeadPipe", 1,
			"MetalPipe", 1,
			"PipeWrench", 1,
			"BaseballBat", 1,
			"CorpseMale", 0.01,
			"CorpseFemale", 0.01,
			"Crisps",5,
			"Crisps2", 5,
			"Crisps3", 5,
			"Crisps4", 5,
			"Cereal", 5,
			"Dogfood", 5,
			"TVDinner",5,
			"TinnedSoup", 5,
			"TinnedBeans", 5,
			"CannedCornedBeef", 2,
			"Macandcheese", 2,
			"CannedChili", 2,
			}
	}
}



distributionTable["FirstTrailer"] = {
		Normal = VehicleDistributions.AutotsarTrailer,
		Specific = { VehicleDistributions.Groceries, VehicleDistributions.Fisherman, VehicleDistributions.Carpenter, VehicleDistributions.Farmer, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.TowBar},
}

distributionTable["SecondTrailer"] = {
		Normal = VehicleDistributions.AutotsarTrailer,
		Specific = { VehicleDistributions.Groceries, VehicleDistributions.Fisherman, VehicleDistributions.Carpenter, VehicleDistributions.Farmer, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.TowBar},
}

distributionTable["HomeTrailer"] = {
		Normal = VehicleDistributions.AutotsarTrailer,
		Specific = { VehicleDistributions.Groceries, VehicleDistributions.Fisherman, VehicleDistributions.Carpenter, VehicleDistributions.Farmer, VehicleDistributions.Electrician, VehicleDistributions.MetalWelder, VehicleDistributions.ConstructionWorker, VehicleDistributions.Painter, VehicleDistributions.TowBar},
}

distributionTable["KbacTrailer"] = {
		Normal = VehicleDistributions.AutotsarKbac,
}

