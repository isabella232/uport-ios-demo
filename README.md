# uPort Demo App for iOS

This repository shows how to setup an iOS app that uses the [**uPort** SDK](https://github.com/uport-project/uport-ios-sdk).


## Getting Started With the Demo App

The **uPort** iOS SDK and its frameworks use [Carthage](https://github.com/Carthage/Carthage) as dependency manager. We chose Carthage over [CocoaPods](https://cocoapods.org) because it's simple and nonintrusive.

### Installing Carthage

If you have [Homebrew (also known as Brew)](https://brew.sh) installed on your macOS machine, just run:

```console
brew install carthage
```

Otherwise, you could download and install the latest [`Cathage.pkg`](https://github.com/Carthage/Carthage/releases).

### Getting the uPort SDK

Now that you have Carthage installed, run the following command (from the root directory of this demo app repository):

```console
carthage update --platform iOS --no-use-binaries --cache-builds
```

This command is also available from the included `build` script. So alternatively you can run:

```console
./build
```

This git-clones the **uPort** SDK's repositories and subsequently builds them as iOS frameworks.

### Running the Demo App

If you open the `uPortDemo.xcodeproj` Xcode project, the app should build and run on the Simulator.

### Feel Free

This demo app uses the [MIT license](LICENSE.txt), so it's totally fine to copy and use it as the base of your new app.


## Adding the uPort SDK to Your App

Now that you may have had a look at our demo app, let's see how you add the **uPort** SDK to your app.

### 1. Copy-Paste the Cartfile

Copy the `Cartfile` (from this demo app's root directory) to your app directory; preferably place it in the root directory. You need to add this file to your git repository as it tell Carthage where the **uPort** SDK can be found and which version to use.

If you wish, also copy the `build` script.

### 2. Get the uPort SDK

To download and build the SDK's frameworks, run:

```console
carthage update --platform iOS --no-use-binaries --cache-builds
```

This will create the file `Cartfile.resolved` by which Carthage keeps track of dependencies. Add this file to your git repository.

### 3. Ignore Carthage Output

The above command will also create the `Cathage/` directory. This directory contains the cloned **uPort** SDK repositories in subdirectory `Carthage/Checkouts/` and the built frameworks in `Carthage/Build/`.

To prevent adding the **uPort** source code and binaries to your git repository, add the following lines to your `.gitignore` file (assuming you run `carthage` from your root directory (where your Xcode project or workspace is)):

```
Carthage/Checkouts
Carthage/Build
```

### 4. Drag Frameworks Into Xcode Target

Drag all built `.framework` 'files' from `Carthage/Build/iOS/` into your Xcode target's *Build Phases > Link Binary With Libraries* section.

Currently these are: `BigInt.framework`, `CoreEth.framework`, `CryptoSwift.framework`, `openssl.framework`, `SipHash.framework`, `Sodium.framework`, `UPTEthereumSigner.framework`, `Uport.framework`, and `Valet.framework`.

### 5. Add Carthage's Copy-Frameworks Run Script

On your application target’s *Build Phases* tab, click the *+* icon at top-right and create a *New Run Script Phase* with the following contents:

```sh
/usr/local/bin/carthage copy-frameworks
```

Then, add the paths to the **uPort** frameworks under *Input Files*:

```
$(SRCROOT)/Carthage/Build/iOS/BigInt.framework
$(SRCROOT)/Carthage/Build/iOS/CoreEth.framework
$(SRCROOT)/Carthage/Build/iOS/CryptoSwift.framework
$(SRCROOT)/Carthage/Build/iOS/openssl.framework
$(SRCROOT)/Carthage/Build/iOS/SipHash.framework
$(SRCROOT)/Carthage/Build/iOS/Sodium.framework
$(SRCROOT)/Carthage/Build/iOS/UPTEthereumSigner.framework
$(SRCROOT)/Carthage/Build/iOS/UPort.framework
$(SRCROOT)/Carthage/Build/iOS/Valet.framework
```

Finally add the *Output Files* for this Run Script Phase:

```
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/BigInt.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/CoreEth.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/CryptoSwift.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/openssl.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/SipHash.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/Sodium.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/UPTEthereumSigner.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/UPort.framework
$(BUILT_PRODUCTS_DIR)/$(FRAMEWORKS_FOLDER_PATH)/Valet.framework
```

Remarks:
1. You may think that this could also be done by adding a `New Copy Files Phase` where you drag in the frameworks and select `Frameworks` as `Destination`. This has indeed the same effect, but `carthage copy-frameworks` strips x86/Simulator from the framework binaries to [work around an old App Store submission issue](https://stackoverflow.com/a/39269506/1971013).
2. This script works, but some say it's error prone. In case you encounter issues with submitting your app, try [this](https://github.com/lvillani/carthage-copy-frameworks).
3. Without this step or if you make a mistake (e.g. a typo in one of the *Input Files*), the app builds. But it fails to run and Xcode prints an error that looks like:
`dyld: Library not loaded: @rpath/UPort.framework/UPort Referenced from: .../uPortDemo.app/uPortDemo Reason: image not found`

For more general details have a look at the [Carthage documentation](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).


## Using the uPort SDK In Your Code

Although the SDK consists of a list of frameworks, you only need `import UPort` for Swift or `#import UPort;` for Objective-C to include the full SDK.


## License

The *uPort* demo app is released under the [MIT License](LICENSE.txt).

This license do not apply to the frameworks used. Please check the frameworks' repositories for their respective licenses.
