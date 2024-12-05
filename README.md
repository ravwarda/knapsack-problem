# knapsack-problem

This repository can be used to solve the discrete, two dimensional knapsack problem using IBM CPLEX Optimization Studio.

### problem description

The goal is to place as many rectangular blocks as possible on a square board of a given size.
Blocks are defined by two integers that correspond to block size in each dimension.
There is a set of blocks given, and each one can be used only once.
Blocks can be rotated by 90 degrees before being placed on the board.

### parameters

**ts** - size of the board (**ts** by **ts** square)

**bn** - amount of blocks

**blocks** - **bn** by **2** array, each row represents one block

### decision variables

**bps** - a three dimensional boolean array, first two dimensions are **ts** by **ts** size and represent the board, and the third dimension has size **bn** to define the upper left corner placement of each block.

**rot** - a boolean array of **bn** elements, defines if the block needs to be rotated (1 means rotated).

**tab** - similar to **bps**, but contains a map of 1 values in place that block occupies. This variable flattened to two dimensions would represent the final board layout.
