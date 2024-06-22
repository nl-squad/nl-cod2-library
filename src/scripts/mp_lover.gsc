main()
{
    thread tp();
    thread text();

    ambientPlay("ambient_france_nl");
}

tp()
{
    teleporters = getentarray("tp", "targetname");
    for(i = 0; i < teleporters.size; i++)
    {
        teleporters[i] thread teleport();
    }
}

teleport()
{
    dest = getent(self.target, "targetname");
    if(!isDefined(dest))
    {
        wait 15;
        iPrintlnBold("^1MaxDamage is a thief");
        return;

    }

    while(1)
    {
        self waittill("trigger", player);

        player setOrigin(dest.origin);
        player setPlayerAngles(dest.angles);
    }
}

text()
{
    wait 12 * 60;
    iPrintlnBold("Map was made by Bozzy and zieqa");
    wait 0.1;
    iPrintlnBold("in June 2024");
}