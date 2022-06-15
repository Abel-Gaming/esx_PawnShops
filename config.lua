Config = {}

-- Blip Settings
Config.EnableBlips = true

-- Notifications
Config.UseSWTNotifications = true -- Download here: https://github.com/Switty6/swt_notifications

-- Locations and items at each location
Config.Locations = {
    {
        name = 'Prosperity Street',
        coord = vector3(-1459.648, -414.3824, 35.71643),
        BlipSprite = 108,
        BlipColor = 25,
        BlipScale = 0.85,
        availableitems =
        {
            {
                label = 'Gold Bar ($600)',
                item = 'goldbar',
                price = 600
            },
            {
                label = 'Gold Watch ($175)',
                item = 'goldwatch',
                price = 175
            },
            {
                label = 'Gold Necklace ($150)',
                item = 'goldnecklace',
                price = 150
            },
            {
                label = 'Diamond ($900)',
                item = 'diamond',
                price = 900
            }
        }
    },
    {
        name = 'Strawberry Ave',
        coord = vector3(182.5187, -1319.275, 29.3136),
        BlipSprite = 108,
        BlipColor = 25,
        BlipScale = 0.85,
        availableitems =
        {
            {
                label = 'Gold Bar ($600)',
                item = 'goldbar',
                price = 600
            },
            {
                label = 'Gold Watch ($175)',
                item = 'goldwatch',
                price = 175
            },
            {
                label = 'Gold Necklace ($150)',
                item = 'goldnecklace',
                price = 150
            },
            {
                label = 'Diamond ($900)',
                item = 'diamond',
                price = 900
            }
        }
    }
}