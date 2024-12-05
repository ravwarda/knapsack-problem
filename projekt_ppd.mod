/*********************************************
 * OPL 22.1.1.0 Model
 * Author: RafałWarda(272419)
 * Creation Date: Apr 30, 2024 at 9:32:40 AM
 *********************************************/

 int ts = 4; // size of the board
 
 int bn = 3; // amount of blocks to place
 int blocks[1..bn][1..2] = [ // size of each block
 [2, 3],
 [3, 2],
 [3, 1]
 ];
 

 // array for decision where to place upper left corner of each block
 dvar boolean bps[1..ts][1..ts][1..bn];
 // decision for each block rotation (1 means that block is rotated 90 degrees)
 dvar boolean rot[1..bn];
 // array for acual placement of each block
 dvar boolean tab[1..ts][1..ts][1..bn];
 
 
 maximize sum(i in 1..ts, j in 1..ts, k in 1..bn) tab[i][j][k];
 
 subject to{
   // number of ones in tab must be equal to coresponding block size
   sum(i in 1..ts, j in 1..ts, k in 1..bn) bps[i][j][k] * blocks[k][1] * blocks[k][2] == sum(i in 1..ts, j in 1..ts, k in 1..bn) tab[i][j][k];
   forall(k in 1..bn) {
     sum(i in 1..ts, j in 1..ts) bps[i][j][k] <= 1; // must be only one block per dimention
   }
   forall(i in 1..ts, j in 1..ts) {
     sum(k in 1..bn) tab[i][j][k] <= 1; // each field can be occupied by only one block
     sum(k in 1..bn) bps[i][j][k] <= 1;
   }
   forall(i in 1..ts, j in 1..ts, k in 1..bn) {
       // this expression ensures that blocks are placed in their original shape
       if(i + blocks[k][1] - 1 <= ts && j + blocks[k][2] - 1 <= ts) {
         bps[i][j][k] == 0 || (bps[i][j][k] == 1 && (rot[k] == 0 && sum(l in 1..blocks[k][1], m in 1..blocks[k][2]) bps[i+l-1][j+m-1][k] == 1 && min(l in 1..blocks[k][1], m in 1..blocks[k][2]) tab[i+l-1][j+m-1][k] == 1 || rot[k] == 1));
       }
       else {
         bps[i][j][k] == 0 || (bps[i][j][k] == 1 && rot[k] == 1);
       }
       // same thing for rotated ones
       if (i + blocks[k][2] - 1 <= ts && j + blocks[k][1] - 1 <= ts) {
         bps[i][j][k] == 0 || (bps[i][j][k] == 1 && (rot[k] == 1 && sum(l in 1..blocks[k][2], m in 1..blocks[k][1]) bps[i+l-1][j+m-1][k] == 1 && min(l in 1..blocks[k][2], m in 1..blocks[k][1]) tab[i+l-1][j+m-1][k] == 1 || rot[k] == 0));
       }
       else {
         bps[i][j][k] == 0 || (bps[i][j][k] == 1 && rot[k] == 0);
       }
   }
 }

 // result print
  range dim = 1..bn;
 range tsize = 1..ts;
 execute POSTPROCESS {
    for (var k in dim) {
    	for (var i in tsize) {
        	for (var j in tsize) {
            	write(tab[i][j][k], " ");
           }            	
            write("   ")
            for (var j in tsize) {
            	write(bps[i][j][k], " ");
           }            	            	
           write("\n");
        }            
        write("\n");
      }     
}