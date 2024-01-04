//
//  ChatWithDrTabView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 04/06/23.
//

import SwiftUI

struct ChatWithDrTabView: View {
    @State private var searchText = ""
    
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                VStack(alignment: .leading){
                    TopBarView(searchText: $searchText)
                        .padding(.horizontal)
                        .background()
                    
                    ScrollView{
                        
                        VStack(alignment: .leading){
                            Text("Connect with Doctors")
                                .padding(.horizontal)
                                .font(.body)
                            
                            DrInfoCardView(geo:geo)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
        }
    }
}

struct ChatWithDrTabView_Previews: PreviewProvider {
    static var previews: some View {
        ChatWithDrTabView()
    }
}

struct DrInfoCardView: View{
    let geo: GeometryProxy
    
    var body: some View{
        ScrollView(.vertical){
            VStack{
                ForEach(0...5, id: \.self){ index in
                    NavigationLink {
                        // TODO: create chat view
                        Text("view")
                    } label: {
                        DrChatOptionCardView()
                    }
                    
                    
                }
            }
            .padding(.horizontal)
        }
    }
}


struct DrChatOptionCardView: View {
    @State private var isFavorite = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            VStack{
                Spacer()
                Image("dr")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .background(Color("Primary").opacity(0.5))
                    .clipShape(Circle())
                Spacer()
            }
            
            
            VStack(alignment: .leading, spacing: 5){
                Spacer()
                Text("Dr. Name")
                    .font(.body)
                    .foregroundColor(.primary)
                
                HStack(alignment: .center, spacing: 15){
                    
                    
                    Image(systemName: "mappin.and.ellipse")
                        .imageScale(.small)
                        .foregroundColor(Color("Primary"))
                    
                    Text("Pune")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
                }
                Spacer()
            }
            
            Spacer()
            
            HStack{
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: "phone")
                        .imageScale(.small)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color("Primary"))
                }
                .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: "message")
                        .imageScale(.small)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color("Primary"))
                }
                .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            
            
            
            
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
        .background(Color("Secondary").opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.vertical, 4)
    }
}
