#include blanco\utils;

main()
{
	ambientPlay("ambient_bunker_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread nl();
}

ownerCredits()
{
	iPrintlnBold("Map was made by zieqa");
	iPrintlnBold("in October 2026");
}

