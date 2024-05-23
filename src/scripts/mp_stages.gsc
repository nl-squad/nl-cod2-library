main()

{
	thread text();
	ambientPlay("ambient_france_nl");
	
	if (!isDefined(level.registerStage))
    {
        thread unlockGate1();
        thread unlockGate2();
		thread unlockGate3();
        return;
    }

    [[ level.registerStage ]](2, level.ZOMBIES_AT_LEAST, 8);
    [[ level.registerStage ]](3, level.ZOMBIES_AT_LEAST, 12);
    [[ level.registerStage ]](4, level.ZOMBIES_AT_LEAST, 16);

    [[ level.registerStageAction ]](2, ::unlockGate1, ::lockGate1);
    [[ level.registerStageAction ]](3, ::unlockGate2, ::lockGate2);
    [[ level.registerStageAction ]](4, ::unlockGate3, ::lockGate3);
}

unlockGate1(dynamicMapPart)
{
    iPrintlnBold("Stage ^31 ^2Opened");
    gate = getEnt("gate1", "targetname");
    gate moveZ(192, 4);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

lockGate1(dynamicMapPart)
{
    gate = getEnt("gate1", "targetname");
    gate moveZ(-192, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

unlockGate2(dynamicMapPart)
{
    iPrintlnBold("Stage ^32 ^2Opened");
    gate = getEnt("gate2", "targetname");
    gate moveZ(192, 4);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

lockGate2(dynamicMapPart)
{
    gate = getEnt("gate2", "targetname");
    gate moveZ(-192, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

unlockGate3(dynamicMapPart)
{
    iPrintlnBold("Stage ^33 ^2Opened");
    gate = getEnt("gate3", "targetname");
    gate moveZ(192, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

lockGate3(dynamicMapPart)
{
    gate = getEnt("gate3", "targetname");
    gate moveZ(-192, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in May 2024"); 
}