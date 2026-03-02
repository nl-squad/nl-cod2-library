#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread q2();
}

ownerCredits()
{
	iPrintlnBold("Map was made by K2o");
	iPrintlnBold("in June 2013"); 
}

q2()
{
	q2 = getEnt("q2", "targetname");	
	while(true)
		{
			q2 rotateyaw(360, 10);
			q2 waittill("rotatedone");
		}
}

