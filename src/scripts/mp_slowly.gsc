main()

{
	thread secret1();
	thread secret2();
	thread secret3();
	thread secret4();
	thread text();

	ambientPlay("ambient_france_nl");
}

secret1()
{
    secret1 = getEnt("secret1", "targetname"); 
    
    wait 120;  
    iPrintlnBold("Box #1 ^2Available"); 
    
    secret1 moveX(54, 2);  
    secret1 waittill("movedone"); 
}

secret2()
{
    secret2 = getEnt("secret1", "targetname"); 
    
    wait 420;  
    iPrintlnBold("Box #2 ^2Available"); 
    
    secret2 moveY(-54, 2);  
    secret2 waittill("movedone"); 
}

secret3()
{
    secret3 = getEnt("secret1", "targetname"); 
    
    wait 420;  
    iPrintlnBold("Box #3 ^2Available"); 
    
    secret3 moveY(-54, 2);  
    secret3 waittill("movedone"); 
}

secret4()
{
    secret4 = getEnt("secret4", "targetname"); 
    
    wait 420;  
    iPrintlnBold("Box #4 ^2Available"); 
    
    secret4 moveY(-54, 2);  
    secret4 waittill("movedone"); 
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by M3gan");
	wait 0.1;
	iPrintlnBold("in August 2023"); 
}