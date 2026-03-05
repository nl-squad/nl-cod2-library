#include blanco\utils;

main()

{
	ambientPlay("ambient_france_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread green();
	thread red();
}

ownerCredits()
{
	iPrintlnBold("Map was made by K2o");
	iPrintlnBold("in July 2013");
}

green()
{
	elevator = getent("green", "targetname");
	trig = getent("green_trig", "targetname");

	while(1)
	{
		trig waittill("trigger");
		wait(10);
		elevator movez(40, 2);
		elevator waittill ("movedone");
		wait(5);
		elevator movez(-40, 2);
		elevator waittill("movedone");
	}
}

red()
{
	elevator1 = getent("red", "targetname");
	trig1 = getent("red_trig", "targetname");

	while(1)
	{
		trig1 waittill("trigger");
		wait(2);
		elevator1 movex(-64, 2);
		elevator1 waittill ("movedone");
		wait(10);
		elevator1 movex(64, 2);
		elevator1 waittill("movedone");
	}
}