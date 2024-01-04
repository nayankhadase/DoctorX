//
//  EditProfileImage.swift
//  DoctorX
//
//  Created by Nayan Khadase on 28/12/23.
//

import SwiftUI
import Kingfisher

struct EditProfileImage: View {
//    @Binding var sideviewVM: SideviewViewModel
    @Environment(SideviewViewModel.self) var sideviewVM
    @State private var showSheet = false
    @Binding var selectedImage: KFImage?
    @State private var tempImage: UIImage?
    
    var body: some View {
        ZStack{
            Color.gray.opacity(0.2)
            VStack{
                if selectedImage != nil && tempImage == nil{
                    selectedImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .background()
                    .clipShape(Circle())
                    
                    .shadow(radius: 2)
                }else{
                    Image(uiImage: ((tempImage) ?? UIImage(named: "dr")!))
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .background()
                        .clipShape(Circle())
                        
                        .shadow(radius: 2)
                }
                
                HStack{
                    Button(action: {
                        showSheet.toggle()
                    }, label: {
                        Text("Select Image")
                            .padding()
                            .frame(maxWidth: .infinity)
                        
                    })
                    
                    .background()
                    .clipShape(Capsule())
                    
                    Button(action: {
                        
                        
                        guard var tempImage = tempImage else{ return }
                        
                        let height = tempImage.size.height
                        let width = tempImage.size.width
                        let minSide = min(height, width)
                        let rect = CGRect(x: (width - minSide) / 2, y: (height - minSide) / 2, width: minSide, height: minSide)
                        
                        tempImage = cropImage(tempImage, toRect: rect)
                        sideviewVM.handleProfilePhotoChange(image: tempImage)
                        
                        print("image uploaded")
                    }, label: {
                        Text("Save")
                            .padding()
                            .frame(maxWidth: .infinity)
                        
                    })
                    .disabled(tempImage == nil)
                    .background()
                    .clipShape(Capsule())
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                
            }
        }
        .sheet(isPresented: $showSheet, content: {
            ImagePicker(image: $tempImage)
        })
        .onAppear{
            tempImage = nil
        }
    }
    
    func cropImage(_ image: UIImage, toRect rect: CGRect) -> UIImage {
           if let cgImage = image.cgImage?.cropping(to: rect) {
               return UIImage(cgImage: cgImage)
           }
           return image
       }
}

#Preview {
    EditProfileImage(selectedImage: .constant(nil))
        .environment(SideviewViewModel())
}
