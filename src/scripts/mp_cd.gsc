main()
{
	thread tp();
	thread tpbot();
	thread elevator1();
	thread elevator2();
	thread text();
	
	ambientPlay("ambient_russia_nl");
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
		player.solutionNextCalculationTime = getTime();
	}
}

tpbot()
{
	teleporters = getentarray("tpbot", "targetname");
	for(i = 0; i < teleporters.size; i++)
	{
		teleporters[i] thread teleport1();
	}
}

teleport1()
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

		if (!player isBot())
			continue;
			
		player.solutionNextCalculationTime = getTime();
		player setOrigin(dest.origin);
		player setPlayerAngles(dest.angles);
		player linkTo(level.blocker);
		wait 0.1;

        if (isDefined(player))
		    player unlink();
	}
}

elevator1()
{
    elevator1 = getEnt("elevator1", "targetname");

    if(!isDefined(elevator1))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator1' not found");
        return;
    }

    while(1)
    {
        elevator1 moveZ(-368, 3);
        elevator1 waittill ("movedone");
        wait 4;

        elevator1 moveZ(368, 3);
        elevator1 waittill ("movedone");
        wait 2;
    }
}

elevator2()
{
    elevator2 = getEnt("elevator2", "targetname");

    if(!isDefined(elevator2))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator2' not found");
        return;
    }

    while(1)
    {
        elevator2 moveZ(-368, 3);
        elevator2 waittill ("movedone");
        wait 4;

        elevator2 moveZ(368, 3);
        elevator2 waittill ("movedone");
        wait 2;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in January 2014"); 
}
