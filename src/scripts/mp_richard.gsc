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
	iPrintlnBold("Map was made by BlancO");
	wait 0.1;
	iPrintlnBold("in January 2012"); 		
}