#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForAll ]]("tpbot");
	[[ level.registerTeleportsForAll ]]("tpbot2");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Akamaru");
	iPrintlnBold("in April 2012");
}