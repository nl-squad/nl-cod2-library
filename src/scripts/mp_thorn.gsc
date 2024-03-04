main()
{
	thread wall();
    thread text();    
    ambientPlay("ambient_africa_nl");
}

wall()
{
    wall = getEnt("wall", "targetname");
    trig = getEnt("wall_trig", "targetname");
	trig setHintString("Reduce Hunters' Sight ^315^7s");

    if(!isDefined(wall))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'wall' not found");
        return;
    }

    if(!isDefined(trig))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'wall_trig' not found");
        return;
    }
		wall movez(-136, 2);
        wall waittill ("movedone");

    while(1)
    {	
        trig waittill ("trigger");

        wall moveZ(136, 3);
        wall waittill ("movedone");
        wait 15;

        wall moveZ(-136, 2);
        wall waittill ("movedone");
        wait 20;
    }
}

text()
{
    wait 12 * 60;
    iPrintlnBold("Map was made by Avard");
	wait 0.1;
	iPrintlnBold("in September 2012");  
}


