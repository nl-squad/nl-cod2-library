#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread object();
}

ownerCredits()
{
	iPrintlnBold("Map was made by K2o");
	iPrintlnBold("in September 2014");
}

object()
{
	object = getEnt("object", "targetname");

	while(true)
	{
		object rotateyaw(360, 5);
		object waittill("rotatedone");
	}
}