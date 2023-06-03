local tabOpen = false 

-- Command to Open -- 
RegisterCommand(Config.commandName, function()
    TriggerEvent('cd_businesstab:usetablet')
end)

-- UI Event -- 
RegisterNetEvent('cd_businesstab:usetablet')
AddEventHandler('cd_businesstab:usetablet', function()
    if not tabOpen then 
        SendNUIMessage({
            type = "opentablet"
        })
        tabOpen = true 
        SetNuiFocus(true, true)
    else 
        SendNUIMessage({
            type = "closetablet"
        })
        tabOpen = false 
        SetNuiFocus(false, false)
    end
end)

-- NUI Callbacks --
RegisterNUICallback('cd_businesstab:closebtn', function(_, cb) 
    cb({})
    SetNuiFocus(false, false)
end)