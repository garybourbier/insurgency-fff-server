#include <sourcemod>

public Plugin myinfo = {
    name        = "FfF Map Restart",
    author      = "FfF",
    description = "Admin command to restart the current map",
    version     = "1.0",
    url         = ""
};

public void OnPluginStart() {
    RegAdminCmd("sm_maprestart", Cmd_MapRestart, ADMFLAG_CHANGEMAP, "Redémarre la map actuelle");
}

public Action Cmd_MapRestart(int client, int args) {
    char map[PLATFORM_MAX_PATH];
    GetCurrentMap(map, sizeof(map));
    PrintToChatAll("[FfF] Map restart dans 5s...");
    PrintToServer("[FfF] Map restart: %s", map);
    DataPack dp = new DataPack();
    dp.WriteString(map);
    CreateTimer(5.0, Timer_Restart, dp);
    return Plugin_Handled;
}

public Action Timer_Restart(Handle timer, DataPack dp) {
    char map[PLATFORM_MAX_PATH];
    dp.Reset();
    dp.ReadString(map, sizeof(map));
    delete dp;
    ForceChangeLevel(map, "Admin map restart");
    return Plugin_Stop;
}
