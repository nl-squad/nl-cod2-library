#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	level RegisterDelayCallback("slowlySecret1", ::secret1, 120);
	level RegisterDelayCallback("slowlySecret2", ::secret2, 420);
	level RegisterDelayCallback("slowlySecret3", ::secret3, 720);
	level RegisterDelayCallback("slowlySecret4", ::secret4, 1020);
}

ownerCredits()
{
	iPrintlnBold("Map was made by Megan");
	iPrintlnBold("in August 2023");
}

secret1()
{
	secret1 = getEnt("secret1", "targetname");
	iPrintlnBold("Box #1 ^2Available");
	secret1 moveX(48, 2);
}

secret2()
{
	secret2 = getEnt("secret2", "targetname");
	iPrintlnBold("Box #2 ^2Available");
	secret2 moveY(-48, 2);
}

secret3()
{
	secret3 = getEnt("secret3", "targetname");
	iPrintlnBold("Box #3 ^2Available");
	secret3 moveY(-48, 2);
}

secret4()
{
	secret4 = getEnt("secret4", "targetname");
	iPrintlnBold("Box #4 ^2Available");
	secret4 moveY(-48, 2);
}