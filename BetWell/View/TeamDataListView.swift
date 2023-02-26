//
//  TeamDataListView.swift
//  BetWell
//
//  Created by David Mann on 2/10/23.
//

import Foundation
import SwiftUI

struct TeamDataListView: View {
    var teamBooks: [Bookmaker]
    var home: Home
    var away: Away
    var venue: String
    @State var books: [String] = []

    var body: some View {
        ScrollView {
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        HomeTeamDetailHeaderView(team: home)
                        HomeTeamTrendsView(team: home)
                    }
//                    VStack(alignment: .center) {
//                       Text(venue)
//                            .font(.caption2)
//                       Text("Officials:")
//                            .font(.caption2)
//                       Text("G. Brady, H. Smith, L. Jones")
//                            .font(.caption2)
//                    }
//                    .frame(width: 50)
                    VStack {
                        AwayTeamDetailHeaderView(team: away)
                        AwayTeamTrendsView(team: away)
                    }
                   
                }
                MatchupDetailView(oddBetID: SampleData.oddsID, home: home, away: away, teamBooks: teamBooks)
                Spacer()
            }
        }.onAppear() {
            
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct TeamDataListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDataListView(teamBooks: SampleData.bookmaker, home: SampleData.home, away: SampleData.away, venue: "TD Garden")
    }
}
