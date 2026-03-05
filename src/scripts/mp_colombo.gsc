#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by K2o & Yuri");
	iPrintlnBold("in December 2013");
}