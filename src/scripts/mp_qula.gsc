main()
{
	thread qula();
	thread text();	
	
	ambientPlay("ambient_africa_nl");
}

qula()
{
	qula = getEnt("qula", "targetname");	
	while(true)
		{
			qula rotateyaw(360, 10);
			qula waittill("rotatedone");
		}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by zazu");
	wait 0.1;
	iPrintlnBold("in August 2012"); 		
}

