//
//  CoreAssembly.swift
//  TMDbCore
//
//  Created by Guille Gonzalez on 22/09/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

final public class CoreAssembly {
	private(set) lazy var detailAssembly = DetailAssembly(imageLoadingAssembly: imageLoadingAssembly)
	private(set) lazy var featuredAssembly = FeaturedAssembly(imageLoadingAssembly: imageLoadingAssembly)
	private(set) lazy var searchAssembly = SearchAssembly(imageLoadingAssembly: imageLoadingAssembly)
	private(set) lazy var imageLoadingAssembly = ImageLoadingAssembly(webServiceAssembly: webServiceAssembly)
	private(set) lazy var webServiceAssembly = WebServiceAssembly()

	public init() {}
}
