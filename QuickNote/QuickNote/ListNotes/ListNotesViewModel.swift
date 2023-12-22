//
//  ListNotesViewModel.swift
//  QuickNote
//
//  Created by Khanh Tran on 19/12/2023.
//

import Foundation
import Combine

class ListNotesViewModel: ObservableObject {
    let dataService: DataManager
    
    @Published var notes: [NoteModel]
    
    @Published var displayNotes: [NoteModel] = []
    
    @Published var searchText = ""
    
    @Published var isLoading: Bool = false
    
    @Published var isAscending: Bool = true

    private var cancellables = Set<AnyCancellable>()
    
    init(dataService: DataManager = DataManager.shared, notes: [NoteModel] = []) {
        self.dataService = dataService
        self.notes = notes
        binding()
    }
    
    func binding() {
        $searchText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] text in
                self?.search(text: text)
            })
            .store(in: &cancellables)
        
        $isAscending
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                guard let self = self else { return }
                self.displayNotes = self.sort(notes: self.displayNotes, isAscending: value)
            })
            .store(in: &cancellables)
            
    }
    
    func delete(note: NoteModel) {
        if let idx = notes.firstIndex(where: {$0.id == note.id}) {
            notes.remove(at: idx)
            search(text: searchText)
        }
    }
    
    func update(note: NoteModel) {
        if let idx = notes.firstIndex(where: {
            $0.id == note.id
        }) {
            notes[idx] = note
        } else {
            notes.append(note)
        }
        search(text: searchText)
    }
    
    func loadData() {
        self.isLoading = true
        dataService.loadData {[weak self] notes in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                self.notes = notes
                self.displayNotes = self.sort(notes: self.notes, isAscending: self.isAscending)
            }
        }
    }
    
    func saveData() {
        dataService.saveData(notes: notes)
    }
    
    func search(text: String) {
        var searchedNotes: [NoteModel] = []
        if text.isEmpty {
            searchedNotes = notes
        } else {
            searchedNotes = notes.filter{ $0.content.lowercased().contains(text.lowercased())
                || $0.title.lowercased().contains(text.lowercased()) }
        }
        displayNotes = sort(notes: searchedNotes, isAscending: isAscending)
    }
    
    func sort(notes: [NoteModel], isAscending: Bool) -> [NoteModel] {
        notes.sorted(by: {
            if isAscending {
                $0.date > $1.date
            } else {
                $0.date < $1.date
            }
        })
    }
}
