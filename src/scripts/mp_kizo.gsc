#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	fireFxFilename = "fx/props/barrel_fire2.efx";
	smokeFxFilename = "fx/smoke/damaged_vehicle_smoke.efx";
	level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 1, a(fireFxFilename, (-1608, -1144, 40)));
	level RegisterLoopCallback("loopFx2", ::QueuePlayFx, 1, a(smokeFxFilename, (-872, -568, 40)));
	[[ level.registerTeleportsForAll ]]("tp");
	[[ level.registerTeleportsForBotsOnly ]]("tpbot");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

ownerCredits()
{
	iPrintlnBold("Map was made by BoNuS");
	iPrintlnBold("in October 2025");
}