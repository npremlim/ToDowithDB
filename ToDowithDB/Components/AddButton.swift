//
//  AddButton.swift
//  ToDowithDB
//
//  Created by Naomi on 1/8/23.
//

import SwiftUI

struct AddButton: View {
    var body: some View {
        ZStack{
            Circle()
                .frame(width:50)
                .foregroundColor(Color(hue: 0.484, saturation: 1.0, brightness: 0.554))
            Text("+")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
        .frame(height:50)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
