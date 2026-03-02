#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForAll ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);	
}

ownerCredits()
{
	iPrintlnBold("Map was made by K2o & Maruch");
	iPrintlnBold("in May 2013"); 
}
