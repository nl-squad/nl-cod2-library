#include blanco\utils;


main()

{
	thread tpbot();
	thread winda();
    thread wiatrak();
    thread t_wiatrak();
	thread text();	

	ambientPlay("ambient_france_nl");
}

tpbot()
{
	teleporters = getentarray("tpbot", "targetname");
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

		player setOrigin(dest.origin);
		player setPlayerAngles(dest.angles);
		player linkTo(level.blocker);
		wait 1.5;
		player unlink();
	}
}
winda()
{
    wall = getEnt("winda", "targetname");
    trig = getEnt("t_winda", "targetname");

    while(1)
    {
        trig waittill("trigger");

        wall solid();
        wall moveZ(272, 1.5);
        wall waittill("movedone");
        wait 1;

        wall notsolid();
        wall moveZ(-272, 1.5);
        wall waittill("movedone");
        wait 1;
    }
}

wiatrak()
{
    wall = getEnt("wiatrak", "targetname");

    while(1)
    {
        wall rotateYaw(1800, 5);
        wall waittill("rotatedone");
    }
}

t_wiatrak()
{
    trig = getEnt("t_wiatrak", "targetname");

    while(1)
    {
        trig waittill("trigger", player);
        if(isDefined(player) && isPlayer(player) && !isDefined(player.zaczepPodnosi))
        {
            player thread podmuch();
        }
    }
}

podmuch()
{
    self.zaczepPodnosi = true;

    zaczep = spawn("script_origin", self.origin);
    self linkTo(zaczep);

    zaczep moveZ(432, 2);
    wait 2;

    zaczep delete();

    if(isDefined(self))
    {
        self unlink();
        self.zaczepPodnosi = undefined;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by BlancO");
	wait 0.1;
	iPrintlnBold("in December 2012"); 	 
}