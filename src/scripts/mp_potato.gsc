#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForAll ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Black & zazu");
	iPrintlnBold("in January 2013"); 
}
