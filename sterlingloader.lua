local Players = game:GetService("Players")
local Scripts = {
    [6931042565] = "https://api.luarmor.net/files/v4/loaders/23887e73347f37b16ca4fd2c433e7914.lua", -- VBL 
    [6945584306] = "https://api.luarmor.net/files/v4/loaders/a30ba67e0f7221e461f226234fbafa4f.lua",  -- AZL
}

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local player = Players.LocalPlayer
while not player do
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    player = Players.LocalPlayer
end

player:WaitForChild("DataLoaded")
local placeId = game.PlaceId
local url = Scripts[placeId]

if not url then
    rconsolewarn("[Sterling Hub Loader] No script registered for PlaceId " .. tostring(placeId))
    return
end

local ok, src = pcall(game.HttpGet, game, url)
if not ok or type(src) ~= "string" or src == "" then
    rconsolewarn("[Sterling Hub Loader] Failed to fetch script for PlaceId " .. tostring(placeId))
    return
end

local fn, err = loadstring(src)
if not fn then
    rconsolewarn("[Sterling Hub Loader] loadstring error: " .. tostring(err))
    return
end

local runOk, runErr = pcall(fn)
if not runOk then
    rconsolewarn("[Sterling Hub Loader] runtime error: " .. tostring(runErr))
end
