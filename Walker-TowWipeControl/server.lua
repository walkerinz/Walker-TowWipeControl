local QBCore = exports['qb-core']:GetCoreObject()


QBCore.Commands.Add("dvall", "Sunucudaki tüm araçları çeker", {}, false, function(source, args)
    dvAll()
end, "god")

dvAll = function()
    local notifyTime = {30, 15, 10, 5, 4, 3, 2, 1}
    for _, time in ipairs(notifyTime) do
        TriggerClientEvent("QBCore:Notify", -1, string.format("Sunucudaki tüm araçlar %d saniye sonra çekilecektir.", time), "error")
        Wait(time == 1 and 1000 or 5000)
    end
    TriggerClientEvent("walker:dvall", -1)
    TriggerClientEvent("QBCore:Notify", -1, "Sunucudaki tüm araçlar çekilmiştir, iyi roller.", "success")
end


CreateThread(function()
    while true do
        Wait(1000 * 60 * 60)
        dvAll()
    end
end)


QBCore.Commands.Add("wipe", "Kişinin karakterini siler.", {}, false, function(source, args)
    local id = tonumber(args[1])
    if id and id > 0 then
        local tPlayer = QBCore.Functions.GetPlayer(id)
        if tPlayer then
            local citizenid = tPlayer.PlayerData.citizenid
            DropPlayer(id, "Karakter Silindi, Tekrar Giriş Sağlayabilirsin")
            if WipeCharacter(citizenid) then
                TriggerClientEvent("QBCore:Notify", source, "Kişiye wipe atıldı.", "success")
            else
                TriggerClientEvent("QBCore:Notify", source, "Karakter silinemedi, lütfen tekrar deneyin.", "error")
            end
        else
            TriggerClientEvent("QBCore:Notify", source, "Kişi bulunamadı.", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "Geçerli bir oyuncu ID'si giriniz.", "error")
    end
end, "god")


function WipeCharacter(citizenid)
    local parameters = {
        ['@citizenid'] = citizenid
    }
    local affectedRows = MySQL.Sync.execute('DELETE FROM players WHERE citizenid = @citizenid', parameters)
    return affectedRows > 0
end
