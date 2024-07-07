local functions = {}

local uzaktanOlaylar = game:GetService("ReplicatedStorage").EventsNTBFired

-- Oyuncunun vardığı bölümle ilgili bilgi, touched v.b. durum için fonksiyonlar

function functions.alSuBolumleri(info1,info2)
	for _, child in pairs(info2:GetDescendants()) do
		local obje = child
        obje.Touched:Connect(function(hit)
        local player = game.Players:GetPlayerFromCharacter(hit.Parent)
            
            if player then
                local mevcutBolum = player:FindFirstChild("leaderstats").Stage.Value
                if mevcutBolum < tonumber(obje.Name) then
                    local bolum = tonumber(obje.Name)
                    info1:Fire(player,bolum)
                end
            end
        end)
    end
end

-- Uzaktan ulaşım için hazırlanmış(client to server, server to server, client to client) fonksiyonlar

function functions.bolumPartinaDokundu()
	uzaktanOlaylar.StageInfo.Event:Connect(function(player,bolum)
		local mevcutBolum = player:FindFirstChild("leaderstats").Stage
		mevcutBolum.Value = bolum
	end)
end

return functions