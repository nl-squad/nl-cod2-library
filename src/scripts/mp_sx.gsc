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
}

unlockGate()
{
	iprintln("dupa");
    gate = getEnt("gate", "targetname");
    gate moveZ(42, 2);
}

lockGate()
{
	iprintln("dupa2");
    gate = getEnt("gate", "targetname");
    gate moveZ(-42, 1);
}