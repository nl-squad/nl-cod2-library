main()

{	
	thread text();
	ambientPlay("ambient_france_nl");
	
    level._effect["spot1"] = loadfx("fx/props/barrel_fire.efx");
    level._effect["spot2"] = loadfx("fx/props/barrel_fire2.efx");
	
    maps\mp\_fx::loopfx("spot1", (-864, -646, 60), 1);
    maps\mp\_fx::loopfx("spot2", (-942, -816, 72), 1);
	maps\mp\_fx::loopfx("spot2", (534, -1116, 80), 1);


    if (!isDefined(level.registerDynamicMapPart))
    {
        thread unlockGate1();
		thread unlockGate2();
        return;
    }

    gateRegistration1 = spawnStruct();
    gateRegistration1.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration1.activatorValue = 6;
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
}

unlockGate1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^2opened");
    if (isDefined(level.markActivationAsDone))
    {
        gate = getEnt("gate1", "targetname");
        if (isDefined(gate))
        {
            gate moveZ(42, 2);
            gate waittill("movedone");
            [[ level.markActivationAsDone ]](dynamicMapPart);
        }
        else
        {
            iPrintln("Error: Gate1 not found!");
        }
    }
}

lockGate1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^1closed");
    if (isDefined(level.markActivationAsDone))
    {
        gate = getEnt("gate1", "targetname");
        if (isDefined(gate))
        {
            gate moveZ(-42, 2);
            gate waittill("movedone");
            [[ level.markActivationAsDone ]](dynamicMapPart);
        }
        else
        {
            iPrintln("Error: Gate1 not found!");
        }
    }
}

unlockGate2(dynamicMapPart)
{
    gate = getEnt("gate2", "targetname");
    if (isDefined(gate))
    {
        gate moveZ(-48, 2);
        gate waittill("movedone");
        if (isDefined(level.markActivationAsDone))
            [[ level.markActivationAsDone ]](dynamicMapPart);
    }
    else
    {
        iPrintln("Error: Gate2 not found!");
    }
}

lockGate2(dynamicMapPart)
{
    gate = getEnt("gate2", "targetname");
    if (isDefined(gate))
    {
        gate moveZ(48, 2);
        gate waittill("movedone");
        if (isDefined(level.markActivationAsDone))
            [[ level.markActivationAsDone ]](dynamicMapPart);
    }
    else
    {
        iPrintln("Error: Gate2 not found!");
    }
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in April 2023"); 
}