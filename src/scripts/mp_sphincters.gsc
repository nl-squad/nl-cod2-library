#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Davis & Ziemia");
	iPrintlnBold("in August 2013");
}