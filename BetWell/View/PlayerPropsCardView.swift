//
//  PlayerPropsCardView.swift
//  BetWell
//
//  Created by David Mann on 2/25/23.
//

import SwiftUI

struct PlayerPropsCardView: View {
    var home: Home
    var away: Away
    @State var bets: Player
    @State var dataVolumeType: DataVolumeType = .last10
    @State var showDeepDiveView = false
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .top) {
                VStack {
                    Text(bets.name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding([.top, .bottom], 10)
                    Spacer()
                    ForEach(bets.arrayOfLines, id: \.self) { line in
                        PlayerBetOddsView(bet: line)
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
                        NavigationLink("", destination: PlayerDeepDiveView(), isActive: $showDeepDiveView)
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
}

//struct PlayerPropsCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerPropsCardView(home: SampleData.home, away: SampleData.away, playerBet: .playerPoints, bets: Player(name: "Bojan Bogdanovic", assists: Optional(BetWell.Lines(line: 2.5, over: 120, under: -150)), points: Optional(BetWell.Lines(line: 20.5, over: -120, under: -110)), rebounds: BetWell.Lines(line: 3.5, over: -135, under: 105)))
//    }
//}
