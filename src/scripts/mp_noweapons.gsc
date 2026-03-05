#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread sphere1();
}

ownerCredits()
{
	iPrintlnBold("Map was made by TyreX");
	iPrintlnBold("in August 2012");
}

sphere1()
{
	sphere1 = getEnt("sphere1", "targetname");
	while(true)
	{
		sphere1 rotateyaw(360, 30);
		sphere1 waittill("rotatedone");
	}
}
