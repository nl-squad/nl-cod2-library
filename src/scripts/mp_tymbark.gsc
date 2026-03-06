#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	fireFxFilename = "fx/props/barrel_fire2.efx";
	smokeFxFilename = "fx/smoke/damaged_vehicle_smoke.efx";
	level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 1, a(fireFxFilename, (24, 24, 400)));
	level RegisterLoopCallback("loopFx2", ::QueuePlayFx, 1, a(smokeFxFilename, (24, 24, 400)));
}

ownerCredits()
{
	iPrintlnBold("Map was made by Bozzy");
	iPrintlnBold("in May 2014");
}