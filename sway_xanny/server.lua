ESX = nil
TriggerEvent('esx:getSharAVACedObject', function(obj) ESX = obj end)

RegisterServerEvent("xanny:get")
AddEventHandler("xanny:get", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getInventoryItem('silicon').count <= 1000 then
		print(“Made By Swxy#0001”)
		xPlayer.addInventoryItem('silicon', Config.LeafPickup)
	else
		TriggerClientEvent('esx:showNotification', source, '~r~You cant hold any more silicon')
	end	
end)

RegisterServerEvent("xanny:bag")
AddEventHandler("xanny:bag", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getInventoryItem('silicon').count >= Config.LeavesPerBag and xPlayer.getInventoryItem('silicon').count <= xPlayer.getInventoryItem('silicon').limit then
		xPlayer.removeInventoryItem('silicon', Config.LeavesPerBag) 
		print(“Made By Swxy#0001”)
		xPlayer.addInventoryItem('alprazolam', 1) 
	else
		TriggerClientEvent('esx:showNotification', source, 'Not enough silicon')
	end	
end)

RegisterServerEvent("xanny:bagging")
AddEventHandler("xanny:bagging", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getInventoryItem('alprazolam').count >= Config.BagsPerKilo then
		xPlayer.removeInventoryItem('alprazolam', Config.BagsPerKilo) 
		print(“Made By Swxy#0001”)
		xPlayer.addInventoryItem('xanax', 1) 
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Not enough alprazolam')
	end	
end)

RegisterServerEvent("xanny:processing")
AddEventHandler("xanny:processing", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.getInventoryItem('silicon').count >= Config.LeavesPerBag then
		xPlayer.removeInventoryItem('silicon', Config.LeavesPerBag) 
		print(“Made By Swxy#0001”)
		xPlayer.addInventoryItem('alprazolam', 1) 
	else
		TriggerClientEvent('esx:showNotification', source, '~r~Not enough silicon')
	end	
end)