local old_ISVehicleMenu_onConfirmSleep = ISVehicleMenu.onConfirmSleep

function ISVehicleMenu.onConfirmSleep(this, button, player, bed)
	
	local chr = getPlayer()
	local vehicle = chr:getVehicle()
	if button.internal == "YES" and  vehicle:getPartById("Mattress") then
		print("Mattress!!!")
		ISWorldObjectContextMenu.onSleepWalkToComplete(player, "RV")
	end
	print("No Mattress!")
	old_ISVehicleMenu_onConfirmSleep(this, button, player, bed)
	
end


