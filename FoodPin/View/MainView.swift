//
//  MainView.swift
//  FoodPin
//
//  Created by 姜智森 on 2024/10/30.
//

import SwiftUI

struct MainView: View {
    @State private var selectedTabIndex = 0
    
    var body: some View {
        TabView(selection: $selectedTabIndex) {
            RestaurantListView()
                .tabItem {
                    Label("Favorites", systemImage: "tag.fill")
                }
                .tag(0)
            
            Text("Discover")
                .tabItem {
                    Label("Discover", systemImage: "wand.and.rays")
                }
                .tag(1)
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "square.stack")
                }
                .tag(2)
        }
        .tint(Color("NavigationBarTitle"))
        .onOpenURL(perform: { url in
            switch url.path {
            case "/OpenFavorites": selectedTabIndex = 0
            case "/OpenDiscover": selectedTabIndex = 1
            case "/NewRestaurant": selectedTabIndex = 0
            default: return
            }
        })
    }
}

#Preview {
    MainView()
}
