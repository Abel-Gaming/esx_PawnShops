ESX	= nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(250)
	end
end)

-- Create blips if enabled in the config
Citizen.CreateThread(function()
	if Config.EnableBlips then
		for k,v in pairs(Config.Locations) do
			-- Create blip
			local blip = AddBlipForCoord(v.coord.x, v.coord.y, v.coord.z)

			-- Set blip sprite
			SetBlipSprite(blip, v.BlipSprite)

			-- Set blip color
			SetBlipColour(blip, v.BlipColor)

			-- Set blip display
			SetBlipDisplay(blip, 4)

			-- Set blip scale
			SetBlipScale(blip, v.BlipScale)

			-- Set blip for short range
			SetBlipAsShortRange(blip, true)

			-- Change blip text
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentString(v.name .. ' Pawn Shop')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

-- Create Enter / Exit Markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		for k,v in pairs(Config.Locations) do
			-- Set the shop locations as a whole vector3
			local ShopLocation = vector3(v.coord.x, v.coord.y, v.coord.z)

			-- Draw the marker
			DrawMarker(25, ShopLocation.x, ShopLocation.y, ShopLocation.z - 0.98, 
			0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 0, 255, 0, 155, false, true, 2, nil, nil, false)
		end
	end
end)

-- Check the distance from the markers
Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do -- Wait for the user to load
		Wait(500)
	end

	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId())
		for k,v in pairs(Config.Locations) do
			local markerlocation = vector3(v.coord.x, v.coord.y, v.coord.z)
		
			-- Check how close the player is to the marker location
			while #(GetEntityCoords(PlayerPedId()) - markerlocation) <= 1.0 do
				Citizen.Wait(0) -- REQUIRED

				-- Draw text with instructions
				ESX.Game.Utils.DrawText3D(markerlocation, "Press ~y~[E]~s~ to sell to pawn shop")

				-- Check for button press
				if IsControlJustReleased(0, 51) then
					-- Open menu is the button is pressed
					OpenMenu(v.availableitems)

					-- Wait for menu control
					while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "general_menu") do
						Wait(50)
					end
				end
			end
		end
	end
end)

--Opens the purchase menu
function OpenMenu(items)
	ESX.UI.Menu.CloseAll()
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'general_menu', {
		title = "Sell Items",
		align = "center",
		elements = items
	}, function(data, menu)
		--TriggerServerEvent("esx_PawnShops:SellItem", data.current.item, data.current.price)
		TriggerServerEvent("esx_PawnShops:SellItemPatched", data.current.item)
	end,
	function(data, menu)
		menu.close()
	end)
end