#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread elevator();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Mynek");
	iPrintlnBold("in September 2025");
}

elevator()
{
	elevator = getEnt("elevator", "targetname");
	trig = getEnt("trig_elevator","targetname");

	if(!isDefined(elevator) || !isDefined(trig))
	{
		iPrintlnBold("^1Entity 'elevator' or trigger 'trig_elevator' not found");
		return;
	}

	while(1)
	{
		trig waittill("trigger");
		elevator moveY(-2360,7);
		elevator waittill("movedone");

		wait(5);

		elevator moveY(2360,7);
		elevator waittill("movedone");

		wait(5);
	}
}
