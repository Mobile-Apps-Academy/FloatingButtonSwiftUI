//
//  AssistiveFloatingButton.swift
//  AssistiveTouch Like Button RnD
//
//  Created by Javid Shaikh on 20/01/24.
//

import SwiftUI

struct AssistiveFloatingButton : View {
    
    @State private var dragAmount: CGPoint?
    @State var opacityState: Double = 1
    var action : () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                        .shadow(radius: 3)
                        .overlay {
                            Image(systemName: "message.badge.filled.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        .opacity(opacityState)
                        .onTapGesture {
                            action()
                            withAnimation(.linear(duration: 0.1)) {
                                opacityState = 0.2
                            }
                            
                            withAnimation(.linear(duration: 0.1).delay(0.1)) {
                                opacityState = 1
                            }
                        }
                        .position(dragAmount ?? CGPoint(x: geometry.size.width-34, y: geometry.size.height-100))
                        .gesture(
                            DragGesture()
                                .onChanged { self.dragAmount = $0.location }
                                .onEnded { value in
                                    
                                    var currentPostion = value.location
                                    
                                    if currentPostion.x > (geometry.size.width/2) {
                                        currentPostion.x = geometry.size.width-34
                                    } else {
                                        currentPostion.x =  16
                                    }
                                    
                                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 100.0, damping: 10, initialVelocity: 0)) {
                                        dragAmount = currentPostion
                                    }
                                }
                        )
                        
                }
            }
        }
    }
}

#Preview {
    AssistiveFloatingButton{
        
    }
}
