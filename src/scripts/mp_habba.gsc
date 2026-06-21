#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");

	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");

	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);

	thread wall();
	thread windowInit();
	thread registerWindow();
}

ownerCredits()
{
	iPrintlnBold("Map was made by TyreX");
	iPrintlnBold("in August 2012");
}

wall()
{
	wall = getEnt("wall", "targetname");
	trig = getEnt("wall_trig", "targetname");

	trig setHintString("Reduce Hunters' Sight ^315^7s ");

	wall moveZ(56, 2);
	wall waittill("movedone");

	while(1)
	{
		trig waittill("trigger");

		wall moveZ(-56, 2);
		wall waittill("movedone");

		wait 15;

		wall moveZ(56, 2);
		wall waittill("movedone");

		wait 5;
	}
}

windowInit()
{
	window = getEnt("window", "targetname");

	window moveZ(60, 1);
	window waittill("movedone");
}

registerWindow()
{
	trig = getEnt("window_trig", "targetname");

	level.registerPaidMapPart(
		trig,
		300,
		level.MAP_PARTS_TEAM_HUNTERS,
		::openWindow,
		::closeWindow,
		"Close the Windows for ^3$300",
		30
	);
}

openWindow(paidMapPart, player)
{
	window = getEnt("window", "targetname");
	window moveZ(-60, 2);
	window waittill("movedone");

	level.markPaidActivationAsDone(paidMapPart);
}

closeWindow(paidMapPart)
{
	window = getEnt("window", "targetname");
	window moveZ(60, 2);
	window waittill("movedone");

	level.markPaidDeactivationAsDone(paidMapPart);
}

