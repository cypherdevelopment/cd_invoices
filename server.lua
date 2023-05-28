QBCore = exports['qb-core']:GetSharedObject()

QBCore.Functions.CreateUseableItem('business_tablet', function()
    TriggerClientEvent('cd_businesstab:usetablet')
)