main()
{
maps\mp\_load::main();

ambientPlay("ambient_france_nl");

thread mainMultiTeleporter("trig_void_tp", 0, "tp_void_output");
if (!isDefined(level.registerDynamicMapPart))
    {
		wait 5;
        thread unlockGate();
        return;
    }

    gateRegistration = spawnStruct();
    gateRegistration.activatorType = level.ACTIVATE_ON_ROUND_ZOMBIES_AT_LEAST;
    gateRegistration.activatorValue = 6;
    gateRegistration.activateFunction = ::unlockGate;
    gateRegistration.deactivateFunction = ::lockGate;
    gateRegistration.isRoundActivatedOnce = false;
    [[ level.registerDynamicMapPart ]]( gateRegistration );	
}

unlockGate(dynamicMapPart)
{
	ladder2 = getEnt("section2_ladder2", "targetname");
	press2 = getEnt("section2_ladder2_press", "targetname");
	ladder1 = getEnt("section2_ladder1", "targetname");
	press1 = getEnt("section2_ladder1_press", "targetname");
	gate_up = getEnt("section2_gate_up", "targetname"); // 56
	gate_up_barrier = getEnt("section2_gate_up_barrier", "targetname");
	gate_down = getEnt("section2_gate_down", "targetname"); // 144
	ramp_anticamp = getEnt("section2_ramp_anticamp", "targetname"); // -68
	gate_down_block = getEnt("section2_block", "targetname");

	wait 5;
	iPrintlnBold("The bunker is opening in 10 seconds, be ready!");
	wait 10;
	
	thread moveEntity(ladder2, 20.5, 0, 0.5, 1);
	thread moveEntity(ladder1, 18, 0, 0.5, 1);
	thread rotateEntity(ladder1, -6.6, 1);
	thread rotateEntity(ladder2, -6.6, 1);
	
	thread moveEntity(press2, 23, 0, 0, 1);
	thread moveEntity(press1, 18, 0, 0, 1);
	thread moveEntity(ramp_anticamp, -68, 0, 0, 1);
	
	thread moveEntity(gate_down, 0, 0, 144, 3);
	gate_down_block NotSolid();
	
	wait 10;
	thread moveEntity(gate_up_barrier, 0, -220, 0, 120);
	wait 110;
	iPrintlnBold("The second gate is opening in 10 seconds!");
	wait 10;
	thread moveEntity(gate_up, 0, 0, 56, 3);
	
	
}

lockGate(dynamicMapPart)
{
    //iPrintlnBold("The gate has been ^1closed");
	
	ladder2 = getEnt("section2_ladder2", "targetname");
	press2 = getEnt("section2_ladder2_press", "targetname");
	ladder1 = getEnt("section2_ladder1", "targetname");
	press1 = getEnt("section2_ladder1_press", "targetname");
	gate_up = getEnt("section2_gate_up", "targetname"); // 56
	gate_down = getEnt("section2_gate_down", "targetname"); // 144
	ramp_anticamp = getEnt("section2_ramp_anticamp", "targetname"); // -52
	gate_down_block = getEnt("section2_block", "targetname");
	
	thread moveEntity(ladder2, -20.5, 0, -0.5, 1);
	thread moveEntity(ladder1, -18, 0, -0.5, 1);
	thread rotateEntity(ladder1, 6.6, 1);
	thread rotateEntity(ladder2, 6.6, 1);
	
	thread moveEntity(press2, -23, 0, 0, 1);
	thread moveEntity(press1, -18, 0, 0, 1);
	thread moveEntity(ramp_anticamp, 68, 0, 0, 1);
	
	thread moveEntity(gate_up, 0, 0, -56, .5);
	thread moveEntity(gate_down, 0, 0, -144, .5);
	gate_down_block Solid();


    if (isDefined(level.markAcitivationAsDone))
        [[ level.markAcitivationAsDone ]](dynamicMapPart);
}

mainMultiTeleporter(trigger, time, target) 
{ 
	if(!isDefined(time)) 
		time = 0.10; 
	entTransporter = getEntArray(trigger, "targetname"); 
	for(lp = 0; lp < entTransporter.size; lp = lp+1) 
	{ 
		if(!isDefined(entTransporter[lp].target)) 
		entTransporter[lp].target = target; 
		entTransporter[lp] thread multiTransporter(time);
	} 
} 

multiTransporter(time) 
{ 
	while(true) 
	{ 
		self waittill("trigger",other); 
		entTargets = getEntArray(self.target, "targetname"); 
		entTarget = entTargets[randomInt(entTargets.size)];
		wait(time); 
		other setorigin(entTarget.origin); 
		other setplayerangles(entTarget.angles); 
		wait(0.10); 
	}
} 

moveEntity(ent, x, y, z, speed)
{
	if (x != 0)
	{
		ent moveX(x, speed); 
		ent waittill("movedone");
    }
	
	if (y != 0)
	{
		ent moveY(y, speed);
		ent waittill("movedone");
	}
	
    if (z != 0)
	{
		ent moveZ(z, speed);
		ent waittill("movedone");
	}
}

rotateEntity(ent, pitch, speed)
{
	ent RotatePitch(pitch, speed);
	ent waittill("movedone");
}