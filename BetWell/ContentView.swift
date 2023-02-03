//
//  ContentView.swift
//  BetWell
//
//  Created by David Mann on 1/15/23.
//

import SwiftUI
import CoreData

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
    
    let todaysGames: [Games] = [
        Games(homeTeam: "Cin", awayTeam: "BAL", overUnder: "78.5"),
        Games(homeTeam: "JAX", awayTeam: "DAL", overUnder: "38.5"),
        Games(homeTeam: "MIA", awayTeam: "PHL", overUnder: "54.5"),
        Games(homeTeam: "CAL", awayTeam: "HOU", overUnder: "100.5"),
        Games(homeTeam: "TEN", awayTeam: "BOS", overUnder: "29.5"),
        Games(homeTeam: "KAC", awayTeam: "PIT", overUnder: "59.5"),
        Games(homeTeam: "DEN", awayTeam: "CLE", overUnder: "86.5"),
        Games(homeTeam: "SEA", awayTeam: "CHI", overUnder: "75.5"),
        Games(homeTeam: "LAV", awayTeam: "LAC", overUnder: "43.5"),
        Games(homeTeam: "ARZ", awayTeam: "LAR", overUnder: "90.5")
    ]
    let networking = Networking()
    
    @State private var userdata = [User]()
    var body: some View {
        NavigationView {
            ScrollView {
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
                    VStack(alignment: .leading) {
                        Text("Who is playing tonight?")
                        ForEach(todaysGames) { game in
                            NavigationLink {
                                MatchupView(game: game)
                            } label: {
                                PlayingTodayView(game: game)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarTitle("BetWell", displayMode: .large)
                    .onAppear(perform: getUsers)
                }
//            }
        }
    }
        
        func getUsers() {
            guard let url = URL(string: "https://reqres.in/api/users")
            else {  return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response,
                error in
                if let data = data {
                    if let response_obj = try?
                        JSONDecoder().decode(UserDetail.self, from: data) {
                        DispatchQueue.main.async {
                            self.userdata = response_obj.data
                        }
                    }
                }
            }.resume()
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


struct UserView: View {
    let user: User
    @State var initialImage = UIImage()
    var body: some View {
        
        VStack {
            Image(uiImage: self.initialImage)
                .resizable()
                .cornerRadius(50)
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 60, maxWidth: .infinity, minHeight: 60, maxHeight: 60, alignment: .center)
                .onAppear {
                    guard let url = URL(string: self.user.avatar) else { return }
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                        guard let data = data else { return }
                        guard let image = UIImage(data: data) else { return }
                        
                        DispatchQueue.main.async {
                            self.initialImage = image
                        }
                        
                    }.resume()
            }
            
            Text(user.first_name + " " + user.last_name)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
    }
}

struct PlayingTodayView: View {
    let game: Games
    var body: some View {
        HStack(spacing: 20.0) {
            Text(game.homeTeam)
            Text("vs")
            Text(game.awayTeam)
            Text("O/U: \(game.overUnder)")
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(Color.init(uiColor: .systemGray5))
    }
}

struct UserDetail: Decodable {
    var page: Int
    var data: [User]
}

struct User: Decodable {
    var id:Int
    var email: String
    var first_name: String
    var last_name:String
    var avatar:String
}

struct ListHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "map")
            Text("Who is playing today")
        }
    }
}

struct ListFooter: View {
    var body: some View {
        Text("Remember to pack plenty of water and bring sunscreen.")
    }
}
