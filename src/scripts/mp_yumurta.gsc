#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[ level.registerTeleportsForAll ]]("tp");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Avard & Lumen");
	iPrintlnBold("in May 2013"); 
}