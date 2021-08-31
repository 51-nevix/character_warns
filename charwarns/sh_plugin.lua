local PLUGIN = PLUGIN

PLUGIN.name = "Character warns"
PLUGIN.author = "Nevix"
PLUGIN.description = "Система предупреждений выдаваемых администраторами."
    


ix.command.Add("CharWarn", {
    description = "Выдать предупреждение персонажу.",
    adminOnly = true,
    arguments = {
        ix.type.character, ix.type.text
    },
    OnRun = function(self, client, character, reason)
        local oldvalue = character:GetData("warn", 0)
        character:SetData("warn", oldvalue+1)
        local newvalue = character:GetData("warn", 1)
        local ply = character:GetPlayer()

        if string.len(reason) <1 then
            reason = "Не указана."
        end
        
        if newvalue >=3 then
            character:Ban(60)
            character:SetData("warn", oldvalue)
            client:Notify("Персонаж " .. client:GetName() .. " был заблокирован за превышение допустимого количества предупреждений")
        end
    
        ply:ChatNotify("Вам было выдано предупреждение от " .. client:GetName() .. "  Комментарий: " .. reason .. ". Будьте осторожны! Если вы получите слишком много предупреждений, ваш персонаж будет временно, либо перманентно заблокирован.")
        --  MsgC( Color( 255, 0, 0 ), "Вам было выдано предупреждение от " .. client:GetName() .. "  Комментарий: " .. reason .. ". Будьте осторожны! Если вы получите слишком много предупреждений, ваш персонаж будет временно, либо перманентно заблокирован.")
        ply:ChatNotify("Всего предупреждений: " .. newValue)
        ply:Notify("Вы были заморожены на 10 секунд. Ознакомьтесь с предупреждением!")
        client:Notify("Успешно!")

        ply:GodEnable()
        ply:Freeze(true)
        IsValid(ply)
        timer.Simple( 10, function()
            if IsValid(ply) then
                ply:GodDisable()
                ply:Freeze(false)
            end    
        end)

    end
})
