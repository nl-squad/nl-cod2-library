#include blanco\utils;

main()
{
    ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");	
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by hyp3r");
	iPrintlnBold("in September 2023"); 
}
