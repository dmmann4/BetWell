//
//  MatchupView.swift
//  BetWell
//
//  Created by David Mann on 1/16/23.
//

import SwiftUI

enum ProfileSection : String, CaseIterable {
    case tweets = "Tweets"
    case media = "Media"
    case likes = "Likes"
}

struct MatchupView: View {
    @State var segmentationSelection : ProfileSection = .tweets
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Image(systemName: "basketball")
                    Text("home team")
                }
                .padding()
                Spacer()
                VStack {
                    Text("Last 5 VS")
                    Text("4-1")
                }
                Spacer()
                VStack {
                    Image(systemName: "basketball")
                    Text("away team")
                }
                .padding()
            }
            Picker("", selection: $segmentationSelection) {
                ForEach(ProfileSection.allCases, id: \.self) { option in
                    Text(option.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
            
        }
    }
}

struct MatchupView_Previews: PreviewProvider {
    static var previews: some View {
        MatchupView()
    }
}
