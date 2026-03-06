#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by SlaYer");
	iPrintlnBold("in June 2013");
}
