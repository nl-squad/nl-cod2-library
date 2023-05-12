main()
{
	thread elevator();
	thread text();
}

elevator()
{
    elevator = getEnt("elevator", "targetname");
    trig = getEnt("trig_elevator", "targetname");

    if(!isDefined(elevator))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator' not found");
        return;
    }

    if(!isDefined(trig))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'trig_elevator' not found");
        return;
    }

    while(1)
    {
        trig waittill ("trigger");

        elevator movey(1240, 5);
        elevator waittill ("movedone");
        wait 3;

        elevator movey(-1240, 4);
        elevator waittill ("movedone");
        wait 1;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by K2o");
	wait 1;
	iPrintlnBold("in June 2012");
}