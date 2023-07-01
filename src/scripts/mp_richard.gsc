main()
{
	thread wall();
	thread text();	
	
	ambientPlay("ambient_africa_nl");
}

wall()
{
    wall = getEnt("wall", "targetname");

    if(!isDefined(wall))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'wall' not found");
        return;
    }

    while(1)
    {
        wall moveY(-144, 3);
        wall waittill ("movedone");
        wait 5;

        wall moveY(144, 3);
        wall waittill ("movedone");
        wait 5;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by BlancO in January 2012");
}