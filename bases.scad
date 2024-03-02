// Copyright 2023 Stefano Linguerri
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.¢
// See the License for the specific language governing permissions and
// limitations under the License.

//height (thickness) of this tray
height = 4;
//base width 
base_width = 25;
//base length 
base_length = 25;
//thickness of the top and sides of the base
height_offset = 1.3;
//Inset of the top of the tray: greater the value greater the slope of the tray
inset = 1;

//magnets height (if greater than 0.1 will generate the magnet holders)
magnets_height = 0.1;
//magnets diameter
magnets_diameter = 0.1;

module tray(offset, height, base_width, base_length, inset) {
    
        
        b_total_cols = (base_width);
        b_total_rows = (base_length);
        
        t_total_cols = (base_width - inset *2);
        t_total_rows = (base_length - inset *2);
        translate(
            [offset,
            offset,
            0]
        )
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

module magnets_holes (base_width, base_length, magnets_height, magnets_diameter) {
    

            translate( 
                        [base_width/2,
                        base_length/2, 
                        0]
            )
            cylinder(d = magnets_diameter, h = magnets_height+0.01,$fn=30);

}

difference(){        
         color ([0.5, 0.5, 0.5]) {
             tray(0, height, base_width, base_length, inset);
         }


        color ([0.7, 0.7, 0.7]) {            
           
            tray(height_offset, height - height_offset, base_width - (2*height_offset), base_length - (2 * height_offset), inset);
        } 
}

if (magnets_height > 0.1){
     difference() {
        magnets_holes (base_width, base_length, height - 0.1, magnets_diameter + (2 * height_offset));        
        magnets_holes (base_width, base_length, magnets_height, magnets_diameter);        
    }
}
