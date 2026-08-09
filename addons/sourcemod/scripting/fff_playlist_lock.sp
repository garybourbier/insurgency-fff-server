#include <sourcemod>

public Plugin myinfo = {
    name        = "FfF Playlist Lock",
    author      = "FfF",
    description = "Force sv_playlist + bloque auto-rotation vide, sm_changemap pour admin",
    version     = "2.2",
    url         = ""
};

ConVar g_cvPlaylist;
bool g_bAdminChangelevel = false;

public void OnPluginStart() {
    g_cvPlaylist = FindConVar("sv_playlist");
    if (g_cvPlaylist != null)
        HookConVarChange(g_cvPlaylist, OnPlaylistChanged);

    AddCommandListener(Cmd_Changelevel, "changelevel");
    RegAdminCmd("sm_changemap", Cmd_AdminMap, ADMFLAG_CHANGEMAP, "Change map (bypass empty-server block)");
}

public void OnConfigsExecuted() { ForcePlaylist(); }

public void OnMapStart() {
    CreateTimer(1.0, Timer_Force);
}

public Action Timer_Force(Handle timer) {
    ForcePlaylist();
    return Plugin_Stop;
}

void ForcePlaylist() {
    if (g_cvPlaylist != null)
        g_cvPlaylist.SetString("nwi/pvp_sustained", true, false);
}

// Admin: force map change même serveur vide
public Action Cmd_AdminMap(int client, int args) {
    if (args < 1) {
        ReplyToCommand(client, "Usage: sm_changemap <map>");
        return Plugin_Handled;
    }
    char mapName[PLATFORM_MAX_PATH];
    GetCmdArg(1, mapName, sizeof(mapName));
    PrintToServer("[FfF] sm_changemap -> %s", mapName);
    g_bAdminChangelevel = true;  // flag reste jusqu'a ce que Cmd_Changelevel le consomme
    ForceChangeLevel(mapName, "Admin changemap");
    return Plugin_Handled;
}

// Bloque auto-rotation moteur quand serveur vide
public Action Cmd_Changelevel(int client, const char[] command, int argc) {
    if (g_bAdminChangelevel) {
        g_bAdminChangelevel = false;  // consomme le flag
        return Plugin_Continue;       // laisse passer ce changement admin
    }
    if (GetClientCount(false) > 0)
        return Plugin_Continue;       // joueurs presents -> laisse passer

    char nextMap[PLATFORM_MAX_PATH];
    if (argc >= 1) GetCmdArg(1, nextMap, sizeof(nextMap));
    char currentMap[PLATFORM_MAX_PATH];
    GetCurrentMap(currentMap, sizeof(currentMap));
    if (StrEqual(currentMap, nextMap, false))
        return Plugin_Continue;       // meme map -> laisse passer (reload)

    PrintToServer("[FfF] Serveur vide - changelevel %s bloque (use sm_changemap)", nextMap);
    return Plugin_Stop;
}

public void OnPlaylistChanged(ConVar cvar, const char[] oldVal, const char[] newVal) {
    if (!StrEqual(newVal, "nwi/pvp_sustained")) {
        cvar.SetString("nwi/pvp_sustained", true, false);
        PrintToServer("[FfF] sv_playlist force -> nwi/pvp_sustained (etait: %s)", newVal);
    }
}
