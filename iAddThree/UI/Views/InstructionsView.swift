//
//  InstructionsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import SwiftUI

struct InstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: InstructionsDataModel
    
    private var showNextButton: Bool { dataModel.showNextButton }
    private var showPreviousButton: Bool { dataModel.showPreviousButton }
    
    private func turnPage(backwards: Bool = false) {
        withAnimation { dataModel.turnPage(backwards: backwards) }
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark").setChalkFont(.title3)
                    }.padding([.horizontal, .top])
                }
                
                if dataModel.showHowToTitle {
                    Text("How to Play")
                        .lineLimit(1)
                        .setChalkFont(.title, autoSize: true)
                        .padding(.horizontal)
                        .transition(.scale(scale: 0.15, anchor: .top))
                }
                
                Text(dataModel.modeTitle)
                    .setChalkFont(.title2)
            }
            
            NumberListView(list: dataModel.sampleList)
                .padding(.vertical)
            
            VStack {
                Text(dataModel.instructions)
                    .setSmoothFont(.subheadline, autoSize: true)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding([.horizontal])
                
                HStack {
                    ToolBarButton(text: "Previous", color: .red, isShowing: showPreviousButton, action: { turnPage(backwards: true) })
                    Spacer()
                    ToolBarButton(text: "Next", color: .green, isShowing: showNextButton, action: { turnPage() })
                }.padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.black.opacity(0.5))
            .cornerRadius(20)
            .padding()
        }.onChalkboard()
    }
}


// MARK: - ToolBarButton
fileprivate struct ToolBarButton: View {
    let text: String
    let color: Color
    let isShowing: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .underline()
                .setSmoothFont(.title3, textColor: color)
        }).opacity(isShowing ? 1 : 0)
    }
}


// MARK: - Previews
struct InstructionsView_Previews: PreviewProvider {
    static func makeDataModel(_ mode: GameMode = .add) -> InstructionsDataModel {
        InstructionsDataModel(mode: mode, instructionsList: InstructionsFactory.makeInstructions(for: mode))
    }
    
    static var previews: some View {
        InstructionsView(dataModel: makeDataModel())
    }
}
