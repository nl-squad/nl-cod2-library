#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread sphere1();
	thread sphere2();	
}

ownerCredits()
{
	iPrintlnBold("Map was made by Dusza");
	iPrintlnBold("in March 2023"); 
}

sphere1()
{
	sphere1 = getEnt("sphere1", "targetname");	
	while(true)
		{
			sphere1 rotateyaw(360, 45);
			sphere1 waittill("rotatedone");
		}
}

sphere2()
{
	sphere2 = getEnt("sphere2", "targetname");	
	while(true)
		{
			sphere2 rotateroll(360, 45);
			sphere2 waittill("rotatedone");
		}
}