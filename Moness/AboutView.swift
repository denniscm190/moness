//
//  AboutView.swift
//  Moness
//
//  Created by Dennis Concepción Martín on 27/12/21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Form {
             let footerString = "This open source app was made by Dennis"
             Section(footer: Text(footerString)) {
                 Link(destination: URL(string: "https://dennistech.io")!) {
                     Label {
                         Text("Web")
                             .foregroundColor(.primary)
                     } icon: {
                         Image(systemName: "safari")
                             .imageScale(.large)
                     }
                 }
                 
                 Link(destination: URL(string: "https://twitter.com/dennisconcep")!) {
                     Label {
                         Text("Twitter")
                             .foregroundColor(.primary)
                     } icon: {
                         Image(systemName: "link")
                             .imageScale(.large)
                     }
                 }
                 
                 Link(destination: URL(string: "https://github.com/denniscm190/moness")!) {
                     Label {
                         Text("Github")
                             .foregroundColor(.primary)
                     } icon: {
                         Image(systemName: "externaldrive.connected.to.line.below")
                             .imageScale(.large)
                     }
                 }
             }
         }
         .navigationTitle("About")
         .if(UIDevice.current.userInterfaceIdiom == .phone) { content in
             NavigationView { content }
         }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
