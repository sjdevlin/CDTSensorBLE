//
//  SecondScreen.swift
//  BLETest
//
//  Created by Stephen Devlin on 26/12/2022.
//

import SwiftUI

struct SecondScreen: View {

    @EnvironmentObject var bleManager: BLEManager
    @StateObject var meetingModel = MeetingModel(stringArray: ["x","x","x","x","x"])
    
    
    var body: some View {
        VStack{
            Text ("Battery: " + meetingModel.stringArray[0])
            Text ("Context: " + meetingModel.stringArray[2])
            Text ("Orientation: " + meetingModel.stringArray[1])
            Text ("Code: " + meetingModel.stringArray[3])
            Text ("Status: " + meetingModel.stringArray[4])

        }.onChange(of: bleManager.Blestr) {newValue in meetingModel.update(bleDATA: bleManager.Blestr)}

    }
}

