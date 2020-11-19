if debugScenarios == nil then
	debugScenarios = {}
end


debugScenarios.AiteronScenario_Towing = {
	name = "Aiteron Towing Car",
--	forceLaunch = true, -- use this to force the launch of THIS scenario right after main menu was loaded, save more clicks! Don't do multiple scenarii with this options
	startLoc = {x=10596, y=9335, z=0 }, -- highway muldraugh
	--startLoc = {x=11480, y=8943, z=0 },
	
	
	setSandbox = function()
		
		SandboxVars.Speed = 3;
		SandboxVars.Zombies = 4; -- 5 = no zombies, 1 = insane (then 2 = low, 3 normal, 4 high..)
		SandboxVars.Distribution = 1;
		SandboxVars.Survivors = 1;
		SandboxVars.DayLength = 3;
		SandboxVars.StartYear = 1;
		SandboxVars.StartMonth = 7;
		SandboxVars.StartDay = 9;
		SandboxVars.StartTime = 2;
		SandboxVars.VehicleEasyUse = true;
		SandboxVars.WaterShutModifier = 14;
		SandboxVars.ElecShutModifier = 14;
		SandboxVars.WaterShut = 2;
		SandboxVars.ElecShut = 2;
		SandboxVars.FoodLoot = 2;
		SandboxVars.WeaponLoot = 2;
		SandboxVars.OtherLoot = 2;
		SandboxVars.Temperature = 3;
		SandboxVars.Rain = 3;
		SandboxVars.ErosionSpeed = 3;
		SandboxVars.XpMultiplier = 1.0;
		SandboxVars.StatsDecrease = 3;
		SandboxVars.NatureAbundance = 3;
		SandboxVars.Alarm = 4;
		SandboxVars.LockedHouses = 6;
		SandboxVars.FoodRotSpeed = 3;
		SandboxVars.FridgeFactor = 3;
		SandboxVars.Farming = 3;
		SandboxVars.LootRespawn = 1;
		SandboxVars.StarterKit = false;
		SandboxVars.Nutrition = true;
		SandboxVars.TimeSinceApo = 1;
		SandboxVars.PlantResilience = 3;
		SandboxVars.PlantAbundance = 3;
		SandboxVars.EndRegen = 3;
		SandboxVars.CarSpawnRate = 3;
		SandboxVars.LockedCar = 3;
		SandboxVars.CarAlarm = 2;
		SandboxVars.ChanceHasGas = 1;
		SandboxVars.InitialGas = 2;
		SandboxVars.CarGeneralCondition = 1;
		SandboxVars.RecentlySurvivorVehicles = 1;
		
		SandboxVars.ZombieLore = {
			Speed = 2,
			Strength = 2,
			Toughness = 2,
			Transmission = 1,
			Mortality = 5,
			Reanimate = 3,
			Cognition = 3,
			Memory = 2,
			Decomp = 1,
			Sight = 3,
			Hearing = 3,
			Smell = 2,
			ThumpNoChasing = 0,
		}
	end,
	onStart = function()
		local chr = getPlayer();
		local inv = chr:getInventory();
	
		chr:setGhostMode(true);
	
		-- adding some cooking level
		getPlayer():LevelPerk(Perks.Cooking);
		getPlayer():LevelPerk(Perks.Cooking);
		getPlayer():LevelPerk(Perks.Cooking);
		-- all the perks are: Agility, Cooking, Melee, Crafting, Fitness, Strength, Blunt, Axe, Sprinting, Lightfoot, Nimble, Sneak, Woodwork, Aiming, Reloading, Farming, Survivalist, Fishing, Trapping, Passiv, Firearm, PlantScavenging, Doctor, Electricity, Blacksmith, MetalWelding, Melting, Mechanics, Spear, Maintenance, SmallBlade, LongBlade, SmallBlunt, Combat,
	
		-- adding an axe!
		getPlayer():getInventory():AddItem("Base.Axe")
		
		-- adding a clip and 3 bullets in it
		local b = getPlayer():getInventory():AddItem("Base.223Clip");
		b:setCurrentAmmoCount(3);
	
		-- adding a broken kitchen knife
		local d = getPlayer():getInventory():AddItem("Base.KitchenKnife");
		d:setCondition(0);
		
		getPlayer():getInventory():AddItem("TowingCar.TowRope");
		getPlayer():getInventory():AddItem("TowingCar.TowRope");
		getPlayer():getInventory():AddItem("TowingCar.TowRope");
		getPlayer():getInventory():AddItem("TowingCar.TowBar");
		getPlayer():getInventory():AddItem("TowingCar.TowBar");
	
		-- adding some recipes (the one you get from magazines)
		getPlayer():getKnownRecipes():add("Basic Mechanics"); getPlayer():getKnownRecipes():add("Intermediate Mechanics"); getPlayer():getKnownRecipes():add("Advanced Mechanics");
		
		-- car
		local car = addVehicleDebug("Base.KbacTrailer", IsoDirections.S, nil, getCell():getGridSquare(10592, 9335, 0));
		--car:repair();
		inv:AddItem(car:createVehicleKey());
		
		local car2 = addVehicleDebug("Base.ModernCar", IsoDirections.S, nil, getCell():getGridSquare(10592, 9345, 0));
		--car2:repair();
		car2:setColor(0.7, 2, 0.4);
		inv:AddItem(car2:createVehicleKey());
		
		local car3 = addVehicleDebug("Base.HomeTrailer", IsoDirections.S, nil, getCell():getGridSquare(10592, 9340, 0));
		--car3:repair();
		car3:setColor(0.1, 2, 0.2);
		inv:AddItem(car3:createVehicleKey());
		
		local car4 = addVehicleDebug("Base.ModernCar", IsoDirections.S, nil, getCell():getGridSquare(10592, 9350, 0));
		--car4:repair();
		car4:setColor(0.7, 2, 0.4);
		inv:AddItem(car4:createVehicleKey());
		
		local car5 = addVehicleDebug("Base.SecondTrailer", IsoDirections.S, nil, getCell():getGridSquare(10592, 9355, 0));
		--car5:repair();
		car5:setColor(0.1, 2, 0.4);
				
		local car6 = addVehicleDebug("Base.ModernCar", IsoDirections.S, nil, getCell():getGridSquare(10592, 9360, 0));
		--car6:repair();
		car6:setColor(0.1, 2, 0.5);
		inv:AddItem(car6:createVehicleKey());
				
		local car7 = addVehicleDebug("Base.FirstTrailer", IsoDirections.S, nil, getCell():getGridSquare(10592, 9365, 0));
		--car7:repair();
		car7:setColor(0.1, 2, 0.6);
		
		local car7 = addVehicleDebug("Base.ModernCar", IsoDirections.S, nil, getCell():getGridSquare(10592, 9360, 0));
		--car7:repair();
		car7:setColor(0.1, 2, 0.5);
		inv:AddItem(car7:createVehicleKey());
				
	end
}
