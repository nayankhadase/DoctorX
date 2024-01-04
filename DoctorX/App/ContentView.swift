//
//  ContentView.swift
//  DoctorX
//
//  Created by Nayan Khadase on 01/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var routes: [Route] = []
    @State private var showLogin = true
    
    var body: some View {
        NavigationStack(path: $routes){
            ZStack{
                VStack{
                    LoginOptionsView()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route{
                case .loginIn:
                    LoginOptionsView()
                case .registration:
                    SignupView()
                case .mainTabbar:
                    MainTabBarView()
                case .genderSelection(let viewModel):
                    GenderSelectionView()
                        .environment(viewModel)
                case .appointments(let viewModel, let homeVM):
                    AppointmentsView()
                        .environment(viewModel)
                        .environment(homeVM)
                case .profile(let viewModel):
                    ProfileView()
                        .environment(viewModel)
                case .address:
                    AddressView()
                }
            }
            
        }
        .environment(\.navigate){ navType in
            DispatchQueue.main.async{
                switch navType{
                    
                case .push(let route):
                    if route == .loginIn{
                        routes = []
                    }else{
                        routes.append(route)
                    }
                    print(routes)
                case .unWind(let route):
                    if route == .loginIn{
                        routes = []
                    }else{
                        guard let index = routes.firstIndex(where: {$0 == route}) else{
                            return
                        }
                        routes = Array(routes.prefix(upTo: index + 1))
                    }
                    print(routes)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(AlertManager())
            .environment(LoginViewModel())
            .environment(ProgressbarViewModel())
    }
}

typealias navigateType = ((NavigationType) -> Void)

/// Routes & Environment value
enum Route: Hashable, Equatable{
    
    case loginIn
    case registration
    case genderSelection(SignupViewModel)
    case mainTabbar
    case appointments(SideviewViewModel, HomeViewModel)
    case profile(SideviewViewModel)
    case address
    
    func hash(into hasher: inout Hasher) {
           switch self {
           case .loginIn:
               hasher.combine("loginIn")
           case .registration:
               hasher.combine("registration")
           case .genderSelection(_):
               hasher.combine("genderSelection")
//               hasher.combine(model) // Include model in hash calculation
           case .mainTabbar:
               hasher.combine("mainTabbar")
           case .appointments:
               hasher.combine("appointments")
           case .profile(_):
               hasher.combine("profile")
           case .address:
               hasher.combine("address")
           }
       }
    
    static func == (lhs: Route, rhs: Route) -> Bool {
            switch (lhs, rhs) {
            case (.loginIn, .loginIn),
                 (.registration, .registration),
                (.mainTabbar, .mainTabbar),
                (.appointments(_,_), .appointments(_,_)),
                (.genderSelection(_), .genderSelection(_)),
                (.profile(_), .profile(_)),
                (.address, .address):
                return true
            default:
                return false
            }
        }
    
}

enum NavigationType: Hashable{
    case push(Route)
    case unWind(Route)
}

struct NavigateEnvironmentKey: EnvironmentKey{
    static var defaultValue: (NavigationType) -> Void = { _ in }
}

extension EnvironmentValues{
    var navigate: (NavigationType) -> Void{
        get{ self[NavigateEnvironmentKey.self]}
        set{ self[NavigateEnvironmentKey.self] = newValue}
    }
}
