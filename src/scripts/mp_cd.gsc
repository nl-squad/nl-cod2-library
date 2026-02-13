main()
{
	[[ level.registerTeleportsForAll ]]("tp");
	thread elevator1();
	thread elevator2();
	thread text();
	
	ambientPlay("ambient_france_nl");
}

elevator1()
{
    elevator1 = getEnt("elevator1", "targetname");

    if(!isDefined(elevator1))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator1' not found");
        return;
    }

    while(1)
    {
        elevator1 moveZ(-368, 3);
        elevator1 waittill ("movedone");
        wait 4;

        elevator1 moveZ(368, 3);
        elevator1 waittill ("movedone");
        wait 2;
    }
}

elevator2()
{
    elevator2 = getEnt("elevator2", "targetname");

    if(!isDefined(elevator2))
    {
        wait 20;
        iPrintlnBold("^1Entity named 'elevator2' not found");
        return;
    }

    while(1)
    {
        elevator2 moveZ(-368, 3);
        elevator2 waittill ("movedone");
        wait 4;

        elevator2 moveZ(368, 3);
        elevator2 waittill ("movedone");
        wait 2;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in January 2014"); 
}
