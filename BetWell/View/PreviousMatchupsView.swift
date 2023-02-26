//
//  PreviousMatchupsView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct PreviousMatchupsView: View {
    let game: NewUpcomingGame
    var body: some View {
        VStack(alignment: .leading) {
            Text("Previous Matchup")
            Text("12/17 @Home 123(BOS)-115(PHI)")
            Text("\(game.home.alias): Assists: 32 Rebounds: 45 Total 3's: 14")
            Text("\(game.away.alias): Assists: 21 Rebounds: 34 Total 3's: 16")
            Text("Officials: G. Brady, H. Smith, L. Jones")
        }
        .font(.caption)
    }
}

struct PreviousMatchupsView_Previews: PreviewProvider {
    static var previews: some View {
        PreviousMatchupsView(game: NewUpcomingGame(statsGameId: "210941", time: "7:30 ET", venue: "TD Garden", home: SampleData.home, away: SampleData.away, oddsEventID: "Stringhere", bookmakers: SampleData.bookmaker))
    }
}
