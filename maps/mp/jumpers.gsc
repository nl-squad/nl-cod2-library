main()
{
  ents=getentarray("jump","targetname");
  for(a=0;a<ents.size;a++)
    ents[a] thread watch_jump();
}

watch_jump()
{
  while(1)
  {
    height = randomint((500)+500);
    plate = getent(self.target, "targetname");
    org = plate.origin;
    self waittill("trigger",other);
    other playsound("whoosh");
    plate movegravity((0,0,height), 1);
    wait(0.9);
    plate notsolid();
    plate.origin = org;
    plate solid();
  }
}