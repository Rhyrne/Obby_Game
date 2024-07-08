local replicatedStorage = game:GetService("ReplicatedStorage")
local obbyParcalari = game:GetService("Workspace"):FindFirstChild("ObbyParts")
local eventsNTBFired = replicatedStorage.EventsNTBFired
local bolumModule = require(game:GetService("ReplicatedStorage").Shared.StageAndSpawnMechanics)
local parcaHareketModule = require(game:GetService("ReplicatedStorage").Shared.ObbyMechanics)

print("FireSomethings is going on")

bolumModule.alSuBolumleri(eventsNTBFired.StageInfo,obbyParcalari:FindFirstChild("Stages"))