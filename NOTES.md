# NOTES.md

This is where I am at with this project...

LEFT OFF ( version "1.0.d.001" )
* FIXED STYLE ISSUE! (I hope)... see "STYLE FIX" below...

NEXT
* clean up console.log messages
    + especially in the new classes (Date and Stored)
* add last date used to storage   

FUTURE
* add screen transition ?
* figure out canPop() (so app doesn't exit unintentionally on back button)
* add more common widgets (dialogs, spinner?)
* add "factory reset"

NOTES
When I added scaling, I moved the initApp() call to main.dart, so I can modify the fonts and other elements (like buttons) in the themeData.

It is a good idea to google themeData and see what else I can stick in there (and remove from the Start, End and Debug pages...)

STYLE FIX
For unknown reasons, sometimes the app would not detect the device width.  But it only happened after it was initially loaded 1x. Sooo....
If the width is grabbed successfully, I store it locally.  Then, if the the width is ever not detected, it uses the locally stored value.  (If both methods give zeroes, I throw a clear error on the HintPage.)

HISTORY
* made drawer scale
* extracted appbar (as preferredSize a widget)
* changed _pageName to _fileName for debugging 
* removed many comments
