main()
{
    thread elevator();
	thread text();
	
	ambientPlay("ambient_france_nl");
}

elevator()
{
    elevator = getEnt("cug", "targetname");
    trig = getent("trig_cug","targetname");

    if(!isDefined(elevator))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator' not found");
        return;
    }

    while(1)
    {
        trig waittill("trigger");
        elevator moveY(-2500,7,1.2,1.2);
        elevator waittill("movedone");

        wait(5);

        elevator moveY(2500,7,1.2,1.2);
        elevator waittill("movedone");

        wait(5);
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Mynek");
	wait 0.1;
	iPrintlnBold("in September 2025"); 
}