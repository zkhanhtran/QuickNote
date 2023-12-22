//
//  DataManager.swift
//  QuickNote
//
//  Created by Khanh Tran on 19/12/2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    let backgroundQueue = DispatchQueue.global(qos: .background)
    
    private init() {}
    
    func loadData(completion: (([NoteModel]) -> Void)?) {
        backgroundQueue.async {
            var notes: [NoteModel] = []
            if let data = UserDefaults.standard.object(forKey: "notes") as? Data {
                let decoder = JSONDecoder()
                if let savedNotes = try? decoder.decode([NoteModel].self, from: data) as [NoteModel] {
                   notes = savedNotes
                }
                completion?(notes)
            } else {
                completion?(notes)
            }
        }
    }
    
    func saveData(notes: [NoteModel]) {
        print("save data in main thread\(Thread.isMainThread)")
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notes){
           UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
}
