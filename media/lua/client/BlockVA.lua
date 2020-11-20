function vehicle_additions_sleep()
	if getActivatedMods():contains("vehicle_additions") 
			or ActiveMods.getById("currentGame"):isModActive("vehicle_additions") then
		toggleModActive(getModInfoByID("vehicle_additions"), false)
		ActiveMods.getById("currentGame"):removeMod("vehicle_additions")
		saveGame()
		arr = getLatestSave()
		pathToSave = arr[2] .. "\\" .. arr[1]
		manipulateSavefile(pathToSave,"WriteModsDotTxt")
	end
end

Events.OnGameBoot.Add(vehicle_additions_sleep)