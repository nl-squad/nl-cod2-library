#include blanco\utils;

main()
{
	ambientPlay("ambient_russia_nl");
	thread text();
	if (!isDefined(level.registerStage))
	{
		thread unlockGate();
		return;
	}

	[[ level.registerStage ]](2, level.ZOMBIES_AT_LEAST, 14);

	[[ level.registerStageAction ]](2, ::unlockGate, ::lockGate);
	level RegisterDelayCallback("ownerCredits", ::ownerCredits, 12 * 60);
}

unlockGate(dynamicMapPart)
{
	iPrintlnBold("^7Gate has been ^1closed");
	gate = getEnt("gate", "targetname");
	gate moveZ(224, 3);
	gate waittill("movedone");

	if (isDefined(level.markStageActionAsDone))
		[[ level.markStageActionAsDone ]](dynamicMapPart);
}

lockGate(dynamicMapPart)
{
	gate = getEnt("gate", "targetname");
	gate moveZ(-224, 3);
	gate waittill("movedone");

	if (isDefined(level.markStageActionAsDone))
		[[ level.markStageActionAsDone ]](dynamicMapPart);
}


ownerCredits()
{
	iPrintlnBold("Map was made by Avard & Dusza");
	iPrintlnBold("in June 2014");
}