local tabOpen = false 

-- Command to Open -- 
RegisterCommand(Config.commandName, function()
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
end)

-- Keymapping -- 
RegisterKeyMapping(Config.commandName, "Open Tablet", "keyboard", "F5")


-- NUI Callbacks --
RegisterNUICallback('cd_businesstab:closebtn', function(_, cb) {
    cb({})
    SetNuiFocus(false, false)
})