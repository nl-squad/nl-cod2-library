#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by K2o");
	iPrintlnBold("in June 2013"); 	
}