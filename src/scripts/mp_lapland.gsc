main()

{
	thread text();

	ambientPlay("ambient_russia_nl");

    level._effect["fire"] = loadfx("fx/props/barrel_fire2.efx");
	level._effect["smoke"] = loadfx("fx/smoke/damaged_vehicle_smoke.efx");
	
	
    maps\mp\_fx::loopfx("fire", (-872, -568, -96), 1);
	maps\mp\_fx::loopfx("smoke", (-872, -568, -96), 1);
	maps\mp\_fx::loopfx("fire", (392, -104, -96), 1);
	maps\mp\_fx::loopfx("smoke", (392, -104, -96), 1);
	maps\mp\_fx::loopfx("fire", (760, -96, -96), 1);
	maps\mp\_fx::loopfx("smoke", (760, -96, -96), 1);

}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by zazu");
	wait 0.1;
	iPrintlnBold("in December 2012"); 
}