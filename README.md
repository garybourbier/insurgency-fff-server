# Insurgency FfF Server

Serveur Insurgency 2014 dédié — playlist officielle "Combat Soutenu" avec maps workshop.

## Stack
- Docker + Steam AppID 222880
- SourceMod + MetaMod
- Playlist NWI `pvp_sustained` modifiée (maps officielles + workshop, mode push)

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
