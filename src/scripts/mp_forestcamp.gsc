main()
{
	thread tp();
	thread elevator();
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
		wait 20;
		iPrintlnBold("^1Trigger niepoprawnie połączony ze script_origin!");
		return;

	}

	while(1)
	{
		self waittill("trigger", player);

		player setOrigin(dest.origin);
		player setPlayerAngles(dest.angles);
	}
}

elevator()
{
	elevator = getent("elevator", "targetname");
	trig = getent("trig_elevator", "targetname");
	
	trig setHintString("Move the wooden planks");
	
	while(1)
	{
		trig waittill("trigger");
		elevator movex(160, 2);
		elevator waittill ("movedone");
		wait(10);
		elevator movex(-160, 2);
		elevator waittill("movedone");
	}
}


text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza in February 2015");
}

