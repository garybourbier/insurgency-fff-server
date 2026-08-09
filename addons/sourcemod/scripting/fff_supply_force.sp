#include <sourcemod>

public Plugin myinfo = {
    name        = "FfF Supply Force",
    author      = "FfF",
    description = "Force mp_supply_token_base a 18",
    version     = "1.0",
    url         = ""
};

ConVar g_cvSupply;

public void OnPluginStart() {
    g_cvSupply = FindConVar("mp_supply_token_base");
    if (g_cvSupply != null)
        HookConVarChange(g_cvSupply, OnSupplyChanged);
}

public void OnConfigsExecuted() {
    ForceSupply();
}

void ForceSupply() {
    if (g_cvSupply == null)
        return;
    int flags = g_cvSupply.Flags;
    g_cvSupply.Flags = flags & ~FCVAR_NOTIFY;
    g_cvSupply.SetInt(18, true, false);
    g_cvSupply.Flags = flags;
}

public void OnSupplyChanged(ConVar cvar, const char[] oldVal, const char[] newVal) {
    if (!StrEqual(newVal, "18"))
        ForceSupply();
}
