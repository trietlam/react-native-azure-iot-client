//
//  AzureIotClient.swift
//  ReactNativeIoT
//
//  Created by Admin on 14/12/17.
//  Copyright © 2017 Facebook. All rights reserved.
//


import Foundation
import CocoaMQTT

@objc(RNAzureIotClient)
class RNAzureIotClient: RCTEventEmitter {
    var mqtt: CocoaMQTT?
    var topic: String?
    
    // MARK: - Implement RCTEventEmitter -
    @objc open override func supportedEvents() -> [String] {
        return ["TEST_EVENT"]
    }
    
    // MARK: - Azure IoT stuffs -
    @objc func testEvent(_ name: String) -> Void{
        sendEvent(withName:"TEST_EVENT",body:"{name: eventName}")
    }
    
    @objc func connect(_ hostName: String, deviceId: String) -> Void {
        simpleSSLSetting(hostName:hostName, deviceId:deviceId)
        topic = "devices/" + deviceId + "/messages/events/"
        switch mqtt!.connState {
        case CocoaMQTTConnState.connected:
            print("disconnect")
            mqtt!.disconnect()
            
        case CocoaMQTTConnState.initial,
             CocoaMQTTConnState.disconnected:
            print("connect")
            mqtt!.connect()
            
        default:
            print("in transition state")
        }
    }
    
    @objc func sendMessage(_ message: String) -> Void {
        mqtt!.publish(topic!, withString: message, qos: .qos1)
    }
    
    @objc(addEvent:location:date:)
    func addEvent(name: String, location: String, date: NSNumber) -> Void {
        // Date is ready to use!
        //simpleSSLSetting()
        let message = "sample message"
        mqtt!.publish("devices/reactnativeclient01/messages/events/", withString: message, qos: .qos1)
    }
    
    func simpleSSLSetting(hostName: String, deviceId: String) {
        mqtt = CocoaMQTT(clientID: deviceId, host: hostName, port: 8883)
        mqtt!.username = hostName + "/" + deviceId
        mqtt!.password = "SharedAccessSignature sr=dev-OBD2-iot.azure-devices.net%2Fdevices%2Freactnativeclient01&sig=YehPGrse%2BVGzcQRoe0auZ9BlHnQkhvu39Nnhe3GTSpo%3D&se=1544647696"
        mqtt!.keepAlive = 60
        mqtt!.delegate = self
        mqtt!.enableSSL = true
    }
    
}


extension RNAzureIotClient: CocoaMQTTDelegate {
    func mqtt(_ mqtt: CocoaMQTT, didConnect host: String, port: Int) {
        print("didConnect \(host):\(port)")
    }
    
    // Optional ssl CocoaMQTTDelegate
    func mqtt(_ mqtt: CocoaMQTT, didReceive trust: SecTrust, completionHandler: @escaping (Bool) -> Void) {
        /// Validate the server certificate
        ///
        /// Some custom validation...
        ///
        /// if validatePassed {
        ///     completionHandler(true)
        /// } else {
        ///     completionHandler(false)
        /// }
        completionHandler(true)
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didConnectAck ack: CocoaMQTTConnAck) {
        print("didConnectAck: \(ack)，rawValue: \(ack.rawValue)")
        
        if ack == .accept {
            mqtt.subscribe("devices/reactnativeclient01/messages/devicebound/#", qos: CocoaMQTTQOS.qos1)
        }
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishMessage message: CocoaMQTTMessage, id: UInt16) {
        print("didPublishMessage with message: \(message.string)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didPublishAck id: UInt16) {
        print("didPublishAck with id: \(id)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didReceiveMessage message: CocoaMQTTMessage, id: UInt16 ) {
        print("didReceivedMessage: \(message.string) with id \(id)")
        
        print("message: \(message.string!) \n topic  \(message.topic)")
        
        //c2dMesssages.text = message.string!
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didSubscribeTopic topic: String) {
        print("didSubscribeTopic to \(topic)")
    }
    
    func mqtt(_ mqtt: CocoaMQTT, didUnsubscribeTopic topic: String) {
        print("didUnsubscribeTopic to \(topic)")
    }
    
    func mqttDidPing(_ mqtt: CocoaMQTT) {
        print("didPing")
    }
    
    func mqttDidReceivePong(_ mqtt: CocoaMQTT) {
        _console("didReceivePong")
    }
    
    func mqttDidDisconnect(_ mqtt: CocoaMQTT, withError err: Error?) {
        _console("mqttDidDisconnect")
        _console(err.debugDescription)
    }
    
    func _console(_ info: String) {
        print("Delegate: \(info)")
    }
}




