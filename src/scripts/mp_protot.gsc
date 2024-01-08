main()
{
	thread text();

	ambientPlay("ambient_africa_nl");

    if (!isDefined(level.registerDynamicMapPart))
    {
        thread unlockGate();
        return;
    }

	level.MAP_MAX_STAGE = 3;

    gateRegistration1 = spawnStruct();
    gateRegistration1.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration1.activatorValue = 3;
    gateRegistration1.activateFunction = ::unlockGateStage1;
    gateRegistration1.deactivateFunction = ::lockGateStage1;
    gateRegistration1.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration1 );

    gateRegistration2 = spawnStruct();
    gateRegistration2.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration2.activatorValue = 6;
    gateRegistration2.activateFunction = ::unlockGateStage2;
    gateRegistration2.deactivateFunction = ::lockGateStage2;
    gateRegistration2.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration2 );
	
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Avard");
	wait 0.1;
	iPrintlnBold("in January 2024"); 
}

unlockGateStage1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^2opened");
    gate = getEnt("gatestage1", "targetname");
    gate moveZ(180, 2);
    gate waittill("movedone");

    [[ level.setCurrentStage ]](2);
    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGateStage1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^1closed");
    gate = getEnt("gatestage1", "targetname");
    gate moveZ(-180, 1);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

unlockGateStage2(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^2opened");
    gate = getEnt("gatestage2", "targetname");
    gate moveZ(180, 2);
    gate waittill("movedone");

    [[ level.setCurrentStage ]](3);
    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGateStage2(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^1closed");
    gate = getEnt("gatestage2", "targetname");
    gate moveZ(-180, 1);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}
