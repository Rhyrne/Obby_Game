local bolumBilgi = game:GetService("ReplicatedStorage").EventsNTBFired.StageInfo
local dosya = game:GetService("Workspace"):FindFirstChild("Stages")
local bolumModule = require(game:GetService("ReplicatedStorage").Shared.StageAndSpawnMechanics)

bolumModule.alSuBolumleri(bolumBilgi,dosya)