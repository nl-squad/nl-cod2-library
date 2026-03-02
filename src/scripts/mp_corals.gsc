#include blanco\utils;

main()
{
	ambientPlay("ambient_africa_nl");
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
	thread wall();
	thread wallL();
}

ownerCredits()
{
	iPrintlnBold("Map was made by Bozzy & zieqa");
	iPrintlnBold("in April 2024"); 
}

wall()
{
    wall = getEnt("wall", "targetname"); 
    
    wait 180;
    wall moveZ(-60, 2);  
    wall waittill("movedone"); 
}

wallL()
{
    wallL = getEnt("wallL", "targetname"); 
    
    wait 180;
	iPrintlnBold("Lugers are ^2Available");	
    wallL moveZ(-60, 2);  
    wallL waittill("movedone"); 
}

