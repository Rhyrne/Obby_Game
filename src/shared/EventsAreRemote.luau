local replicatedStorage = game:GetService("ReplicatedStorage")
local uzaktanOlaylar = replicatedStorage.EventsNTBFired
local bolumVeSpawnModule = require(replicatedStorage.Shared.StageAndSpawnMechanics)

local functions = {}

-- Uzaktan ulaşım için hazırlanmış(client to server, server to server, client to client) fonksiyonlar

function functions.bolumPartinaDokundu()
	uzaktanOlaylar.StageInfo.Event:Connect(function(player,bolum)
		local mevcutBolum = player:FindFirstChild("leaderstats").Stage
		mevcutBolum.Value = bolum
	end)
end

function functions.olumPartinaDokundu()
	uzaktanOlaylar.KillSomeone.Event:Connect(function(player)
		if player then
			local character = player.Character or player.CharacterAdded:Wait()
			local humanoid = character:WaitForChild("Humanoid")
			if humanoid then
				humanoid.Health = 0
			else
				print(humanoid.Name .. (" is not humanoid"))
			end

			humanoid.Died:Connect(function()
				bolumVeSpawnModule.karakteriYenidenBaslat(player, character)
			end)
		end
	end)
end

function functions.zamanArttirmaKodu()
	uzaktanOlaylar.IncreaseTime.Event:Connect(function(player)
		while wait(1) do
			player:WaitForChild("leaderstats").Time.Value += 1
		end
	end)
end

function functions.kirpanPartinaDokundu()
	uzaktanOlaylar.NeedBlind.Event:Connect(function(player, obje)
		if player then
			obje.Transparency = 0.5
			obje.CanCollide = false
			obje.CanTouch = false
			wait(2)
			obje.Transparency = 0
			obje.CanCollide = true
			obje.CanTouch = true
		end
	end)
end

function functions.satinAlmaIslemi()
	uzaktanOlaylar.PlayerIsShopping.OnServerEvent:Connect(function(player, mevcutUrun, urunTuru)
		if urunTuru == "Silah" then
			local klonUrun = replicatedStorage.Gears[mevcutUrun]:Clone()
			klonUrun.Parent = player.Backpack
		else
			print("what")
		end
	end)
end

return functions