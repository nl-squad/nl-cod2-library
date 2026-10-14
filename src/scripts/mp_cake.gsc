#include blanco\utils;

main()
{
    ambientPlay("ambient_france");

    [[ level.registerTeleportsForAll ]]("tp");
    [[ level.registerTeleportsForBotsOnly ]]("tpbot");

    level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	
    thread boat_control();
}

ownerCredits()
{
    iPrintlnBold("Map was made by Daveyyy");
    iPrintlnBold("in October 2026");
}

boat_control()
{
    boat = getEnt("boat", "targetname");
    boat_trigger = getEnt("boat_trigger", "targetname");

    while(true)
    {
        boat_trigger waittill("trigger", player);

        boat movey(-750, 5, 1, 1);
        boat waittill("movedone");
		wait 4;

        boat movey(750, 5, 1, 1);
        boat waittill("movedone");
    }
}