main()
{
	maps\mp\_load::main();
	thread players();
	thread outfromcampa();
	thread lotto();
	thread lotto1();
	thread lotto2();
	thread lotto3();
	thread czolg();
	thread napisy();
	thread blokrespa();
	thread roszada();
}

players()
{
	while(1)
	{
		wait 17;
		level waittill("connected",player);
		player iprintlnbold("Welcome on Yero and Yankes PARTY!>!>!.");
		wait 1;
		player iprintlnbold("Love Yankes and keep sex with hand.");
	}
}

napisy()
{
	while(1)
	{
		iprintlnbold("Love Yankes and Yero.");
		wait 200;
	}
}

lotto()  ///////Wciskanie guzika do losowania
	{
		guzik = getent("guzik","targetname");  
			while(1)
			{
				guzik waittill("trigger", player);
				player thread losowanko();
				wait 4;
			}
	}
lotto1()  ///////Wciskanie guzika do losowania
	{
		guzik1 = getent("guzik1","targetname");  
			while(1)
			{
				guzik1 waittill("trigger", player);
				player thread losowanko();
				wait 4;
			}
	}
lotto2()  ///////Wciskanie guzika do losowania
	{
		guzik2 = getent("guzik2","targetname");  
			while(1)
			{
				guzik2 waittill("trigger", player);
				player thread losowanko();
				wait 4;
			}
	}
lotto3()  ///////Wciskanie guzika do losowania
	{
		guzik3 = getent("guzik3","targetname");  
			while(1)
			{
				guzik3 waittill("trigger", player);
				player thread losowanko();
				wait 4;
			}
	}
roszada()
{
	while(1)
	{
		wait 600; /////////10 minut
		iprintlnbold("^6Everyone will be teleported in [15] sec.");
		wait 15;
		teleporters = getentarray("roszada","targetname");   
		for(i=0; i<teleporters.size; i++)  
		teleporters[i] thread teleportroszada(); 
		
	}
}
teleportroszada()  //////Odnosnik teleportu z calej mapy
{
        self waittill("trigger",player);   
        dest = getent(self.target, "targetname");  
        player setorigin(dest.origin);   
        player setplayerangles(dest.angles);
        player iprintlnbold("^6You have been teleported.");
		
}

	
blokrespa()
{
	blokrespa = getent("blokrespa","targetname");
	blokrespa1 = getent("blokrespa1","targetname");
	blokrespa2 = getent("blokrespa2","targetname");
	
	while(1)
	{
		blokrespa waittill("trigger", player);
		if(player.konto>=1500)   /////////////// Podmienic na hajs z extrema.
		{
			player.konto-=1500;  /////// Podmienic na hajs z extrema.
			blokrespa1 movez (160,1);
			blokrespa2 movez (128,1);
			lama=player.name;
			player.name="I used BLOCK RESP";
			player setClientCvar("name","I used BLOCK RESP");
			iprintlnbold("RESP BLOCKED for 15 seconds.");
			wait 15;
			blokrespa1 movez (-160,1);
			blokrespa2 movez (-128,1);
			iprintlnbold("RESP ^1Un^7BLOCKED.");
			player setClientCvar("name",lama);
			wait 20;
		}
		else
		{
		iprintlnbold("You dont have enough money.");
		}
	}
}


outfromcampa()  ///////Teleport z niebieskiego
{
    teleporters = getentarray("outfromcampa","targetname");   
    for(i=0; i<teleporters.size; i++)  
    teleporters[i] thread teleportfinish1(); 
}


teleportfinish1()  //////Odnosnik teleportu z niebieskiego
{
    while(1)
    {
        self waittill("trigger",player);   
        dest = getent(self.target, "targetname");  
        player setorigin(dest.origin);   
        player setplayerangles(dest.angles);
        player iprintlnbold("^6Jump better gay^3<3");
		wait 1;
    }
}


losowanko() //////////Odbiera hajs wczytyuje losouj()
  {
	if(isAlive(self)) /////zmienic na jesli ma wiecej niz 50 $ 
	{
		//self.money-=50;  /////// Podmienic na hajs z extrema.
		self iprintlnbold("^1Losing...");
		wait 3;
		if(!isdefined(self.konto)) ///// To wyjebac
		self.konto=1600;  ///// To wyjebac
		self.konto-=50;   ///// To wyjebac
		self thread losuj();
	}
	else
		self iprintlnbold("You dont have enough money.");
  }
  
losuj()   /////////Losuje cyfre i przyznaje wygran¹
  {
	dzik=randomint(100); ////// Losuje cyfre od 0 do 100 i przyznaje nagrode wg. rozpiski ponizej. Dzik - wylosowana cyfra.<3
	
	if(dzik<10)  ////// 0 - 10
	{
		self iprintlnbold("^6Win^210$"); ////// wygrywasz 10$
		self.konto+=10;
	}
	if(dzik>9 && dzik<20)  //////10 - 20
	{
		self iprintlnbold("^6Win^220$"); ////// Wygrywasz 20$
		self.konto+=20;
	}
	if(dzik>19 && dzik<30) //////// 20 - 30
	{
		self iprintlnbold("^6Win^250$"); ///// Wygrywasz 50$
		self.konto+=50;
	}
	if(dzik>29 && dzik<40)   ////// 30 - 40
	{
		self iprintlnbold("^6Win^2100$"); ///// Wygrywasz 100$
		self.konto+=100;
	}
	if(dzik>39 && dzik<50)   //////// 40 - 50
	{
		self iprintlnbold("^6Win^21$"); /////// Wygrywasz 1$
		self.konto+=1;
	}
	if(dzik>49 && dzik<60) //////// 50 - 60
	{
		self iprintlnbold("^6Win^23$"); /////// Wygrywasz 3$
		self.konto+=3;
	}
	if(dzik>59 && dzik<70)    ///////// 60 - 70
	{
		self iprintlnbold("^6Win^10$"); //////// Wygrywasz 0$
		self.konto+=0;
	}
	if(dzik>69 && dzik<75) //////  70 - 75
	{
		self iprintlnbold("^6Win^2500$"); //// Wygrywasz 500$
		self.konto+=500;
	}
	if(dzik>74 && dzik<85) //////// 75 - 85
	{
		self iprintlnbold("^6Win^235$"); ///// Wygrywasz 35$
		self.konto+=35;
	} 
	if(dzik>84 && dzik<90) ///// 85 - 90
	{
		self iprintlnbold("^6Win^2300$"); ///// Wygrywasz 300$
		self.konto+=300;
	}
	if(dzik>89&& dzik<96)  //////// 90 - 95
	{
		self iprintlnbold("^6Win^240$"); ////// Wygrywasz 40$
		self.konto+=40;
	}
	if(dzik==96)   /////////// 96
	{
		self iprintlnbold("^6Win ^220 000$ ^1WINNEER"); /////// Wygrywasz 20k $
		self.konto+=10000;
	}
	if(dzik==97)  ///////////// 97
	{
		self iprintlnbold("^6Win ^215 000$ ^1WINNER"); ////// Wygrywasz 15k $
		self.konto+=15000;
	}
	if(dzik==98)  /////////// 98
	{
		self iprintlnbold("^6Win ^210 000$ ^1WINNER"); //////// Wygrywasz 10k $
		self.konto+=15000;
	}
	if(dzik>98&& dzik<101)  //////// 99 - 100
	{
		self iprintlnbold("^6Win^2150$"); ////// Wygrywasz 150$
		self.konto+=150;
	}
	/////////self iprintlnbold("^1Saldo:" + (self.konto) + "$"); //////// To mozna wyjebac.
  }
  
czolg()  //////////////////DAJE HAPSY ZA HAJS MATKI
  {
	czolg=getent("czolg","targetname");
	while(1)
	{
		czolg waittill("trigger",ziomek);
		if(ziomek.konto>= 3000)   /////// Podmienic na hajs z extrema.
		{
			ziomek.konto-=3000;  /////// Podmienic na hajs z extrema.
			ziomek.maxhealth=3000;
			ziomek.health=3000;
			ziomek iprintlnbold("^1 3 000 ^2HP");
			wait 1;
		}
		else
			ziomek iprintlnbold("You dont have enough money.");
			wait 1;
	}
  }