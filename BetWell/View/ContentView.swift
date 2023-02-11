//
//  ContentView.swift
//  BetWell
//
//  Created by David Mann on 1/15/23.
//

import SwiftUI
import CoreData
import Combine

struct Games: Identifiable {
    let id = UUID()
    let homeTeam: String
    let awayTeam: String
    let overUnder: String
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var  networking = Networking()
    @State var todaysGamesLocal: [UpcomingGame] = []
    @State var todaysGames: [UpcomingGame] = []
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach($todaysGames, id: \.statsGameID) { game in
                        NavigationLink {
                            MatchupView(game: game.wrappedValue)
                        } label: {
                            PlayingTodayView(game: game.wrappedValue)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("BetWell", displayMode: .large)
                .onAppear() {
                    searchText = ""
                    todaysGamesLocal = loadData()!
                    todaysGames = todaysGamesLocal
//                    networking.fetchTodaysGames { games in
//                        switch games {
//                            case .success(let count):
//                            todaysGamesLocal = count
//                            todaysGames =  todaysGamesLocal
//                            case .failure(let error):
//                                print(error.localizedDescription)
//                            }
//                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .searchable(text: $searchText, prompt: "Who is playing tonight?")
        .onChange(of: searchText) { index in
            if !index.isEmpty {
                todaysGames = todaysGamesLocal.filter { $0.home.name.contains(searchText) ||  $0.away.name.contains(searchText)}
            } else {
                todaysGames = todaysGamesLocal
            }
        }
    }
    
    var searchResults: [UpcomingGame] {
            if searchText.isEmpty {
                return todaysGames
            } else {
                return todaysGames.filter { $0.away.name.contains(searchText) ||  $0.home.name.contains(searchText)}
            }
        }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func loadData() -> [UpcomingGame]? {
        guard let url = Bundle.main.url(forResource: "UpcomingGames", withExtension: "json")
            else {
                print("Json file not found")
                return []
            }
        
        let data = try? Data(contentsOf: url)
        let users = try? JSONDecoder().decode([UpcomingGame].self, from: data!)
        return users
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct PlayingTodayView: View {
    var game: UpcomingGame
    var body: some View {
        HStack(spacing: 15.0) {
            VStack(alignment: .center) {
                Text(parseName(game.home.nickname))
                    .allowsTightening(true)
                    .lineLimit(2)
                    .scaledToFit()
                    .minimumScaleFactor(0.4)
                AsyncImage(url: URL(string: game.home.logo)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            .padding(.leading, 10)
            Spacer()
            Text("vs")
            Spacer()
            VStack(alignment: .center) {
                Text(parseName(game.away.nickname))
                    .allowsTightening(true)
                    .lineLimit(2)
                    .scaledToFit()
                    .minimumScaleFactor(0.4)
                AsyncImage(url: URL(string: game.away.logo)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .clipShape(Circle())
            }
            Spacer()
            Text(game.oddsEventID ?? "No Odds")
                .lineLimit(2)
                .scaledToFit()
                .minimumScaleFactor(0.4)
            Spacer()
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(Color.init(uiColor: .systemGray5))
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


//                VStack {
//                    VStack(alignment: .leading) {
//                        Text("My Teams")
//                            .font(.headline)
//                            .fontWeight(.heavy)
//                        ScrollView(.horizontal,showsIndicators: false) {
//                            HStack(spacing: 15) {
//                                ForEach(userdata,id: \.id) { user in
//                                    UserView(user: user)
//                                }
//                            }
//                            .padding(.top, 10)
//                        }
//                        .frame(height: 80)
//                    }
//                    .padding()
//                    VStack(alignment: .leading) {
//                        Text("My Players")
//                            .font(.headline)
//                            .fontWeight(.heavy)
//                        ScrollView(.horizontal,showsIndicators: false) {
//                            HStack(spacing: 15) {
//                                ForEach(userdata,id: \.id) { user in
//                                    UserView(user: user)
//                                }
//                            }
//                            .padding(.top, 10)
//                        }
//                        .frame(height: 80)
//                    }
//                    .padding()
