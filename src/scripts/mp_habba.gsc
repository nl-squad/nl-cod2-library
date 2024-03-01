main()

{
	thread tp();
	thread tpbot();
	thread wall1();
	thread wall2();
	thread wall3();
	thread text();

	ambientPlay("ambient_france_nl");
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
		wait 0.2;

        if (isDefined(player))
		    player unlink();
	}
}

wall1()
{
    elevator = getEnt("wall1", "targetname");

    if(!isDefined(elevator))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'wall' not found");
        return;
    }

    while(1)
    {
        elevator movex(-104, 2);
        elevator waittill ("movedone");
        wait 2;

        elevator movex(104, 2);
        elevator waittill ("movedone");
        wait 2;
    }
}

wall2()
{
    elevator2 = getEnt("wall2", "targetname");

    if(!isDefined(elevator2))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'wall2' not found");
        return;
    }

    while(1)
    {
        elevator2 movex(104, 2);
        elevator2 waittill ("movedone");
        wait 2;

        elevator2 movex(-104, 2);
        elevator2 waittill ("movedone");
        wait 2;
    }
}

wall3()
{
    wall3 = getEnt("wall3", "targetname");
    trig = getEnt("wall3_trig", "targetname");
	trig setHintString("Reduce Hunters' Sight for 10s");

    if(!isDefined(wall3))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'wall3' not found");
        return;
    }

    if(!isDefined(trig))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'wall3_trig' not found");
        return;
    }
		wall3 movez(176, 2);
        wall3 waittill ("movedone");

    while(1)
    {	
        trig waittill ("trigger");

        wall3 moveZ(-176, 3);
        wall3 waittill ("movedone");
        wait 10;

        wall3 moveZ(176, 2);
        wall3 waittill ("movedone");
        wait 25;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by TyreX");
	wait 0.1;
	iPrintlnBold("in August 2012"); 
}