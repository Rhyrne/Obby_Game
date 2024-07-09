local obbyParcalari = game:GetService("Workspace").ObbyParts

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

-- Oyuncuya ait karakter öldüğünde ya da düştüğünde veya olağanüstü bir durum yaşandığında karakteri spawn eden fonksiyon

function functions.karakteriYenidenBaslat(player)
	player.CharacterAdded:Connect(function(character)
		if character then
			local onemliParca = character:WaitForChild("HumanoidRootPart")
			local mevcutBolum = player:FindFirstChild("leaderstats").Stage.Value
			local spawnNoktasi = game.Workspace.ObbyParts.Stages[mevcutBolum]

			if onemliParca and spawnNoktasi then
				onemliParca.CFrame = spawnNoktasi.CFrame + Vector3.new(0, 3, 0)
			else
				print("HumanoidRootPart veya spawn noktası bulunamadı")
			end
		else
			print("Karakter yok")
		end
	end)
end

return functions