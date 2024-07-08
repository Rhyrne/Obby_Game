local uzaktanOlaylar = game:GetService("ReplicatedStorage").EventsNTBFired

local functions = {}

-- Uzaktan ulaşım için hazırlanmış(client to server, server to server, client to client) fonksiyonlar

function functions.bolumPartinaDokundu()
	uzaktanOlaylar.StageInfo.Event:Connect(function(player,bolum)
		local mevcutBolum = player:FindFirstChild("leaderstats").Stage
		mevcutBolum.Value = bolum
	end)
end

return functions