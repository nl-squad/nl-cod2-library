main()
{
	thread wall();
	thread wallL();
	thread text();
	
	ambientPlay("ambient_africa_nl");
	
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

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Bozzy & zieqa");
	wait 0.1;
	iPrintlnBold("in April 2024"); 
}

