main()
{
    maps\mp\_load::main();

    setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
    // setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
    ambientPlay("ambient_france");

    game["allies"] = "american";
    game["axis"] = "german";
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    game["american_soldiertype"] = "normandy";
    game["german_soldiertype"] = "normandy";

    setCvar("r_glowbloomintensity0", ".25");
    setCvar("r_glowbloomintensity1", ".25");
    setCvar("r_glowskybleedintensity0",".3");


    level thread plat1();
    level thread plat2();
    level thread platforma1();
    level thread showCredits();

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
showCredits()
{
    while(1)
    {
        wait 300;

        hud = newHudElem();
        hud.x = 0.5;                
        hud.y = 0.3;                
        hud.alignX = "center";
        hud.alignY = "middle";
        hud.fontScale = 2;
        hud.color = (1,1,1);
        hud.alpha = 1;
        hud.label = "Map created by Mynek in 2025";

        wait 3;

        hud destroy();
    }
}
