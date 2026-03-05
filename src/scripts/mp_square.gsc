#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread elevator();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Dusza");
	iPrintlnBold("in January 2017");
}

elevator()
{
	elevator = getEnt("elevator", "targetname");

	while(1)
	{

		elevator moveZ(256, 2);
		elevator waittill ("movedone");
		wait 2;

		elevator moveZ(-256, 2);
		elevator waittill ("movedone");
		wait 4;
	}
}