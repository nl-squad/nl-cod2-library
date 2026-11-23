#include blanco\utils;

main()
{
    ambientPlay("ambient_france_nl");
    [[ level.registerTeleportsForAll ]]("tp");
    [[ level.registerTeleportsForBotsOnly ]]("tpbot");
    level thread objectRotate();
    level thread objectRotate2();
    level thread objectRotate3();
    level thread door();
    level thread door2();
    level thread kapsula1();
    level thread kapsula2();
    level thread showCredits();
}

showCredits()
{
	iPrintlnBold("Map was made by Mynek");
	iPrintlnBold("in November 2026");
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

objectRotate3()
{
    obj = getEnt("ufo3", "targetname");

    if (!isDefined(obj))
    {
        iprintlnBold("Nie znaleziono obiektu 'ufo3'!");
        return;
    }


    while(2)
    {
        obj rotateYaw(90, 4);
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

door2()
{
    trig = getent("door2trig","targetname");
    plat = getent("door2","targetname");

    while(1)
    {
        trig waittill("trigger");
        plat moveZ(90,7,1.2,1.2);
        plat waittill("movedone");

        wait(600);

        plat moveZ(-90,7,1.2,1.2);
        plat waittill("movedone");

        wait(5);
    }
}

kapsula1()
{
    trig = getent("teleportacjaopen","targetname");
    plat = getent("kapsula1","targetname");

    while(1)
    {
        trig waittill("trigger");
        plat moveZ(-70,7,1.2,1.2);
        plat waittill("movedone");

        wait(8);

        plat moveZ(70,7,1.2,1.2);
        plat waittill("movedone");

        wait(10);
    }
}

kapsula2()
{
    trig = getent("teleportacjastart","targetname");
    plat = getent("kapsula2","targetname");

    while(1)
    {
        trig waittill("trigger");
        plat moveZ(46,7,1.2,1.2);
        plat waittill("movedone");

        wait(3);

        plat moveZ(-46,7,1.2,1.2);
        plat waittill("movedone");

        wait(10);
    }
}