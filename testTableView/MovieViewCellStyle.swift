//
//  MovieViewCellStyle.swift
//  testTableView
//
//  Created by Tina Andria on 23/04/2020.
//  Copyright © 2020 Tina Andria. All rights reserved.
//

import UIKit

class MovieViewCellStyle: UITableViewCell {

    override init(style: UITableViewCell.CellStyle , reuseIdentifier: String? ) { super.init(style: .subtitle , reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(" init(coder:) has not been implemented" )
    }

}
