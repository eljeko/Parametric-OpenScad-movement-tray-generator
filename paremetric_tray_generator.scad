//Number of columns for this tray
cols = 6;
//Number of rows for this tray
rows = 7;
//heigh (thickness) of this tray
height = 5;
// square base size 
base_size = 25;
// square base size of adapted models
adapted_base_size = 20;
//minimum bottom height (thickness) of the insets for the bases
height_offset = 2;
//Inset of the top of the tray: greater the value greater the slope of the tray
inset = 1;
//if base adapted are round (in this case adapted_base_size is considered as the diameter of the round base)
isRound_adapted = false;

module tray(cols, rows, height, base_size, adapted_base_size, inset) {
    
    b_total_cols = base_size * cols;
    b_total_rows = base_size * rows;
    
    t_total_cols = base_size * cols - inset *2;
    t_total_rows = base_size * rows - inset *2;
    
 
    polyhedron(
        points=[
                [0,0,0],                        //base bottom left
                [b_total_cols,0,0],             //base bottom right
                [b_total_cols,b_total_rows,0],  //base top right
                [0,b_total_rows,0],             //base top left
    
                [inset,  inset,   height],                              //surface bottom left
                [inset + t_total_cols, inset,  height],                 //surface bottom right
                [inset + t_total_cols, inset + t_total_rows, height],   //surface top right
                [inset,   inset + t_total_rows,  height]                //surface top left
            ],
        faces =[
                    [0,1,2,3],
                    [4,5,1,0],
                    [5,6,2,1],
                    [6,7,3,2],
                    [7,4,0,3],
                    [7,6,5,4]
                ]
    );
        

   
}

module adapted_base_holes(cols, rows, height_offset, base_size, adapted_base_size,isRound_adapted) {
    
    gap = base_size - adapted_base_size;
    echo(gap)
    for (c = [0:cols-1]){
        for (r = [0:rows-1]){
            translate( 
                        [gap/2 + (c*adapted_base_size) + (c*gap), //row
                        gap/2 + (r*adapted_base_size) + (r*gap), //col
                        height_offset]
            )                       
            cube(size = adapted_base_size);            
        }
    }
}

module adapted_base_holes_round(cols, rows, height_offset, base_size, adapted_base_size) {
    
    gap = base_size - adapted_base_size;
    echo(gap)
    for (c = [0:cols-1]){
        for (r = [0:rows-1]){
            translate( 
                        [base_size/2 + base_size * c , //row
                        base_size/2 + base_size * r, //col
                        height_offset]
            )
            cylinder(r = adapted_base_size/2, h = height);
        }
    }
}

difference(){
    tray(cols, rows, height, base_size, adapted_base_size, inset);
    
    if(!isRound_adapted){
        adapted_base_holes(cols, rows, height_offset, base_size, adapted_base_size, isRound_adapted);
    }else{
        adapted_base_holes_round(cols, rows, height_offset, base_size, adapted_base_size);
    }
}
