QBCore = exports['qb-core']:GetCoreObject()

-- Events -- 
RegisterServerEvent('cd_businesstab:createinvoice')
AddEventHandler('cd_businesstab:createinvoice', function(id, title, amount, InvoiceNumber)
    local src = QBCore.Functions.GetPlayer(tonumber(id))
    local playerid = src.PlayerData.citizenid
    MySQL.insert(
       'INSERT INTO invoices (title, amount, playerid, invoiceno) VALUES (@title, @amount, @playerid, @invoiceno);',
       {
        ['@title'] = title,
        ['@amount'] = amount,
        ['@playerid'] = playerid,
        ['@invoiceno'] = InvoiceNumber,
       },
       function(result)
       end)
       print(InvoiceNumber)
       TriggerClientEvent('QBCore:Notify', id, 'You have been invoiced: $' .. amount)
end)

RegisterServerEvent('cd_businesstab:payinvoice')
AddEventHandler('cd_businesstab:payinvoice', function(amount, invoiceno)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local playerid = Player.PlayerData.citizenid
    Player.Functions.RemoveMoney('bank', amount, title)
    MySQL.query(
        'DELETE FROM invoices WHERE playerid = @playerid AND amount = @amount AND invoiceno = @invoiceno LIMIT 1',
        {
            ['@playerid'] = playerid,
            ['@amount'] = amount,
            ['@invoiceno'] = invoiceno
        },
        function(result)
    end)
end)

-- SQL Queries -- 

-- CallBacks -- 
QBCore.Functions.CreateCallback('cd_ganglands::getInvoices',function(source,cb,args)
    local src = source 
    local Player = QBCore.Functions.GetPlayer(src)
    local playerid = Player.PlayerData.citizenid
    --https://overextended.github.io/docs/oxmysql/Usage/query
    MySQL.query('SELECT title,amount,invoiceno FROM invoices WHERE playerid = @playerid', 
    {
        ['@playerid'] = playerid
    }, function(result)
        cb(result)
    end)

end)
