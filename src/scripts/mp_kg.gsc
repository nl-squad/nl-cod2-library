main()
{

	level._effect["spot2"] = loadfx("fx/misc/spotlight_decoytown.efx");
	
	maps\mp\_fx::loopfx("spot2", (-488, 152, 240), 30);
	maps\mp\_fx::loopfx("spot2", (600, 152, 240), 30);

	thread text();
	
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by K1r@");
	wait 1.5;
	iPrintlnBold("in October 2016");
}