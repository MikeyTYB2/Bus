local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('tapCardPayment', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local itemQuantity = xPlayer.getInventoryItem('buscard').count
        if itemQuantity >= 1 then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Bus',
                description = 'You have used your TAP card to take the bus.',
                position = 'top',
                style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                icon = 'bus',
                iconColor = '#98FB98'
            })       
            cb(true)
        else
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Bus',
                description = 'You do not have a TAP card.',
                position = 'top',
                style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                icon = 'bus',
                iconColor = '#FF6347'
            })
            cb(false)
        end
    else
        print('xPlayer is nil for source: ' .. tostring(source))
    end
end)

ESX.RegisterServerCallback('sc_bus:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local itemQuantity = xPlayer.getInventoryItem('money').count
        if itemQuantity >= Config.price then
            xPlayer.removeInventoryItem('money', Config.price)
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Bus',
                description = string.format('You purchased a bus ticket for $%d.', Config.price),
                position = 'top',
                style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                icon = 'bus',
                iconColor = '#98FB98',
            })
            cb(true)
        else
            cb(false)
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Bus',
                description = 'You have insufficient funds to travel, you need $'..Config.price..'',
                position = 'top',
                style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                icon = 'bus',
                iconColor = '#C53030',
                duration = 5000
            })
        end
    else
        print('xPlayer is nil for source: ' .. tostring(source))
    end
end)

ESX.RegisterServerCallback('checkMoneyCard', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if xPlayer.getAccount('money').money >= Config.Cardprice then
            xPlayer.removeInventoryItem('money', Config.Cardprice)
            xPlayer.addInventoryItem('buscard', 1)
            cb(true)
        else
            cb(false)
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Bus',
                description = 'You have insufficient funds to buy a TAP card, you need $'..Config.Cardprice..'.',
                position = 'top',
                style = { backgroundColor = '#2E3440', color = '#D8DEE9' },
                iconColor = '#C53030',
                duration = 5000
            })
        end
    else
        print('xPlayer is nil for source: ' .. tostring(source))
    end
end)
