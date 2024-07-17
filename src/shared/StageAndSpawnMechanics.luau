local functions = {}

-- Oyuncunun vardığı bölümle ilgili bilgi, touched v.b. durum için fonksiyonlar

function functions.alSuBolumleri(eventimiz,parcalar)
	for _, child in pairs(parcalar:GetDescendants()) do
		local obje = child
        obje.Touched:Connect(function(hit)
        local oyuncu = game.Players:GetPlayerFromCharacter(hit.Parent) 
            if oyuncu then
				local mevcutBolum = oyuncu:FindFirstChild("leaderstats").Stage.Value
				oyuncu:FindFirstChild("PlayerGui").ChangeStageUI.ChangeStageFrame.StageNum.Text = tonumber(obje.Name)
                if mevcutBolum < tonumber(obje.Name) then
                    local bolum = tonumber(obje.Name)
                    eventimiz:Fire(oyuncu,bolum)
                end
            end
        end)
    end
end

-- Oyuncuya ait karakter öldüğünde ya da düştüğünde veya olağanüstü bir durum yaşandığında karakteri spawn eden fonksiyon

function functions.karakteriYenidenBaslat(oyuncu)
	oyuncu.CharacterAdded:Connect(function()
		functions.karakteriIsinla(oyuncu, oyuncu:FindFirstChild("leaderstats").Stage.Value)
	end)
end

function functions.karakteriIsinla(oyuncu, mevcutBolum)
	local karakter = oyuncu.Character
		if karakter then
			local onemliParca = karakter:WaitForChild("HumanoidRootPart")
			local spawnNoktasi = game.Workspace.ObbyParts.Stages[mevcutBolum]

			if onemliParca and spawnNoktasi then
				onemliParca.CFrame = spawnNoktasi.CFrame + Vector3.new(0, 3, 0)
			else
				print("HumanoidRootPart veya spawn noktasi bulunamadi")
			end
		else
			print("Karakter yok")
		end
end

return functions