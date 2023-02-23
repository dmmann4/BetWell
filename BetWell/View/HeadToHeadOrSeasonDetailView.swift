//
//  HeadToHeadOrSeasonDetailView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct HeadToHeadOrSeasonDetailView: View {
    var state: MatchupDataSelection
    var body: some View {
        Text(state == .h2h ? "Last 10 games results" : "Season results")
            .font(.system(size: 16, weight: .bold, design: .default))
            .foregroundColor(.white)
            .padding(.top, 8)
    }
}

struct HeadToHeadOrSeasonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HeadToHeadOrSeasonDetailView(state: .h2h)
    }
}
