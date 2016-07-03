@echo off

attrib -R "%UserProfile%\Documents\The Witcher 3\input.settings"
type "input.settings" >> "%UserProfile%\Documents\The Witcher 3\input.settings"
attrib +R "%UserProfile%\Documents\The Witcher 3\input.settings"

echo Attempted to inject input.settings.
echo If you have no in-game Key Bindings for Phoenix Rage
echo then you will need to install it manually instead.
echo.
echo.
pause 