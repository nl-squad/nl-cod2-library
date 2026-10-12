#include blanco\utils;

main()
{
	ambientPlay("ambient_france_nl");

	if (!isDefined(level.registerStage))
	{
		for (stage = 2; stage <= 6; stage += 1)
		{
			moveHatches(stage, 1, 0.05);
			level thread runElevator(stage);
		}
		return;
	}

	[[ level.registerStage ]](2, level.HUNTERS_AT_MOST, 14);
	[[ level.registerStage ]](3, level.HUNTERS_AT_MOST, 10);
	[[ level.registerStage ]](4, level.HUNTERS_AT_MOST, 7);
	[[ level.registerStage ]](5, level.HUNTERS_AT_MOST, 4);
	[[ level.registerStage ]](6, level.HUNTERS_AT_MOST, 2);

	for (stage = 2; stage <= 6; stage += 1)
		[[ level.registerStageAction ]](stage, ::openStage, ::closeStage);
}

openStage(stageAction)
{
	stage = stageAction.stage;
	if (stage == 6)
		iPrintlnBold("^2Roof Opened");
	else
		iPrintlnBold("Floor ^3" + (stage - 1) + " ^2Opened");

	level thread runElevator(stage);
	moveHatches(stage, 1, 3);
	wait 3;

	[[ level.markStageActionAsDone ]](stageAction);
}

closeStage(stageAction)
{
	stage = stageAction.stage;
	level notify("stopElevator" + stage);

	elevators = getEntArray("elevator" + stage, "targetname");
	for (i = 0; i < elevators.size; i += 1)
		elevators[i] moveTo(elevators[i].baseOrigin, 2);

	moveHatches(stage, -1, 2);
	wait 2;

	[[ level.markStageActionAsDone ]](stageAction);
}

moveHatches(stage, direction, time)
{
	slide = 168 * direction;
	moveHatchGroup("hatch" + stage + "_xp", (slide, 0, 0), time);
	moveHatchGroup("hatch" + stage + "_xn", (0 - slide, 0, 0), time);
	moveHatchGroup("hatch" + stage + "_yp", (0, slide, 0), time);
	moveHatchGroup("hatch" + stage + "_yn", (0, 0 - slide, 0), time);
}

moveHatchGroup(targetname, offset, time)
{
	hatches = getEntArray(targetname, "targetname");
	for (i = 0; i < hatches.size; i += 1)
		hatches[i] moveTo(hatches[i].origin + offset, time);
}

runElevator(stage)
{
	level endon("stopElevator" + stage);

	elevators = getEntArray("elevator" + stage, "targetname");
	if (elevators.size == 0)
		return;

	elevator = elevators[0];
	if (!isDefined(elevator.baseOrigin))
		elevator.baseOrigin = elevator.origin;

	while (true)
	{
		wait 3;
		elevator moveTo(elevator.baseOrigin + (0, 0, 256), 4, 0.5, 0.5);
		elevator waittill("movedone");
		wait 3;
		elevator moveTo(elevator.baseOrigin, 4, 0.5, 0.5);
		elevator waittill("movedone");
	}
}
