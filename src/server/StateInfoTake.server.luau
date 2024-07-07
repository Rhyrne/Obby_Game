local bolumBilgi = game:GetService("ReplicatedStorage").EventsNTBFired.StageInfo
local dosya = game:GetService("Workspace"):FindFirstChild("Stages")

local function bolumAyarla(obje)
	obje.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	
		if player then
			local mevcutBolum = player:FindFirstChild("leaderstats").Stage.Value
			if mevcutBolum < tonumber(obje.Name) then
				local bolum = tonumber(obje.Name)
				bolumBilgi:Fire(player,bolum)
			end
		end
	end)
end

for _, child in pairs(dosya:GetDescendants()) do
	bolumAyarla(child)
end