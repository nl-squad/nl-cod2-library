#include blanco\utils;

main()
{

	level._effect["spot1"] = loadfx("fx/misc/spotlight_decoytown.efx");
	
	maps\mp\_fx::loopfx("spot1", (63, 598, -184), 5);
	
	thread tp();
	thread tpbot();
	thread black();
	thread q1();
	thread q2();
	thread q3();
	thread q4();
	thread q5();
	thread q6();
	thread q8();
	thread q9();
	thread q10();
	thread q11();
	thread q12();
	thread q13();
	thread text();
	
	ambientPlay("ambient_france_nl");
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

tpbot()
{
	teleporters = getentarray("tpbot", "targetname");
	for(i = 0; i < teleporters.size; i++)
	{
		teleporters[i] thread teleport1();
	}
}

teleport1()
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

		if (!player isBot())
			continue;
			
		player.solutionNextCalculationTime = getTime();
		player setOrigin(dest.origin);
		player setPlayerAngles(dest.angles);
		player linkTo(level.blocker);
		wait 0.1;

        if (isDefined(player))
		    player unlink();
	}
}

black()
{
    black = getEnt("black", "targetname");    
    
    while(true)
        {
            black rotateyaw(360, 5);
            black waittill("rotatedone");
        }
}

q1()
{
	q1 = getEnt("q1", "targetname");	
	while(true)
		{
			q1 rotateyaw(360, 5);
			q1 waittill("rotatedone");
		}
}

q2()
{
	q2 = getEnt("q2", "targetname");	
	while(true)
		{
			q2 rotateyaw(-360, 5);
			q2 waittill("rotatedone");
		}
}

q3()
{
	q3 = getEnt("q3", "targetname");	
	while(true)
		{
			q3 rotatepitch(360, 5);
			q3 waittill("rotatedone");
		}
}

q4()
{
	q4 = getEnt("q4", "targetname");	
	while(true)
		{
			q4 rotatepitch(-360, 5);
			q4 waittill("rotatedone");
		}
}

q5()
{
	q5 = getEnt("q5", "targetname");	
	while(true)
		{
			q5 rotateroll(360, 5);
			q5 waittill("rotatedone");
		}
}

q6()
{
	q6 = getEnt("q6", "targetname");	
	while(true)
		{
			q6 rotateroll(-360, 5);
			q6 waittill("rotatedone");
		}
}

q8()
{
	q8 = getEnt("q8", "targetname");	
	while(true)
		{
			q8 rotateyaw(-360, 5);
			q8 waittill("rotatedone");
		}
}

q9()
{
	q9 = getEnt("q9", "targetname");	
	while(true)
		{
			q9 rotateyaw(360, 5);
			q9 waittill("rotatedone");
		}
}

q10()
{
	q10 = getEnt("q10", "targetname");	
	while(true)
		{
			q10 rotatepitch(-360, 5);
			q10 waittill("rotatedone");
		}
}

q11()
{
	q11 = getEnt("q11", "targetname");	
	while(true)
		{
			q11 rotatepitch(360, 5);
			q11 waittill("rotatedone");
		}
}

q12()
{
	q12 = getEnt("q12", "targetname");	
	while(true)
		{
			q12 rotateroll(-360, 5);
			q12 waittill("rotatedone");
		}
}

q13()
{
	q13 = getEnt("q13", "targetname");	
	while(true)
		{
			q13 rotateroll(360, 5);
			q13 waittill("rotatedone");
		}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in November 2013"); 
}