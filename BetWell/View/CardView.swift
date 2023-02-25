//
//  CardView.swift
//  BetWell
//
//  Created by David Mann on 2/22/23.
//

import SwiftUI

struct CardView: View {
    var home: Home
    var away: Away
    let teambet: TeamBets?
    let playerBet: PlayerBets?
    @State var playerORMatchup: MatchupDataSelection
    @State var dataVolumeType: DataVolumeType = .last10
    @State var showDeepDiveView = false
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                VStack {
                    if let teambet {
                        Text(teambet.rawValue)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding([.top, .bottom], 10)
                    } else {
                        Text(playerBet?.rawValue ?? "N/A")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding([.top, .bottom], 10)
                    }
                    Spacer()
                    if let teambet {
                        TeamBetOddsMatchupView(bet: teambet)
                    } else {
                        PlayerBetOddsView(bet: playerBet!)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.leading, 15)
                Spacer()
                VStack(alignment: .trailing) {
                    Picker("", selection: $dataVolumeType) {
                        ForEach(DataVolumeType.allCases, id: \.self) { option in
                            Text(option.rawValue)
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 175)
                    .padding(.top, 10)
                    HeadToHeadOrSeasonDetailView(state: dataVolumeType)
                    Spacer()
                    VStack {
                        Button {
                            showDeepDiveView.toggle()
                        } label: {
                            Text("More Details")
                                .frame(width: 75, height: 30)
                                .font(.caption)
                        }
                        NavigationLink("", destination: destinationView, isActive: $showDeepDiveView)
                    }
                }
            }
            .padding(.trailing, 20)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
    
    @ViewBuilder
    var destinationView: some View {
        playerORMatchup == .h2h ?  AnyView(MatchupDeepDiveView()) : AnyView(PlayerDeepDiveView())
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(home: SampleData.home, away: SampleData.away, teambet: .moneyLine, playerBet: .playerPoints, playerORMatchup: .h2h)
//    }
//}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}
