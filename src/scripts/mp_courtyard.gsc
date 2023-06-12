main()
{

thread tp();
thread text();

}

tp()
{
	teleporters = getentarray("enter", "targetname");
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
		iPrintlnBold("^1Trigger niepoprawnie po³¹czony ze script_origin!");
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
	iPrintlnBold("Map was made by hOlyguy");
	wait 1;
	iprintlnbold ("in August 2012");
}