//
//  FeaturedAssembly.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 27/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

final public class FeaturedAssembly {
    private let imageLoadingAssembly: ImageLoadingAssembly
    private let detailAssembly: DetailAssembly
    
    init(imageLoadingAssembly: ImageLoadingAssembly,
         detailAssembly: DetailAssembly) {
        self.imageLoadingAssembly = imageLoadingAssembly
        self.detailAssembly = detailAssembly
    }
    
    //public func viewController() -> FeaturedViewController {
    public func viewController() -> UIViewController {
        return FeaturedViewController(presenter: presenter(),
                                      cardPresenter: cardPresenter())
    }
    
    func presenter() -> FeaturedPresenter {
        return FeaturedPresenter(detailNavigator: detailAssembly.detailNavigator())
    }
    
    func cardPresenter() -> CardPresenter {
        return CardPresenter(imageRepository: imageLoadingAssembly.imageRepository)
    }
}
