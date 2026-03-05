#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Rekki");
	iPrintlnBold("in October 2023");
}