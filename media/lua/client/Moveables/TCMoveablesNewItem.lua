--***********************************************************
--** IBRRUS/Faithful and discreet slave of Tsar Vyacheslav **
--***********************************************************

if (HomeTrailerItems == nil) then HomeTrailerItems = {} end

HomeTrailerItems["appliances_cooking_01_0"] = "MovGreenOven"
HomeTrailerItems["appliances_cooking_01_1"] = "MovGreenOven"
HomeTrailerItems["appliances_cooking_01_2"] = "MovGreenOven"
HomeTrailerItems["appliances_cooking_01_3"] = "MovGreenOven"
HomeTrailerItems["appliances_cooking_01_4"] = "MovGreyOven"
HomeTrailerItems["appliances_cooking_01_5"] = "MovGreyOven"
HomeTrailerItems["appliances_cooking_01_6"] = "MovGreyOven"
HomeTrailerItems["appliances_cooking_01_7"] = "MovGreyOven"
HomeTrailerItems["appliances_cooking_01_8"] = "MovRedOven"
HomeTrailerItems["appliances_cooking_01_9"] = "MovRedOven"
HomeTrailerItems["appliances_cooking_01_10"] = "MovRedOven"
HomeTrailerItems["appliances_cooking_01_11"] = "MovRedOven"
HomeTrailerItems["appliances_cooking_01_12"] = "MovModernOven"
HomeTrailerItems["appliances_cooking_01_13"] = "MovModernOven"
HomeTrailerItems["appliances_cooking_01_14"] = "MovModernOven"
HomeTrailerItems["appliances_cooking_01_15"] = "MovModernOven"
HomeTrailerItems["appliances_cooking_01_20"] = "MovIndustrialOven"
HomeTrailerItems["appliances_cooking_01_21"] = "MovIndustrialOven"
HomeTrailerItems["appliances_cooking_01_22"] = "MovIndustrialOven"
HomeTrailerItems["appliances_cooking_01_23"] = "MovIndustrialOven"

HomeTrailerItems["appliances_refrigeration_01_0"] = "MovWhiteFridge"
HomeTrailerItems["appliances_refrigeration_01_1"] = "MovWhiteFridge"
HomeTrailerItems["appliances_refrigeration_01_2"] = "MovWhiteFridge"
HomeTrailerItems["appliances_refrigeration_01_3"] = "MovWhiteFridge"
HomeTrailerItems["appliances_refrigeration_01_4"] = "MovBlueFridge"
HomeTrailerItems["appliances_refrigeration_01_5"] = "MovBlueFridge"
HomeTrailerItems["appliances_refrigeration_01_6"] = "MovBlueFridge"
HomeTrailerItems["appliances_refrigeration_01_7"] = "MovBlueFridge"
HomeTrailerItems["appliances_refrigeration_01_8"] = "MovSteelFridge"
HomeTrailerItems["appliances_refrigeration_01_9"] = "MovSteelFridge"
HomeTrailerItems["appliances_refrigeration_01_10"] = "MovSteelFridge"
HomeTrailerItems["appliances_refrigeration_01_11"] = "MovSteelFridge"
HomeTrailerItems["appliances_refrigeration_01_12"] = "MovGreenFridge"
HomeTrailerItems["appliances_refrigeration_01_13"] = "MovGreenFridge"
HomeTrailerItems["appliances_refrigeration_01_14"] = "MovGreenFridge"
HomeTrailerItems["appliances_refrigeration_01_15"] = "MovGreenFridge"
HomeTrailerItems["appliances_refrigeration_01_28"] = "MovPlaneFridge"
HomeTrailerItems["appliances_refrigeration_01_29"] = "MovPlaneFridge"
HomeTrailerItems["appliances_refrigeration_01_30"] = "MovPlaneFridge"
HomeTrailerItems["appliances_refrigeration_01_31"] = "MovPlaneFridge"
HomeTrailerItems["appliances_refrigeration_01_32"] = "MovRedFridge"
HomeTrailerItems["appliances_refrigeration_01_33"] = "MovRedFridge"
HomeTrailerItems["appliances_refrigeration_01_34"] = "MovRedFridge"
HomeTrailerItems["appliances_refrigeration_01_35"] = "MovRedFridge"

function TCOnObjectAboutToBeRemoved(object)
	local worldSprite = object:getSprite()
	if worldSprite ~= nil then
		worldSpriteName = worldSprite:getName()
		local newItem = HomeTrailerItems[worldSpriteName]
		if newItem then
			local player = getPlayer()
			local playerInv = player:getInventory()
			local allItems = playerInv:getItemsFromType("Moveable")
			for i=0, allItems:size()-1 do
				local oldItem = allItems:get(i)
				if oldItem:getWorldSprite() == worldSpriteName then
					--print("TC: add")
					playerInv:Remove(oldItem)
					playerInv:AddItem("tsarcraft." .. newItem);
					return
				end
			end
		end
	end
end

Events.OnObjectAboutToBeRemoved.Add(TCOnObjectAboutToBeRemoved)