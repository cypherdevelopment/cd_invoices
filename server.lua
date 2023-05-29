QBCore = exports['qb-core']:GetSharedObject()

-- Create Useable Item -- 
QBCore.Functions.CreateUseableItem('business_tablet', function()
    TriggerClientEvent('cd_businesstab:usetablet')
)
