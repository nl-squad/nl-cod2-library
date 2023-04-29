main()
{
	thread sphereControl();
	thread runElevatorY("1", -640, 2);
	thread runElevatorY("2", 640, 2);
	thread runElevatorY("3", -640, 2);
	thread runElevatorY("4", 640, 2);
	thread tp();
	thread text();
}

sphereControl()
{
	sphere = getEnt("sphere", "targetname");	
	while(true)
		{
			sphere rotateyaw(360, 45);
			sphere waittill("rotatedone");
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
      	wait 3;

		elevator moveY (ydiff * -1, moveTime);
		elevator waittill ("movedone");
		wait 3;
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
	wait 1.5;
	iPrintlnBold("in March 2023");
}