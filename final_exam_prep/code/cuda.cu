#include <stdio.h>
#include <stdlib.h>
// #include "timer.h"
// #define DEBUG
//nvcc -o dot dot_prod.cu

static int n;
static float dot_parallel;
static float dot_serial;

float Serial_dot_prod(float x[], float y[], int n) {//serial
    float cdot = 0.0;

    for (int i = 0; i < n; i++) {
        cdot += x[i] * y[i];
    }
    return cdot;
}

//GPU Kernel
__global__ void dot_1(float *a, float *b, float *c, int n)//basic parallel, assume thred num = vector size
{
    // TODO: Exercise 1
    //compute each threads' corresponding array index.
    //then, use atomicAdd to add the result to c; you can assume each thread will be responsible for only one element
    int index = blockDim.x * blockIdx.x + threadIdx.x;
    
    float temp = a[index] * b[index];
    atomicAdd(c, temp);
    printf("%f", temp);


}

//GPU Kernel
__global__ void dot_2a(float *a, float *b, float *c, int n)//block distribution
{
    // TODO: Exercise 2a: block distribution
    int np = gridDim.x*blockDim.x;
    int index =  (blockDim.x * blockIdx.x) + threadIdx.x;
    int work ;
    int step =  n/np;
    // printf("index %d",index);
    if(np > n){
        work = 1;
    }
    
    else if ((n % np) == 0){
        work = step;
        // int x = 300 % 20;
        // printf("index %d",work);
    }

    else {
        work = (step);
        // printf("index %d",index);
        if (index == (np-1)){
            
            work = step + (n%np);
            // printf("%d", work);
        }
    }

    float temp =0.0;
    
    for (int i =0; i < work; i++) {
        temp += a[index *step+i] * b[index*step+i];
        
        //  printf("working %d",ind
    }
}