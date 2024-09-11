-- Initialize the Config table
Config = {}

-- Set the price for the bus ride
Config.price = 69

-- Set the price for the bus TAP card
Config.Cardprice = 30

-- Define the bus stop locations (Set description to "" if you dont want a description)
Config.locations = {
    { id = 1, name = "watts", title = "Watts", description = "A vibrant neighborhood known for its cultural heritage.", coords = { x = 439.21, y = -2032.38, z = 23.58 } },
    { id = 2, name = "koreatown", title = "Koreatown", description = "A bustling area with diverse dining options.", coords = { x = 110.0, y = 210.0, z = 310.0 } },
    { id = 3, name = "venice", title = "Venice", description = "Famous for its canals and beachfront boardwalk.", coords = { x = 120.0, y = 220.0, z = 320.0 } },
    { id = 4, name = "santamonica", title = "Santa Monica", description = "A popular beachside city with a lively pier.", coords = { x = 130.0, y = 230.0, z = 330.0 } },
    { id = 5, name = "echopark", title = "Echo Park", description = "A trendy neighborhood with a beautiful lake.", coords = { x = 140.0, y = 240.0, z = 340.0 } }
}

-- coordinates where to purchase  TAP card
Config.coords = vec3(80.4697, 102.5533, 79.1953)
