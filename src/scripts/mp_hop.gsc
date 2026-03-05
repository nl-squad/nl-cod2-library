#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by BlancO");
	iPrintlnBold("in March 2012");
}