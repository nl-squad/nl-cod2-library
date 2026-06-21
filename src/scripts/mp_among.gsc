#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
    level thread plat1();
    level thread plat2();
    level thread platforma1();
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
} 

plat1()
{
    trig = getent("trigplat1","targetname");
    plat = getent("plat1","targetname");

    while(1)
    {
        trig waittill("trigger");
        plat moveZ(-51,7,1.2,1.2);
        plat waittill("movedone");

        wait(5);

        plat moveZ(51,7,1.2,1.2);
        plat waittill("movedone");

        wait(5);
    }
}

plat2()
{
    trig = getent("trigplat2","targetname");
    plat = getent("plat2","targetname");

    while(1)
    {
        trig waittill("trigger");
        plat moveZ(-84,7,1.2,1.2);
        plat waittill("movedone");

        wait(50);

        plat moveZ(84,7,1.2,1.2);
        plat waittill("movedone");

        wait(5);
    }
}

platforma1()
{
    trig = getent("trigplatforma1","targetname");
    plat = getent("platforma1","targetname");

    while(5)
    {

        wait(9);

        trig waittill("trigger");
        plat moveX(-910,7,1.2,1.2);
        plat waittill("movedone");

        wait(5);

        plat moveX(910,7,1.2,1.2);
        plat waittill("movedone");

        wait(5);
    }
}

ownerCredits()
{
	iPrintlnBold("Map was made by Mynek");
	iPrintlnBold("in May 2026");
}
