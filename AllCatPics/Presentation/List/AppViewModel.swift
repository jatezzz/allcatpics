//
//  AppViewModel.swift
//  AllCatPics
//
//  Created by John Trujillo on 24/2/24.
//

import Foundation

class AppViewModel: ObservableObject {
    @Published var isShowingDetailView = false
    @Published var selectedCatId: String?
}
