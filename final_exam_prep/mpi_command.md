int MPI_Send(const void* buffer,
             int count,
             MPI_Datatype datatype,
             int recipient,
             int tag,
             MPI_Comm communicator);

int MPI_Recv(void* buffer,
             int count,
             MPI_Datatype datatype,
             int sender,
             int tag,
             MPI_Comm communicator,
             MPI_Status* status);

int MPI_Sendrecv(const void* buffer_send,
                 int count_send,
                 MPI_Datatype datatype_send,
                 int recipient,
                 int tag_send,
                 void* buffer_recv,
                 int count_recv,
                 MPI_Datatype datatype_recv,
                 int sender,
                 int tag_recv,
                 MPI_Comm communicator,
                 MPI_Status* status);

int MPI_Scatter(const void* buffer_send,
                int count_send, // not total buffer size
                MPI_Datatype datatype_send,
                void* buffer_recv,
                int count_recv,
                MPI_Datatype datatype_recv,
                int root,
                MPI_Comm communicator);

int MPI_Gather(const void* buffer_send,
               int count_send,
               MPI_Datatype datatype_send,
               void* buffer_recv,
               int count_recv,
               MPI_Datatype datatype_recv,
               int root,
               MPI_Comm communicator);

int MPI_Bcast(void* buffer,
              int count,
              MPI_Datatype datatype,
              int emitter_rank,
              MPI_Comm communicator);

int MPI_Alltoall(const void* buffer_send,
                 int count_send,
                 MPI_Datatype datatype_send,
                 void* buffer_recv,
                 int count_recv,
                 MPI_Datatype datatype_recv,
                 MPI_Comm communicator);

int MPI_Allgather(const void* buffer_send,
                  int count_send,
                  MPI_Datatype datatype_send,
                  void* buffer_recv,
                  int count_recv,
                  MPI_Datatype datatype_recv,
                  MPI_Comm communicator);

int MPI_Scan(void* send_buffer,
             void* receive_buffer,
             int count,
             MPI_Datatype datatype,
             MPI_Op operation,
             MPI_Comm communicator);

int MPI_Reduce(const void* send_buffer,
               void* receive_buffer,
               int count,
               MPI_Datatype datatype,
               MPI_Op operation,
               int root,
               MPI_Comm communicator);