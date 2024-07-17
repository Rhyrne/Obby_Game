local uzaktanOlaylarModule = require(game:GetService("ReplicatedStorage").Shared.EventsAreRemote)
local bolumVeSpawnModule = require(game:GetService("ReplicatedStorage").Shared.StageAndSpawnMechanics)

print("MainScript is going on")

-- Spawn noktalarına basıldığında tetiklenir

uzaktanOlaylarModule.bolumPartinaDokundu()

-- Ölümcül parçalara dokunulduğunda tetiklenir

uzaktanOlaylarModule.olumPartinaDokundu()

-- Oyuncu oyuna girdiğinde, ait olduğu "Time" durumunu arttırmak için tetiklenir

uzaktanOlaylarModule.zamanArttirmaKodu()

-- Basıldığında kaybolan parçalara basılınca tetiklenir

uzaktanOlaylarModule.kirpanPartinaDokundu()

-- Satın alma işlemlerini gerçekleştiren fonksiyon tetiklenir

uzaktanOlaylarModule.satinAlmaIslemi()

-- Lider tablosunun kullanıcılara gösterilmesini sağlıyor (düzgün çalışmıyor)

uzaktanOlaylarModule.liderTablosunuDoldur()

-- Karakterimiz istediği zaman istediği bölümler arasında geçiş yapmasını sağlar

uzaktanOlaylarModule.karakteriIstenilenBolumeIsinla()

-- Oyun içerisinde bulunan ve saldırmaya ya da özel yeteneklere yarayan gearların kullanılması durumunda tetiklenir

uzaktanOlaylarModule.saldiriOlayi()
uzaktanOlaylarModule.yetenekOlayi()

-- Dünyadan düşen oyuncuları spawn noktalarına geri ışınlamaya yarayan fonksiyon

game:GetService("Workspace").ObbyParts.WorldBorder.Touched:Connect(function(dokunanParca)
	local karakter = dokunanParca.Parent
	if karakter and karakter:FindFirstChild("Humanoid") then
		local player = game:GetService("Players"):GetPlayerFromCharacter(karakter)
		bolumVeSpawnModule.karakteriIsinla(player, player:FindFirstChild("leaderstats").Stage.Value)
	end
end)

