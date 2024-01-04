//
//  DoctorMapview.swift
//  DoctorX
//
//  Created by Nayan Khadase on 26/12/23.
//

import SwiftUI
import MapKit

struct DoctorMapview: View {
    @State private var position: MapCameraPosition = .automatic
    @State private var istap = true
    let home = CLLocationCoordinate2DMake(18.520490, 73.856743)
    
    var body: some View {
        Map(position: $position){
//            Marker("Clinic",coordinate: home)
            
            Annotation("Clinic", coordinate: home) {
                Button {
                    openMapApp(coordinate: home)
                    istap.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                        .symbolEffect(.bounce, value: istap)
                        .padding(5)
                        .background(Color.green)
                        .foregroundStyle(Color.white)
                        .cornerRadius(5)
                        .shadow(radius: 3, x:0,y:3)
                }

                
                    
            }
            
            .annotationTitles(.hidden)
        }
    }
    
    func openMapApp(coordinate: CLLocationCoordinate2D){
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Destination"
        MKMapItem.openMaps(with: [mapItem], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}

#Preview {
    DoctorMapview()
}
