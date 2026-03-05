#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForAll ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread runElevatorZ("1", -344, 3);
	thread runElevatorZ("2", -344, 3);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Black & damO");
	iPrintlnBold("in November 2012");
}

runElevatorZ(num, zDiff, moveTime)
{
	elevator = getEnt("elevator" + num, "targetname");

	if(!isDefined(elevator))
	{
		wait 15;
		iPrintlnBold("^1Entity named 'elevator" + num + "' not found");
		return;
	}

	while(1)
	{
		elevator moveZ (zdiff, moveTime);
		elevator waittill ("movedone");
		wait 4;

		elevator moveZ (zdiff * -1, moveTime);
		elevator waittill ("movedone");
		wait 4;
	}
}
