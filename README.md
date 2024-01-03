# Parametric OpenScad Movement tray generator
![Movement tray generator](main.png "Movement tray generator")

This is an [OpenScad](http://openscad.org/index.html) script that can generate a movement tray to adapt the Old school warhammer 20mm square base to the new Old World 25mm square base system.

The script is absolutely parametric and can generate a custom tray for rows/cols tray.

# How to use

You can use the script and run it with [OpenScad](http://openscad.org/index.html) desktop app.

You can also generate trays from cli, for example this command:

```openscad -o tray.stl -D "cols=6;rows=3;" paremetric_tray_generator.scad```

Will generate a tray with 6 cols and 3 rows calculated for default 25mm square base and 20mm insets, the tray will be 150x75 mm.

The script can also generate a tray to adapt round bases setting ```isRound_adapted``` to true (default is false)

If you use different values for width and lenght you can generate also adapters for cavalry

## Important note

When setting the value for ```adapted_base_width```and ```adapted_base_length``` add 1mm of tolerance eg: set 21mm for an old 20mm square base. The final "fit" depends also on you printer settings and calibration.  

### Parameters

```cols```  Number of columns for this tray

```rows``` Number of rows for this tray

```height``` heigh (thickness) of the tray

```new_base_width```  new base width 

```new_base_length```  new base length  

```adapted_base_width``` existing base width of adapted models

```adapted_base_length``` existing base length of adapted models

```height_offset``` minimum bottom height (thickness) of the insets for the bases

```inset``` Inset of the top of the tray: greater the value greater the slope of the tray

```isRound_adapted``` if base adapted are round (in this case adapted_base_size is considered as the diameter of the round base)

```magnets_height``` magnets height (if greater than zero will generate the insets)

```magnets_radius``` magnets radius


## Samples

### Square 20mm to 25mm sample:

<img src="sample_tray.png" alt= “sample” width="400" >

### Round 25mm to 25mm sample:

<img src="main_round_02.png" alt= “sample” width="600" >

### Rectangular 25x50mm to 30x60mm sample:

<img src="rectangular.png" alt= “sample” width="600" >

### Magnets 3x1mm insets

<img src="magnets.png" alt= “sample” width="600" >


## License

Parametric OpenScad movement tray generator is under [Apache 2
license](http://www.apache.org/licenses/LICENSE-2.0.html).


