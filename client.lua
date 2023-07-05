local invoices = {}
local QBCore = exports['qb-core']:GetCoreObject();

CreateThread(function()
    while true do 
    Wait(100)
    local RandNum = math.random(0, 5000) * 5
    local RandLetter = string.char(math.random(65, 65 + 25))
    InvoiceNumber = RandLetter..RandNum
    end
end)

<<<<<<< Updated upstream
-- Functions -- 
function GetNearPed()
	local plyPed = GetPlayerPed(PlayerPedId())
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function GetPedID()
    local ped = GetNearPed()
    playerid = GetPlayerServerId(ped)
    SendNUIMessage({
        type = "updateplayerid",
        id = playerid
    })
end
=======
-- Get Nearest Ped ID -- 
local nearestplayer, distance = QBCore.Functions.GetClosestPlayer()
if nearestplayer ~= 1 and distance < 5.0 then 
    nearestplayerid = GetPlayerServerId(nearestplayer)
end 
>>>>>>> Stashed changes


-- NUI Events -- 
RegisterNetEvent('openinvoice')
AddEventHandler('openinvoice', function()
    SendNUIMessage({
        type = "createinvoice",
        nearestplayer = nearestplayerid
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
    TriggerServerEvent('cd_invoicesystem:createinvoice', playerid, data.title, data.amount, InvoiceNumber)
end)

-- Targeting -- 
exports['qb-target']:AddGlobalPlayer({
    options = {
        {
            type = "client",
            event = "openinvoice",
            icon = "fas fa-envelope",
            label = 'Create Invoice'
        }
    },
    distance = 2.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
  })


-- Invoice Menu --
RegisterCommand("invoicemenu", function()
    local invoiceList = {}
    invoices = nil
    QBCore.Functions.TriggerCallback('cd_invoicesystem:getinvoice',function(returnValue)
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
            event = 'cd_invoicesystem:client:payinvoice',
            args = {
                amount = v.amount, 
                invoiceno = v.invoiceno,
            }
        }
    }
    end
    exports['qb-menu']:openMenu(invoiceList)
end)

RegisterKeyMapping("invoicemenu", "Open the Invoice Menu", "keyboard", "F6")

-- Events -- 
RegisterNetEvent('cd_invoicesystem:client:payinvoice', function(data)
    TriggerServerEvent('cd_invoicesystem:payinvoice', data.amount, data.invoiceno)
 end)

