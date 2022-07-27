1. Cannon's algorithm is less efficient than SUMMA algorithm in practice, because it works on square matrices only.
2. 1d layout, summa, cannon all have same exec time.
3. efficiency: summa is efficient in practice.
4. 3d layout use larger M (fast memory limited capacity) to achieve optimal communication 
5. mpi/cuda needs specialized compilers, but openMP can be used by typical gcc compiler.
6. Computation intensity: block > strassen > matrix-matrix; 3d > cannon > summa > strassen > 1d
7. communication overhead = waiting time + delivery time = (1/Bandwidth) * #words_moved + latency * #messages.
8. Cannon algorithm is that its storage requirements remain constant and are independent of the number of processors.