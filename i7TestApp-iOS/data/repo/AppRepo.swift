//
//  AppRepo.swift
//  i7TestApp-iOS
//
//  Created by Mark Caguioa on 8/12/23.
//

import Foundation
import CoreData

final class AppRepo {
    
    private let container: NSPersistentContainer
    private let request = NSFetchRequest<ButtonActionEntity>(entityName: "ButtonActionEntity")
    
    init() {
        container = NSPersistentContainer(name: "i7TestAppContainer")
        container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("yow.AppRepo.init.error: \(error)")
            }
        }
    }
    
    func saveButtonAction(_ btnAction: ButtonActionModel) {
        if let btnActions = getBtnActions() {
            if btnActions.contains(where: { $0.id == btnAction.id }) {
                return // avoid saving same action
            }
        }
        let vContext = self.container.viewContext
        let entity = ButtonActionEntity(context: vContext)
        if let id = btnAction.id { entity.id = id }
        if let btnId = btnAction.buttonId { entity.buttonId = btnId }
        if let dateTime = btnAction.dateTime { entity.dateTime = dateTime }
        
        do {
            if vContext.hasChanges {
                try vContext.save()
            }
        } catch {
            print("yow.AppRepo.saveButtonAction.error: \(error)")
        }
    }
    
    func getBtnActions() -> [ButtonActionModel]? {
        request.sortDescriptors = [NSSortDescriptor(key: "dateTime", ascending: false)]
        
        do {
            let result = try container.viewContext.fetch(request)
            return result.map { convertToModelFromEntity(entity: $0) }
            
        } catch {
            print("yow.AppRepo.getBtnActions.error: \(error)")
        }
        return nil
    }
    
    func convertToModelFromEntity(entity: ButtonActionEntity) -> ButtonActionModel {
        var model = ButtonActionModel()
        model.id = entity.id
        model.buttonId = entity.buttonId
        model.dateTime = entity.dateTime
        return model
    }
}
