//
//  ProgressbarViewModel.swift
//  DoctorX
//
//  Created by Nayan Khadase on 25/12/23.
//

import SwiftUI
import Observation

@Observable
class ProgressbarViewModel{
    var showProgressbar = false
    var showProgressBarAtBottom = false
    var rotate = false
    
    func showProgressBar(atBottom: Bool = false){
        DispatchQueue.main.async {
            self.showProgressBarAtBottom = atBottom
            self.showProgressbar = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.rotate = true
            })
            
        }
    }
    
    func hideProgressBar(){
        DispatchQueue.main.async {
            self.showProgressbar = false
            self.showProgressBarAtBottom = false
            self.rotate = false
        }
    }
}

