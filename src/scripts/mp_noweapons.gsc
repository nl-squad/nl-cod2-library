#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	
	wall = getEnt("wall", "targetname");
    wall_trig = getEnt("wall_trig", "targetname");
    thread wall_logic(wall, wall_trig);
	
	thread sphere1();
}

ownerCredits()
{
	iPrintlnBold("Map was made by TyreX");
	iPrintlnBold("in August 2012");
}

wall_logic(wall, trig)
{
    if (!isDefined(wall) || !isDefined(trig))
        return;

    trig setHintString("Reduce Hunters' Sight 30 s ");

    wall moveY(-200, 2);
    wall waittill("movedone");

    while (isDefined(trig))
    {
        trig waittill("trigger");

        if (!isDefined(wall))
            return;

        wall moveY(200, 2);
        wall waittill("movedone");

        wait 30;

        if (!isDefined(wall))
            return;

        wall moveZ(-200, 2);
        wall waittill("movedone");

        wait 3;
    }
}

sphere1()
{
	sphere1 = getEnt("sphere1", "targetname");
	while(true)
	{
		sphere1 rotateyaw(14400, 1200);
		sphere1 waittill("rotatedone");
	}
}
