#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread elevator();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Dusza");
	iPrintlnBold("in February 2015"); 
}

elevator()
{
	elevator = getent("elevator", "targetname");
	trig = getent("trig_elevator", "targetname");
	
	trig setHintString("Move the wooden planks ");
	
	while(1)
	{
		trig waittill("trigger");
		elevator movex(160, 2);
		elevator waittill ("movedone");
		wait(10);
		elevator movex(-160, 2);
		elevator waittill("movedone");
	}
}


