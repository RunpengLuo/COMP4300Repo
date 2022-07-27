#!/bin/bash
echo "---------------------->Benchmark script-PartB"
cd /home/444/rl0644/COMP4300/student-comp4300-2022-project/code/PartB
rm -rf ../testcases/input/list/*
rm -rf ../testcases/output/list/*
make clean
make all

Mod="1000"
in_testcase_prefix=../testcases/input/list/testcase_
out_testcase_prefix=../testcases/output/list/testcase_
# generate testcase
echo "Generate test cases.."
for Dimension in 100 200
do
    ./datagen $Dimension $Mod $in_testcase_prefix$Dimension
done

echo "-----------------SampleSort MPI-----------------"
for Dimension in 100 200 500 1000 2000 5000
do
    for Eunit in 1 2 4 8 16
    do
        echo "----------------------------------------------------------"
        echo "dimension: $Dimension - numprocs: $Eunit"
        echo "----------V1----------"
        mpirun -n $Eunit ./sampleSort $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}s
        echo "----------V2----------"
        mpirun -n $Eunit ./sampleSort2 $Eunit ${in_testcase_prefix}${Dimension} ${out_testcase_prefix}s2
    done
done
echo "------------------------------------------------"
make clean
