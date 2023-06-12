main()
{
	thread elevator();
	thread text();
}

elevator()

{
    elevator = getEnt("elevator", "targetname");
    trig = getEnt("trig_elevator", "targetname");
	
    while(1)
    {
	trig waittill ("trigger");

        elevator moveZ(256, 2);
        elevator waittill ("movedone");
        wait 2;

        elevator moveZ(-256, 2);
        elevator waittill ("movedone");
        wait 1;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 1;
	iPrintlnBold("in January 2017");
}