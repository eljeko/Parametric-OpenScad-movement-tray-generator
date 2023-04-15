# Parametric OpenScad Movement tray generator

This is an [OpenScad](http://openscad.org/index.html) script that can generate a movement tray to adapt the Old school warhammer 20mm square base to the new Old World 25mm square base system.

The script is absolutely parametric and can generate a custom tray for rows/cols tray.

# How to use

You can use the script and run it with [OpenScad](http://openscad.org/index.html) desktop app.

You can also generate trays from cli, for example this command:

```openscad -o tray.stl -D "cols=6;rows=3;" paremetric_tray_generator.scad```

Will generate a tray with 6 cols and 3 rows calculated for default 25mm square base and 20mm insets, the tray will be 150x75 mm.

The script can also generate a tray to adapt round bases setting ```isRound_adapted``` to true (default is false)

### Parameters

```cols```  Number of columns for this tray

```rows``` Number of rows for this tray

```height``` heigh (thickness) of the tray

```base_size```  square base size 

```adapted_base_size``` square base size of adapted models

```height_offset``` minimum bottom height (thickness) of the insets for the bases

```inset``` Inset of the top of the tray: greater the value greater the slope of the tray

```isRound_adapted``` if base adapted are round (in this case adapted_base_size is considered as the diameter of the round base)
