
# 🚌 FiveM Bus Stops and TAP Card System

[🔍 Preview](https://discord.gg/aPdEVCKQbu)

### 📜 Check Out My Other Scripts!
- 💬 [Join My Discord](https://discord.gg/tJtKPSz9p3)
- 🛒 [Visit My Tebex Store](https://mikey.tebex.io/)

## 📝 Description
A third-eye feature to travel to other bus stops with an integrated TAP card system for convenient public transport.

## ✨ Features
- 🚏 **Interactive Bus Stops**: Use the third-eye feature to travel between bus stops across the city.
- 💳 **TAP Card System**: Players can purchase a TAP card, allowing them to travel for free on the bus.

## ⚙️ Configuration Options
- ➕ **Add/Remove Bus Stops**: Easily add or remove bus stops via the config file to match your server's unique layout.
- 🛣️ **Set Bus Routes**: Customize bus routes for efficient and logical travel paths across your server.
- 💲 **TAP Card and Bus Pricing**: Set prices for bus rides and TAP cards.

## 📦 Dependencies
- 📥 [ox_inventory](https://github.com/overextended/ox_inventory)
- 📥 [ox_lib](https://github.com/overextended/ox_lib)
- 📥 [ox_target](https://github.com/overextended/ox_target)

## 🛠️ Item to Add in `ox_inventory` > `data` > `items.lua`

```lua
['buscard'] = {
    label = 'Bus TAP Card',
    stack = false,
    weight = 1,
    description = 'Bus Fare Ticket'
},
```
