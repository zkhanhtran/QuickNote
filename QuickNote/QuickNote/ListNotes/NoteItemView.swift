//
//  NoteItemView.swift
//  QuickNote
//
//  Created by Khanh Tran on 20/12/2023.
//

import SwiftUI

struct NoteItemView: View {
    var note: NoteModel
    var deleteCompletion:(() -> Void)?
    
    var body: some View {
        ZStack {
            Color(note.colorString)
            VStack {
                HStack {
                    Text(note.title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color("text_color"))
                        .lineLimit(2)
                    Spacer()
                }
                
                HStack {
                    let time = dateToString()
                    Text(time)
                        .font(.system(size: 12, weight: .semibold))
                    Spacer()
                    
                    Button(action: {
                        deleteCompletion?()
                    }, label: {
                        Image("ic-delete")
                            .renderingMode(.template)
                            .foregroundColor(.orange)
                    })
                }
                .padding([.top, .bottom], 8)
                
                Divider()
                    .padding(.bottom, 8)
                
                HStack(alignment: .top) {
                    Text(note.content)
                        .font(.system(size: 14))
                        .foregroundColor(Color("text_color"))
                        .multilineTextAlignment(.leading)
                        .lineLimit(10)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
        }
        .cornerRadius(8)
    }
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: note.date)
    }
}

#Preview {
    NoteItemView(note: NoteModel())
}
