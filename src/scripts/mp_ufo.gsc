#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	
	thread door();
	thread objectRotate();
    thread objectRotate2();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Mynek");
	iPrintlnBold("in March 2026");
}

door()
{
    trig = getent("doortrig","targetname");
    plat = getent("door","targetname");

    while(1)
    {
        trig waittill("trigger");
        plat moveZ(80,7,1.2,1.2);
        plat waittill("movedone");

        wait(600);

        plat moveZ(-80,7,1.2,1.2);
        plat waittill("movedone");

        wait(5);
    }
}

objectRotate()
{
    obj = getEnt("ufo", "targetname");

    if (!isDefined(obj))
    {
        iprintlnBold("Nie znaleziono obiektu 'ufo'!");
        return;
    }


    while(1)
    {
        obj rotateYaw(90, 2);
        obj waittill("rotatedone");
    }
}

objectRotate2()
{
    obj = getEnt("ufo2", "targetname");

    if (!isDefined(obj))
    {
        iprintlnBold("Nie znaleziono obiektu 'ufo2'!");
        return;
    }


    while(2)
    {
        obj rotateYaw(90, 4);
        obj waittill("rotatedone");
    }
}