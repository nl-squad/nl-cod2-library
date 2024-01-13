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
		wait 20;
		iPrintlnBold("^1Trigger niepoprawnie połączony ze script_origin!");
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

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Arno");
	wait 0.1;
	iPrintlnBold("in December 2014"); 
}
