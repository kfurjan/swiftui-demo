//
//  ExampleView.swift
//  SwiftUIDemo
//
//  Created by Ericsson on 19.01.2023.
//

import SwiftUI

struct Person: Identifiable {
    var id = UUID()
    var firstName: String
    var lastName: String
    var iconName: String
}


struct PersonRow: View {
    var person: Person

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: person.iconName)
                .resizable()
                .frame(width: 48, height: 64)

            VStack (alignment: .leading, spacing: 8) {
                Text(person.firstName)
                    .font(.largeTitle)
                Text(person.lastName)
                .font(.title)
            }
        }
    }
}


struct PersonDetail: View {
    var person: Person

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: person.iconName)
                .resizable()
                .frame(width: 64, height: 96)

            Text(person.firstName)
                .font(.largeTitle)
            Text(person.lastName)
                .font(.largeTitle)
        }
    }
}

struct PeopleView: View {
    @State private var people = [
        Person(firstName: "John", lastName: "Doe", iconName: "person.fill"),
        Person(firstName: "Jane", lastName: "Doe", iconName: "person.fill"),
        Person(firstName: "Peter", lastName: "Pan", iconName: "person.fill"),
        Person(firstName: "Tim", lastName: "Cook", iconName: "person.fill"),
        Person(firstName: "Steve", lastName: "Jobs", iconName: "person.fill")
    ]
    @State private var searchTerm = ""
    @State private var filteredPeople: [Person] = []

    func delete(offset: IndexSet) -> Void {
        people.remove(atOffsets: offset)
    }

    func move(offset: IndexSet, destination: Int) -> Void {
        people.move(fromOffsets: offset, toOffset: destination)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(searchTerm.isEmpty ? people : filteredPeople) { person in
                    NavigationLink(destination: PersonDetail(person: person)) {
                        PersonRow(person: person)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationBarTitle("People")
            .navigationBarItems(trailing: EditButton())
        }
        .searchable(text: $searchTerm)
        .onChange(of: searchTerm, perform: { searchValue in
            if searchValue.isEmpty {
                filteredPeople = people
            } else {
                filteredPeople = filteredPeople.filter { $0.firstName.contains(searchValue) }
            }
        })
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
