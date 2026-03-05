#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Bozzy");
	iPrintlnBold("in May 2023");
}