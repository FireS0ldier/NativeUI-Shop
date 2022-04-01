ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterServerEvent('risk_shops:Achat')
AddEventHandler('risk_shops:Achat', function(Label, Value, Price) 
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Price then
	    xPlayer.removeMoney(Price)
    	xPlayer.addInventoryItem(Value, 1)
		Citizen.Wait(500) 
		TriggerClientEvent('risk_notify', _src, '#00FF00', 'Geschäft', 'Du hast 1x '..Label..' für '..Price..'$ gekauft!')
	else 
		Citizen.Wait(500) 
		TriggerClientEvent('risk_notify', _src, '#eb4034', 'Geschäft', 'Du hast nicht genug Bargeld bei dir!')
    end
end)  
