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
            VStack {
                HStack {
                    Text(bets.name)
                        .font(.system(size: 20, weight: .bold, design: .default))
                        .padding([.top, .bottom], 10)
                    Spacer()
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
                }
                Spacer()
                ForEach(bets.arrayOfLines, id: \.self) { key in
                    HStack {
                        PlayerBetOddsView(bet: key)
                        Spacer()
                        HeadToHeadOrSeasonDetailView(state: dataVolumeType)
                    }
                    
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding(.leading, 15)
            Spacer()
            VStack(alignment: .trailing) {
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
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(CardModifier())
        .padding(.all, 10)
    }
}

struct PlayerPropsCardView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPropsCardView(home: SampleData.home, away: SampleData.away, bets: SampleData.playerProps[0].players[0], dataVolumeType: .last10, showDeepDiveView: false)
    }
}
