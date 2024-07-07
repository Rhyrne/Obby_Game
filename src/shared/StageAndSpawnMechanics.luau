local functions = {}

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

return functions