//
//  ActionLogsView.swift
//  i7TestApp-iOS
//
//  Created by Mark Caguioa on 8/13/23.
//

import Foundation
import SwiftUI

struct ActionLogsView: View {
    
    @StateObject private var vm = ActionLogsViewModelImpl()
    
    var body: some View {
        VStack {
            List(vm.btnActions) { actionLog in
                VStack (alignment: .leading) {
                    Text(vm.getDisplayAction(buttonId: actionLog.buttonId)).bold()
                    Text(vm.getDisplayDateFormat(date: actionLog.dateTime))
                }
                .padding(8)
            }
        }
        .onAppear {
            Task {
                await vm.loadLogs()
            }
        }
    }
}
