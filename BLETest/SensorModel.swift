//
//  MeetingModel.swift
//  BLETest
//
//  Created by Stephen Devlin on 26/11/2023.
//

import SwiftUI

class SensorModel:ObservableObject {

    @Published var stringArray:[String] = []
    
    func update (bleDATA:String)
    {
        self.stringArray = bleDATA.components(separatedBy: ",")
        
    }
    
    init(stringArray:[String]){
        self.stringArray = stringArray

    }
    
    static let example = SensorModel(stringArray: ["3.2V","36.4","38.2","76","86"])
}



