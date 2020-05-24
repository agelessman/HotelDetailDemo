//
//  HotelDetailAddressView.swift
//  ElongHotel
//
//  Created by MC on 2020/4/29.
//  Copyright © 2020 MC. All rights reserved.
//

import SwiftUI
import MapKit

struct HotelDetailAddressView: View {
    var response: HotelDetailResponse
    
    var body: some View {
        VStack {
            MapView(coordinate: CLLocationCoordinate2D(latitude: self.response.location.latgcj02, longitude: self.response.location.lnggcj02))
                .cornerRadius(12)
                .frame(height: 80)
                .padding(0)
            
            VStack(alignment: .leading) {
                HStack {
                    if self.response.areaName != nil {
                        Text("\(self.response.areaName!) | ")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    
                    Text("\(self.response.address)")
                        .font(.caption)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .padding([.leading, .trailing], 10)
                .padding([.bottom], 5)
                
                Text("\(self.response.trafficInfo)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing, .bottom], 10)
                    .lineLimit(1)
            }
        }
        .background(LinearGradient(gradient: .init(colors: [.orange, .red]), startPoint: .init(x: 0, y: 0.5), endPoint: .init(x: 1.0, y: 0.5)))
        .cornerRadius(12)
        .padding([.leading, .trailing, .top], 10)

    }
}


struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        let mk = MKMapView()
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
        mk.setRegion(region, animated: true)
        
        /// 添加大头针
        let annotation = Place(coordinate)
        mk.addAnnotation(annotation)
        
        return mk
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
}

final class Place: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(_ coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
