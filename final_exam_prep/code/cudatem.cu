#include <stdio.h>
#include <stdlib.h>

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
__device__ void Comparator(int * x, int * y){
    int acc = *x;
    *x = acc > *y ? *y : acc;
    *y = acc > *y ? acc : *y;
    return;
}
// size = 4
// run on single block, with only 2 thread
// arr is allocated on gpu global memory
// return on arr
__global__ void BM4(int * arr){
    __device__ __shared__ int * arr_b;
    cudaMalloc(arr_b, sizeof(int) *4);

    for (int i = 0; i < 4; i++){
        arr_b[i] = arr[i];
    }
    if (threadIdx.x == 0){
        Comparator(arr_b, arr_b+2);
    }else {
        Comparator(arr_b+1, arr_b+3);
    }
    __syncthreads();
    if (threadIdx.x == 0){
        Comparator(arr_b, arr_b+1);
    }else {
        Comparator(arr_b+2, arr_b+3);
    }

    for (int i = 0; i < 4; i++){
        arr[i] = arr_b[i];
    }
    return;
}

__host__ void sort(){
    int * arrb = malloc(sizeof(int) * 4);
    arrb[0] = 10;
    arrb[1] = 20;
    arrb[2] = 9;
    arrb[3] = 5;
    __device__  int * arr;
    cudaMalloc(arr, sizeof(int) * 4);
    cudaMemcpy(arr, arrb, sizeof(int) * 4, cudaMemcpyHostToDevice);

    BM4<<<1,2>>>(arr);

    cudaMemcpy(arrb, arr, sizeof(int) * 4, cudaMemcpyDeviceToHost);
    printf("after BM4=");
    for (int i = 0; i < 3; i ++){
        printf("%d,", arrb[i]);
    }
    printf("%d\n", arrb[3]);
    cudaFree(arr);
    free(arrb);
    return;
}