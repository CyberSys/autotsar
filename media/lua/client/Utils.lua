function vehicle_additions_off()
	
	if getActivatedMods():contains("vehicle_additions") then
		--print("TSARCRAFT SLEEP")
		toggleModActive(getModInfoByID("vehicle_additions"), false)
	end
	if getActivatedMods():contains("FuelTanker") then
		--print("TSARCRAFT SLEEP")
		toggleModActive(getModInfoByID("FuelTanker"), false)
	end

end

function vehicle_additions_sleep()
	
	if ActiveMods.getById("currentGame"):isModActive("vehicle_additions") then
		--print("TSARCRAFT OFF")
		ActiveMods.getById("currentGame"):removeMod("vehicle_additions")
		saveGame()
		arr = getLatestSave()
		pathToSave = arr[2] .. "\\" .. arr[1]
		manipulateSavefile(pathToSave,"WriteModsDotTxt")
	end
	if ActiveMods.getById("currentGame"):isModActive("FuelTanker") then
		--print("TSARCRAFT OFF")
		ActiveMods.getById("currentGame"):removeMod("FuelTanker")
		saveGame()
		arr = getLatestSave()
		pathToSave = arr[2] .. "\\" .. arr[1]
		manipulateSavefile(pathToSave,"WriteModsDotTxt")
	end
	
end

Events.OnGameBoot.Add(vehicle_additions_off)
Events.OnGameStart.Add(vehicle_additions_sleep)

-- local function fix86bounder()
	-- local scriptManager = getScriptManager()
	-- local vehicleScripts = scriptManager:getAllVehicleScripts()
	-- for i = 0, vehicleScripts:size()-1 do
		-- local script = vehicleScripts:get(i)
		
		-- if script:getName() == "86bounder" then
			-- print("script:")
			-- print(script:getName())
			-- print("TSARCRAFT 86bounder FOUND!")
			
			-- script:copyPartsFrom(scriptManager:getItemName("Engine"), "*")
			-- Write-paste
			-- h = io.open(targetfile, 'wb')
			-- h:write(fc)
			-- h:close()				
			-- print(script:getFileName())
			-- meta = getmetatable(script)
			-- for n,k in pairs(meta) do
				-- for x,y in pairs(k) do
					-- print(x, " : ", y)
				-- end
			-- end
			--script:LoadFile("media/scripts/vehicles/86bounderfix.txt", false)
			--script:Load("template", "EngineDoor")
			-- script:Load("template", "Mattress")
			-- script:Load("template", "Fridge/part/Fridge")
			-- print(scriptManager:getItemName("Fridge"))
			-- print(scriptManager:getItemName("Counter"))
			-- print(scriptManager:getItemName("EngineDoor"))
			-- print(scriptManager:getItemName("Engine"))
			-- local datet = getmetatable(scriptManager)
			-- for n,k in pairs(datet) do
				-- print(n, " : ", k)
				-- for x,y in pairs(k) do
					-- print(x, " : ", y)
				-- end
			-- end
			-- vehicleTemplateModule = scriptManager:getModule("EngineDoor")
			-- print(vehicleTemplateModule)
			-- vehicleTemplate = vehicleTemplateModule:getVehicleTemplate("EngineDoor")
			--vehicleTemplate = scriptManager:getVehicleTemplate("asd1d12d12edsa")
			-- print(vehicleTemplate)
			-- print(getmetatable(vehicleTemplate))
			-- vehicleTemplate = scriptManager:getVehicleTemplate("Counter")
			-- print(vehicleTemplate)
			-- print(getmetatable(vehicleTemplate))
			-- vehicleTemplate = scriptManager:getVehicleTemplate("Oven")
			-- print(vehicleTemplate)
			-- print(getmetatable(vehicleTemplate))
			-- vehicleTemplate = scriptManager:getVehicleTemplate("EngineDoor")
			-- print(vehicleTemplate)
			-- print(getmetatable(vehicleTemplate))
			-- vehicleTemplate = scriptManager:getVehicleTemplate("Battery")
			-- print(vehicleTemplate)
			-- print(getmetatable(vehicleTemplate))
			-- vehicleTemplate = scriptManager:getVehicleTemplate("Engine")
			-- print(vehicleTemplate)
			-- print(getmetatable(vehicleTemplate))			
			-- print(getmetatable(scriptManager))
			-- print("A")
			--vehicleScript = vehicleTemplate:getScript
			--script:copyAreasFrom(vehicleScript, "*")
		-- end
	-- end
-- end

-- Events.OnGameBoot.Add(fix86bounder)