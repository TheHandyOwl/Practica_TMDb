//
//  FeaturedAssembly.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 27/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

final class FeaturedAssembly {
	private let imageLoadingAssembly: ImageLoadingAssembly

	init(imageLoadingAssembly: ImageLoadingAssembly) {
		self.imageLoadingAssembly = imageLoadingAssembly
	}

	func viewController() -> FeaturedViewController {
		return FeaturedViewController(presenter: presenter(),
		                              cardPresenter: cardPresenter())
	}

	func presenter() -> FeaturedPresenter {
		return FeaturedPresenter()
	}

	func cardPresenter() -> CardPresenter {
		return CardPresenter(imageRepository: imageLoadingAssembly.imageRepository)
	}
}
