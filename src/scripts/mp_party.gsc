#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by K2o");
	iPrintlnBold("in November 2014");
}