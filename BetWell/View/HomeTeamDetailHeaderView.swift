//
//  HomeTeamDetailHeaderView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct HomeTeamDetailHeaderView: View {
    let team: Home
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
                NavigationLink("", destination:  TeamDeepDiveView(), isActive: $goToDeepDive)
            }
            Text(team.alias)
                .fontWeight(.bold)
            Text("\(team.standings.record)(\(team.standings.rank.confRank)th)")
                .font(.caption2)
        }
    }
}

//struct HomeTeamDetailHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTeamDetailHeaderView(team: SampleData.home)
//    }
//}
