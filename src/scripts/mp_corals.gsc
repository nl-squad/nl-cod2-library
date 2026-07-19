#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	
	thread secret();
	thread wall();
	thread wallLuger();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Bozzy & zieqa");
	iPrintlnBold("in April 2024");
}

secret()
{
	secret = getEnt("secret", "targetname");

	wait 180;
	iPrintlnBold("Lugers are ^2Available");
	secret moveZ(-60, 2);
	secret waittill("movedone");
}

wall()
{
	wall = getEnt("wall", "targetname");
	trig = getEnt("wall_trig", "targetname");
	trig setHintString("Reduce Hunters' Sight ^315 ^7s ");

	wall movez(40, 2);
	wall waittill ("movedone");

	while(1)
	{
		trig waittill ("trigger");

		wall moveZ(-40, 2);
		wall waittill ("movedone");
		wait 15;

		wall moveZ(40, 2);
		wall waittill ("movedone");
		wait 3;
	}
}

wallLuger()
{
	wallLuger = getEnt("wallLuger", "targetname");

	wait 180;
	wallLuger moveZ(-60, 2);
	wallLuger waittill("movedone");
}