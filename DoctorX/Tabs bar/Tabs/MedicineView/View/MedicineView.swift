//
//  MedicineView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 03/06/23.
//

import SwiftUI
import Kingfisher

struct MedicineView: View {
    @State private var medicineViewModel = MedicineViewViewModel()
    @Environment(ProgressbarViewModel.self) var progressbarViewModel
    @Environment(AlertManager.self) var alertManager
    
    @State private var searchText = ""
    @State private var categoryIndex: Int = 0
    
    @State private var cartHasItems = false
    @State private var itemInCart = 0
    
    @State private var productIncart: [MedicineModel] = []
    
    let columns = [GridItem(.adaptive(minimum: 190, maximum: 190))]
    
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
                            LazyVGrid(columns: columns, spacing: 30) {
                                ForEach(medicineViewModel.medicines, id: \.self){ medinine in
                                    TabletsCardView(geo: geo, medicine: medinine, productIncart: $productIncart)
                                }
                            }
                            .padding(.top)
                            .background(Color.gray.opacity(0.06))
                            
                            
                            
                        }
                    }
                    
                    if !productIncart.isEmpty {
                        Group{
                            VStack(alignment: .leading){
                                HStack{
                                    Image(systemName: "box.truck")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40)
                                        .foregroundStyle(Color("Primary"))
                                        .padding(5)
                                        .background(Color.white.opacity(0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    
                                    VStack(alignment: .leading){
                                        Text("Get FREE delivery")
                                            .bold()
                                            .foregroundStyle(Color("Primary"))
                                        
                                        Text("Add mode items")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        
                                        
                                            
                                    }
                                    
                                }
                                HStack{
                                    Text("Items added: 4")
                                        .bold()
                                        .foregroundStyle(Color("Primary"))
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                    }, label: {
                                        Text("View Cart")
                                            .padding(10)
                                            .padding(.horizontal)
                                            .background(Color("Primary"))
                                            .foregroundColor(Color.white)
                                            .clipShape(Capsule())
                                    })
                                        
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                           
                            .padding()
                        }
                        .background(Color("Secondary").opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: -3)
                        .transition(.move(edge: .trailing))
                    }
                   
                }
            }
            .frame(width: geo.size.width)
            .modifier(ProgressbarView(progressbarView: progressbarViewModel))
            .onAppear {
                medicineViewModel.alertManager = alertManager
                medicineViewModel.progressBar = progressbarViewModel
                medicineViewModel.fetchAllMedicines()
            }
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
    let medicine: MedicineModel
    @Binding var productIncart: [MedicineModel]
    
    @State private var itemAdded = 0
    var body: some View{
        VStack{
            KFImage(URL(string: medicine.actualimagePath))
//            Image("tablet\(Int.random(in: 1...3))")
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width * 0.15, height: geo.size.width * 0.15)
            
            Text(medicine.name.capitalized)
                .font(.system(size: 14))
            
            HStack{
                Text(medicine.priceValue, format: .currency(code: "INR"))
                    .font(.system(size: 14))
                if itemAdded == 0{
                    Button {
                        if itemAdded == 0{
                            itemAdded += 1
                            withAnimation(.bouncy) {
                                productIncart.append(medicine)
                            }
                        }
                    } label: {
                        Text("Add")
                            .font(.system(size: 14))
                            .padding(4)
                            .padding(.horizontal)
                            .foregroundColor(Color("Primary"))
                    }
                    .background(RoundedRectangle(cornerRadius: 5).stroke(Color("Primary"),lineWidth: 1.0))
//                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }else{
                    HStack{
                        Button {
                            if itemAdded > 0{
                                itemAdded -= 1
                                if itemAdded == 0{
                                    withAnimation(.bouncy) {
                                        productIncart.removeAll{$0.id == medicine.id}
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "minus")
                                .padding(.leading,1)
                                .padding(.vertical, 4)
                                .frame(maxHeight: .infinity)
                        }
                        Text("\(itemAdded)")
                            .bold()
                        Button {
                            if itemAdded < medicine.remainingItemValue{
                                itemAdded += 1
                            }
                        } label: {
                            Image(systemName: "plus")
                                .padding(.trailing,1)
                                .padding(.vertical, 4)
                                .frame(maxHeight: .infinity)
                                
                        }
                        
                    }
                    .frame(width: geo.size.width * 0.18)
                    .background(Color("Primary"))
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }

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
            .environment(MainTabbarViewModel())
            .environment(ProgressbarViewModel())
            .environment(AlertManager())
    }
}
