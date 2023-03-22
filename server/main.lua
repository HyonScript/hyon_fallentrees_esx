local trees ={}
local Time = (Config.spawntime_min*1000)*60
local mintime = (Config.spawntime_min*1000)*60
local maxtime = (Config.spawntime_max*1000)*60
local randomamount = math.random(Config.treespawn_min, Config.treespawn_max)

RegisterServerEvent('lootmoney')
AddEventHandler('lootmoney', function(tree, id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(source)
	local randomreward = math.random(Config.reward_min, Config.reward_max)

	trees[id].spawn = 0

	TriggerClientEvent("hyon_fallentree:create_tree", -1, trees)

		if Config.reward == "money" then
			xPlayer.addMoney(randomreward)
			xPlayer.showNotification('~o~You got as a reward~s~~g~ '..randomreward.. ' ~s~~o~money~s~')
		elseif Config.reward == "item" then
			local randomitem = math.random(1, #Config.Lootitem)
			local amount = math.random(Config.Lootitem[randomitem].minamount, Config.Lootitem[randomitem].maxamount)
			xPlayer.addInventoryItem(Config.Lootitem[randomitem].item,amount)
			xPlayer.showNotification('~o~You got as a reward~s~~g~ ' ..amount..'x ' ..Config.Lootitem[randomitem].item.. '')
		elseif Config.reward == false then
			xPlayer.showNotification('~o~You chopped a Fallen Tree~s~~g~')
		end
    end)
	
RegisterServerEvent('hyon_fallentree:get_tree')
AddEventHandler('hyon_fallentree:get_tree', function()
	TriggerClientEvent("hyon_fallentree:create_tree", -1, trees)
    end)

Citizen.CreateThread(function() 
    while true do
				if #trees ~= #Config.Trees then
				for k,v in pairs(Config.Trees) do
				trees[k] = {}
				trees[k] = {coords = v.coords, spawn = 0, heading = v.heading}
				end
				end
				Citizen.Wait(1000)
	end
end)
 
Citizen.CreateThread(function() 
    while true do
	Time = math.random(mintime, maxtime)
	randomamount = math.random(Config.treespawn_min, Config.treespawn_max)
		for i = 1, randomamount do
			print("i:", i)
			print("randomamount:", randomamount)
			print("Time:", Time)
			local randomtree = math.random(1, #trees)
				if trees[randomtree].spawn < 60 then
				trees[randomtree].spawn = 60
				elseif trees[randomtree].spawn == 60 then
				i = i-1
				end
		end	
		Citizen.Wait(Time)
	end
end) 


RegisterCommand(Config.Commanddel, function(source)
    if (source < 1) then return end

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() ~= Config.Admin then return end
	
		for k,v in pairs(trees) do
			trees[k].spawn = 0
		end
		print("All Trees Deleted")
end)

RegisterCommand(Config.Commandspawn, function(source)
    if (source < 1) then return end

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() ~= Config.Admin then return end
	
		for k,v in pairs(trees) do
			trees[k].spawn = 60
		end
		print("All Trees Spawned")
end)