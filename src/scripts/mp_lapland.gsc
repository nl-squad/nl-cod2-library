#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");

	fireFxFilename = "fx/props/barrel_fire2.efx";
	smokeFxFilename = "fx/smoke/damaged_vehicle_smoke.efx";
    level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 1, a(fireFxFilename, (-872, -568, -96)));
    level RegisterLoopCallback("loopFx2", ::QueuePlayFx, 1, a(smokeFxFilename, (-872, -568, -96)));
    level RegisterLoopCallback("loopFx3", ::QueuePlayFx, 1, a(fireFxFilename, (392, -104, -96)));
    level RegisterLoopCallback("loopFx4", ::QueuePlayFx, 1, a(smokeFxFilename, (392, -104, -96)));
    level RegisterLoopCallback("loopFx5", ::QueuePlayFx, 1, a(fireFxFilename, (760, -96, -96)));
    level RegisterLoopCallback("loopFx6", ::QueuePlayFx, 1, a(smokeFxFilename, (760, -96, -96)));

	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by zazu");
	iPrintlnBold("in December 2012"); 
}
