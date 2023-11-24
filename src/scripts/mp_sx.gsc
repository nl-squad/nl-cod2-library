main()

{	
	thread text();
	ambientPlay("ambient_france_nl");
	
    level._effect["spot2"] = loadfx("fx/props/barrel_fire2.efx");
	
    maps\mp\_fx::loopfx("spot2", (-864, -646, 60), 1);
    maps\mp\_fx::loopfx("spot2", (-942, -816, 72), 1);
	maps\mp\_fx::loopfx("spot2", (520, -1120, 80), 1);
	maps\mp\_fx::loopfx("spot2", (480, -1120, 80), 1);
	maps\mp\_fx::loopfx("spot2", (504, -968, 80), 1);
	maps\mp\_fx::loopfx("spot2", (464, -968, 80), 1);


    if (!isDefined(level.registerDynamicMapPart))
    {
        thread unlockGate1();
        return;
    }

    gateRegistration1 = spawnStruct();
    gateRegistration1.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration1.activatorValue = 6;
    gateRegistration1.activateFunction = ::unlockGate1;
    gateRegistration1.deactivateFunction = ::lockGate1;
	gateRegistration1.isRoundActivatedOnce = true;
    [[ level.registerDynamicMapPart ]]( gateRegistration1 );
	
}

unlockGate1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^2opened");
    gate = getEnt("gate1", "targetname");
    gate moveZ(42, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

lockGate1(dynamicMapPart)
{
    iPrintlnBold("The gate has been ^1closed");
    gate = getEnt("gate1", "targetname");
    gate moveZ(-42, 2);
    gate waittill("movedone");

    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in April 2023"); 
}