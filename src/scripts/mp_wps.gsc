main()
{

	thread object();
	thread text();
	
}

object()
{
    object = getEnt("object", "targetname");    
    
    while(true)
        {
            object rotateyaw(360, 5);
            object waittill("rotatedone");
        }
} 

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by K2o");
	wait 1;
	iPrintlnBold("in September 2014");
}