//
//  PhoneDetailNavigator.swift
//  TMDbCore
//
//  Created by Carlos on 14/10/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

final class PhoneDetailNavigator: DetailNavigator {
    private let navigationController: UINavigationController
    private unowned let viewControllerProvider: DetailViewControllerProvider // Referencia débil al objeto pero sin ser opcional porque la tendremos siempre
    
    init(navigationController: UINavigationController,
         viewControllerProvider: DetailViewControllerProvider) {
        self.navigationController = navigationController
        self.viewControllerProvider = viewControllerProvider
    }
    
    func showDetail(withIdentifier identifier: Int64, mediaType: MediaType) {
        let viewController = viewControllerProvider.detailViewController(identifier: identifier, mediaType: mediaType)
        navigationController.pushViewController(viewController, animated: true)
    }
}
