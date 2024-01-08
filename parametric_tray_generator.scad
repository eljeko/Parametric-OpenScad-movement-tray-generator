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
adapted_base_width = 21.1;
// existing base length of adapted models
adapted_base_length = 21.1;
//minimum bottom height (thickness) of the insets for the bases
height_offset = 2;
//Inset of the top of the tray: greater the value greater the slope of the tray
inset = 1;
//if base adapted are round (in this case adapted_base_width is considered as the diameter of the round base)
isRound_adapted = false;
//magnets height (if greater than 1 will generate the insets)
magnets_height = 0.1;
//magnets radius
magnets_radius = 0.1;
//if the tray is for lance formation, use only the number of rows to genrate the tray
isLanceFormation = false;
//Create a standard (non an adpater) movement tray for given new_base_length x new_base_width
createEmptyMovementTray = false;
//Put a mark to show the new base widh/length on the adapter
markBases = false;

module tray(cols, rows, height, new_base_width, new_base_length, adapted_base_width, adapted_base_length, inset, margin_for_empty_tray) {
    
        b_total_cols = (new_base_width * cols) + margin_for_empty_tray;
        b_total_rows = (new_base_length * rows)+ margin_for_empty_tray;
        
        t_total_cols = (new_base_width * cols - inset *2) + margin_for_empty_tray;
        t_total_rows = (new_base_length * rows - inset *2) + margin_for_empty_tray;
        
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

//this module will create the hole in the "empty" classic movement tray
module empty_tray_hole(cols, rows, height_offset, new_base_width,  new_base_length, adapted_base_width, adapted_base_length, inset, margin_for_empty_tray) {
    
    t_total_cols = (new_base_width * cols ) ;
    t_total_rows = (new_base_length * rows);

 
    translate( 
                [margin_for_empty_tray/2, //row
               margin_for_empty_tray/2, //col
                height_offset]
    )                       
    cube([t_total_cols,t_total_rows+margin_for_empty_tray, 30]);            
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
}surface("/var/folders/0m/rfm_wx490_ncm2nkym8m87qw0000gp/T/TemporaryItems/NSIRD_screencaptureui_oOBpAq/Screenshot 2024-01-06 at 16.00.00.png");


module magnets_holes (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset) {
    
    for (c = [0:cols-1]){
        for (r = [0:rows-1]){
            translate( 
                        [new_base_width/2 + new_base_width * c , //row
                        new_base_length/2 + new_base_length * r, //col
                        height_offset-magnets_height+0.01]
            )
            cylinder(r = magnets_radius/2, h = magnets_height+0.01,$fn=20);
           
        }
    }
}

/// BASE MARKER
module mark_new_bases (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset) {
    color ([0.9, 0.4, 0.4])
                    {
        for (c = [1:cols-1]){
            translate( 
                [new_base_width * c-inset/2 , //col
                 new_base_length * 0, //row
                 height+height/5]
            )

            rotate([-90,0,0]) {             
                linear_extrude(new_base_length*rows) {
                     polygon(points=[[0,0],[1,0],[inset/2,(height-height_offset)]], paths=[[0,1,2]]);
                }
            }           
        }
        
        
        for (r = [1:rows-1]){
            translate( 
                    [new_base_width * 0 , //col
                     new_base_length * r-inset/2, //row
                     height+height/5]
            )
            rotate([90,90,90]) { 
                linear_extrude(new_base_width*cols) {
                    polygon(points=[[0,1],[(height-height_offset),inset/2],[0,0]], paths=[[0,1,2]]);
                }
            }
        }
    }
}

module lance_formation (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset,  inset, margin_for_empty_tray) {
    
    
    for (thisRow = [0:rows-1]){    

        translate( [0,thisRow*new_base_length,0]){
            for (thisCol = [0:thisRow]){    
                translate( [(new_base_width/2)*thisRow-(new_base_width*thisCol),0,0]){
                    //color([0.4, rands(0.01, 1,1)[0],rands(0.01, 1,1)[0] ])
                    color ([0.5, 0.5, 0.5])
                    {
                        lance_sloped_slot(thisCol+1, thisRow+1 == rows, height, new_base_width, new_base_length, adapted_base_width, adapted_base_length, inset, margin_for_empty_tray);
                    }    
                }
            }
        }
    }     
}

////////////////////////////////
// LANCE FORMATION            //
////////////////////////////////
module lance_sloped_slot(cols, isLastRow, height, new_base_width, new_base_length, adapted_base_width, adapted_base_length, inset, margin_for_empty_tray) {
    
        rows = 1;
    
        b_total_cols = (new_base_width * cols) + margin_for_empty_tray;
        b_total_rows = (new_base_length * rows)+ margin_for_empty_tray;
        
        t_total_cols = (new_base_width * cols - inset *2) + margin_for_empty_tray;
        t_total_rows = (new_base_length * rows - inset *2) + margin_for_empty_tray;

    

        polyhedron(
            points=[
                    [0,0,0],                        //base bottom left
                    [b_total_cols,0,0],             //base bottom right
                    [b_total_cols,b_total_rows,0],  //base top right
                    [0,b_total_rows,0],             //base top left
        
                    [inset,  inset,   height],                              //surface bottom left
                    [inset + t_total_cols, inset,  height],                 //surface bottom right
                    [inset + t_total_cols,  
                        isLastRow ? inset + t_total_rows : inset*3 + t_total_rows, //if last row we set the slope otherwise we move the y of the point to reach the next row
                        height],   //surface top right
                    [inset, 
                        isLastRow ? inset + t_total_rows : inset*3 + t_total_rows,//if last row we set the slope otherwise we move the y of the point to reach the next row
                        height]//surface top left
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


module lance_formation_hole (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset) {
    
    gap_w = new_base_width - adapted_base_width;
    gap_l = new_base_length - adapted_base_length;
    
    for (thisRow = [0:rows-1]){    

        translate( [0,thisRow*new_base_length+gap_l/2,height_offset]){
            for (thisCol = [0:thisRow]){                    
                translate( [(new_base_width/2)*thisRow-(new_base_width*thisCol)+gap_w/2,0,0]){
                    color([0.7, 0.7,0.7 ]){
                        cube([adapted_base_width, adapted_base_length,height+2 ]);
                    }    
                }
            }
        }
    }     
}

//Standard movement tray
module lance_formation_tray_hole (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset, inset, margin_for_empty_tray) {
    
    gap_w = new_base_width - adapted_base_width;
    gap_l = new_base_length - adapted_base_length;
    
    for (thisRow = [0:rows-1]){    

        translate( [0,thisRow*new_base_length+margin_for_empty_tray/2,height_offset]){
            for (thisCol = [0:thisRow]){                    
                translate( [(new_base_width/2)*thisRow-(new_base_width*thisCol)+margin_for_empty_tray/2,0,0]){
                    color([0.7, 0.7,0.7 ]){
                        cube([new_base_width, new_base_length*2+margin_for_empty_tray,height+2 ]);
                    }    
                }
            }
        }
    }     
}

module lance_formation_magnets_hole (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset) {
    
    gap_w = new_base_width - adapted_base_width;
    gap_l = new_base_length - adapted_base_length;
    
    for (thisRow = [0:rows-1]){    

        translate( [0,(thisRow+1)*new_base_length-new_base_length/2,height_offset-magnets_height+0.01]){
            for (thisCol = [0:thisRow]){                    
                translate( [(new_base_width/2)*thisRow-(new_base_width*thisCol)+gap_w/2+new_base_width/2,0,0]){
                    color([0.7, 0.7,0.7 ]){
                        cylinder(r = magnets_radius/2, h = magnets_height+0.01,$fn=20);
                    }    
                }
            }
        }
    }     
}

//Ranked movement tray
if(!isLanceFormation){
    difference(){        
            color ([0.5, 0.5, 0.5]) {
                if(!createEmptyMovementTray){
                    tray(cols, rows, height, new_base_width, new_base_length, adapted_base_width, adapted_base_length, inset, 0);
                }else{
                    tray(cols, rows, height, new_base_width, new_base_length, adapted_base_width, adapted_base_length, inset, 3);
                }
            }
            color ([0.7, 0.7, 0.7]) {
                if (magnets_height > 1){
                    echo ("magnets");
                    magnets_holes (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius,height, height_offset);
                }
                if(!createEmptyMovementTray){
                    if(!isRound_adapted){
                        adapted_base_holes(cols, rows, height_offset, new_base_width, new_base_length, adapted_base_width, adapted_base_length);
                    }else{
                        adapted_base_holes_round(cols, rows, height_offset, new_base_width, new_base_length, adapted_base_width, adapted_base_length);
                    }
                }else{
                    empty_tray_hole(cols, rows, height_offset, new_base_width,  new_base_length, adapted_base_width, adapted_base_length, inset, 3);
                }
            }
            
            if(markBases){
                echo("mark it");
                mark_new_bases (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset);
            }
        
    }
}

//Lance formation movment tray
if(isLanceFormation){    
    difference(){      
        if(!createEmptyMovementTray){
            union() {
                lance_formation (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset, inset, 0);
            }
        }else{
            union() {
                lance_formation (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset, inset, 3);
            }
        }
        
        if(!createEmptyMovementTray){
            lance_formation_hole (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset);    
        }else{
            lance_formation_tray_hole(cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius, height, height_offset, inset, 3);
        }
        
        if (magnets_height > 1){
            echo ("magnets lance");
            lance_formation_magnets_hole (cols, rows,  new_base_width, new_base_length, magnets_height, magnets_radius,height, height_offset);
        }
    }
}