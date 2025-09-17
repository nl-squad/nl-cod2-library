main()

{
	tp();
	tpbot();
	tpG();
	thread wall();
	thread wallL();
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
	self setHintString("Press ^3F ^7to back to Spawn ");
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
		wait 0.1;

        if (isDefined(player))
		    player unlink();
	}
}

tpG()
{
	teleporters = getentarray("tpG", "targetname");
	for(i = 0; i < teleporters.size; i++)
	{
		teleporters[i] thread teleportG();
	}
}

teleportG()
{
	dest = getent(self.target, "targetname");
	self setHintString("Press ^3F ^7to go Up ");
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

wall()
{
    wall = getEnt("wall", "targetname");
    trig = getEnt("wall_trig", "targetname");
	trig setHintString("Open the Gate ");
	
    while(1)
    {	
        trig waittill ("trigger");

        wall moveZ(80, 4);
        wall waittill ("movedone");
        wait 15;

        wall moveZ(-80, 2);
        wall waittill ("movedone");
    }
}

wallL()
{
    wallL = getEnt("wallL", "targetname"); 
    
    wait 180;
	iPrintlnBold("Luger is ^2Available");	
    
    wallL moveZ(-96, 3);  
    wallL waittill("movedone"); 
}


text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by bonuS");
	wait 0.1;
	iPrintlnBold("in July 2014"); 
}