#include blanco\utils;

main()
{
	ambientPlay("ambient_bunker_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread wall();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Mlotek");
	iPrintlnBold("in November 2012");
}

wall()
{
	wall = getEnt("wall", "targetname");

	wait 180;
	iPrintlnBold("Luger is ^2Available");
	wall moveZ(100, 2);
	wall waittill("movedone");
}