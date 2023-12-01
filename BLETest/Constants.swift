//
//  Constants.swift
//  NewMeetPie
//
//  Created by Stephen Devlin on 13/11/2023.
//

import Foundation
import CoreBluetooth

struct K {
    static let CDTSensorCBUUID = CBUUID(string: "7DEF8317-7300-4EE6-8849-46FACE74CA2A")
    static let CDTSensorDataCBUUID = CBUUID(string: "7DEF8317-7301-4EE6-8849-46FACE74CA2A")
    static let CDTSensorInstructionCBUUID = CBUUID(string: "00002A3D-0000-1000-8000-00805f9b34fb")
    
    static let BTServiceName = "BLE_String"

}
