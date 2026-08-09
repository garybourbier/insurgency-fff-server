#include <sourcemod>

char g_MapsListOfficial[][] = {
	"station push",
	"tell push",
	"panj push",
	"market push",
	"sinjar push",
	"peak push",
	"heights push",
	"buhriz push",
	"district push",
	"siege push",
	"revolt push",
	"verticality push",
	"drycanal push",
	"embassy push",
	"contact push",
	"ministry skirmish",
	"kandagal push"
};

char g_MapsListCustom[][] = {
"baghdad_b5 push",
"zagros_convoy_b5 push",
"almaden_b5 push",
"oasis push",
"convoy_pvp_day_fix push",
"khanashin_b8 push",
"docks push",
"winter_rescue_b6 push",
"karkar_b11 push",
"gizab_b2 push",
"hideout_b2 push",
"takbar_b6 push",
"badlands_b2 push",
"clean_sweep_beta3 push",
"khanashin_b8_night",
"osama_b4_push push",
"panama_canal_b2 push",
"depot_b2 push",
"congress push",
"badel_b5 push",
"pamir_v3 push",
"szepezd_redux push",
"iron_express_b2 push",

"foot infiltrate"
};

ConVar g_cvar_PLimit; //Amount of Players Connected before Custom Theater is enabled.

public void OnPluginStart()
{
	HookEvent("round_end", OnRoundEnd);
	g_cvar_PLimit = CreateConVar("sm_xlimit", "24", "Number of players needed to switch on Custom Playlist", 0, true, 0.0, true, 64.0);
}

public Action OnRoundEnd(Event event, const char[] name, bool dontBroadcast)
{
	if(GetClientCount() < g_cvar_PLimit.IntValue) //If player count is less that X limit value
	{
		//Exec official server cfg
		ServerCommand("exec server.cfg");

		SetNextLevel(1);
	}
	else //else X limit value is higher or equal to player count
	{
		//Exec Custom server cfg
		ServerCommand("exec server_custom.cfg");

		SetNextLevel(2);
	}

	return Plugin_Continue;
}

void SetNextLevel(int mode) //1 = official, 2 = custom
{
	//Get Random Custom Map
	char sMapRandom[128];
	if(mode == 1) strcopy(sMapRandom, sizeof(sMapRandom), g_MapsListOfficial[GetRandomInt(0, sizeof(g_MapsListOfficial)-1)]);
	else if(mode == 2) strcopy(sMapRandom, sizeof(sMapRandom), g_MapsListCustom[GetRandomInt(0, sizeof(g_MapsListCustom)-1)]);
	ServerCommand("nextlevel %s", sMapRandom);

	//Debug msg letting us know wtf we just did :)
	if(mode == 1) PrintToChatAll("[Round End Check] Less than 24 Players are currently connected, the official map %s will be the next map.", sMapRandom);
	else if(mode == 2) PrintToChatAll("[Round End Check] At least 24 Players are currently connected, the custom map %s will be the next map .", sMapRandom);
}