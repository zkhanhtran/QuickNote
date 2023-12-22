//
//  LoadingView.swift
//  QuickNote
//
//  Created by Khanh Tran on 20/12/2023.
//

import SwiftUI

struct LoadingView: View {
    @State var isRotating = 0.0
    @State var isLoading: Bool = false
    
    private var foreverAnimation: Animation {
            Animation.linear(duration: 3.0)
                .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.3)
                .ignoresSafeArea()
            
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .foregroundColor(.white)
                Image("ic-loading")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.orange)
                    .frame(width: 80, height: 80)
                    .rotationEffect(Angle(degrees: self.isLoading ? 360 : 0.0))
                    .animation(self.isLoading ? foreverAnimation : .default, value: isLoading)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.isLoading = true
                        }
                    }
                    .onDisappear {
                        DispatchQueue.main.async {
                            self.isLoading = false
                        }
                    }
                
            }
            .frame(width: 250, height: 200)
            .padding(.bottom, 100)
        }
    }
}

#Preview {
    LoadingView()
}
