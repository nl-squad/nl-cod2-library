#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	ambientFX();
	
	thread tp();
	thread kraty();
	thread zapadnia();
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	
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

ambientFX()
{

	fireFxFilename = "fx/fire/tank_fire_engine.efx";
    level RegisterLoopCallback("loopFx1", ::QueuePlayFx, 1, a(fireFxFilename, (1740, 70, -475)));
	maps\mp\_fx::soundfx("smallfire", (1740, 70, -475));

    level RegisterLoopCallback("loopFx2", ::QueuePlayFx, 1, a(fireFxFilename, (-1207, -701, 25)));
	maps\mp\_fx::soundfx("smallfire", (-1207, -701, 25));

	spotFxFilename = "fx/misc/spotlight_decoytown.efx";
    level RegisterLoopCallback("loopFx3", ::QueuePlayFx, 1, a(spotFxFilename, (-161, -655, -436)));
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
		iPrintlnBold("^11");
		wait(10);
		iPrintlnBold("^22");
		zapadnia1 rotatepitch(-85, 3);
		zapadnia2 rotatepitch(85, 3);
		iPrintlnBold("^33");
		wait(4);
		iPrintlnBold("^44");
	}
}

ownerCredits()
{
    iPrintlnBold("Map was made by Avard");
    iPrintlnBold("in March 2024"); 
}