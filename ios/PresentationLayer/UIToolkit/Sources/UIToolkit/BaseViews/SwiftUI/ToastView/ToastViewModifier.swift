//
//  Created by Tomas Brand on 21.11.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import SwiftUI

struct ToastViewModifier: ViewModifier {
    
    @Binding private(set) var toastData: ToastData?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView().offset(y: -30)
                }
                .animation(.spring(), value: toastData)
            )
            .onChange(of: toastData) { _ in
                showToast()
            }
    }
    
    @ViewBuilder private func mainToastView() -> some View {
        if let toastData = toastData {
            VStack {
                Spacer()
                ToastView(ToastData(toastData.title, style: toastData.style))
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toastData = toastData else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toastData.hideAfter > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
               dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toastData.hideAfter, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toastData = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}
