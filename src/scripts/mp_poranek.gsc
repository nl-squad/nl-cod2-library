#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");

	spotFxFilename = "fx/misc/spotlight_decoytown.efx";
    level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 30, a(spotFxFilename, (0, -128, 9)));
	
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);

	thread sphereControl(1);
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

ownerCredits()
{
	iPrintlnBold("Map was made by K2o");
	iPrintlnBold("in June 2012"); 
}
