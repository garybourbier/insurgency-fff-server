#include <sourcemod>
#include <sdktools>

#define PLUGIN_VERSION "1.0"
#define PLUGIN_DESCRIPTION "._."

public Plugin:myinfo =
{
	name = "#Lua Server Info System for shoubi ._.",
	author = "D.Freddo",
	description = PLUGIN_DESCRIPTION,
	version = PLUGIN_VERSION,
	url = "http://steam.lua.kr"
}

public OnPluginStart()
{
	CreateConVar("Lua_Server_Info_System", PLUGIN_VERSION, PLUGIN_DESCRIPTION, FCVAR_NOTIFY | FCVAR_PLUGIN | FCVAR_DONTRECORD);
	HookEvent("game_end", Event_GameEnd);
	HookEvent("round_start", Event_RoundStart);
	HookConVarChange(FindConVar("nextlevel"), ConVarChanged);
}

public OnMapStart()
{
	// Precaching sounds if you edit sounds path you also need to edit these
}

public Event_GameEnd(Handle:event, const String:name[], bool:dontBroadcast)
{
	// Play sound when game ends and voting starts
	if (GetConVarInt(FindConVar("sv_changelevel_next_round")) == 0)
		EmitSoundToAll("Lua_sounds/gman_choose2.wav", _, _, _, _, 1.0);
}

public ConVarChanged(Handle:cvar, const String:oldVal[], const String:newVal[])
{
	// Play sound when nextlevel convar has been set therefore it also plays when nextlevel player vote has been called
	EmitSoundToAll("Lua_sounds/endofvote.ogg", _, _, _, _, 1.0);
}

public Action:PopupMenu(Handle:timer, any:timeout)
{
	if (timeout < 1) return;
	for (new client = 1; client <= GetMaxClients(); client++)
	{
		if (IsClientInGame(client) && !IsFakeClient(client) && GetClientTeam(client) > 1)
			ShowNoticeMenu(client, timeout);
	}
}

public Action:Event_RoundStart(Handle:event, const String:name[], bool:dontBroadcast)
{
	if (GetClientCount() > 0)
	{
		// Display Popup Menu
		// Parameters: (3.0, PopupMenu, 10) will be showing popup menu 3.0 seconds later for 10 seconds (also player can close it themself)
		// You only need to edit times, text lines are in ShowNoticeMenu function you need to edit these text
		CreateTimer(3.0, PopupMenu, 10, TIMER_FLAG_NO_MAPCHANGE);

		// Display Hint Messages
		// Method: HintMessage(Delay Seconds (Float), "Text", "Timeout Seconds");
		// If you want no delay use 0.0
		// use Timeout at least 1 seconds if i remeber correct under 1 sec could remain message until map change
		HintMessage(3.0, "[FfF] Frag , Fun et Fairplay !", "7");
		HintMessage(9.5, "Group:  https://steamcommunity.com/groups/fragfunfair", "7");
	}
}

public ShowNoticeMenu(client, time)
{
	new Handle:panel = CreatePanel();
	// Edit These lines for text
	SetPanelTitle(panel, "[FfF] Frag , Fun et Fairplay !", false);
	DrawPanelText(panel, "Follow this link to subscribe to our mods on the Steam workshop:");
	DrawPanelText(panel, "https://steamcommunity.com/sharedfiles/filedetails/?id=649274722");
	DrawPanelText(panel, "Teamspeak 3: 212.83.131.33:27015 (no password)");
	DrawPanelText(panel, "This server auto-reconnect you for precache some mod|Admins contact them on steam : garybourbier");
	DrawPanelText(panel, "Please support this server on utip by watching a few video ads https://utip.io/garybourbier");
	DrawPanelText(panel, "LEADER can call artillery strike, simply aim properly to the ground and say !fs");
	// Menu Number Key Settings (recommend to use 10)
	SetPanelCurrentKey(panel, 10);
	SendPanelToClient(panel, client, Handler_DoNothing, time);
	CloseHandle(panel);
}

HintMessage(Float:delay, const String:text[], const String:timeout[])
{
	if (StringToInt(timeout) < 1)
	{
		LogToGame("You need to set timeout at least 1 seconds for HintMessage \"ins_serverinfo_shoubi.sp\"");
		return false;
	}

	for (new client = 1; client <= GetMaxClients(); client++)
	{
		if (IsClientInGame(client) && !IsFakeClient(client) && GetClientTeam(client) > 1)
		{
			decl String:sUser[32];
			new instructor = CreateEntityByName("env_instructor_hint");
			Format(sUser, sizeof(sUser), "%d%d", instructor, client);
			DispatchKeyValue(client, "targetname", sUser);
			DispatchKeyValue(instructor, "hint_static", "1");
			DispatchKeyValue(instructor, "hint_color", "255 255 255");
			DispatchKeyValue(instructor, "hint_icon_onscreen", "icon_alert");
			DispatchKeyValue(instructor, "hint_timeout", timeout);
			DispatchKeyValue(instructor, "hint_caption", text);
			DispatchSpawn(instructor);
			decl String:addoutput[64];
			if (delay > 0.0)
			{
				Format(addoutput, sizeof(addoutput), "OnUser1 !self:ShowHint:%s:%f:1", sUser, delay);
				SetVariantString(addoutput);
				AcceptEntityInput(instructor, "AddOutput");
				AcceptEntityInput(instructor, "FireUser1");
			}
			else AcceptEntityInput(instructor, "ShowHint", client);
			Format(addoutput, sizeof(addoutput), "OnUser2 !self:kill::%f:1", StringToFloat(timeout));
			SetVariantString(addoutput);
			AcceptEntityInput(instructor, "AddOutput");
			AcceptEntityInput(instructor, "FireUser2");
		}
	}
	return true;
}

public Handler_DoNothing(Handle:menu, MenuAction:action, param1, param2) {}
