main()
{
	maps\mp\_load::main();
	thread text();
	thread myfog();
}

text()
{
    while (true)
    {
        wait 30;
        iPrintlnBold("test");
    }
}

myfog()
{
    while (true)
    {
		setExpFog(0.0001, 0.2, 0.0, 0.0, 0.001);
        wait 10;
		setExpFog(0.0001, 0.0, 0.2, 0.0, 0.001);
        wait 10;
		setExpFog(0.0001, 0.0, 0.0, 0.2, 0.001);
        wait 10;
    }
}