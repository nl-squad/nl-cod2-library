main()
{
	thread tp();
	thread kraty();
	thread zapadnia();
	thread text();

	ambientPlay("ambient_russia_nl");
	
	if (!isDefined(level.registerDynamicMapPart))
    {
        thread unlockGate1();
        return;
    }

    gateRegistration1 = spawnStruct();
    gateRegistration1.activatorType = level.ACTIVATE_ON_ROUND_HUNTERS_AT_MOST;
    gateRegistration1.activatorValue = 6;
    gateRegistration1.activateFunction = ::unlockGate1;
    gateRegistration1.deactivateFunction = ::lockGate1;
	gateRegistration1.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration1 );
}

unlockGate1(dynamicMapPart)
{
    iPrintlnBold("Stoves have been opened");
    gate = getEnt("gate1", "targetname");
    gate moveZ(-40, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGate1(dynamicMapPart)
{
    gate = getEnt("gate1", "targetname");
    gate moveZ(40, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

tp()
{
	teleporters = getentarray("tp", "targetname");
	for(i = 0; i < teleporters.size; i++)
	{
		teleporters[i] thread teleport();
	}
}

teleport()
{
	dest = getent(self.target, "targetname");
	if(!isDefined(dest))
	{
		wait 15;
		iPrintlnBold("^1MaxDamage is a thief");
		return;
	}

	while(1)
	{
		self waittill("trigger", player);

		player setOrigin(dest.origin);
		player setPlayerAngles(dest.angles);
	}
}

kraty()
{
    elevator = getent("kraty", "targetname");
    trig = getent("kraty_trig", "targetname");

    trig setHintString("Open the gate ");

    while(1)
    {
        trig waittill("trigger");
        elevator movez(176, 2);
        elevator waittill ("movedone");
        wait(10);
        elevator movez(-176, 2);
        elevator waittill("movedone");
    }
}

zapadnia()
{
    zapadnia1 = getent("zapadnia1", "targetname");
    zapadnia2 = getent("zapadnia2", "targetname");
    trig = getent("zapadnia_trig", "targetname");

    trig setHintString("Activate the trap ");

    while(1)
    {
        trig waittill("trigger");
        zapadnia1 rotatepitch(85, 3);
        zapadnia2 rotatepitch(-85, 3);
        wait(10);
        zapadnia1 rotatepitch(-85, 3);
        zapadnia2 rotatepitch(85, 3);
        wait(4);
    }
}

text()
{
	wait 12 * 60;
    iPrintlnBold("Map was made by Avard");
    wait 0.1;
    iPrintlnBold("in March 2024"); 
}