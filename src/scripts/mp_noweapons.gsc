main()
{
	thread sphere1();
	thread tp();
	thread text();
	
	ambientPlay("ambient_africa_nl");
}

sphere1()
{
	sphere1 = getEnt("sphere1", "targetname");	
	while(true)
		{
			sphere1 rotateyaw(360, 20);
			sphere1 waittill("rotatedone");
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
	iPrintlnBold("Map was made by TyreX");
	wait 0.1;
	iPrintlnBold("in August 2012"); 
}