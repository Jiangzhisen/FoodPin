//
//  MapView.swift
//  FoodPin
//
//  Created by 姜智森 on 2024/10/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    var location: String = ""
    
    @State private var position: MapCameraPosition = .automatic
    @State private var markerLocation = CLLocation()
    
    var body: some View {
        Map(position: $position, interactionModes: []) {
            Marker("", coordinate: markerLocation.coordinate)
                .tint(.red)
        }
        .task {
            convertAddress(location: location)
        }
    }
    
    private func convertAddress(location: String) { 
        // 取得位置
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let placemarks = placemarks,
                  let location = placemarks[0].location else {
                return
            }
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
            self.position = .region(region)
            self.markerLocation = location
        })
    }
}

#Preview {
    MapView(location: "54 Frith Street London W1D 4SL United Kingdom")
}
