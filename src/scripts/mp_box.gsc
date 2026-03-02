#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread nl();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Wolf");
	iPrintlnBold("in June 2023"); 
}

nl()
{
	nl = getEnt("nl", "targetname");	
	while(true)
		{
			nl rotateyaw(360, 5);
			nl waittill("rotatedone");
		}
}


