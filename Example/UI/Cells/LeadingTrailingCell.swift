// Created for Example in 2022

import SwiftUI

struct LeadingTrailingCell: View {
    let leadingText: String
    let trailingText: String

    init(itemVO: ItemVO) {
        self.leadingText = itemVO.leadingText
        self.trailingText = itemVO.trailingText
    }

    var body: some View {
        HStack {
            Text(leadingText)
                .font(.body)
            Spacer()
            Text(trailingText)
                .font(.callout)
        }
    }
}

struct LeadingTrailingCell_Previews: PreviewProvider {
    static var previews: some View {
        let item = ItemVO(id: UUID(),
                          leadingText: "Movies",
                          trailingText: "Tony")
        
        LeadingTrailingCell(itemVO: item)
            .previewLayout(.sizeThatFits)
    }
}
