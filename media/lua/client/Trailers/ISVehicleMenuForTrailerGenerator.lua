
ISVehicleMenuForTrailerGenerator = {}

local function predicateNotEmpty(item)
	return item:getUsedDelta() > 0
end

-- function ISVehicleMenuForTrailerGenerator.launchRadialMenu(playerObj, trailer)
	-- local menu = getPlayerRadialMenu(playerObj:getPlayerNum())
	-- if trailer:getMass() > 9000 then
		-- menu:addSlice(getText("ContextMenu_GeneratorUnplug"), getTexture("media/ui/vehicles/vehicle_repair.png"), ISVehicleMenuForTrailerGenerator.generatorUnplug, nil, playerObj, trailer)
	-- else
		-- menu:addSlice(getText("ContextMenu_GeneratorPlug"), getTexture("media/ui/vehicles/vehicle_repair.png"), ISVehicleMenuForTrailerGenerator.generatorPlug, playerObj, trailer)
	-- end
-- end

-- function ISVehicleMenuForTrailerGenerator.replaceTrailer(trailer, newSriptName)
	-- local partsCondition = {}
	-- for i=1, trailer:getScript():getPartCount() do
		-- local part = trailer:getPartByIndex(i-1)
		-- partsCondition[part:getId()] = {}
		-- partsCondition[part:getId()]["InventoryItem"] = part:getInventoryItem()
		-- partsCondition[part:getId()]["Condition"] = part:getCondition()
	-- end
	-- trailer:setScriptName(newSriptName)
	-- trailer:scriptReloaded()
	-- for i=1, trailer:getScript():getPartCount() do
		-- local part = trailer:getPartByIndex(i-1)
		-- part:setInventoryItem(partsCondition[part:getId()]["InventoryItem"])
		-- part:setCondition(partsCondition[part:getId()]["Condition"])
	-- end
	-- return trailer
-- end

ISVehicleMenuForTrailerGenerator.generatorPlug = function(worldobjects, playerObj, trailer)
	if luautils.walkAdj(playerObj, trailer:getSquare()) then
		ISTimedActionQueue.add(ISPlugTrailerGenerator:new(playerObj, trailer, 300));
	end
end

function ISVehicleMenuForTrailerGenerator.generatorUnplug(worldobjects, playerObj, trailer)
	if luautils.walkAdj(playerObj, trailer:getSquare()) then
		ISTimedActionQueue.add(ISUnplugTrailerGenerator:new(playerObj, trailer, 300));
	end
end

ISVehicleMenuForTrailerGenerator.OnFillWorldObjectContextMenu = function(player, context, worldobjects, test)
	wo = worldobjects
	local playerObj = getSpecificPlayer(player)
	local vehicle = playerObj:getVehicle()
	if not vehicle then
		if JoypadState.players[player+1] then
			local px = playerObj:getX()
			local py = playerObj:getY()
			local pz = playerObj:getZ()
			local sqs = {}
			sqs[1] = getCell():getGridSquare(px, py, pz)
			local dir = playerObj:getDir()
			if (dir == IsoDirections.N) then        sqs[2] = getCell():getGridSquare(px-1, py-1, pz); sqs[3] = getCell():getGridSquare(px, py-1, pz);   sqs[4] = getCell():getGridSquare(px+1, py-1, pz);
			elseif (dir == IsoDirections.NE) then   sqs[2] = getCell():getGridSquare(px, py-1, pz);   sqs[3] = getCell():getGridSquare(px+1, py-1, pz); sqs[4] = getCell():getGridSquare(px+1, py, pz);
			elseif (dir == IsoDirections.E) then    sqs[2] = getCell():getGridSquare(px+1, py-1, pz); sqs[3] = getCell():getGridSquare(px+1, py, pz);   sqs[4] = getCell():getGridSquare(px+1, py+1, pz);
			elseif (dir == IsoDirections.SE) then   sqs[2] = getCell():getGridSquare(px+1, py, pz);   sqs[3] = getCell():getGridSquare(px+1, py+1, pz); sqs[4] = getCell():getGridSquare(px, py+1, pz);
			elseif (dir == IsoDirections.S) then    sqs[2] = getCell():getGridSquare(px+1, py+1, pz); sqs[3] = getCell():getGridSquare(px, py+1, pz);   sqs[4] = getCell():getGridSquare(px-1, py+1, pz);
			elseif (dir == IsoDirections.SW) then   sqs[2] = getCell():getGridSquare(px, py+1, pz);   sqs[3] = getCell():getGridSquare(px-1, py+1, pz); sqs[4] = getCell():getGridSquare(px-1, py, pz);
			elseif (dir == IsoDirections.W) then    sqs[2] = getCell():getGridSquare(px-1, py+1, pz); sqs[3] = getCell():getGridSquare(px-1, py, pz);   sqs[4] = getCell():getGridSquare(px-1, py-1, pz);
			elseif (dir == IsoDirections.NW) then   sqs[2] = getCell():getGridSquare(px-1, py, pz);   sqs[3] = getCell():getGridSquare(px-1, py-1, pz); sqs[4] = getCell():getGridSquare(px, py-1, pz);
			end
			for _,sq in ipairs(sqs) do
				vehicle = sq:getVehicleContainer()
				if vehicle and string.lower(vehicle:getScript():getName()) == "trailergenerator" then
					return ISVehicleMenuForTrailerGenerator.FillMenuOutsideVehicle(player, context, vehicle, test)
				end
			end
			return
		end
		vehicle = IsoObjectPicker.Instance:PickVehicle(getMouseXScaled(), getMouseYScaled())
		if vehicle and string.lower(vehicle:getScript():getName()) == "trailergenerator" then
			return ISVehicleMenuForTrailerGenerator.FillMenuOutsideVehicle(player, context, vehicle, test)
		end
		return
	end
end

function ISContextMenu:updateOption(id, name, target, onSelect, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	local option = self:allocOption(name, target, onSelect, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
	self.options[id] = option;
	return option;
end

function ISContextMenu:removeOption(option)
	if option then
		table.insert(self.optionPool, self.options[option.id])
		self.options[option.id] =  nil;
		for i = option.id, self.numOptions - 1 do
			self.options[i] = self.options[i+1]
			if self.options[i] then
				self.options[i].id = i
			end
		end
		self.numOptions = self.numOptions - 1;
		self:calcHeight()
	end
end


ISVehicleMenuForTrailerGenerator.FillMenuOutsideVehicle = function(player, context, trailer, test)
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	local generator = trailer:getModData()["generatorObject"]
	if generator then
		local old_options = context:getOptionFromName(getText("ContextMenu_GeneratorInfo"))
		if old_options then 
			if not generator:isActivated() then
				local old_option_update = context:getOptionFromName(getText("ContextMenu_GeneratorUnplug"))
				context:updateOption(old_option_update.id, old_option_update.name, old_option_update.target, ISVehicleMenuForTrailerGenerator.generatorUnplug, playerObj, trailer)
				old_option_update = context:getOptionFromName(getText("ContextMenu_Turn_On"))
				context:updateOption(old_option_update.id, old_option_update.name, trailer, ISVehicleMenuForTrailerGenerator.onActivateGenerator, true, generator, player)
			else
				local old_option_update = context:getOptionFromName(getText("ContextMenu_Turn_Off"))
				context:updateOption(old_option_update.id, old_option_update.name, trailer, ISVehicleMenuForTrailerGenerator.onActivateGenerator, false, generator, player)
			end
		else 
			local option = context:addOptionOnTop(getText("ContextMenu_GeneratorInfo"), worldobjects, ISWorldObjectContextMenu.onInfoGenerator, generator, player);
			if generator:isActivated() then
				context:addOptionOnTop(getText("ContextMenu_Turn_Off"), trailer, ISVehicleMenuForTrailerGenerator.onActivateGenerator, false, generator, player);
			else
				if generator:getFuel() < 100 and playerInv:containsTypeEvalRecurse("PetrolCan", predicateNotEmpty) then
					local petrolCan = playerInv:getFirstTypeEvalRecurse("PetrolCan", predicateNotEmpty);
					context:addOptionOnTop(getText("ContextMenu_GeneratorAddFuel"), worldobjects, ISWorldObjectContextMenu.onAddFuel, petrolCan, generator, player);
				end
				if generator:getCondition() < 100 then
					local option = context:addOptionOnTop(getText("ContextMenu_GeneratorFix"), worldobjects, ISWorldObjectContextMenu.onFixGenerator, generator, player);
					if not playerObj:isRecipeKnown("Generator") then
						local tooltip = ISWorldObjectContextMenu.addToolTip();
						option.notAvailable = true;
						tooltip.description = getText("ContextMenu_GeneratorPlugTT");
						option.toolTip = tooltip;
					end
					if not playerInv:containsTypeRecurse("ElectronicsScrap") then
						local tooltip = ISWorldObjectContextMenu.addToolTip();
						option.notAvailable = true;
						tooltip.description = getText("ContextMenu_GeneratorFixTT");
						option.toolTip = tooltip;
					end
				end
				local option = context:addOptionOnTop(getText("ContextMenu_GeneratorUnplug"), worldobjects, ISVehicleMenuForTrailerGenerator.generatorUnplug, playerObj, trailer);
				if generator:getFuel() > 0 then
					option = context:addOptionOnTop(getText("ContextMenu_Turn_On"), trailer, ISVehicleMenuForTrailerGenerator.onActivateGenerator, true, generator, player);
					local doStats = playerObj:DistToSquared(generator:getX() + 0.5, generator:getY() + 0.5) < 2 * 2
					local description = ISGeneratorInfoWindow.getRichText(generator, doStats)
					if description ~= "" then
						local tooltip = ISWorldObjectContextMenu.addToolTip()
						tooltip:setName(getText("IGUI_Generator_TypeGas"))
						tooltip.description = description
						option.toolTip = tooltip
					end
				end
			end
		end
		context:removeOption(context:getOptionFromName(getText("ContextMenu_VehicleSiphonGas")))
		context:removeOption(context:getOptionFromName(getText("ContextMenu_VehicleRefuelFromPump")))
		context:removeOption(context:getOptionFromName(getText("ContextMenu_VehicleAddGas")))
		context:removeOption(context:getOptionFromName(getText("ContextMenu_VehicleMechanics")))
	else
		context:addOptionOnTop(getText("ContextMenu_GeneratorPlug"), nil, ISVehicleMenuForTrailerGenerator.generatorPlug, playerObj, trailer)
	end
end

ISVehicleMenuForTrailerGenerator.onActivateGenerator = function(trailer, enable, generator, player)
	local playerObj = getSpecificPlayer(player)
	if luautils.walkAdj(playerObj, generator:getSquare()) then
		ISTimedActionQueue.add(ISActivateTrailerGenerator:new(player, trailer, generator, enable, 30));
	end
end


Events.OnFillWorldObjectContextMenu.Add(ISVehicleMenuForTrailerGenerator.OnFillWorldObjectContextMenu);
