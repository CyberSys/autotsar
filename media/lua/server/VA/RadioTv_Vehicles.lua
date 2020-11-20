function Vehicles.Create.Radio(vehicle, part)
	local deviceData = part:createSignalDevice()
	local invItem = VehicleUtils.createPartInventoryItem(part);

	local text2 = invItem:getType()
	print( text2 )
	--getPlayer():Say( text2, 1.0, 1.0, 0.0, UIFont.Dialogue, 30.0, "radio" )

	deviceData:setIsTwoWay( invItem:getDeviceData():getIsTwoWay() )
	deviceData:setTransmitRange( invItem:getDeviceData():getTransmitRange() )
	deviceData:setMicRange( invItem:getDeviceData():getMicRange() )
	deviceData:setBaseVolumeRange( invItem:getDeviceData():getBaseVolumeRange() )
	deviceData:setIsPortable(false)
	deviceData:setIsTelevision( invItem:getDeviceData():getIsTelevision() )
	deviceData:setMinChannelRange( invItem:getDeviceData():getMinChannelRange() )
	deviceData:setMaxChannelRange( invItem:getDeviceData():getMaxChannelRange() )
	deviceData:setIsBatteryPowered(false)
	deviceData:setIsHighTier(false)
	deviceData:setUseDelta(0.007)
	deviceData:generatePresets()
	deviceData:setRandomChannel()
end
