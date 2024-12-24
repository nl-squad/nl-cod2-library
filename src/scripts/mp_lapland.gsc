main()

{
	thread text();

	ambientPlay("ambient_russia_nl");

    level._effect["fire"] = loadfx("fx/props/barrel_fire2.efx");
	
    maps\mp\_fx::loopfx("fire", (-848, -544, 8), 1);
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by zazu");
	wait 0.1;
	iPrintlnBold("in December 2012"); 
}