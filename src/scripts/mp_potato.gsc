#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread wall();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Black & zazu");
	iPrintlnBold("in January 2013");
}

wall()
{
	wall = getEnt("wall", "targetname");
	trig = getEnt("wall_trig", "targetname");
	trig setHintString("Reduce Hunters' Sight ^315^7s ");

	wall movez(40, 2);
	wall waittill ("movedone");

	while(1)
	{
		trig waittill ("trigger");

		wall moveZ(-40, 2);
		wall waittill ("movedone");
		wait 15;

		wall moveZ(40, 2);
		wall waittill ("movedone");
		wait 10;
	}
}