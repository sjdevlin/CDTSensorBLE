//
//  ContentView.swift
//  BLETest
//
//  Created by Stephen Devlin on 24/11/2023.
//

import SwiftUI
struct ContentView: View {
    
    @StateObject var bleManager = BLEManager()
    @StateObject var sensorModel = SensorModel(stringArray: ["","","","",""])

    var body: some View {
        
        let actual_temp = sensorModel.stringArray[1]
        let est_temp = sensorModel.stringArray[2]
        let battery = sensorModel.stringArray[0]
        let actual_heart = sensorModel.stringArray[3]
        let est_heart = sensorModel.stringArray[4]

        VStack{

            Text("Sensor CDT").font(.system(size:32))
                .padding([.bottom],5)
            Text(!bleManager.isConnected ? "Not Connected" : "Connected").font(.system(size:20))
                .foregroundColor(!bleManager.isConnected ? .red : .green)
                .padding([.bottom],20)

            HStack{
                Label("Batt: " + battery, systemImage: "battery.100.circle")
                    .font(.system(size:24))
                    .labelStyle(.titleAndIcon)
                    .imageScale(.medium)
                    .padding([.bottom],30)
 
            }.padding([.bottom],30)
            Text ("Temperature").font(.system(size:28,weight: .medium))

            ZStack {
                HStack{
                    Spacer ()
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color(UIColor.systemGray6))
                    .frame(width: 120, height: 120)
                    .overlay(Text(actual_temp)).font(.system(size:36,weight: .medium))
                    .foregroundColor(.white)
                    Spacer ()
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color(UIColor.systemGray6))
                        .frame(width: 120, height: 120)
                        .overlay(Text(est_temp)).font(.system(size:36,weight: .medium))
                        .foregroundColor(.gray)
                    Spacer ()

                }

            }.padding([.bottom],40)
            Text ("Heart Rate").font(.system(size:28,weight: .medium))

            
            ZStack {
                HStack{
                    Spacer ()
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .fill(Color(UIColor.systemGray6))
                    .frame(width: 120, height: 120)
                    .overlay(Text(actual_heart)).font(.system(size:36,weight: .medium))
                    .foregroundColor(.white)
                    Spacer ()
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color(UIColor.systemGray6))
                        .frame(width: 120, height: 120)
                        .overlay(Text(est_heart)).font(.system(size:36,weight: .medium))
                        .foregroundColor(.gray)
                    Spacer ()

                }
            }.padding([.bottom],40)
            Spacer()
            Spacer()

            Button(bleManager.Running ? "Stop" : "Start") {
                bleManager.StartStopSensing()
                        }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .foregroundColor(.black)
            .tint(bleManager.Running ? .red : .green)
            .controlSize(.large)
            .font(.system(size:24))
        }
        .frame(width: UIScreen.main.bounds.width * 0.75,height: UIScreen.main.bounds.height * 0.7, alignment: .center)
        .onChange(of: bleManager.Blestr) {newValue in sensorModel.update(bleDATA: bleManager.Blestr)}
        .preferredColorScheme(.dark)
    }

}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sensorModel: SensorModel.example).preferredColorScheme(.dark)
    }
}
