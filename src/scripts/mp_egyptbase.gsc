main()
{
	thread elevator();
	thread text();
	
	ambientPlay("ambient_africa_nl");
}

elevator()

{
    elevator = getEnt("elevator", "targetname");
	
    while(1)
    {

        elevator moveZ(188, 2);
        elevator waittill ("movedone");
        wait 2;

        elevator moveZ(-188, 2);
        elevator waittill ("movedone");
        wait 5;
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in February 2014");  
}