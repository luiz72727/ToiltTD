-- Aguarda o jogo carregar
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Espera o HumanoidRootPart aparecer
repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

-- Etapa 1: Teleporta pro portal Nightmare (ajuste se necessário)
local nightmarePosition = Vector3.new(417.38, 162, -6) -- chute baseado no print
character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(nightmarePosition)


-- Etapa 2: Aguarda alguns segundos para o jogo te colocar na partida
task.wait(2)

-- Etapa 3: Auto Start inteligente
local gui = player:WaitForChild("PlayerGui")
local success = false

for i = 1, 60 do -- tenta por até 30 segundos
    for _, v in pairs(gui:GetDescendants()) do
        if v:IsA("TextButton") or v:IsA("ImageButton") then
            local text = v.Text or ""
            if text:lower():find("start") then
                print("✅ Botão Start encontrado, tentando clicar...")

                -- Tenta clicar com segurança
                pcall(function()
                    v:Activate()
                end)

                if v:FindFirstChildOfClass("LocalScript") or v.MouseButton1Click then
                    pcall(function()
                        v.MouseButton1Click:Fire()
                    end)
                end

                success = true
                break
            end
        end
    end

    if success then
        print("🎮 Partida iniciada com sucesso!")
        break
    end

    task.wait(0.5) -- espera meio segundo antes de tentar novamente
end

if not success then
    warn("❌ Botão 'Start' não foi encontrado ou clicado.")
end
