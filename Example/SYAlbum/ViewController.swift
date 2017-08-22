//
//  ViewController.swift
//  SYAlbum
//
//  Created by 914359463@qq.com on 08/22/2017.
//  Copyright (c) 2017 914359463@qq.com. All rights reserved.
//

import UIKit
import SYAlbum

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(SYAlbumController(), animated: true)
    }


}

