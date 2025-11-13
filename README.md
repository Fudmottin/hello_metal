# hello_metal

This is just a vibe coded Objective-C++ application to test using metal on the
command line.

You may have to run the following command to install the Metal Toolchain:

```bash
xcodebuild -downloadComponent MetalToolchain
```

Experience the full horror of Objective-C++!

## Build

After cloning the repo (on a Mac), do the usual cmake mantra:

```bash
mkdir build
cd build
cmake ..
make
```

I've tested on an M2 Mac mini and an M4 Mac mini. My cmake is from brew.
You should get something like this:

```bash
$ cmake ..
-- The CXX compiler identification is AppleClang 17.0.0.17000404
-- The OBJCXX compiler identification is AppleClang 17.0.0.17000404
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Detecting OBJCXX compiler ABI info
-- Detecting OBJCXX compiler ABI info - done
-- Check for working OBJCXX compiler: /usr/bin/c++ - skipped
-- Configuring done (2.5s)
-- Generating done (0.0s)
-- Build files have been written to: /Users/david/Projects/metal/hello_metal/build
$ make
[ 33%] Building Metal shaders
[ 33%] Built target metal_shaders
[ 66%] Building OBJCXX object CMakeFiles/hello_metal.dir/main.mm.o
[100%] Linking OBJCXX executable hello_metal
[100%] Built target hello_metal
$ ./hello_metal
0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
```

If you do, you're golden.
