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

	trig setHintString("Reduce Hunters' Sight 15s");

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

	window moveTo(window.origin + (0, 0, 60), 0.1);
	window waittill("movedone");
}

registerWindow()
{
	trig = getEnt("window_trig", "targetname");

	level.registerPaidMapPart(trig, 300, level.MAP_PARTS_TEAM_HUNTERS, ::onWindowActivate, ::onWindowDeactivate, "Press ^3F ^7to Close the Windows", 30);
}

onWindowActivate(paidMapPart, player)
{
	window = getEnt("window", "targetname");

	window moveTo(window.origin + (0, 0, -60), 0.5);
	window waittill("movedone");

	level.markPaidActivationAsDone(paidMapPart);
}

onWindowDeactivate(paidMapPart)
{
	window = getEnt("window", "targetname");

	window moveTo(window.origin + (0, 0, 60), 0.5);
	window waittill("movedone");

	level.markPaidDeactivationAsDone(paidMapPart);
}