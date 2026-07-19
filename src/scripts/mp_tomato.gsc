#include blanco\utils;

main()
{
	ambientPlay("ambient_bunker_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread wall();
}

ownerCredits()
{
	iPrintlnBold("Map was made by SlaYeR");
	iPrintlnBold("in June 2013");
}

wall()
{
	wall = getEnt("wall", "targetname");
	trig = getEnt("wall_trig", "targetname");
	trig setHintString("Reduce Hunters' Sight ^315 ^7s ");

	wall movez(48, 2);
	wall waittill ("movedone");

	while(1)
	{
		trig waittill ("trigger");

		wall moveZ(-48, 2);
		wall waittill ("movedone");
		wait 15;

		wall moveZ(48, 2);
		wall waittill ("movedone");
		wait 3;
	}
}