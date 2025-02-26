main()
{
	thread runElevatorZ("1", -344, 3);
	thread runElevatorZ("2", -344, 3);
	thread tp();
	thread tpbot();
	thread text();
	
	ambientPlay("ambient_france_nl");
	
}

runElevatorZ(num, zDiff, moveTime)
{
	elevator = getEnt("elevator" + num, "targetname");
	
  	if(!isDefined(elevator))
    {
		wait 15;
		iPrintlnBold("^1Entity named 'elevator" + num + "' not found");
		return;
	}
	
	while(1)
	{
		elevator moveZ (zdiff, moveTime);
		elevator waittill ("movedone");
      	wait 4;

		elevator moveZ (zdiff * -1, moveTime);
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

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Black & damO");
	wait 0.1;
	iPrintlnBold("in November 2012"); 
}