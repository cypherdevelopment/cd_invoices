local invoices = {}
local QBCore = exports['qb-core']:GetCoreObject();
local RandNum = math.random(0, 5000) * 5
local RandLetter = string.char(math.random(65, 65 + 25))
local InvoiceNumber = RandLetter..RandNum

-- NUI Events -- 
RegisterNetEvent('openinvoice')
AddEventHandler('openinvoice', function()
    SendNUIMessage({
        type = "createinvoice"
    })
    SetNuiFocus(true, true)
end)

RegisterCommand('openinvoice',function()
TriggerEvent('openinvoice')
end,false)

RegisterNuiCallback('closeui', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
    QBCore.Functions.Notify('You cancelled the Invoice', 'error', 5000)
end)

RegisterNuiCallback('submitinvoice', function(data, cb)
    cb({})
    SetNuiFocus(false, false)
    QBCore.Functions.Notify('Invoice Submitted!', 'success', 5000)
    TriggerServerEvent('cd_businesstab:createinvoice', data.playerid, data.title, data.amount, InvoiceNumber)
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
    invoices = nil
    QBCore.Functions.TriggerCallback('cd_ganglands::getInvoices',function(returnValue)
        invoices = {}
        for k,v in pairs(returnValue) do 
            table.insert(invoices,v)
        end
    end,Datasend)
    while invoices == nil do 
        Citizen.Wait(200)
    end
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
                invoiceno = v.invoiceno,
            }
        }
    }
    end
    exports['qb-menu']:openMenu(invoiceList)
end

-- Events -- 
RegisterNetEvent('cd_businesstab:client:payinvoice', function(data)
    TriggerServerEvent('cd_businesstab:payinvoice', data.amount, data.invoiceno)
    
 end)

-- Create Invoice -- 
RegisterCommand("openm", function()
    InvoiceMenu()
end)
