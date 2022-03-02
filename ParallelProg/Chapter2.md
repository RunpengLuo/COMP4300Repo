# 2. Parallel Hardware and Parallel Software

## Backgrounds

### The von Neumann architecture
1. Main memory, central-processing unit (CPU) or processor or core, and an interconnection between the main memory and the CPU.
2. Main memory: a collection of *locations*, each *location* consists of an *address* (used to access this location) and the *content* of the location (either instruction or data be stored)
3. CPU: Control unit and an arthmetic logic unit (ALU). Control unit decides which instructions in a program should be executed next, and the ALU indeed executes the decided instruction.
4. Intermediate data, information about the state of an executing proggram are stored in very fast storage called *registers*, control unit has a special register: *program counter*, stores the address of the next instruction to be executed.
5. Interconnection: connect CPU and the main memory, used to transfrom data between them, also called a bus. Which consists of a collection of parallel wires and some hardware controlling access to the wires.
6. Traditional von Neumann architecture executes a single instruction and only few piece of data at a time, i.e., Single instruction single data (SISD)
7. Read/fetched: data/instructions are transferred from memory to CPU
8. Write/stored: data are transferred from the CPU to memory.

![](pic/von%20Neumann%20architecture.png)

9. The separation of memory and CPU is often called the *von Neumann bottleneck*, since CPU execute the instruction in a speed way more faster (100 times faster in 2010) than the pending instruction/data be fetched to CPU via interconnection/bus, CPU will stay in idle, which wastes computational resource. i.e., exec speed >> fetch speed
10. Example: Imagine that a large company has a single factory (the CPU) in one town and a single warehouse (main memory) in another. Further imagine that there is a single two-lane road joining the warehouse and the factory. All the raw materials used in manufacturing the products are stored in the warehouse. Also, all the finished products are stored in the warehouse before being shipped to customers. If the rate at which products can be manufactured is much larger than the rate at which raw materials and finished products can be transported, then it’s likely that there will be a huge traffic jam on the road, and the employees and machinery in the factory will either be idle for extended periods or they will have to reduce the rate at which they produce finished products.
11. Modification on classical von Neumman architecture is required to address the bottleneck problem.

### Processes, multitasking, threads
1. operating system: major software, used to manage hardware and software resources on a computer. Determines which programs can run and when they can run. It also controls the allocation of memory to running programs and access to peripheral devices(hard disks, network interface cards, etc).