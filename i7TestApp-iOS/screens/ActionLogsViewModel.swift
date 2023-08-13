//
//  ActionLogsViewModel.swift
//  i7TestApp-iOS
//
//  Created by Mark Caguioa on 8/13/23.
//

import Foundation
import SwiftUI

protocol ActionLogsViewModel: ObservableObject {
    func loadLogs() async
}

@MainActor
final class ActionLogsViewModelImpl: ActionLogsViewModel {
    
    @Published var btnActions: [ButtonActionModel] = []
    
    private let repo: AppRepo
    
    init() {
        repo = AppRepo()
    }
    
    func loadLogs() async {
        btnActions = repo.getBtnActions() ?? []
    }
    
    func getDisplayAction(buttonId: String?) -> String {
        if let btnId = buttonId {
            return "\(btnId) pressed"
        }
        return ""
    }
    
    func getDisplayDateFormat(date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}

