main()
{
	thread wall();
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

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Bozzy & zieqa");
	wait 0.1;
	iPrintlnBold("in April 2024"); 
}

