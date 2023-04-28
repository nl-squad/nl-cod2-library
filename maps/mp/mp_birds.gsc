main()
{
	maps\mp\_load::main();
	thread text();
	
	ambientPlay("avard_ambient_birds");
	
	setExpFog(0.1, 0.55, 0.6, 0.55, 0);
}

text()
{
    while (true)
    {
        wait 30;
        iPrintlnBold("Dupa dusznika");
    }
}