//
//  MainViewModel.swift
//  i7TestApp-iOS
//
//  Created by Mark Caguioa on 8/12/23.
//

import Foundation
import SwiftUI

protocol MainViewModel: ObservableObject {
    func onPressButton(buttonId: String) async
}

@MainActor
final class MainViewModelImpl: MainViewModel {
    
    private let repo: AppRepo
    
    @Published
    var showActionLogsView = false
    
    init() {
        repo = AppRepo()
    }
    
    func onPressButton(buttonId: String) async {
        var btnAction = ButtonActionModel()
        btnAction.id = UUID().uuidString
        btnAction.buttonId = buttonId
        btnAction.dateTime = Date.now
        repo.saveButtonAction(btnAction)
        
        showActionLogsView = true
    }
}
