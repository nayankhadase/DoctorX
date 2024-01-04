//
//  AddressView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 25/12/23.
//

import SwiftUI

struct AddressView: View {
    var body: some View {
        ZStack{
            Color.gray.opacity(0.15)
                .ignoresSafeArea(edges: .bottom)
            
            VStack(alignment: .leading){
                Button(action: {
                    //code
                }, label: {
                    Label(
                        title: {
                            Text("Add new address")
                        },
                        icon: {
                            Image(systemName: "plus")
                        }
                    )
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                })
                
                
                // saved addresses:
                VStack(alignment: .leading){
                    Text("Your saved addresses")
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading){
                            Text("Office")
                                .bold()
                            Text("Sumasoft pvt. ltd, Aundh, Pune 43007")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                        }
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(90))
                        })
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    
                    HStack{
                        Image(systemName: "house.fill")
                            .resizable()
                            .scaledToFit()
                            .padding(8)
                            .frame(width: 40)
                        
                        VStack(alignment: .leading){
                            Text("Office")
                                .bold()
                            Text("Sumasoft pvt. ltd, Aundh, Pune 43007")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            
                        }
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "ellipsis")
                                .rotationEffect(.degrees(90))
                        })
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .navigationTitle("My addresses")
    }
}

#Preview {
    AddressView()
}
