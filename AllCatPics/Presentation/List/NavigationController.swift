//
//  NavigationController.swift
//  AllCatPics
//
//  Created by John Trujillo on 24/2/24.
//

import Foundation

struct NavigationController {
    var appViewModel: AppViewModel
    
    func navigateToDetail(catId: String) {
        appViewModel.selectedCatId = catId
        appViewModel.isShowingDetailView = true
    }
}
