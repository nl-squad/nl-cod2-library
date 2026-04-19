#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread runElevatorZ("1", -386, 3);
}

ownerCredits()
{
	iPrintlnBold("Map was made by BloW & BoNuS");
	iPrintlnBold("in November 2012");
}

runElevatorZ(num, zDiff, moveTime)
{
	elevator = getEnt("elevator", "targetname");

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
		wait 5;

		elevator moveZ (zdiff * -1, moveTime);
		elevator waittill ("movedone");
		wait 5;
	}
}
