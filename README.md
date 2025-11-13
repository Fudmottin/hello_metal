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

