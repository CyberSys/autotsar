--***********************************************************
--** IBRRUS/Faithful and discreet slave of Tsar Vyacheslav **
--***********************************************************

if (HomeTrailerItems == nil) then HomeTrailerItems = {} end

HomeTrailerItems["appliances_cooking_01_01"] = "Mov_GreenOven"
HomeTrailerItems["appliances_cooking_01_05"] = "Mov_GreyOven"
HomeTrailerItems["appliances_cooking_01_09"] = "Mov_RedOven"
HomeTrailerItems["appliances_cooking_01_13"] = "Mov_ModernOven"
HomeTrailerItems["appliances_cooking_01_21"] = "Mov_IndustrialOven"

HomeTrailerItems["appliances_refrigeration_01_0"] = "Mov_WhiteFridge"
HomeTrailerItems["appliances_refrigeration_01_4"] = "Mov_BlueFridge"
HomeTrailerItems["appliances_refrigeration_01_8"] = "Mov_SteelFridge"
HomeTrailerItems["appliances_refrigeration_01_12"] = "Mov_GreenFridge"
HomeTrailerItems["appliances_refrigeration_01_28"] = "Mov_PlaneFridge"
HomeTrailerItems["appliances_refrigeration_01_32"] = "Mov_RedFridge"

function OnObjectAboutToBeRemoved(object)
	local worldSprite = object:getSprite():getName()
	local newItem = HomeTrailerItems[worldSprite]
	if newItem then
		local player = getPlayer()
		local playerInv = player:getInventory()
		local allItems = playerInv:getItemsFromType("Moveable")
		for i=0, allItems:size()-1 do
			local oldItem = allItems:get(i)
			if oldItem:getWorldSprite() == worldSprite then
				playerInv:Remove(oldItem)
				playerInv:AddItem("Tsarcraft." .. newItem);
				return
			end
		end
	end
end

Events.OnObjectAboutToBeRemoved.Add(OnObjectAboutToBeRemoved)