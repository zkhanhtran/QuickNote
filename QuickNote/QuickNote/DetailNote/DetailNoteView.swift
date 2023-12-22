//
//  DetailNoteView.swift
//  QuickNote
//
//  Created by Khanh Tran on 19/12/2023.
//

import SwiftUI

struct DetailNoteView: View {
    @StateObject var viewModel: DetailNoteViewModel
    @Environment(\.dismiss) var dismiss
    
    private enum Field: Int, Hashable {
        case title
        case content
    }
    
    @FocusState private var focused: Field?
    
    init(viewModel: DetailNoteViewModel = DetailNoteViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            
            Color("background_color")
            
            VStack() {
                TextField("Note Title", text: $viewModel.note.title)
                    .padding()
                    .border(Color("boder_color"))
                    .cornerRadius(8)
                    .foregroundColor(Color("text_color"))
                    .padding([.trailing, .top, .leading])
                    .focused($focused, equals: .title)
                
                TextEditor(text: $viewModel.note.content)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(Color("text_color"))
                    .padding()
                    .border(Color("boder_color"))
                    .cornerRadius(8)
                    .padding()
                    .focused($focused, equals: .content)
            }
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                focused = .content
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("New Note")
                    .font(.system(size: 18, weight: .bold))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    viewModel.note.date = Date()
                    viewModel.completion?(viewModel.note)
                    dismiss()
                }, label: {
                    Text("Done")
                        .foregroundColor(Color("bar_color"))
                })
            }
        }
    }
}

#Preview {
    DetailNoteView(viewModel: DetailNoteViewModel())
}
