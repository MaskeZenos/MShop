ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

PlayerName = {}

NewToken = 'MaskeZen-'..math.random(1000000, 9999999999)

print ('[^2'..GetCurrentResourceName()..'^0] ^2Token: ^0'..NewToken)

RegisterNetEvent("tokenget")
AddEventHandler("tokenget", function()
    local _source = source

    TriggerClientEvent("token", _source, NewToken)
end)

RegisterNetEvent('esx:buyItem')
AddEventHandler('esx:buyItem', function(item, amount,price, bancaire, liquide, token )
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if NewToken ~= token then 
        DropPlayer(_source, 'Token invalide')
        return
    end 
    if bancaire == true then 
        if xPlayer.getAccount('bank').money >= price then
            xPlayer.removeAccountMoney('bank', price)
            xPlayer.addInventoryItem(item, amount)
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheté un ~g~' .. item .. '~s~ pour ~g~' .. price .. '$')
        else
            TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent')
        end
    elseif liquide == true then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            xPlayer.addInventoryItem(item, amount)
            TriggerClientEvent('esx:showNotification', _source, 'Vous avez acheté un ~g~' .. item .. '~s~ pour ~g~' .. price .. '$')
        else
            TriggerClientEvent('esx:showNotification', _source, 'Vous n\'avez pas assez d\'argent')
        end
    end
end)

ESX.RegisterServerCallback('getmoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getMoney()
    local bank = xPlayer.getAccount('bank').money
    cb(money, bank)
end)    