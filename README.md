# gimbalsaurus

_Objective-c might be old and extinct to some, but it sure is powerful._

<p align="center">
    <img src="https://blog.krzyzanowskim.com/content/images/2017/05/Dinosaur_bg-3.png"  />
</p>

## What is this?
Gimbalsaurus is a set of bindings for the libgimbal cross platform framework written in Objective-c. These bindings will provide a Cocoa flavour to the extensive APIs already available in the core framework. They will be the basis of an upcoming rewrite of my EVMU (Sega Visual Memory Unit Emulator) for the Apple Watch.

## Use GimbalSaurus in your project
Clone the project
```
git clone git@github.com:andrewapperley/gimbalsaurus.git
```

Run `build.sh`
```
./build.sh
```

a) Embed `/gimbalsaurus/gimbalsaurus.xcodeproj` and mark the `gimbalsaurus.framework` target as a dependency
</br>OR</br>
b) Use either the Cocoapods or Carthage dependency (COMING SOON)