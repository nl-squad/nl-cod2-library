#include blanco\utils;

Main()
{
    ambientPlay("ambient_france_nl");

    [[ level.registerTeleportsForAll ]]("tp");
    [[ level.registerTeleportsForBotsOnly ]]("tpbot");

    level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);

    wall = getEnt("wall", "targetname");
    wall_trig = getEnt("wall_trig", "targetname");
    thread wall_logic(wall, wall_trig);

	window_trig = getEnt("window_trig", "targetname");
	window = getEnt("window", "targetname");
    window moveZ(60, 0.5);
	[[ level.registerPaidMapPart ]](
        window_trig,
        300,
        level.MAP_PARTS_TEAM_HUNTERS,
        ::onWindowActivate,
        ::onWindowDeactivate,
        "Close the Windows",
        30
    );

    thread ownerCredits();
}

ownerCredits()
{
    iPrintlnBold("Map was made by TyreX");
    iPrintlnBold("in August 2012");
}

onWindowActivate(paidMapPart, player)
{
    window = getEnt("window", "targetname");
    window moveZ(-60, 0.5);
    window waittill("movedone");

    [[ level.markPaidActivationAsDone ]](paidMapPart);
}

onWindowDeactivate(paidMapPart)
{
    window = getEnt("window", "targetname");
    window moveZ(60, 0.5);
    window waittill("movedone");

    [[ level.markPaidDeactivationAsDone ]](paidMapPart);
}

wall_logic(wall, trig)
{
    if (!isDefined(wall) || !isDefined(trig))
        return;

    trig setHintString("Reduce Hunters' Sight 15 s ");

    wall moveZ(56, 2);
    wall waittill("movedone");

    while (isDefined(trig))
    {
        trig waittill("trigger");

        if (!isDefined(wall))
            return;

        wall moveZ(-56, 2);
        wall waittill("movedone");

        wait 15;

        if (!isDefined(wall))
            return;

        wall moveZ(56, 2);
        wall waittill("movedone");

        wait 5;
    }
}