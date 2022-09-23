//
//  NumberPadView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct NumberPadView: View {
    private let numbers: [String?] = ["7", "8", "9", "4", "5", "6", "1", "2", "3", nil, "0"]
    private var number: CGFloat { 25 }
    private var columns: [GridItem] {
        [GridItem(.adaptive(minimum: getWidthPercent(number))),
         GridItem(.adaptive(minimum: getWidthPercent(number))),
         GridItem(.adaptive(minimum: getWidthPercent(number)))]
    }
    
    let selection: (String) -> Void
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: getWidthPercent(4)) {
            ForEach(numbers, id: \.self) { number in
                NumberPadButton(number: number, selection: selection)
            }
        }
    }
}


// MARK: - Button
fileprivate struct NumberPadButton: View {
    let number: String?
    let selection: (String) -> Void
    
    private var text: String { "\(number ?? "")" }
    private var sizeNumber: CGFloat { getWidthPercent(20) }
    private func submitNumber() {
        if let number = number {
            withAnimation { selection(number) }
        }
    }

    var body: some View {
        if number == nil {
            Text("")
        } else {
            Button(action: submitNumber) {
                Text(text)
                    .setChalkFont(.largeTitle, textColor: .black)
                    .padding(10)
                    .frame(maxWidth: sizeNumber, maxHeight: sizeNumber)
            }
        }
    }
}



struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        PlayView_Previews.previews
    }
}
