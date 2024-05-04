main()

{
	thread green();
	thread red();
	thread text();

	ambientPlay("ambient_france_nl");
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
		elevator movex(-40, 2);
		elevator waittill("movedone");
	}
}

red()
{
	elevator = getent("red", "targetname");
	trig = getent("red_trig", "targetname");
	
	while(1)
	{
		trig waittill("trigger");
		wait(2);
		elevator movex(-64, 2);
		elevator waittill ("movedone");
		wait(5);
		elevator movex(64, 2);
		elevator waittill("movedone");
	}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by K2o");
	wait 0.1;
	iPrintlnBold("in July 2013"); 
}