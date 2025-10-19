main()
{
    thread elevator();
	thread text();
	
	ambientPlay("ambient_france_nl");
}

elevator()
{
    elevator = getEnt("cug", "targetname");
    trig = getEnt("trig_cug","targetname");

    if(!isDefined(elevator) || !isDefined(trig))
    {
        iPrintlnBold("^1Entity 'cug' or trigger 'trig_cug' not found");
        return;
    }

    while(1)
    {
        trig waittill("trigger");
        elevator moveY(2500,7);
        elevator waittill("movedone");

        wait(5);

        elevator moveY(-2500,7);
        elevator waittill("movedone");

        wait(5);
    }

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Mynek");
	wait 0.1;
	iPrintlnBold("in September 2025"); 
}