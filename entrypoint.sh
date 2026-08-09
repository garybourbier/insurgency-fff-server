#!/bin/bash
GAME_DIR="/home/steam/game"
CFG_DIR="/home/steam/config"
LOG="/tmp/entry.log"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG"; }

cd "$GAME_DIR" || { log "Dossier game introuvable"; exit 1; }

# Lier les configs au bon endroit
[ -d "$CFG_DIR/cfg" ]     && ln -sfn "$CFG_DIR/cfg"     insurgency/cfg
[ -d "$CFG_DIR/addons" ]  && ln -sfn "$CFG_DIR/addons"  insurgency/addons
[ -d "$CFG_DIR/custom" ]  && ln -sfn "$CFG_DIR/custom"  insurgency/custom

export LD_LIBRARY_PATH="$GAME_DIR/bin:$GAME_DIR/linux64:$LD_LIBRARY_PATH"

CMD="./srcds_linux -game insurgency -nobattleye -strictportbind -ip 0.0.0.0 \
  -port 27015 +clientport 27005 +tv_port 27020 \
  -tickrate 64 +sv_playlist nwi/pvp_sustained +map tell \
  +maxplayers 32 -workshop -nowatchdog -console -usercon \
  +exec server.cfg"

RESTART=0
while true; do
    RESTART=$((RESTART + 1))
    log "Démarrage #$RESTART"
    screen -dmS insurgency bash -c "$CMD"
    while true; do
        pgrep -x srcds_linux > /dev/null 2>&1 || { log "srcds mort, relance dans 10s"; screen -S insurgency -X quit 2>/dev/null; sleep 10; break; }
        sleep 5
    done
done
