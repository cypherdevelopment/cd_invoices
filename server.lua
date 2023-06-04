QBCore = exports['qb-core']:GetCoreObject()

-- Events -- 
RegisterServerEvent('cd_businesstab:createinvoice')
AddEventHandler('cd_businesstab:createinvoice', function(id, title, amount, InvoiceNumber)
    MySQL.insert(
       'INSERT INTO invoices (title, amount, playerid, invoiceno) VALUES (@title, @amount, @playerid, @invoiceno);',
       {
        ['@title'] = title,
        ['@amount'] = amount,
        ['@playerid'] = id,
        ['@invoiceno'] = InvoiceNumber,
       },
       function(result)
       end)
       print(InvoiceNumber)
       TriggerClientEvent('QBCore:Notify', id, 'You have been invoiced: $' .. amount)
end)

RegisterServerEvent('cd_businesstab:payinvoice')
AddEventHandler('cd_businesstab:payinvoice', function(amount, title)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveMoney('bank', amount, title)
end)

-- SQL Queries -- 