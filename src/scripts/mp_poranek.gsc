main()
{
	thread sphereControl(1);
	thread text();
	
	ambientPlay("ambient_africa_nl");
}

sphereControl(num)
{
	sphere = getEnt("sphere" + num, "targetname");	
	while(true)
		{
			sphere rotateyaw(360, 10);
			sphere waittill("rotatedone");
		}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by K2o");
	wait 0.1;
	iPrintlnBold("in June 2012"); 
}
