main()
{
	ambientPlay("ambient_russia_nl");

	thread text();
}

text()
{
	wait 12 * 60;
    iPrintlnBold("Map was made by Avard & Dusza");
    wait 0.1;
    iPrintlnBold("in June 2024"); 
}