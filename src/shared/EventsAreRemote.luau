local uzaktanOlaylar = game:GetService("ReplicatedStorage").EventsNTBFired
local bolumVeSpawnModule = require(game:GetService("ReplicatedStorage").Shared.StageAndSpawnMechanics)

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

return functions