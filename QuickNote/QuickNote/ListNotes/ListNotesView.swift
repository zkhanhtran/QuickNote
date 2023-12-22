//
//  ListNotesView.swift
//  QuickNote
//
//  Created by Khanh Tran on 19/12/2023.
//

import SwiftUI

struct ListNotesView: View {
    @StateObject var viewModel: ListNotesViewModel
    @Environment(\.scenePhase) var scenePhase
    
    init(viewModel: ListNotesViewModel = ListNotesViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background_color")
                    //.ignoresSafeArea()
                VStack {
                    
                    actionBarView()

                    listNotesView()
                    //Spacer()
                }
                
                buttonAddNote()
                
                if viewModel.notes.isEmpty {
                    Text("Your notes is empty!")
                        .foregroundColor(Color("empty_color"))
                        .font(.system(size: 18, weight: .bold))
                }
            }
            .overlay(alignment: .center, content: {
                if viewModel.isLoading {
                    LoadingView()
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Quick Note")
                        .font(.system(size: 18, weight: .bold))
                }
            }
        }
        .onAppear(perform: {
            viewModel.loadData()
        })
        .onChange(of: scenePhase) { newPhase in
                        if newPhase == .background {
                            viewModel.saveData()
                        }
                    }
    }
    
    func actionBarView() -> some View {
        return HStack {
            TextField("search", text: $viewModel.searchText)
                .foregroundColor(Color("text_color"))
                .textFieldStyle(.roundedBorder)
                .frame(height: 60)
            
            Button(action: {
                viewModel.isAscending = !viewModel.isAscending
            }, label: {
                Image("ic-filter")
                    .renderingMode(.template)
                    .foregroundColor(.orange)
            })
        }
        .padding([.leading, .trailing])
    }
    
    func listNotesView() -> some View {
        let columns = [
            GridItem(.adaptive(minimum: 140))
        ]

        return ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.displayNotes, id: \.id) { item in
                    NavigationLink {
                        DetailNoteView(viewModel: DetailNoteViewModel(note: item, completion: { model in
                            viewModel.update(note: model)
                        }))
                    } label: {
                        NoteItemView(note: item) {
                            viewModel.delete(note: item)
                        }
                        .frame(minHeight: 200, maxHeight: 300)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding([.trailing, .leading])
        }
    }
    
    func buttonAddNote() -> some View {
        return VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: DetailNoteView(viewModel: DetailNoteViewModel(completion: { note in
                    viewModel.update(note: note)
                }))) {
                    Image("ic-note")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .padding([.trailing, .bottom], 30)
                }
            }
        }
    }
}

#Preview {
    ListNotesView(viewModel: ListNotesViewModel())
}
