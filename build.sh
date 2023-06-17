git submodule update --init --recursive
mkdir ./build
cd ./build
cmake ../libgimbal -DGBL_ENABLE_TESTS=ON -GXcode
cmake --build .