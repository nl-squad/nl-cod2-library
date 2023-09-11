main()
{
	thread sphere1();
	thread sphere2();
	thread tp();
	thread text();
	
	ambientPlay("ambient_russia_nl");
	
}

sphere1()
{
	sphere = getEnt("sphere1", "targetname");	
	while(true)
		{
			sphere rotateyaw(360, 45);
			sphere waittill("rotatedone");
		}
}

sphere2()
{
	sphere = getEnt("sphere2", "targetname");	
	while(true)
		{
			sphere rotatexaw(360, 35);
			sphere waittill("rotatedone");
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
	wait 0.1;
	iPrintlnBold("in March 2023"); 
}