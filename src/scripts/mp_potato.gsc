main()
{
	thread elevator();
	thread tp();
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
        elevator moveZ(264, 1.5);
        elevator waittill ("movedone");
        wait 2;

        elevator moveZ(-264, 1.5);
        elevator waittill ("movedone");
        wait 4;
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
	iPrintlnBold("Map was made by Black & Zazu in January 2013");
}