#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	

	fireFxFilename = "fx/props/barrel_fire2.efx";
    level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 1, a(fireFxFilename, (-864, -646, 60)));
    level RegisterLoopCallback("loopFx2", ::QueuePlayFx, 1, a(fireFxFilename, (-942, -816, 72)));
    level RegisterLoopCallback("loopFx3", ::QueuePlayFx, 1, a(fireFxFilename, (520, -1120, 80)));
    level RegisterLoopCallback("loopFx4", ::QueuePlayFx, 1, a(fireFxFilename, (480, -1120, 80)));
    level RegisterLoopCallback("loopFx5", ::QueuePlayFx, 1, a(fireFxFilename, (504, -968, 80)));
    level RegisterLoopCallback("loopFx6", ::QueuePlayFx, 1, a(fireFxFilename, (464, -968, 80)));
    
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);

    if (!isDefined(level.registerDynamicMapPart))
    {
        thread unlockGate1();
        return;
    }

    gateRegistration1 = spawnStruct();
    gateRegistration1.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration1.activatorValue = 6;
    gateRegistration1.activateFunction = ::unlockGate1;
    gateRegistration1.deactivateFunction = ::lockGate1;
	gateRegistration1.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration1 );
	
}

unlockGate1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^2opened");
    gate = getEnt("gate1", "targetname");
    gate moveZ(42, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGate1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^1closed");
    gate = getEnt("gate1", "targetname");
    gate moveZ(-42, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Dusza");
	iPrintlnBold("in April 2023"); 
}