//
//  HomeTeamDetailHeaderView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct TeamDetailHeaderView: View {
    let team: Team
    @State var goToDeepDive = false
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
                NavigationLink("", destination:  TeamDeepDiveView(teamName: team.name, teamLogo: team.alias), isActive: $goToDeepDive)
            }
            Text(team.alias)
                .fontWeight(.bold)
            Text("\(team.standings.record)(\(team.standings.rank.confRank)th)")
                .font(.caption2)
        }
    }
}

struct TeamDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TeamDetailHeaderView(team: SampleData.home)
    }
}
