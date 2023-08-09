main()
{
	thread text();
	thread NoZombies();
	thread zooka();
	thread czolganie();
	thread winda();
	thread secretVIP();
	thread watchSecretCampers();

	ambientPlay("ambient_russia_nl");
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Avard & BlancO");
	wait 0.1;
	iPrintlnBold("in September 2012"); 
}

NoZombies()
{
	trig = getent("nozombies", "targetname");

	while(1)
	{
		trig waittill("trigger", player);

		if(player.pers["team"] == "axis")
		{
			player suicide();
		}
	}
}

zooka()
{
	cost = 1200;
	trig = getent("bazooka", "targetname");
	trig setHintString("^9Bazooka ^4- ^3" + cost + " ^4$");

	while(1)
	{
		trig waittill("trigger", player);

		if(!isDefined(player.stats["money"]))
			player.stats["money"] = 0;
		
		if(player.stats["money"] >= cost && player.pers["team"] == "allies")
		{
			weapon = "zooka_mp";
			player setWeaponSlotWeapon("primaryb", weapon);
			player giveMaxAmmo(weapon);
			player switchToWeapon(weapon);
			player setWeaponSlotAmmo("primaryb", 12);
		}
		else if(player.stats["money"] < cost && player.pers["team"] == "allies")
		{
			player iPrintlnBold("^4! ^7Not ^9Enough ^7Money ^4!");
		}
	}
}

czolganie()
{
	wall = getent("czolg", "targetname");
	trig = getent("t_czolg", "targetname");

	while(1)
	{
		trig waittill("trigger");

		wall moveX(-10, 1);
		wall waittill("movedone");
		wall moveZ(57, 1);
		wall waittill("movedone");
		wait 5;

		wall moveZ(-57, 1);
		wall waittill("movedone");
		wall moveX(10, 1);
		wall waittill("movedone");
	}
}

winda()
{
	wall = getent("winda", "targetname");
	wall moveZ(-128, 1);
	wait 1;

	while(1)
	{
		wall moveZ(568, 2);
		wait 0.5;
		wall rotateYaw(180, 1);
		wall waittill("movedone");
		wait 1;

		wall moveZ(-568, 2);
		wait 0.5;
		wall rotateYaw(-180, 1);
		wall waittill("movedone");
		wait 1;
	}
}

secretVIP()
{
	wall = getent("secret", "targetname");
	trig = getent("t_secret", "targetname");

	while(1)
	{
		trig waittill("trigger", player);

		if(!isDefined(player.isVIP))
			player.isVIP = false;

		if(player.isVIP)
		{
			if(player.pers["team"] == "allies")
			{
				if(isDefined(player.campingTime))
				{
					player.campingTime = 0;
				}

				player iPrintlnBold("^4! ^7Secret ^9Open ^4!");

				wall notsolid();
				wait 0.1;
				wall solid();
			}
			else
			{
				player iPrintlnBold("^4! ^9Only For ^7Hunters ^4!");
				wall solid();
				wait 1;
			}
		}
		else
		{
			player iPrintlnBold("Your penis size is too small!");
			wall solid();
			wait 1;
		}
	}
}

watchSecretCampers()
{
	trigs = getentarray("vip_secret", "targetname");
	max = 30; // Maksymalny czas campy (sekundy)
	warn = 20; // Upomnienie po (sekundy)

	while(1)
	{
		wait 1;

		players = getentarray("player", "classname");
		for(i = 0; i < players.size; i++)			
		{
			touching = false;
			for(x = 0; x < trigs.size; x++)
			{
				if(players[i] isTouching(trigs[x]))
				{
					touching = true;
				}
			}

			if(touching)
			{
				if(!isDefined(players[i].campingTime))
				{
					players[i].campingTime = 0;
					players[i] iPrintlnBold("^4!!! ^9You Can't ^7Camp ^9More Than ^3" + max + " ^7Seconds ^4!!!");
				}

				players[i].campingTime += 1;

				if(players[i].campingTime == int(max))
				{
					players[i] suicide();
					iPrintln("^4!!! ^7" + players[i].name + " ^9Tried To ^7Camp ^9In ^7Secret ^4<~ ^7NOOB ^4!!!");
				}
				else if(players[i].campingTime == int(warn))
				{
					roznica = int(max) - int(warn);
					players[i] iPrintlnBold("^4!!! ^9You Can ^7Camp ^9More ^3" + roznica + " ^7Seconds ^4!!!");
				}
			}
		}
	}
}

