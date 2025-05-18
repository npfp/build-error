Example that build on cmake but not using scikit_build_core.



Compilation using cmake directly works well

```shell
mkdir build
cd build
cmake ..
cd ..
cmake --build build
```
gives
```shell
[ 50%] Building CXX object CMakeFiles/example.dir/src/example/example.cpp.o
[100%] Linking CXX shared module example.cpython-311-darwin.so
```
which is runnable:
```shell
cd builld
python
>>> import example
>>> example.square(24)
576.0
```


while using cv
```shell
uv build
```

leads to 

```shell
-- Looking for C++ include vector
-- Looking for C++ include vector - not found
-- CXX_VECTOR_SUPPORT: 
CMake Error at CMakeLists.txt:36 (message):
  Couldn't find #include <vector>
```