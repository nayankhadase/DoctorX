//
//  ProgressbarView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 25/12/23.
//

import Foundation
import SwiftUI

struct ProgressbarView: ViewModifier{
    @Bindable var progressbarView: ProgressbarViewModel
    
    var foreverAnimation: Animation {
            Animation.linear(duration: 2.0)
                .repeatForever(autoreverses: false)
        }
    
    
    func body(content: Content) -> some View {
        if progressbarView.showProgressBarAtBottom{
            VStack{
                content
                if progressbarView.showProgressbar{
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 0).fill(Color("Secondary")))
                }
            }
        }else{
            ZStack{
                    content
                    if progressbarView.showProgressbar{
//                        ProgressView()
//                            .frame(width: 300, height:300)
//                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("Secondary")))
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
//                            .background(Color.black.opacity(0.6))
//                            .ignoresSafeArea(edges: .all)
//                        GeometryReader { _ in
//                            EmptyView()
//                        }
//                        .background(.gray.opacity(0.5))
//                        .opacity(0)
                        VStack{
                            ZStack{
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .background(Color.black.opacity(0.5))
                                    .opacity(0.4)
                                    .ignoresSafeArea(.all)
                                
                                VStack{
                                    Spacer()
                                    Image(systemName: "volleyball.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70)
                                        .foregroundStyle(Color("Primary"))
                                        .rotationEffect(Angle(degrees: progressbarView.rotate ? 360 : 0.0))
                                        .animation(progressbarView.rotate ? foreverAnimation : .default, value: progressbarView.rotate)
                                        .offset(y: 10)
                                    Spacer()
                                    Text("Please wait! Loading...")
                                        .padding(.bottom)
                                }
                                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.width * 0.7)
                                .background()
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                            
                        }
                    }
                
            }
        }
    }
}
