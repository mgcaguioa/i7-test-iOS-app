//
//  ContentView.swift
//  i7TestApp-iOS
//
//  Created by Mark Caguioa on 8/12/23.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var vm = MainViewModelImpl()
    
    var body: some View {
        NavigationStack {
            VStack {
                ForEach(1...4, id: \.self) {
                    AppButton(
                        text: "Button \($0)",
                        action: { buttonId in
                            Task {
                                await vm.onPressButton(buttonId: buttonId)
                            }
                        }
                    )
                }
            }
            .navigationDestination(isPresented: $vm.showActionLogsView) {
                ActionLogsView()
            }
        }
    }
}

@ViewBuilder
func AppButton(text: String, action: @escaping (String) -> Void) -> some View {
    Button(action: { action(text) }) {
        Text(text)
            .padding()
            .padding(.horizontal, 32)
    }
    .foregroundColor(.white)
    .background(.green)
    .cornerRadius(12)
    .padding()
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
