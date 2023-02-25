//
//  PlayingTodayView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct PlayingTodayView: View {
    let game: NewUpcomingGame
    var body: some View {
        HStack(spacing: 0.5) {
            VStack(alignment: .center) {
                Text(game.away.alias)
                    .allowsTightening(true)
                    .lineLimit(2)
                    .scaledToFit()
                    .minimumScaleFactor(0.4)
                Image(game.away.alias)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            .padding(.leading, 10)
            Spacer()
            Text("@")
            Spacer()
            VStack(alignment: .center) {
                Text(game.home.alias)
                    .allowsTightening(true)
                    .lineLimit(2)
                    .scaledToFit()
                    .minimumScaleFactor(0.4)
                Image(game.home.alias)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            Spacer()
            Text(game.venue)
                .font(.subheadline)
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                .minimumScaleFactor(0.4)
            Spacer()
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(.clear)
    }
    
    func parseName(_ string: String) -> String {
        let parsed = string.components(separatedBy: " ")
        if parsed.count >= 2 {
            let count = parsed.count
            print("\(parsed[count - 1])")
            return parsed[parsed.count - 1]
        } else {
            return string
        }
    }
}

//struct PlayingTodayView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayingTodayView(game: NewUpcomingGame(statsGameID: "210941", time: "7:30 ET", venue: "TD Garden", home: SampleData.home, away: SampleData.away, oddsEventID: "Stringhere", bookmakers: [Bookmaker(key: <#T##BookmakerKey#>, title: <#T##Title#>, lastUpdate: <#T##Date#>, markets: <#T##[Market]#>)]))
//    }
//}
