# [FfF] Frag, Fun et Fairplay — Insurgency 2014 Server

Serveur Insurgency 2014 dédié — playlist officielle "Combat Soutenu" avec maps et mods workshop.

> Insurgency Custom PvP server with :
> - 78 custom weapons (The Armory PvP + Dismemberment mod)
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
- `fff_maprestart` — commande `sm_maprestart` pour redémarrer la map

### Pourquoi sm_maprestart ?

Le mod **Dismemberment** (The Armory PvP) nécessite un redémarrage de la map à la connexion des premiers joueurs. Sans ça, les effets de démembrement ne s'initialisent pas correctement pour les joueurs qui rejoignent un serveur vide. La commande `sm_maprestart` permet à un admin de relancer la map en une seconde sans passer par le menu.

## Déploiement
```bash
docker-compose up -d
```

## Config
Copier `cfg/server.cfg` et renseigner `rcon_password`.

---

## Maps custom (52)

| Map | Map | Map | Map |
|-----|-----|-----|-----|
| abdallah_b1 | almaden_b5 | badel_b5 | badlands_b1 |
| badlands_b2 | baghdad_b5 | citadel | clean_sweep_beta3 |
| congress | congress_night | convoy_pvp_day_fix | crossbow |
| depot_b2 | docks | downtown_b1 | dust2_b4 |
| dust_b2 | estates_b4 | foot | frequency |
| gizab_b1 | gizab_b2 | haditha_b2 | healthcenter |
| hideout | hideout_b2 | hillah_b1 | ins_pidan_museum |
| iron_express_b2 | karam_b3 | karkand_b3 | karkar_b11 |
| khanashin_b8 | khanashin_b8_night | oasis | oilfield_b4 |
| osama_b4_push | pamir_v3 | panama_canal_b2 | payback |
| point_blank | prospect_b3 | rainforest_b2 | ramadi_b5 |
| samawah_b1 | shellshock | shop_invasion | szepezd_redux |
| takbar_b6 | toujane_b2 | winter_rescue_b6 | zagros_convoy_b5 |

## Armes custom (78) — The Armory PvP + Dismemberment

| Arme | Arme | Arme | Arme |
|------|------|------|------|
| 1911a1 | 901mw | ak12u | aks74u |
| aug | augbo | barret | be93r |
| c4 | c500 | c96 | c9mn |
| codbo | colt_9mm | commando | d9 |
| delta | e9 | enfield | famas |
| fn57 | g33 | g36 | glk33 |
| gol | golma | hb | hk417 |
| imi_uzi | kribk | kritn | ksg |
| l85 | m1014 | m14 | m1asoc |
| m4a1 | m60 | m72law | mac10 |
| mb | mk17 | mp5 | mp7 |
| msra1 | n4 | nova | oc33 |
| p220_hyper | panzerfaust | pecmw | remmington_acr_e |
| s9 | saiga | spas12 | stg44forfal |
| suomi | sw659 | thejudge | trijic |
| ty95 | usp | uzi | secc |
| bits | extended | mbus_m16 | mbus_mk18 |
| micro_t1_m16 | micro_t1_mk18 | nm | sd |
| ins2_sandstorm | melee | upgrades | optics |
| sling | muzzle | | |
