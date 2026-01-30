#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");

	fireFxFilename = "fx/props/barrel_fire2.efx";
	smokeFxFilename = "fx/smoke/damaged_vehicle_smoke.efx";
    level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 1, a(fireFxFilename, (24, 24, 400)));
    level RegisterLoopCallback("loopFx2", ::QueuePlayFx, 1, a(smokeFxFilename, (24, 24, 400)));

	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);

	tp();
	tpbot();
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

ownerCredits()
{
	iPrintlnBold("Map was made by Bozzy");
	iPrintlnBold("in May 2014"); 
}