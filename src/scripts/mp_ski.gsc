main()

{
	thread tp();
	thread tpbot();
	thread text();


	ambientPlay("ambient_africa_nl");
}

tp()
{

	teleporters = getentarray("tp","targetname");

	for(i=0; i<teleporters.size; i++)

		teleporters[i] thread teleport();

  }

  

  teleport()

  {

	while(1)

	{

		self waittill("trigger",player);

		dest = getent(self.target, "targetname");

		if(!isDefined(dest))

		{

			player iprintlnbold("^1Trigger niepoprawnie po  czony ze script_origin!");

			wait(0.1);

			continue;

		}

		player setorigin(dest.origin);

		player setplayerangles(dest.angles);

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

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Patryczesko");
	wait 0.1;
	iPrintlnBold("in March 2014"); 
}