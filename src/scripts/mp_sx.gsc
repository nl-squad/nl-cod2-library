main()
{
    if (!isDefined(level.registerDynamicMapPart))
    {
        thread unlockGate();
        return;
    }

    gateRegistration = spawnStruct();
    gateRegistration.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration.activatorValue = 6;
    gateRegistration.activateFunction = ::unlockGate;
    gateRegistration.deactivateFunction = ::lockGate;
	gateRegistration.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration );

    ambientPlay("ambient_france_nl");
	
    level._effect["spot1"] = loadfx("fx/props/barrel_fire.efx");
    level._effect["spot2"] = loadfx("fx/props/barrel_fire2.efx");
	level._effect["spot3"] = loadfx("fx/props/barrel_fire2.efx");
    maps\mp\_fx::loopfx("spot1", (-864, -646, 60), 1);
    maps\mp\_fx::loopfx("spot2", (-942, -816, 72), 1);
	maps\mp\_fx::loopfx("spot3", (534, -1116, 80), 1);
}

unlockGate(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^2opened");
    gate = getEnt("gate", "targetname");
    gate moveZ(42, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGate(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^1closed");
    gate = getEnt("gate", "targetname");
    gate moveZ(-42, 1);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}