#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForAll ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Patryczesko");
	iPrintlnBold("in March 2014");
}