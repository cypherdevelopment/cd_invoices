RegisterNetEvent('openinvoice')
AddEventHandler('openinvoice', function()
    SendNUIMessage({
        type = "createinvoice"
    })
    SetNuiFocus(false, false)
end)

RegisterCommand("openui", function()
    TriggerEvent('openinvoice')
    SetNuiFocus(true,true)
end)

RegisterNuiCallback('closeinvoice', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
end)

RegisterKeyMapping('openui', "test", 'keyboard', 'F5')