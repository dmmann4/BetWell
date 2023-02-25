//
//  AwayTeamDetailHeaderView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct AwayTeamDetailHeaderView: View {
    @State var goToDeepDive = false
    @Environment(\.colorScheme) var colorScheme
    let team: Away
    var body: some View {
        VStack {
            ZStack {
                Button {
                    goToDeepDive.toggle()
                    print("away team logo button pressed")
                   
                } label: {
                    Image(team.alias)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 44, height: 44)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                NavigationLink("", destination:  TeamDeepDiveView(), isActive: $goToDeepDive)
            }
            
            Text(team.alias)
                .fontWeight(.bold)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            Text("\(team.standings.record)(\(team.standings.rank.confRank)th)")
                .font(.caption2)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        }
    }
}

struct AwayTeamDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AwayTeamDetailHeaderView(team: SampleData.away)
    }
}
