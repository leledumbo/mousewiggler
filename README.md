# MouseWiggler

![icon](https://github.com/leledumbo/mousewiggler/assets/270400/65bba630-5f95-462f-b5b7-0d4b632b740a)

is a simple application to periodically send message to make mouse move to prevent screen saver from executing (could be useful in a limited environment like a computer lab with auto logoff :stuck_out_tongue_winking_eye:).

# How to run
Either build the project or download the executables then just run it like any other GUI app you know.

# How to use
Upon execution, you will be greeted by the following dialog:

![image](https://github.com/leledumbo/mousewiggler/assets/270400/1406d9a3-90d2-49de-b178-20f7bff6df78)

There will be no window on the taskbar but an icon is there on the system tray.

Fill in the "every" spin edit to configure the interval between the wiggles. Click Apply then the status text should be like this:

![image](https://github.com/leledumbo/mousewiggler/assets/270400/9a0137ec-604d-4fbd-8742-1f43cf3d8e10)

Click Stop to, well, stop it. Click Exit to, well, exit.

You can close the window and it will minimize to the system tray. Hovering the tray icon will give you something like this:

![image](https://github.com/leledumbo/mousewiggler/assets/270400/8dc02385-bacc-4c37-8c81-2f46d95bd844)

(left) Clicking on the icon will bring back the dialog while right clicking will allow you to exit the app right from the tray.

# How to build
1. Install [Lazarus](https://www.lazarus-ide.org/), any recent version will do, the code was even written with whatever Lazarus version available in 2015.
2. Open mousewiggler.lpi with it
3. Optionally select a build mode (should default to Release)
4. Press Run->Build (Ctrl+F9)

The executable will be created in the same folder as the source code. This is a portable, standalone application you can move anywhere you want, no other files are necessary.
