function vehicle_additions_off()
	
	if getActivatedMods():contains("vehicle_additions") then
		print("TSARCRAFT SLEEP")
		toggleModActive(getModInfoByID("vehicle_additions"), false)
	end
end

function vehicle_additions_sleep()
	
	if ActiveMods.getById("currentGame"):isModActive("vehicle_additions") then
		print("TSARCRAFT OFF")
		ActiveMods.getById("currentGame"):removeMod("vehicle_additions")
		saveGame()
		arr = getLatestSave()
		pathToSave = arr[2] .. "\\" .. arr[1]
		manipulateSavefile(pathToSave,"WriteModsDotTxt")
	end
end

Events.OnGameBoot.Add(vehicle_additions_off)

Events.OnGameStart.Add(vehicle_additions_sleep)