main()
{
	thread text();
	ambientPlay("ambient_russia_nl");
	
	if (!isDefined(level.registerStage))
    {
        thread unlockGate();
		return;
    }
	
	 [[ level.registerStage ]](2, level.ZOMBIES_AT_LEAST, 14);
	 [[ level.registerStageAction ]](2, ::unlockGate, ::lockGate);

}

unlockGate(dynamicMapPart)
{
    iPrintlnBold("^7Gate has been ^1closed");
    gate = getEnt("gate", "targetname");
    gate moveZ(152, 3);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

lockGate(dynamicMapPart)
{
    gate = getEnt("gate", "targetname");
    gate moveZ(-152, 3);
    gate waittill("movedone");

    if (isDefined(level.markStageActionAsDone))
        [[ level.markStageActionAsDone ]](dynamicMapPart);
}

text()
{
	wait 12 * 60;
    iPrintlnBold("Map was made by Avard & Dusza");
    wait 0.1;
    iPrintlnBold("in June 2014"); 
}