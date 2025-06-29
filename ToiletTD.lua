-- Aguarda o jogo carregar
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Espera o HumanoidRootPart aparecer
repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

-- Etapa 1: Teleporta pro portal Nightmare (ajuste se necessário)
local nightmarePosition = Vector3.new(13, 1, 12) -- chute baseado no print
character:MoveTo(nightmarePosition)

-- Etapa 2: Aguarda alguns segundos para o jogo te colocar na partida
task.wait(10)

-- Etapa 3: Procura o botão "Start" e clica automaticamente
local function autoStart()
    local gui = player:WaitForChild("PlayerGui")
    
    for _, v in pairs(gui:GetDescendants()) do
        if v:IsA("TextButton") and v.Text:lower():find("start") then
            task.wait(1)
            print("🟢 Clicando no botão Start!")
            pcall(function()
                v:Activate()
            end)
            break
        end
    end
end

-- Aguarda o botão aparecer e executa o clique
local success = false
for i = 1, 20 do -- tenta por 20 vezes
    local gui = player:FindFirstChild("PlayerGui")
    if gui then
        for _, v in pairs(gui:GetDescendants()) do
            if v:IsA("TextButton") and v.Text:lower():find("start") then
                pcall(function()
                    v:Activate()
                end)
                success = true
                print("✅ Start clicado!")
                break
            end
        end
    end
    if success then break end
    task.wait(1)
end

if not success then
    warn("❌ Botão Start não encontrado.")
end
