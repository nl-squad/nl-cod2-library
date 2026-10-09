#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread wall();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Dusza");
	iPrintlnBold("in February 2014");
}

wall()
{
	wall = getEnt("door", "targetname");

	wait 240;
	iPrintlnBold("Lugers are ^2Available");

	wall moveZ(104, 2);
	wall waittill("movedone");
}