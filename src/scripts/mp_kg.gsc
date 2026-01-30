#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");

	spotFxFilename = "fx/misc/spotlight_decoytown.efx";
    level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 30, a(spotFxFilename, (-488, 152, 240)));
    level RegisterLoopCallback("loopFx2", ::QueuePlayFx, 30, a(spotFxFilename, (600, 152, 240)));

	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by K1r@");
	iPrintlnBold("in October 2016"); 	
}