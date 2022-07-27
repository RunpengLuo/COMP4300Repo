#!/bin/bash
echo "---------------------->Benchmark script-PartA"
cd /home/444/rl0644/COMP4300/student-comp4300-2022-project/code/PartA
rm -rf ../testcases/input/matrix/*
rm -rf ../testcases/output/matrix/*
make clean
make all

Mod="100"
in_testcase_prefix=../testcases/input/matrix/testcase_
out_testcase_prefix=../testcases/output/matrix/testcase_
# generate testcase
echo "Generate test cases.."
for Dimension in 100 200 500 1000 2000
do
    ./matrixgen $Dimension $Dimension $Dimension $Dimension $Mod $in_testcase_prefix$Dimension
done

echo "-----------------Block Mult-----------------"
for Dimension in 100 200 500 1000
do
    for Eunit in 1 2 4 8 16
    do
        for bs in 1 8 16 32 48 
        do 
            echo "----------------------------------------------------------"
            echo "dimension: $Dimension - numthread: $Eunit - blocksize: $bs"
            echo "----------V1----------"
            ./blockmult $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}bm $bs
            echo "----------V2----------"
            ./blockmult2 $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}bm $bs
        done
    done
done

echo "-----------------SUMMA MPI-----------------"
for Dimension in 100 200 500 1000 2000
do
    for Eunit in 1 2 9 16
    do
        echo "----------------------------------------------------------"
        echo "dimension: $Dimension - numprocs: $Eunit"
        echo "----------V1----------"
        mpirun -n $Eunit ./summa $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}s
        echo "----------V2----------"
        mpirun -n $Eunit ./summa2 $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}s2
    done
done

echo "-----------------CANNON MPI-----------------"
for Dimension in 100 200 500 1000 2000
do
    for Eunit in 1 2 9 16
    do
        echo "----------------------------------------------------------"
        echo "dimension: $Dimension - numprocs: $Eunit"
        echo "----------V1----------"
        mpirun -n $Eunit ./cannon $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}c
        echo "----------V2----------"
        mpirun -n $Eunit ./cannon2 $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}c2
    done
done

echo "-----------------SUMMA Pthread-----------------"
for Dimension in 100 200 500 1000 2000
do
    for Eunit in 1 2 9 16
    do
        echo "----------------------------------------------------------"
        echo "dimension: $Dimension - numprocs: $Eunit"
        echo "----------V1----------"
        ./summa_pthread $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}ps
        echo "----------V2----------"
        ./summa_pthread2 $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}ps2
    done
done

echo "-----------------CANNON Pthread-----------------"
for Dimension in 100 200 500 1000 2000
do
    for Eunit in 1 2 9 16
    do
        echo "----------------------------------------------------------"
        echo "dimension: $Dimension - numprocs: $Eunit"
        echo "----------V1----------"
        ./summa_pthread $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}pc
        echo "----------V2----------"
        ./summa_pthread2 $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}pc2
    done
done
echo "------------------------------------------------"
make clean
