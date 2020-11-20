require 'Vehicles/Vehicles'

function Vehicles.Create.PoliceGunRack(vehicle, part)
	local ranger = true
	local skin = vehicle:getSkinIndex()
	print("SKIN INDEX " .. tostring(skin))
	if skin > 0 then
		ranger = false
	end
	if ranger then
		local invItem = VehicleUtils.createPartInventoryItem(part);
	end

end

function Vehicles.Create.GunRack(vehicle, part)

	if ZombRand(100) < 50 then
		local invItem = VehicleUtils.createPartInventoryItem(part);
	end

end

function Vehicles.UninstallTest.GunRack(vehicle, part, chr)
	if ISVehicleMechanics.cheat then return true; end
	local keyvalues = part:getTable("uninstall")
	if not keyvalues then return false end
	if not part:getInventoryItem() then return false end
	if not part:getItemType() or part:getItemType():isEmpty() then return false end
	local typeToItem = VehicleUtils.getItems(chr:getPlayerNum())
	if keyvalues.requireUninstalled and (vehicle:getPartById(keyvalues.requireUninstalled) and vehicle:getPartById(keyvalues.requireUninstalled):getInventoryItem()) then
		return false;
	end
	if not VehicleUtils.testProfession(chr, keyvalues.professions) then return false end
	-- allow all perk, but calculate success/failure risk
--	if not VehicleUtils.testPerks(chr, keyvalues.skills) then return false end
	if not VehicleUtils.testRecipes(chr, keyvalues.recipes) then return false end
	if not VehicleUtils.testTraits(chr, keyvalues.traits) then return false end
	if not VehicleUtils.testItems(chr, keyvalues.items, typeToItem) then return false end	
	--print("AMOUNT: " .. tostring((round(part:getContainerContentAmount(), 3))))	
	--print("AMOUNT: " .. tostring((part:getContainerContentAmount())))
	if (part:getContainerContentAmount()) > 0 then return false end
	local seatNumber = part:getContainerSeatNumber()
	local seatOccupied = (seatNumber ~= -1) and vehicle:isSeatOccupied(seatNumber)
	if keyvalues.requireEmpty and seatOccupied then return false end
	-- if doing mechanics on this part require key but player doesn't have it, we'll check that door or windows aren't unlocked also
	if VehicleUtils.RequiredKeyNotFound(part, chr) then
		return false
	end
	return true
end

function Vehicles.ContainerAccess.GunRack(vehicle, part, chr)
	if not part:getInventoryItem() then
        return false
    end
	if chr:getVehicle() == vehicle then
		local seat = vehicle:getSeat(chr)
		-- Can the seated player reach the passenger seat?
		-- Only character in front seat can access it
		return seat == 1 or seat == 0;
	elseif chr:getVehicle() then
		-- Can't reach from inside a different vehicle.
		return false
	else
		-- Standing outside the vehicle.
		if not vehicle:isInArea(part:getArea(), chr) then return false end
		local doorPart = vehicle:getPartById("DoorFrontRight")
		if doorPart and doorPart:getDoor() and not doorPart:getDoor():isOpen() then
			return false
		end
		return true
	end
end