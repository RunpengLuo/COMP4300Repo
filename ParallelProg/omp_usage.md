```shell
$gcc -g -Wall -fopenmp file.c -o file
```
Problem in MacOS
```shell
$clang: error: unsupported option '-fopenmp'
```
Since MacOS default clang compiler disabled the openmp usage, we can install another gcc via 

```shell
$brew update && brew install libomp
```

Then, we can use the newly installed gcc under `/usr/local/bin/gcc-v` with v specified as the version.

Replace above gcc compiler with `gcc-v` can solve the problem