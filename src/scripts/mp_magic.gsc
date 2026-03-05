#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForAll ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	spotFxFilename = "fx/misc/spotlight_decoytown.efx";
	level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 5, a(spotFxFilename, (63, 598, -184)));
	thread rotation();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Dusza");
	iPrintlnBold("in November 2013");
}

rotation()
{
	black = getEnt("black", "targetname");
	q1 = getEnt("q1", "targetname");
	q2 = getEnt("q2", "targetname");
	q3 = getEnt("q3", "targetname");
	q4 = getEnt("q4", "targetname");
	q5 = getEnt("q5", "targetname");
	q6 = getEnt("q6", "targetname");
	q7 = getEnt("q7", "targetname");
	q8 = getEnt("q8", "targetname");
	q9 = getEnt("q9", "targetname");
	q10 = getEnt("q10", "targetname");
	q11 = getEnt("q11", "targetname");
	q12 = getEnt("q12", "targetname");
	q13 = getEnt("q13", "targetname");
	q14 = getEnt("q14", "targetname");
	while(true)
	{
		black rotateyaw(360, 5);
		q1 rotateyaw(360, 5);
		q2 rotateyaw(-360, 5);
		q3 rotatepitch(360, 5);
		q4 rotatepitch(-360, 5);
		q5 rotateroll(360, 5);
		q6 rotateroll(-360, 5);
		q8 rotateyaw(-360, 5);
		q9 rotateyaw(360, 5);
		q10 rotatepitch(-360, 5);
		q11 rotatepitch(360, 5);
		q12 rotateroll(-360, 5);
		q13 rotateroll(360, 5);
		q1 waittill("rotatedone");
	}
}
