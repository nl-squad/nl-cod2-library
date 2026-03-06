#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	[[ level.registerTeleportsForAll ]]("tpG");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread wall();
	thread wallL();
}

ownerCredits()
{
	iPrintlnBold("Map was made by BoNuS");
	iPrintlnBold("in July 2014");
}

wall()
{
	wall = getEnt("wall", "targetname");
	trig = getEnt("wall_trig", "targetname");
	trig setHintString("Open the Gate ");

	while(1)
	{
		trig waittill ("trigger");

		wall moveZ(80, 4);
		wall waittill ("movedone");
		wait 15;

		wall moveZ(-80, 2);
		wall waittill ("movedone");
	}
}

wallL()
{
	wallL = getEnt("wallL", "targetname");

	wait 180;
	iPrintlnBold("Luger is ^2Available");

	wallL moveZ(-96, 3);
	wallL waittill("movedone");
}