#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	level RegisterDelayCallback("thornOpenYellowRoom", ::thornOpenYellowRoom, 40);
	thread elevator();
	thread wall();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Avard");
	iPrintlnBold("in September 2012");
}

thornOpenYellowRoom()
{
	elevator = getEnt("elevator", "targetname");
	iPrintlnBold("^3Yellow Room ^7has been Opened");
	elevator moveZ(-88, 2);
}

wall()
{
	wall = getEnt("wall", "targetname");
	trig = getEnt("wall_trig", "targetname");
	trig setHintString("Reduce Hunters' Sight ^315^7s ");

	wall movez(-136, 2);
	wall waittill ("movedone");

	while(1)
	{
		trig waittill ("trigger");

		wall moveZ(136, 3);
		wall waittill ("movedone");
		wait 20;

		wall moveZ(-136, 2);
		wall waittill ("movedone");
		wait 10;
	}
}


