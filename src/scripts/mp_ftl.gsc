main()
{
	thread sphereControl(1);
	thread runElevatorX("5", 896, 1.5);
	thread runElevatorX("6", -896, 1.5);
	thread runElevatorY("1", -640, 2);
	thread runElevatorY("2", -640, 2);
	thread runElevatorY("3", 640, 2);
	thread runElevatorY("4", 640, 2);
	thread tp();
	thread text();
}

sphereControl(num)
{
	sphere = getEnt("sphere" + num, "targetname");	
	while(true)
		{
			sphere rotateyaw(360, 45);
			sphere waittill("rotatedone");
		}
}

runElevatorX(num, xDiff, moveTime)
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
		elevator moveX (xdiff, moveTime);
		elevator waittill ("movedone");
      	wait 2;

		elevator moveX (xdiff * -1, moveTime);
		elevator waittill ("movedone");
		wait 2;
	}
}

runElevatorY(num, yDiff, moveTime)
{
	elevator = getEnt("elevator" + num, "targetname");
  	trig = getEnt("trig_elevator" + num, "targetname");

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
      	trig waittill ("trigger");

		elevator moveY (ydiff, moveTime);
		elevator waittill ("movedone");
      	wait 2;

		elevator moveY (ydiff * -1, moveTime);
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
	iPrintlnBold("Map was made by Dusza");
	wait 1;
	iPrintlnBold("in March 2023");
}