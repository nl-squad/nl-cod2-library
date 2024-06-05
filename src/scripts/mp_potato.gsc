main()
{
	thread elevator();
	thread text();
	
	ambientPlay("ambient_france_nl");
}

elevator()

{
    elevator = getEnt("elevator", "targetname");

    if(!isDefined(elevator))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator' not found");
        return;
    }

    while(1)
    {
        elevator moveZ(-256, 2);
        elevator waittill ("movedone");
        wait 4;

        elevator moveZ(256, 2);
        elevator waittill ("movedone");
        wait 2;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Black & Zazu");
	wait 0.1;
	iPrintlnBold("in January 2013"); 			 
}