//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by Ericsson on 19.01.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PeopleView()
                .tabItem {
                    Label {
                        Text("People")
                    } icon: {
                        Image(systemName: "person.fill")
                    }
                }

            ExampleView()
                .tabItem {
                    Label {
                        Text("Example")
                    } icon: {
                        Image(systemName: "person.fill")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
