main()

{
	thread tp();
	thread text();


	ambientPlay("ambient_africa_nl");
}

tp()
{

	teleporters = getentarray("teleport","targetname");

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

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Akamaru & Black");
	wait 0.1;
	iPrintlnBold("in January 2012"); 
}