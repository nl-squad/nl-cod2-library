main()
{
	thread runElevatorZ("1", 280, 2);
	thread tp();
	thread text();
	
	ambientPlay("ambient_africa_nl");
}

runElevatorZ(num, ZDiff, moveTime)
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

		elevator moveZ (Zdiff, moveTime);
		elevator waittill ("movedone");
      	wait 2;

		elevator moveZ (Zdiff * -1, moveTime);
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
	iPrintlnBold("Map was made by SlaYer");
	wait 0.1;
	iPrintlnBold("in June 2013");
}
