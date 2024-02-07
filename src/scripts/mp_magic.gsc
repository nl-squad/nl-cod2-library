main()
{
	thread q1();
	thread q2();
	thread q3();
	thread q4();
	thread q5();
	thread q6();
	thread q7();
	thread q8();
	thread q9();
	thread q10();
	thread q11();
	thread q12();
	thread q13();
	thread q14();	
	thread text();
	
	ambientPlay("ambient_france_nl");
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
			q2 rotateyaw(360, 5);
			q2 waittill("rotatedone");
		}
}

q3()
{
	q3 = getEnt("q3", "targetname");	
	while(true)
		{
			q3 rotateyaw(360, 5);
			q3 waittill("rotatedone");
		}
}

q4()
{
	q4 = getEnt("q4", "targetname");	
	while(true)
		{
			q4 rotateyaw(360, 5);
			q4 waittill("rotatedone");
		}
}

q5()
{
	q5 = getEnt("q5", "targetname");	
	while(true)
		{
			q5 rotateyaw(360, 5);
			q5 waittill("rotatedone");
		}
}

q6()
{
	q6 = getEnt("q6", "targetname");	
	while(true)
		{
			q6 rotateyaw(360, 5);
			q6 waittill("rotatedone");
		}
}

q7()
{
	q7 = getEnt("q7", "targetname");	
	while(true)
		{
			q7 rotateyaw(360, 5);
			q7 waittill("rotatedone");
		}
}

q8()
{
	q8 = getEnt("q8", "targetname");	
	while(true)
		{
			q8 rotateyaw(360, 5);
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
			q10 rotateyaw(360, 5);
			q10 waittill("rotatedone");
		}
}

q11()
{
	q11 = getEnt("q11", "targetname");	
	while(true)
		{
			q11 rotateyaw(360, 5);
			q11 waittill("rotatedone");
		}
}

q12()
{
	q12 = getEnt("q12", "targetname");	
	while(true)
		{
			q12 rotateyaw(360, 5);
			q12 waittill("rotatedone");
		}
}

q13()
{
	q13 = getEnt("q13", "targetname");	
	while(true)
		{
			q13 rotateyaw(360, 5);
			q13 waittill("rotatedone");
		}
}

q14()
{
	q14 = getEnt("q14", "targetname");	
	while(true)
		{
			q14 rotateyaw(360, 5);
			q14 waittill("rotatedone");
		}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Dusza");
	wait 0.1;
	iPrintlnBold("in November 2013"); 
}