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
    [[ level.registerDynamicMapPart ]]( gateRegistration );

	ambientPlay("ambient_france_nl");
	
	level._effect["spot2"] = loadfx("fx/props/barrel_fire2.efx");
	
	maps\mp\_fx::loopfx("spot2", (-864, -646, 48), 1500);
	maps\mp\_fx::loopfx("spot2", (-942, -816, 56), 1500);
}

unlockGate()
{
    iprintlnBold("The gate has been ^2opened");
    gate = getEnt("gate", "targetname");
    gate moveZ(42, 2);
}

lockGate()
{
    iprintlnBold("The gate has been ^1closed");
    gate = getEnt("gate", "targetname");
    gate moveZ(-42, 2);
}