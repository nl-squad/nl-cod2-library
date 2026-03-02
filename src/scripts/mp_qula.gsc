#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread qula();
}

ownerCredits()
{
	iPrintlnBold("Map was made by zazu");
	iPrintlnBold("in August 2012"); 
}

qula()
{
	qula = getEnt("qula", "targetname");	
	while(true)
		{
			qula rotateyaw(360, 10);
			qula waittill("rotatedone");
		}
}
