# Init deps
git submodule update --init --recursive
# Create build folder
mkdir ./build
cd ./build
# Build Deps
cmake ../libgimbal -DGBL_ENABLE_TESTS=ON -GXcode
cmake --build .
# Build project
cd ../gimbalsaurus
xcodebuild -scheme gimbalsaurus clean build