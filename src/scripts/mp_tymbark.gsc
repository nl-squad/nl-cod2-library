main()

{
	tp();
	tpbot();
	thread text();
	
	ambientPlay("ambient_france_nl");

	level._effect["fire"] = loadfx("fx/props/barrel_fire2.efx");
	level._effect["smoke"] = loadfx("fx/smoke/damaged_vehicle_smoke.efx");
	
	maps\mp\_fx::loopfx("fire", (24, 24, 400), 1);
	maps\mp\_fx::loopfx("smoke", (24, 24, 400), 1);

	
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
	self setHintString("Press ^3F ^7to back to Spawn ");
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

tpbot()
{
	teleporters = getentarray("tpbot", "targetname");
	for(i = 0; i < teleporters.size; i++)
	{
		teleporters[i] thread teleport1();
	}
}

teleport1()
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
	iPrintlnBold("Map was made by Bozzy");
	wait 0.1;
	iPrintlnBold("in May 2014"); 
}