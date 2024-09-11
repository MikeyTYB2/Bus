local ESX = exports["es_extended"]:getSharedObject()

BusStop = {'prop_busstop_05', 'prop_busstop_02', 'prop_busstop_04'}

exports.ox_target:addModel(BusStop, {
    {
        event = 'sc_bus:locationlist',
        icon = 'fas fa-bus',
        label = 'Access Bus',
    },
})

exports.ox_target:addBoxZone({
    name = "buyCard",
    coords = Config.coords,
    size = vec3(1.000000, 1.000000, 1.500000),
    rotation = 19.000000,
    debug = false,
    options = {
        {
            event = 'buyCard',
            icon = "fa-solid fa-credit-card",
            label = "Buy Bus TAP Card ($".. Config.Cardprice .. ")",
        },
    },
})

RegisterNetEvent('buyCard')
AddEventHandler('buyCard', function()
    local playerPed = PlayerPedId()
    ESX.TriggerServerCallback('checkMoneyCard', function(hasMoney)
        if hasMoney then
            lib.notify({
                title = 'Success',
                description = string.format('You purchased a TAP card for $%d.', Config.Cardprice),
                position = 'top',
                style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                icon = 'credit-card',
            })
        end
    end)
end)

local function registerContext(id, yesEvent, Tapcard)
    lib.registerContext({
        id = tostring(id),
        title = "Choose Payment Method",
        options = {
            { title = "Cash ($"..Config.price..")", event = yesEvent, args = {} },
            { title = "TAP Card", event = Tapcard, args = {} }
        },
        menu = "location_list"
    })
    lib.showContext(tostring(id))
end

local function handleBusEvent(event, coords, message)
    RegisterNetEvent(event)
    AddEventHandler(event, function()
        local playerPed = PlayerPedId()
        ESX.TriggerServerCallback('sc_bus:checkMoney', function(hasMoney)
            if hasMoney then
                ESX.Streaming.RequestAnimDict('anim@heists@heist_corona@team_idles@male_a', function()
                    TaskPlayAnim(playerPed, 'anim@heists@heist_corona@team_idles@male_a', 'idle', 8.0, -8, -1, 1, 0, false, false, false)
                end)
                lib.progressCircle({
                    duration = 5000,
                    label = 'Waiting On The Bus',
                    position = 'bottom',
                    controlDisables = { disableMovement = true, disableCarMovement = true, disableCombat = true },
                })
                DoScreenFadeOut(15)
                SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, 1, 0, 0, 1)
                Wait(300)
                ClearPedTasksImmediately(playerPed)
                DoScreenFadeIn(1000)
                lib.notify({
                    title = 'Bus',
                    description = string.format('You have walked off the bus and arrived at %s', message),
                    position = 'top',
                    style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                    icon = 'bus',
                    iconColor = '#98FB98'
                })
            end
        end)
    end)
end

local function handleBusEventTap(event, coords, message)
    RegisterNetEvent(event)
    AddEventHandler(event, function()
        local playerPed = PlayerPedId()
        ESX.TriggerServerCallback('tapCardPayment', function(hasCard)
            if hasCard then
                ESX.Streaming.RequestAnimDict('anim@heists@heist_corona@team_idles@male_a', function()
                    TaskPlayAnim(playerPed, 'anim@heists@heist_corona@team_idles@male_a', 'idle', 8.0, -8, -1, 1, 0, false, false, false)
                end)
                lib.progressCircle({
                    duration = 5000,
                    label = 'Waiting On The Bus',
                    position = 'bottom',
                    controlDisables = { disableMovement = true, disableCarMovement = true, disableCombat = true },
                })
                DoScreenFadeOut(15)
                SetEntityCoordsNoOffset(playerPed, coords.x, coords.y, coords.z, 1, 0, 0, 1)
                Wait(300)
                ClearPedTasksImmediately(playerPed)
                DoScreenFadeIn(1000)
                lib.notify({
                    title = 'Bus',
                    description = string.format('You have walked off the bus and arrived at %s', message),
                    position = 'top',
                    style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                    icon = 'bus',
                    iconColor = '#98FB98'
                })
             end
        end)
    end)
end

for _, location in ipairs(Config.locations) do
    RegisterNetEvent('sc_bus:confirm' .. location.name)
    AddEventHandler('sc_bus:confirm' .. location.name, function()
        registerContext(location.id, 'sc_bus:' .. location.name, 'sc_bustapcard:'.. location.name)
    end)
    handleBusEvent('sc_bus:' .. location.name, location.coords, location.title)
    handleBusEventTap('sc_bustapcard:' .. location.name, location.coords, location.title)
end

RegisterNetEvent('sc_bus:locationlist')
AddEventHandler('sc_bus:locationlist', function()
    local options = {}
    for _, location in ipairs(Config.locations) do
        table.insert(options, {
            title = location.title,
            description = location.description,
            event = 'sc_bus:confirm' .. location.name,
            args = {}
        })
    end
    lib.registerContext({
        id = 'location_list',
        title = 'Select Destination',
        options = options
    })
    lib.showContext('location_list')
end)
