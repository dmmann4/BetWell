//
//  TeamDataListView.swift
//  BetWell
//
//  Created by David Mann on 2/10/23.
//

import Foundation
import SwiftUI

struct TeamDataListView: View {
    
    var home: Home
    var away: Away
    var venue: String

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        HomeTeamDetailHeaderView(team: home)
                    }
                    .padding()
                    VStack(alignment: .center) {
                       Text(venue)
                            .font(.caption)
                       Text("Officials:")
                            .font(.caption)
                       Text("G. Brady, H. Smith, L. Jones")
                            .font(.caption)
                    }
                    VStack {
                        AwayTeamDetailHeaderView(team: away)
                    }
                }
                HStack {
                    HomeTeamTrendsView(team: home)
                    Spacer()
                    AwayTeamTrendsView(team: away)
                }
                MatchupDetailView(home: home, away: away)
                Spacer()
            }
        }.onAppear() {
          print("home \(home)")
          print("away \(away)")
        }
        .background(Color.init(red: 75, green: 68, blue: 83))
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
}

struct TeamDataListView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDataListView(home: SampleData.home, away: SampleData.away, venue: "TD Garden")
    }
}
