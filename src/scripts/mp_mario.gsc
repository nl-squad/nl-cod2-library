#include blanco\utils;

main()
{
	ambientPlay("ambient_bunker_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
    thread rotation();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Mynek");
	iPrintlnBold("in September 2026");
}

rotation()
{
	star1 = getEnt("star1", "targetname");
	star2 = getEnt("star2", "targetname");
	star3 = getEnt("star3", "targetname");
	star4 = getEnt("star4", "targetname");
	star5 = getEnt("star5", "targetname");
	star6 = getEnt("star6", "targetname");
	star7 = getEnt("star7", "targetname");
	star8 = getEnt("star8", "targetname");
	star9 = getEnt("star9", "targetname");
	star10 = getEnt("star10", "targetname");
	while(true)
	{
		star1 rotateyaw(90, 4);
		star2 rotateyaw(90, 4);
		star3 rotateyaw(90, 4);
		star4 rotateyaw(90, 4);
		star5 rotateyaw(90, 4);
		star6 rotateyaw(90, 4);
		star7 rotateyaw(90, 4);
		star8 rotateyaw(90, 4);
		star9 rotateyaw(90, 4);
		star10 rotateyaw(90, 4);
		star1 waittill("rotatedone");
	}
}





