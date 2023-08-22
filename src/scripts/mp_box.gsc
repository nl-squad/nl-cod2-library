main()
{
	thread nl();
	thread text();

	
	ambientPlay("ambient_france_nl");
	
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Wolf");
	wait 0.1;
	iPrintlnBold("in August 2023"); 
}

nl
{
	nl = getEnt("nl", "targetname");	
	while(true)
		{
			sphere rotateyaw(360, 5);
			sphere waittill("rotatedone");
		}
}