#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread winda();
    thread wiatrak();
    thread t_wiatrak();
}

ownerCredits()
{
	iPrintlnBold("Map was made by BlancO");
	iPrintlnBold("in December 2012"); 
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


