#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	
	wall = getEnt("wall", "targetname");
    wall_trig = getEnt("wall_trig", "targetname");
    thread wall_logic(wall, wall_trig);
	
	thread wallLuger();
	thread secret();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Bozzy & zieqa");
	iPrintlnBold("in April 2024");
}

wallLuger()
{
	wallLuger = getEnt("wallLuger", "targetname");

	wait 180;
	wallLuger moveZ(-60, 2);
	wallLuger waittill("movedone");
}

secret()
{
	secret = getEnt("secret", "targetname");

	wait 180;
	iPrintlnBold("Lugers are ^2Available");
	secret moveZ(-60, 2);
	secret waittill("movedone");
}

wall_logic(wall, trig)
{
    if (!isDefined(wall) || !isDefined(trig))
        return;

    trig setHintString("Reduce Hunters' Sight 15 s ");

    wall moveZ(48, 2);
    wall waittill("movedone");

    while (isDefined(trig))
    {
        trig waittill("trigger");

        if (!isDefined(wall))
            return;

        wall moveZ(-48, 2);
        wall waittill("movedone");

        wait 15;

        if (!isDefined(wall))
            return;

        wall moveZ(48, 2);
        wall waittill("movedone");

        wait 3;
    }
}
