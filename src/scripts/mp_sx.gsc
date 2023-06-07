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
    iprintlnBold("The gate has been opened");
    gate = getEnt("gate", "targetname");
    gate moveZ(42, 2);
}

lockGate()
{
    iprintlnBold("The gate has been closed");
    gate = getEnt("gate", "targetname");
    gate moveZ(-42, 2);
}