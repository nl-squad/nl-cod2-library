main()
{
	thread elevator();
	thread text();
	
	ambientPlay("ambient_russia_nl");
}

elevator()

{
    elevator = getEnt("elevator", "targetname");
	
    while(1)
    {

        elevator moveZ(256, 2);
        elevator waittill ("movedone");
        wait 2;

        elevator moveZ(-256, 2);
        elevator waittill ("movedone");
        wait 4;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in January 2017");  
}