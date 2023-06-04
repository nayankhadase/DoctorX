//
//  MedicineView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/06/23.
//

import SwiftUI

struct MedicineView: View {
    @State private var searchText = ""
    @State private var categoryIndex: Int = 0
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { geo in
            ZStack{
                VStack(spacing: 0){
                    TopBarView(searchText: $searchText)
                        .padding(.horizontal)
                        .background()
                    
                    ScrollView{
                        VStack(alignment: .leading){
                            ScrollView{
                                HStack{
                                    OffersCardView(geo: geo)
                                }
                            }
                            
                            //
                            VStack(alignment: .leading, spacing: 0){
                                Text("Categories")
                                    .font(.system(.subheadline))
                                    .foregroundColor(.black.opacity(0.6))
                                    .padding(.horizontal)
                                
                                MedicineCategoryView(geo: geo, categoryIndex: $categoryIndex)
                                    .padding(.top)
                            }
                            
                            //
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(0...10, id: \.self){ i in
                                    TabletsCardView(geo: geo)
                                }
                            }
                            .padding(.top)
                            .background(Color.gray.opacity(0.06))
                            
                            
                        }
                    }
                }
            }
            .frame(width: geo.size.width)
        }
    }
}

struct OffersCardView: View{
    let geo: GeometryProxy
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text("GET 50% OFF")
                        .font(.title3.bold())
                    Text("on all items")
                        .font(.callout)
                    Text("on your first order")
                        .font(.caption)
                    
                    Button {
                        //code
                    } label: {
                        Text("Order now")
                            .padding(5)
                            .font(.caption)
                            .background()
                            .foregroundColor(Color("Primary"))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 5))

                }
                .foregroundColor(.white)
                
                Spacer()
                
                Image("shoppingcart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width * 0.4)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .background(LinearGradient(colors: [Color("Primary").opacity(0.7),Color("Primary")], startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 3, y:3)
        .shadow(color: Color.white.opacity(0.3), radius: 2, x: -3, y: -3)
        .padding()
    }
}

struct MedicineCategoryView: View{
    let geo: GeometryProxy
    @Binding var categoryIndex: Int
    let categories = [
        "All", "Covid 19", "Antibiotics", "Baby care", "Vitamins"
    ]
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .center){
                ForEach(categories, id: \.self) { category in
                    MedicineCategoryCardView(isActive: category == categories[categoryIndex], type: category){
                        //code
                        withAnimation {
                            categoryIndex = categories.firstIndex(of: category) ?? 0
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}

struct MedicineCategoryCardView: View{
    
    let isActive: Bool
    let type: String
    let action: (() -> Void)
    
    @Namespace var namespace
    
    var body: some View{
        Button {
            action()
            
        } label: {
            VStack{
                Text(type)
                    .font(.system(.subheadline))
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .foregroundColor(isActive ? .white : Color("Primary"))
                    .background(isActive ? Color("Primary") : .offWhite)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
//                Text(drType.type)
//                    .font(.caption)
            }
            
        }

        

    }
    
}

struct TabletsCardView: View{
    let geo: GeometryProxy
    var body: some View{
        VStack{
            Image("tablet\(Int.random(in: 1...3))")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.15)
            Text("tablet_name")
                .font(.system(size: 14))
            HStack{
                Text(13, format: .currency(code: "INR"))
                    .font(.system(size: 14))
                
                Button {
                    //code
                } label: {
                    Text("Add")
                        .font(.system(size: 14))
                        .padding(4)
                        .padding(.horizontal)
                        .background(Color("Primary"))
                        .foregroundColor(Color.white)
                }
                .clipShape(RoundedRectangle(cornerRadius: 5))

            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray.opacity(0.1),radius: 3, x:3,y:3)
    }
}




struct MedicineView_Previews: PreviewProvider {
    static var previews: some View {
        MedicineView()
    }
}
