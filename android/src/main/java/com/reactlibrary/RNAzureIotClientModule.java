
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;

import com.microsoft.azure.sdk.iot.device.DeviceClient;
import com.microsoft.azure.sdk.iot.device.IotHubClientProtocol;
import com.microsoft.azure.sdk.iot.device.Message;

public class RNAzureIotClientModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNAzureIotClientModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNAzureIotClient";
  }

  @ReactMethod
  public void connect(String connectionString) {
      try {
          client = new DeviceClient(connectionString, IotHubClientProtocol.HTTPS);
          client.open();
      } catch(IOException e1) {
          Log.e("IotModule", "Exception while opening IoTHub connection: " + e1.toString());
      } catch(Exception e2) {
          Log.e("IotModule", "Exception while opening IoTHub connection: " + e2.toString());
      }
  }

  @ReactMethod
  public void sendMessage(String messageString) {
      Message msg = new Message(messageString);
      try {
          client.sendEventAsync(msg, null, null);
      } catch(IllegalStateException e) {
          Log.e("IotModule", "Exception while sending message: " + e.toString());
      }
  }
}