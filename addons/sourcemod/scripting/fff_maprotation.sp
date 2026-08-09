#include <sourcemod>

public Plugin myinfo = {
    name        = "FfF Map Rotation",
    author      = "FfF",
    description = "Bypass NWI allowed_maps via ForceChangeLevel - reste en playlist officielle",
    version     = "1.1",
    url         = ""
};

char g_MapsOfficial[][] = {
    "station push",   "tell push",      "panj push",     "market push",
    "sinjar push",    "peak push",      "heights push",  "buhriz push",
    "district push",  "siege push",     "revolt push",   "verticality push",
    "drycanal push",  "embassy push",   "contact push",  "ministry skirmish",
    "kandagal push"
};

char g_MapsCustom[][] = {
    "baghdad_b5 push",       "zagros_convoy_b5 push", "almaden_b5 push",
    "oasis push",            "convoy_pvp_day_fix push","khanashin_b8 push",
    "khanashin_b8_night push","docks push",            "winter_rescue_b6 push",
    "karkar_b11 push",       "gizab_b2 push",         "hideout_b2 push",
    "takbar_b6 push",        "badlands_b2 push",      "clean_sweep_beta3 push",
    "osama_b4_push push",    "panama_canal_b2 push",  "depot_b2 push",
    "congress push",         "badel_b5 push",         "pamir_v3 push",
    "szepezd_redux push",    "iron_express_b2 push"
};

ConVar g_cvLimit;
char g_sNextMap[128];

public void OnPluginStart() {
    HookEvent("game_end", Event_GameEnd);
    g_cvLimit = CreateConVar("fff_custom_limit", "4",
        "Nb joueurs min pour activer la rotation custom", 0, true, 0.0, true, 64.0);
}

public void Event_GameEnd(Event event, const char[] name, bool dontBroadcast) {
    int players = GetClientCount(false);

    if (players >= g_cvLimit.IntValue) {
        strcopy(g_sNextMap, sizeof(g_sNextMap), g_MapsCustom[GetRandomInt(0, sizeof(g_MapsCustom)-1)]);
        PrintToChatAll("[FfF] Prochaine map custom : %s", g_sNextMap);
    } else {
        strcopy(g_sNextMap, sizeof(g_sNextMap), g_MapsOfficial[GetRandomInt(0, sizeof(g_MapsOfficial)-1)]);
        PrintToChatAll("[FfF] Prochaine map officielle : %s", g_sNextMap);
    }

    CreateTimer(8.0, Timer_ChangeLevel, _, TIMER_FLAG_NO_MAPCHANGE);
}

public Action Timer_ChangeLevel(Handle timer) {
    // ForceChangeLevel bypasse le whitelist allowed_maps de NWI
    // sv_playlist reste "nwi/pvp_sustained" -> serveur visible en Combat Soutenu
    ForceChangeLevel(g_sNextMap, "FfF rotation");
    return Plugin_Stop;
}
