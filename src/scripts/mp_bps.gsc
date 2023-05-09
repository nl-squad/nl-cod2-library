main()
{
	thread elevatorWithoutTrigger();
	thread tp();
	thread text();
}

elevatorWithoutTrigger()
{
    elevator = getEnt("floor", "targetname");

    if(!isDefined(elevator))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator' not found");
        return;
    }

    while(1)
    {
        elevator moveX(-128, 2);
        elevator waittill ("movedone");
        wait 5;

        elevator moveX(128, 2);
        elevator waittill ("movedone");
        wait 5;
    }
}

tp()
{
	teleporters = getentarray("tp", "targetname");
	for(i = 0; i < teleporters.size; i++)
	{
		teleporters[i] thread teleport();
	}
}

teleport()
{
	dest = getent(self.target, "targetname");
	if(!isDefined(dest))
	{
		wait 15;
		iPrintlnBold("^1MaxDamage is a thief");
		return;

	}

	while(1)
	{
		self waittill("trigger", player);

		player setOrigin(dest.origin);
		player setPlayerAngles(dest.angles);
	}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Akamaru");
	wait 1;
	iPrintlnBold("in February 2012");
}