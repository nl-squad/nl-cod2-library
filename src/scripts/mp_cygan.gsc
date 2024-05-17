main()
{
	thread runElevatorZ("1", -344, 2);
	thread runElevatorZ("2", -344, 2);
	thread tp();
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

  	if(!isDefined(trig))
    {
		wait 15;
		iPrintlnBold("^1Entity named 'trig_elevator" + num + "' not found");
		return;
	}
	
	while(1)
	{
		elevator moveZ (zdiff, moveTime);
		elevator waittill ("movedone");
      	wait 4;

		elevator moveZ (zdiff * -1, moveTime);
		elevator waittill ("movedone");
		wait 2;
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
	iPrintlnBold("Map was made by Black & damO");
	wait 0.1;
	iPrintlnBold("in November 2012"); 
}