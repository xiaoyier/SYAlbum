//
//  SYAlbumController.swift
//  Pods
//
//  Created by AllConnected on 2017/8/22.
//
//

import UIKit

public class SYAlbumController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let button = UIButton(type: .custom)
        button.center = CGPoint(x: UIScreen.main.bounds.width * 0.5, y: UIScreen.main.bounds.height * 0.5)
        button.setTitle("Show", for: .normal)
        button.setTitleColor(UIColor.cyan, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.addTarget(self, action: #selector(show(button:)), for: .touchUpInside)
        button.sizeToFit()
        view.addSubview(button)

    }

    func show(button: UIButton){
        let sheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil)
        
        sheet.addButton(withTitle: "Browser")
        sheet.addButton(withTitle: "Picker")
        
        sheet.show(in: self.view)

    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        debugPrint(view.subviews)
    }
}

extension SYAlbumController: UIActionSheetDelegate {
    
    public func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        guard buttonIndex != actionSheet.cancelButtonIndex else {
            return
        }

        switch buttonIndex {
        case 1:
            let container = Browser(library: PHLibrary())
            let vc2 = BrowserAlbumListControllerMake(container)
            present(vc2, animated: true, completion: nil)
            
        case 2:
            let container = Picker(library: PHLibrary())
            let vc2 = BrowserAlbumListControllerMake(container)
            present(vc2, animated: true, completion: nil)
            
        default:
            break
        }
    }
    
}
