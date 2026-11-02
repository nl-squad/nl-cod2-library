#include blanco\utils;

main()
{
	ambientPlay("ambient_bunker_nl");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by zieqa");
	iPrintlnBold("in October 2026");
}

