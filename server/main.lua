ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local item_prices = {}
for k, v in pairs(Config.Locations) do
	for h, i in pairs(v.availableitems) do
		item_prices[i.item] = i.price
	end
end

RegisterNetEvent("esx_PawnShops:SellItemPatched")
AddEventHandler("esx_PawnShops:SellItemPatched", function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if item_prices[item] and xPlayer.getInventoryItem(item) then
		if xPlayer.getInventoryItem(item).count >= 1 then
			local itemCount = xPlayer.getInventoryItem(item).count
			
			xPlayer.removeInventoryItem(item, itemCount) -- Removes item
			
			xPlayer.addAccountMoney('black_money', item_prices[item] * itemCount) -- Adds the money
			
			-- Notify the player
			local caption = 'Item Sold'
			local message = 'You sold ' .. itemCount .. ' ' .. item .. ' to the pawn shop for $' .. itemCount * item_prices[item]
			local position = 'top'
			local timeout = 5000
			local progress = true
			if Config.UseSWTNotifications then
				TriggerClientEvent("swt_notifications:Success", source, caption, message, position, timeout, progress)
			else
				-- IMPLEMENT YOUR OWN NOTIFICATIONS HERE
			end
		else
			
			local caption = 'Error'
			local message = 'You do not have a ' .. item .. ' to sell!'
			local position = 'top'
			local timeout = 5000
			local progress = true
			if Config.UseSWTNotifications then
				TriggerClientEvent("swt_notifications:Negative", source, caption, message, position, timeout, progress)
			else
				-- IMPLEMENT YOUR OWN NOTIFICATIONS HERE
			end
		end
	
	else
		
		local caption = 'Error'
		local message = 'That item does not exist!'
		local position = 'top'
		local timeout = 5000
		local progress = true
		if Config.UseSWTNotifications then
			TriggerClientEvent("swt_notifications:Negative", source, caption, message, position, timeout, progress)
		else
			-- IMPLEMENT YOUR OWN NOTIFICATIONS HERE
		end
	end
end)

--[[ THIS METHOD WAS USED BEFORE BUT HAS BEEN REMOVED DUE TO EXPLOITS

RegisterServerEvent('esx_PawnShops:SellItem')
AddEventHandler('esx_PawnShops:SellItem', function(item, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem(item).count > 0 then
		-- Get how many of the items the player has
		local itemCount = xPlayer.getInventoryItem(item).count

		-- Remove the item from the inventory
		xPlayer.removeInventoryItem(item, itemCount)

		-- Give the player the money they need
		xPlayer.addAccountMoney('black_money', itemCount * price)

		-- Notify the player
		local caption = 'Item Sold'
		local message = 'You sold ' .. itemCount .. ' ' .. item .. ' to the pawn shop for $' .. itemCount * price
		local position = 'top'
		local timeout = 5000
		local progress = true
		TriggerClientEvent("swt_notifications:Success", source, caption, message, position, timeout, progress)
	else
		local caption = 'Error'
		local message = 'You do not have a ' .. item .. ' to sell!'
		local position = 'top'
		local timeout = 5000
		local progress = true
		TriggerClientEvent("swt_notifications:Negative", source, caption, message, position, timeout, progress)
	end
end)

]]