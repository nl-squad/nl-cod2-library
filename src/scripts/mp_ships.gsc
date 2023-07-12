main()
{
    thread text();
    
    setExpFog(0.01, 0.01, 0.01, 0.01, 0);
    setCullFog(0, 2500, 0.01, 0.01, 0.01, 0);
    ambientPlay("ambient_russia_nl");
}

text()
{
    wait 12 * 60;
    iPrintlnBold("Map was made by Avard");
	wait 0.1;
	iPrintlnBold("in November 2017");  
}

