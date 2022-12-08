# NOTES.md

This is where I am at with this project...

LEFT OFF ( version "1.0.c.014" )
* added quit
* added Date class, and timestamp on init load

NEXT
* NEW APPROACH: Use Storage class!
    + when size comes up 0.0, see if last size is stored
    + if it is, use that!

* safe area?
* see if I can move more styling to main.dart (themeData)
* add other common classes (storage, date, etc.)

FUTURE
* add screen transition ?
* figure out canPop() (so app doesn't exit unintentionally on back button)
* add more common widgets (dialogs, spinner?)
* add "factory reset"

NOTES
When I added scaling, I moved the initApp() call to main.dart, so I can modify the fonts and other elements (like buttons) in the themeData.

It is a good idea to google themeData and see what else I can stick in there (and remove from the Start, End and Debug pages...)

HISTORY
* made drawer scale
* extracted appbar (as preferredSize a widget)
* changed _pageName to _fileName for debugging 
* removed many comments
