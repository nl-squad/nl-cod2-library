main()

{
	thread tp();
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
	iPrintlnBold("Map was made by damO and Toxiic");
	wait 0.1;
	iPrintlnBold("in December 2012"); 
}