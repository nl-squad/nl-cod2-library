main()
{
	thread tp();
	thread q2();
	thread text();
	
	ambientPlay("ambient_africa_nl");
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

		player.solutionNextCalculationTime = getTime();
		player setOrigin(dest.origin);
		player setPlayerAngles(dest.angles);
	}
}

q2()
{
	q2 = getEnt("q2", "targetname");	
	while(true)
		{
			q2 rotateyaw(360, 7);
			q2 waittill("rotatedone");
		}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by K2o");
	wait 0.1;
	iPrintlnBold("in June 2013"); 	
}