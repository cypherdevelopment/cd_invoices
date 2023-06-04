QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('cd_businesstab:createinvoice')
AddEventHandler('cd_businesstab:createinvoice', function(id, title, amount)
    TriggerClientEvent('QBCore:Notify', id, 'You have been invoiced: $' .. amount)
end)

RegisterServerEvent('cd_businesstab:payinvoice')
AddEventHandler('cd_businesstab:payinvoice', function(amount, title)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveMoney('bank', amount, title)
end)