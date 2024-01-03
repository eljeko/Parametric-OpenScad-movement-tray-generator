// Copyright 2023 Stefano Linguerri
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

//Number of columns for this tray
cols = 6;
//Number of rows for this tray
rows = 7;
//heigh (thickness) of this tray
height = 5;
//new base width 
new_base_width = 25;
//new base length 
new_base_length = 25;
// existing base width of adapted models
adapted_base_width = 21;
// existing base length of adapted models
adapted_base_length = 21;
//minimum bottom height (thickness) of the insets for the bases
height_offset = 2;
//Inset of the top of the tray: greater the value greater the slope of the tray
inset = 1;
//if base adapted are round (in this case adapted_base_width is considered as the diameter of the round base)
isRound_adapted = false;



module tray(cols, rows, height, new_base_width, new_base_length, adapted_base_width, adapted_base_length, inset) {
    
        b_total_cols = new_base_width * cols;
        b_total_rows = new_base_length * rows;
        
        t_total_cols = new_base_width * cols - inset *2;
        t_total_rows = new_base_length * rows - inset *2;
        
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

module adapted_base_holes(cols, rows, height_offset, new_base_width,  new_base_length, adapted_base_width, adapted_base_length) {
    
    gap_w = new_base_width - adapted_base_width;
    gap_l = new_base_length - adapted_base_length;

    for (c = [0:cols-1]){
        for (r = [0:rows-1]){
            translate( 
                        [gap_w/2 + (c*adapted_base_width) + (c*gap_w), //row
                        gap_l/2 + (r*adapted_base_length) + (r*gap_l), //col
                        height_offset]
            )                       
            cube([adapted_base_width,adapted_base_length, 30]);
            
        }
    }
}

module adapted_base_holes_round(cols, rows, height_offset, new_base_width, new_base_length, adapted_base_width, adapted_base_length) {
    
    for (c = [0:cols-1]){
        for (r = [0:rows-1]){
            translate( 
                        [new_base_width/2 + new_base_width * c , //row
                        new_base_length/2 + new_base_length * r, //col
                        height_offset]
            )
            //resize([adapted_base_width,adapted_base_length]) 
            cylinder(r = adapted_base_width/2, h = height);
           
        }
    }
}

difference(){
    tray(cols, rows, height, new_base_width, new_base_length, adapted_base_width, adapted_base_length, inset);
    
    if(!isRound_adapted){
        adapted_base_holes(cols, rows, height_offset, new_base_width, new_base_length, adapted_base_width, adapted_base_length);
    }else{
        adapted_base_holes_round(cols, rows, height_offset, new_base_width, new_base_length, adapted_base_width, adapted_base_length);
    }
}
