//
//  HeadToHeadOrSeasonDetailView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct HeadToHeadOrSeasonDetailView: View {
    var state: DataVolumeType
    var body: some View {
        Text(state == .last10 ? " 'Last 10 games results' " : " 'Season results' ")
            .font(.system(size: 16, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(.top, 8)
    }
}

struct HeadToHeadOrSeasonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeadToHeadOrSeasonDetailView(state: .last10)
    }
}
