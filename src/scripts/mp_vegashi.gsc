#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread wall();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Vegarin");
	iPrintlnBold("in August 2025");
}

wall()
{
	wall = getEnt("wall", "targetname");

	wait 180;
	iPrintlnBold("Lugers are ^2Available");

	wall moveZ(60, 2);
	wall waittill("movedone");
}