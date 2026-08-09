# [FfF] Frag, Fun et Fairplay — Insurgency 2014 Server

Serveur Insurgency 2014 dédié — playlist officielle "Combat Soutenu" avec maps et mods workshop.

> Insurgency Custom PvP server with :
> - 221 custom weapons (The Armory PvP + Dismemberment mod)
> - 52 custom maps (+ 14 official NWI maps)
> - Voice mod
> - Dismemberment mod
> - Fire Strike
> - and more

Collection Steam Workshop : https://steamcommunity.com/sharedfiles/filedetails/?id=649274722

## Stack
- Docker + Steam AppID 222880
- SourceMod + MetaMod
- Playlist NWI `pvp_sustained` modifiée (maps officielles + workshop, mode push uniquement)

## Plugins FfF
- `fff_playlist_lock` — force sv_playlist officielle + bloque l'auto-rotation quand le serveur est vide
- `fff_supply_force` — force 18 supply tokens de départ
- `fff_maprestart` — commande `sm_maprestart`

## Déploiement
```bash
docker-compose up -d
```

## Config
Copier `cfg/server.cfg` et renseigner `rcon_password`.
