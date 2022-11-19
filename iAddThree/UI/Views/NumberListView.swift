//
//  NumberListView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct NumberListView: View {
    let list: [NumberItemPresenter]
    let isPlaying: Bool
    let gridItems = [GridItem()]
    
    init(list: [NumberItemPresenter], isPlaying: Bool = false) {
        self.list = list
        self.isPlaying = isPlaying
    }
    
    var body: some View {
        HStack(spacing: getWidthPercent(5)) {
            ForEach(list) { item in
                NumberItemRow(item: item, isPlaying: isPlaying)
            }
        }
    }
}


// MARK: - Row
fileprivate struct NumberItemRow: View {
    let item: NumberItemPresenter
    let isPlaying: Bool
    
    private var answer: String { item.userAnswer ?? "" }
    private var answerColor: Color { item.isCorrect ? .green : .red }
    
    
    var body: some View {
        VStack(spacing: 0) {
            Text(item.number)
                .padding(.horizontal)
                .opacity(item.userAnswer == nil ? 1 : 0.5)
                .setChalkFont(item.userAnswer == nil ? .largeTitle : .title3)
            
            if let answer = item.userAnswer {
                Divider()
                    .background(.white)
                Text(answer)
                    .setChalkFont(.largeTitle, textColor: answerColor)
            }
        }
        .frame(maxWidth: getWidthPercent(18))
        .background(.black.opacity(0.6))
        .multilineTextAlignment(.center)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


// MARK: - Preview
struct NumberListView_Previews: PreviewProvider {
    static var previews: some View {
        NumberListView(list: NumberItemPresenter.defaultList).onChalkboard()
    }
}
