local players = game:GetService("Players")
local tekrarliDepo = game:GetService("ReplicatedStorage")
local yukleVeKaydetModule = require(tekrarliDepo.Shared.SaveAndLoadMechanics)
local obbyMekanikleri = require(tekrarliDepo.Shared.ObbyMechanics)
local bolumVeSpawnModule = require(game:GetService("ReplicatedStorage").Shared.StageAndSpawnMechanics)

print("DataJob is going on")

players.PlayerAdded:Connect(function(player)
	yukleVeKaydetModule.liderTablosuOlustur(player)
	yukleVeKaydetModule.verileriTabloyaGetir(player)
	obbyMekanikleri.zamanArttirma(player)
	bolumVeSpawnModule.karakteriYenidenBaslat(player)
end)

players.PlayerRemoving:Connect(function(player)
	yukleVeKaydetModule.verileriTabloyaKaydet(player)
end)