//
//  DetailNoteViewModel.swift
//  QuickNote
//
//  Created by Khanh Tran on 20/12/2023.
//

import Foundation

class DetailNoteViewModel: ObservableObject {
    @Published var note: NoteModel
    var completion:((NoteModel) -> Void)?
    
    init(note: NoteModel = NoteModel(), completion: ((NoteModel) -> Void)? = nil) {
        self.note = note
        self.completion = completion
    }
}
