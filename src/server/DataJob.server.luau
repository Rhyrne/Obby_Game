local players = game:GetService("Players")

players.PlayerAdded:Connect(function(player)
	local leaderboard = Instance.new("Folder", player)
	leaderboard.Name = "leaderstats"
	local stage = Instance.new("IntValue", leaderboard)
	stage.Name = "Stage"
	stage.Value = 1
end)