sudo "/Applications/CMake.app/Contents/bin/cmake-gui" --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install xcodesorg/made/xcodes
xcodes install --latest
brew install fastlane