//
//  ContentView.swift
//  BundleResourceFix
//
//  Created by Christian Treffs on 01.06.22.
//

import SwiftUI
import ModuleA
import ModuleB

struct ContentView: View {
    var body: some View {
        VStack {
            Image(uiImage: UIImage(contentsOfFile: ModuleA().resourceURL.path)!)
            Image(uiImage: UIImage(contentsOfFile: ModuleB().resourceURL.path)!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
