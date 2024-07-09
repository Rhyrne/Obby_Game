local replicatedStorage = game:GetService("ReplicatedStorage")
local obbyParcalari = game:GetService("Workspace"):FindFirstChild("ObbyParts")
local eventsNTBFired = replicatedStorage.EventsNTBFired
local bolumVeSpawnModule = require(game:GetService("ReplicatedStorage").Shared.StageAndSpawnMechanics)
local obbyModule = require(game:GetService("ReplicatedStorage").Shared.ObbyMechanics)

print("FireSomethings is going on")

bolumVeSpawnModule.alSuBolumleri(eventsNTBFired.StageInfo,obbyParcalari:FindFirstChild("Stages"))

obbyModule.olumculParca(eventsNTBFired.KillSomeone, obbyParcalari:FindFirstChild("DamageParts"))