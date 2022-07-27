#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

int thread_count;

void * Thread_work(void * arg){
    //...
    return NULL;
}

int main(int argc, char* argv[]) {
   long       thread;
   pthread_t* thread_handles; 

   thread_count = strtol(argv[1], NULL, 10);

   thread_handles = malloc (thread_count*sizeof(pthread_t));
//    pthread_mutex_init(&barrier_mutex, NULL);
//    pthread_cond_init(&ok_to_proceed, NULL);

   for (thread = 0; thread < thread_count; thread++)
      pthread_create(&thread_handles[thread], NULL,
          Thread_work, (void*) thread);

   for (thread = 0; thread < thread_count; thread++) {
      pthread_join(thread_handles[thread], NULL);
   }

//    pthread_mutex_destroy(&barrier_mutex);
//    pthread_cond_destroy(&ok_to_proceed);
   free(thread_handles);
   return 0;
}

