#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by RiyT");
	iPrintlnBold("in May 2009"); 
}