main()
{
	thread TeleportsInit();
	thread text();
	

	setExpFog(0.0001, 0.55, 0.6, 0.55, 0);
	// setCullFog(0, 16500, 0.55, 0.6, 0.55, 0);
	ambientPlay("ambient_france");

	setCvar("r_glowbloomintensity0", ".25");
	setCvar("r_glowbloomintensity1", ".25");
	setcvar("r_glowskybleedintensity0",".3");	
}	

TeleportsInit()
{	
	entTransporter = getentarray("enter","targetname");
	if(isdefined(entTransporter))
	{
		for(lp=0;lp<entTransporter.size;lp=lp+1)
		entTransporter[lp] thread Transporter();
	}
}

Transporter()
{
	while(true)
	{
		self waittill("trigger",other);
		entTarget = getent(self.target, "targetname");

		wait(0.10);
		other setorigin(entTarget.origin);
		other setplayerangles(entTarget.angles);
		wait(0.10);
	}
}

text()
{
	wait 12 * 60;
	iPrintlnBold("Map was made by Sluw");
	wait 1;
	iPrintlnBold("in June 2008");
}
