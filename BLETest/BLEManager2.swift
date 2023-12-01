//
//  BLEManager.swift
//  CDT Sensor
//
//  Created by Stephen Devlin on 08/11/2023.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate,CBPeripheralDelegate {

    @Published var Blestr:String = ""
    @Published var isConnected:Bool = false
    @Published var Running:Bool = false

    var myPeripheral: CBPeripheral!
    var myCentral: CBCentralManager!

    
    
    override init() {
            super.init()
            myCentral = CBCentralManager(delegate: self, queue: nil)
            myCentral.delegate = self
        }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
           }
           else {
               print("Something wrong with BLE")
           }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected!")
        peripheral.discoverServices([K.CDTSensorCBUUID])
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected!")
        isConnected = false
        central.scanForPeripherals(withServices: nil, options: nil)
    }

    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService,
                    error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            if characteristic.properties.contains(.notify) {
                print("\(characteristic.uuid): has notify")
                peripheral.setNotifyValue(true, for: characteristic)
                self.isConnected = true
            }
        }
    }
        
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
       
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
                       print (name)
                       if name == K.BTServiceName {
                           central.stopScan()
                           self.myPeripheral = peripheral
                           self.myPeripheral.delegate = self
                           central.connect(peripheral, options: nil)
                       }
                   }

        }
       
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        
        switch characteristic.uuid {

        case K.CDTSensorDataCBUUID:

            Blestr = String(decoding: characteristic.value!, as: UTF8.self) + "\n"
            print (Blestr)
            
            default:
            print("Unhandled Characteristic UUID: \(characteristic.uuid)")
        }

    }
    
    
    
    func StartStopSensing() {
        guard let peripheral = self.myPeripheral,
                      let characteristic = peripheral.services?.first?.characteristics?.first(where: { $0.uuid == K.CDTSensorInstructionCBUUID })
                else {
                    print("Peripheral or characteristic not found")
                    return
                }
                
        let text = (self.Running ? "S":"G")
        self.Running = !self.Running
                    
        let data = text.data(using: .utf8)!
                peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
    
}

