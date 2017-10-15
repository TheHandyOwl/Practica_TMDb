//
//  DetailNavigator.swift
//  TMDbCore
//
//  Created by Carlos on 14/10/17.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation

protocol DetailNavigator {
    func showDetail(withIdentifier identifier: Int64, mediaType: MediaType)
}
