main()

{
	thread text();
	ambientPlay("ambient_france_nl");
	
	if (!isDefined(level.registerDynamicMapPart))
    {
        thread unlockGate1();
        thread unlockGate2();
		thread unlockGate3();
        return;
    }

    gateRegistration1 = spawnStruct();
    gateRegistration1.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration1.activatorValue = 8;
    gateRegistration1.activateFunction = ::unlockGate1;
    gateRegistration1.deactivateFunction = ::lockGate1;
	gateRegistration1.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration1 );

    gateRegistration2 = spawnStruct();
    gateRegistration2.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration2.activatorValue = 12;
    gateRegistration2.activateFunction = ::unlockGate2;
    gateRegistration2.deactivateFunction = ::lockGate2;
	gateRegistration2.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration2 );

    gateRegistration3 = spawnStruct();
    gateRegistration3.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration3.activatorValue = 16;
    gateRegistration3.activateFunction = ::unlockGate3;
    gateRegistration3.deactivateFunction = ::lockGate3;
	gateRegistration3.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration3 );
}

unlockGate1(dynamicMapPart)
{
    iPrintlnBold("Footbridge #1 has been lowered");
    gate = getEnt("gate1", "targetname");
    gate moveZ(-144, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGate1(dynamicMapPart)
{
    gate = getEnt("gate1", "targetname");
    gate moveZ(144, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

unlockGate2(dynamicMapPart)
{
    iPrintlnBold("Footbridge #2 has been lowered");
    gate = getEnt("gate2", "targetname");
    gate moveZ(-144, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGate2(dynamicMapPart)
{
    gate = getEnt("gate2", "targetname");
    gate moveZ(144, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

unlockGate3(dynamicMapPart)
{
    iPrintlnBold("The gates have been lowered");
    gate = getEnt("gate3", "targetname");
    gate moveZ(-144, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGate3(dynamicMapPart)
{
    gate = getEnt("gate3", "targetname");
    gate moveZ(144, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Brutha");
	wait 0.1;
	iPrintlnBold("in May 2006"); 
}