*** IMPORTANT INFO ABOUT THE FILES:

You can manually edit the user_position.json if desired, 
but we advice against touching the files named "default" and "preset", as these files won't be autogenerated by the game.

The system for resetting to default won't use these files in the future, it's just a temporary solution.

------------------------------------------------------------------------------------------------------------
*** IMPORTANT INFO ABOUT X AND Y POSITIONS:

Keep in mind that not all of these objects share the same X and Y positions. 
Example:
To get the scoreText in the middle of the screen on the X axis, then the value needs to be "0",
meanwhile the judgementCounter needs to have a value of 565 to be in the middle.

All objects will use a normalized value in the future so it's even easier to determine the positions, just gotta find a way to do it without breaking custom charts and lua scripts ;)