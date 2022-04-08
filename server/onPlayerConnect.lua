---@author Razzway
---@version 1.0

AddEventHandler('playerConnecting', function()
    local PLAYER_NAME, PLAYER_IP, PLAYER_STEAMHEX = GetPlayerName(source), GetPlayerEndpoint(source), GetPlayerIdentifier(source)
    PLAYER_DISCORD = "`Pas relié`"
    for _,v in ipairs(GetPlayerIdentifiers(source))do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            discordid = string.sub(v, 9)
            PLAYER_DISCORD = "<@" .. discordid .. ">"
        end
    end

    local date = os.date('*t')

    if date.day < 10 then date.day = '' .. tostring(date.day) end
    if date.month < 10 then date.month = '' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
    if date.min < 10 then date.min = '' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '' .. tostring(date.sec) end

    local logsDate = date.day.."/"..date.month.."/"..date.year.." - "..date.hour..":"..date.min..":"..date.sec

    local connect = {
        {
            ["color"] = _ServerConfig.param.color.green,
            ["title"] = "Un joueur vient de se connecter",
            ["description"] = "Nom du Joueur : `"..PLAYER_NAME.."`\nAdresse IP : ||`"..PLAYER_IP.."`||\nSteam Hex : `"..PLAYER_STEAMHEX.."`\nDiscord : "..PLAYER_DISCORD.."",
            ["footer"] = {
                ["text"] = logsDate,
                ["icon_url"] = _ServerConfig.param.logo,
            },
        }
    }

    PerformHttpRequest(_ServerConfig.param.wehbook, function(err, text, headers) end, 'POST', json.encode({username = _ServerConfig.param.name, embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerDropped', function(reason)
    local PLAYER_NAME, PLAYER_IP, PLAYER_STEAMHEX = GetPlayerName(source), GetPlayerEndpoint(source), GetPlayerIdentifier(source)
    local date = os.date('*t')

    if date.day < 10 then date.day = '' .. tostring(date.day) end
    if date.month < 10 then date.month = '' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
    if date.min < 10 then date.min = '' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '' .. tostring(date.sec) end

    local logsDate = date.day.."/"..date.month.."/"..date.year.." - "..date.hour..":"..date.min..":"..date.sec

    local disconnect = {
        {
            ["color"] = _ServerConfig.param.color.red,
            ["title"] = "Un joueur vient de se déconnecter",
            ["description"] = "Nom du Joueur : `"..PLAYER_NAME.."`\nAdresse IP : ||`"..PLAYER_IP.."`||\n Steam Hex : `"..PLAYER_STEAMHEX.."`\nDiscord : "..PLAYER_DISCORD.."\nRaison : `"..reason.."`",
            ["footer"] = {
                ["text"] = logsDate,
                ["icon_url"] = _ServerConfig.param.logo,
            },
        }
    }

    PerformHttpRequest(_ServerConfig.param.wehbook, function(err, text, headers) end, 'POST', json.encode({username = _ServerConfig.param.name, embeds = disconnect}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local source = source
    local PLAYER_NAME = GetPlayerName(source)
    local PLAYER_STEAMHEX = GetPlayerIdentifier(source)

    local MONEY_IN_CASH = xPlayer.getMoney()
    local MONEY_AT_BANK = xPlayer.getAccount('bank').money
    local MONEY_IN_DIRT = xPlayer.getAccount('black_money').money

    local PLAYER_JOB = xPlayer.job.label
    local PLAYER_JOB_GRADE = xPlayer.job.grade_label
    local PLAYER_JOB2 = xPlayer.job2.label
    local PLAYER_JOB2_GRADE = xPlayer.job2.grade_label

    local MESSAGE_LINE = "─────────────────────"
    local date = os.date('*t')

    if date.day < 10 then date.day = '' .. tostring(date.day) end
    if date.month < 10 then date.month = '' .. tostring(date.month) end
    if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
    if date.min < 10 then date.min = '' .. tostring(date.min) end
    if date.sec < 10 then date.sec = '' .. tostring(date.sec) end

    local logsDate = date.day.."/"..date.month.."/"..date.year.." - "..date.hour..":"..date.min..":"..date.sec

    local info = {
        {
            ["color"] = _ServerConfig.param.color.yellow,
            ["title"] = "Connexion établie",
            ["description"] = MESSAGE_LINE.."\nNom du Joueur: `"..PLAYER_NAME.."`\nID du Joueur : `"..source.."`\nSteam Hex : `"..PLAYER_STEAMHEX.."`\nDiscord : "..PLAYER_DISCORD.."\n"..MESSAGE_LINE.."\nArgent en cash : `"..MONEY_IN_CASH.." $`\nArgent en banque : `"..MONEY_AT_BANK.." $`\nArgent sale : `"..MONEY_IN_DIRT.." $`\n"..MESSAGE_LINE.."\nJob : `"..PLAYER_JOB.."` › Grade : `"..PLAYER_JOB_GRADE.."`\nOrganisation : `"..PLAYER_JOB2.."` › Grade : `"..PLAYER_JOB2_GRADE.."`",
            ["footer"] = {
                ["text"] = logsDate,
                ["icon_url"] = _ServerConfig.param.logo,
            },
        }
    }

    PerformHttpRequest(_ServerConfig.param.wehbook, function(err, text, headers) end, 'POST', json.encode({username = _ServerConfig.param.name, embeds = info}), { ['Content-Type'] = 'application/json' })
end)
