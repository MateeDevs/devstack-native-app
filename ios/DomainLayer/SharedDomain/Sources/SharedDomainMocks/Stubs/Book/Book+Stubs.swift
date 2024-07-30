//
//  Created by Petr Chmelar on 08.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import KMPShared

public extension Book {
    static let stub = Book(
        id: "1",
        name: "Kniha",
        author: "David",
        pages: 25
    )
}

public extension Array where Element == Book {
    static let stub = [
        Book(
            id: "1",
            name: "Kniha",
            author: "David",
            pages: 25
        ),
        Book(
            id: "2",
            name: "Dharma Bums",
            author: "Jack Kerouac",
            pages: 200
        )
    ]
}
