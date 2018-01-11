
# react-native-azure-iot-client
To be updated after Native iOS SDK release
https://feedback.azure.com/forums/321918-azure-iot/suggestions/16433716-native-ios-support-for-iot-hub-sdks

## Getting started

`$ npm install react-native-azure-iot-client --save`

### Mostly automatic installation

Not recommended due to lack of RN support for Swift language

### Manual installation


#### iOS
1. Add and install pod ```pod 'CocoaMQTT', '~>1.0.11'```
1. In XCode workspace, in the project navigator, right click your root project ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-azure-iot-client` and add all the source files.
3. Choose `Create Bridging Header` when prompted from xcode
4. Add below line to your project bridging header file
	```
	#import <React/RCTBridgeModule.h>
	#import <React/RCTEventEmitter.h>
	
	```
3. In XCode, in the project navigator, select your project. Add `libRNAzureIotClient.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNAzureIotClientPackage;` to the imports at the top of the file
  - Add `new RNAzureIotClientPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-azure-iot-client'
  	project(':react-native-azure-iot-client').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-azure-iot-client/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-azure-iot-client')
  	```

## Usage
```javascript
import RNAzureIotClient from 'react-native-azure-iot-client';

// TODO: What to do with the module?
RNAzureIotClient;
```
  