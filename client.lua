local invoices = {}
local QBCore = exports['qb-core']:GetCoreObject();

-- NUI Events -- 
RegisterNetEvent('openinvoice')
AddEventHandler('openinvoice', function()
    SendNUIMessage({
        type = "createinvoice"
    })
    SetNuiFocus(true, true)
end)

RegisterNuiCallback('closeui', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
    QBCore.Functions.Notify('You cancelled the Invoice', 'error', 5000)
end)

RegisterNuiCallback('submitinvoice', function(data, cb)
    cb({})
    SetNuiFocus(false, false)
    QBCore.Functions.Notify('Invoice Submitted!', 'success', 5000)
    table.insert(invoices, data)
    TriggerServerEvent('cd_businesstab:createinvoice', data.playerid, data.title, data.amount)
end)

-- QB-Target -- 
CreateThread(function()
    model = "a_m_m_indian_01"
    RequestModel(model)

    while not HasModelLoaded(model) do 
        Wait(1)
    end 

    aiped = CreatePed(0, model, -247.77, 289.58, 91.99, 92.48, true, false)

    exports['qb-target']:AddTargetEntity(aiped, {
        options = {
            {
                type = "client",
                event = "openinvoice",
                label = 'Create Invoice',
                icon = "fas fa-envelope",
            }
        },
        distance = 2.5, 
    })
end)

-- QB-Menu--
function InvoiceMenu()
    local invoiceList = {}
    invoiceList[#invoiceList+1] = {
        isMenuHeader = true,
        header = 'Invoice Menu',
        icon = 'fa-solid fa-envelope'
    }
        for k,v in pairs(invoices) do 
        invoiceList[#invoiceList + 1] = {
        header = "Invoice "..k.. ": " .. v.title,
        txt = "$"..v.amount,
        icon = 'fa-solid fa-money',
        params = {
            event = 'cd_businesstab:client:payinvoice',
            args = {
                amount = v.amount, 
                title = k,
            }
        }
    }
    end
    exports['qb-menu']:openMenu(invoiceList)
end

-- Events -- 
RegisterNetEvent('cd_businesstab:client:payinvoice', function(data)
    TriggerServerEvent('cd_businesstab:payinvoice', data.amount, data.title)
 end)

-- Create Invoice -- 
RegisterCommand("openm", function()
    InvoiceMenu()
end)
