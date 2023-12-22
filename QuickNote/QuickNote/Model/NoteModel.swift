//
//  NoteModel.swift
//  QuickNote
//
//  Created by Khanh Tran on 19/12/2023.
//

import Foundation

struct NoteModel: Identifiable, Codable {
    var id = UUID()
    var title: String = "Untitled"
    var content: String = ""
    var date: Date = Date()
    var colorString: String = Helper.randomColorString()
}
