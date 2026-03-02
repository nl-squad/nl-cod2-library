#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	
	if (!isDefined(level.registerStage))
    {
        thread unlockGate1();
        thread unlockGate2();
		thread unlockGate3();
		thread unlockGate4();
        return;
    }

    [[ level.registerStage ]](2, level.ZOMBIES_AT_LEAST, 8);
    [[ level.registerStage ]](3, level.ZOMBIES_AT_LEAST, 12);
    [[ level.registerStage ]](4, level.ZOMBIES_AT_LEAST, 16);

    [[ level.registerStageAction ]](2, ::unlockGate1, ::lockGate1);
    [[ level.registerStageAction ]](3, ::unlockGate2, ::lockGate2);
    [[ level.registerStageAction ]](4, ::unlockGate3, ::lockGate3);
    [[ level.registerStageAction ]](4, ::unlockGate4, ::lockGate4);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Brutha");
	iPrintlnBold("in May 2006"); 
}

unlockGate1(dynamicMapPart)
{
    iPrintlnBold("Bridge #1 has been closed");

    gate = getEnt("gate1", "targetname");
    gate moveZ(192, 4);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);

    if (isDefined(level.addMapDynamicEdge))
    {
        [[ level.addMapDynamicEdge ]](42, 250, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](250, 42, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](253, 254, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](254, 253, level.EDGE_NORMAL);
    }
}

lockGate1(dynamicMapPart)
{
    if (isDefined(level.removeMapDynamicEdge))
    {
        [[ level.removeMapDynamicEdge ]](42, 250, level.EDGE_NORMAL);
        [[ level.removeMapDynamicEdge ]](250, 42, level.EDGE_NORMAL);
        [[ level.removeMapDynamicEdge ]](253, 254, level.EDGE_NORMAL);
        [[ level.removeMapDynamicEdge ]](254, 253, level.EDGE_NORMAL);
    }

    gate = getEnt("gate1", "targetname");
    gate moveZ(-192, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

unlockGate2(dynamicMapPart)
{
    iPrintlnBold("Bridge #2 has been closed");

    gate = getEnt("gate2", "targetname");
    gate moveZ(192, 4);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);

    if (isDefined(level.addMapDynamicEdge))
    {
        [[ level.addMapDynamicEdge ]](141, 278, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](278, 141, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](280, 281, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](281, 280, level.EDGE_NORMAL);
    }
}

lockGate2(dynamicMapPart)
{
    if (isDefined(level.removeMapDynamicEdge))
    {
        [[ level.addMapDynamicEdge ]](141, 278, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](278, 141, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](280, 281, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](281, 280, level.EDGE_NORMAL);
    }

    gate = getEnt("gate2", "targetname");
    gate moveZ(-192, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

unlockGate3(dynamicMapPart)
{
    iPrintlnBold("The Gates have been lowered");

    gate = getEnt("gate3", "targetname");
    gate moveZ(-216, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);

    if (isDefined(level.addMapDynamicEdge))
    {
        [[ level.addMapDynamicEdge ]](158, 267, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](267, 158, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](161, 266, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](266, 161, level.EDGE_NORMAL);
    }
}

lockGate3(dynamicMapPart)
{
    if (isDefined(level.removeMapDynamicEdge))
    {
        [[ level.addMapDynamicEdge ]](158, 267, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](267, 158, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](161, 266, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](266, 161, level.EDGE_NORMAL);
    }

    gate = getEnt("gate3", "targetname");
    gate moveZ(216, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

unlockGate4(dynamicMapPart)
{
    gate = getEnt("gate4", "targetname");
    gate moveZ(-216, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);

    if (isDefined(level.addMapDynamicEdge))
    {
        [[ level.addMapDynamicEdge ]](150, 264, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](264, 150, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](151, 265, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](265, 151, level.EDGE_NORMAL);
    }
}

lockGate4(dynamicMapPart)
{
    if (isDefined(level.removeMapDynamicEdge))
    {
        [[ level.addMapDynamicEdge ]](150, 264, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](264, 150, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](151, 265, level.EDGE_NORMAL);
        [[ level.addMapDynamicEdge ]](265, 151, level.EDGE_NORMAL);
    }

    gate = getEnt("gate4", "targetname");
    gate moveZ(216, 2);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}
