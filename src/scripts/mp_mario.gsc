#include blanco\utils;

main()
{
	ambientPlay("ambient_bunker_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);

	for (i = 1; i <= 10; i += 1)
		rotation(i);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Mynek");
	iPrintlnBold("in September 2026");
}

rotation(num)
{
	star = getEnt("star" + num, "targetname");
	star rotateYaw(43200, 1200);
}





