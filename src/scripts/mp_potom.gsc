main()

{
	tp();
	tpbot();
	thread wall();
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

wall()
{
    wall = getEnt("wall", "targetname");
    trig = getEnt("wall_trig", "targetname");
	trig setHintString("Open the Door ");
	
	wait 40;  
    iPrintlnBold("Labolatory is ^2Available"); 
    
    while(1)
    {	
        trig waittill ("trigger");

        wall moveZ(120, 3);
        wall waittill ("movedone");
        wait 10;

        wall moveZ(-120, 2);
        wall waittill ("movedone");
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by bonuS");
	wait 0.1;
	iPrintlnBold("in July 2014"); 
}