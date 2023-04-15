# Parametric OpenScad Movement tray generator

This is an [OpenScad](http://openscad.org/index.html) script that can generate a movement tray to adapt the Old World 20mm square base to the new 25mm square base system.

The script is absolutely parametric and can generate a custom tray for rows/cols tray.

# How to use

You can use the script and run with [OpenScad](http://openscad.org/index.html) desktop app.

You can generate tray from cli, for example:

```openscad -o tray.stl -D "cols=6;rows=3;" paremetric_tray_generator.scad```

Will generate a tray with 6 cols and 3 rows calculated for default 25mm square base and 20mm insets, the tray will be 150x75 mm.
