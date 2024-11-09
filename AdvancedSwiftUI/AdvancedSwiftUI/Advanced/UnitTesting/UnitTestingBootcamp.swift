//
//  UnitTestingBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

import SwiftUI

/*
 1.Unit Tests
 - test the business logic in your app

 2.UI Tests
 - test the ui of your app

 */

struct UnitTestingBootcamp: View {
    @StateObject private var vm: UnitTestingBootcampViewModel

    init(isPremium: Bool) {
        _vm = StateObject(wrappedValue: .init(isPremium: isPremium))
    }

    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcamp(isPremium: true)
}
