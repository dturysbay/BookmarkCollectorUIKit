//
//  WelcomeView.swift
//  BookmarkUI
//
//  Created by Dinmukhambet Turysbay on 05.05.2023.
//

import UIKit

class WelcomeView: UIViewController{
    
    private func assignbackground(){
        let background = UIImage(named: "bookmarkapp-background")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }

    private var label: UILabel = {
        let label = UILabel()
        label.text = "Save all interesting \nlinks in one app"
        label.numberOfLines = 2
        label.textColor = .white
        label.font = .systemFont(ofSize: 36,weight: .bold)
        return label
    }()

    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.setTitle("Let’s start collecting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)

        return button
    }()
    
   
    
    private func buttonDidPress(){
        let vc = ListView()
        vc.modalPresentationStyle = .fullScreen

        navigationController?.present(vc,animated: true,completion: nil)
    }

    override func viewDidLoad(){
        super.viewDidLoad()
        assignbackground()

        [label,button].forEach {
            view.addSubview($0)
        }
        
        button.addAction(.init(handler: { _ in
            self.buttonDidPress()
        }), for: .touchUpInside)
        
       

        button.anchor(left: self.view.leftAnchor,bottom: self.view.bottomAnchor,right: self.view.rightAnchor,paddingLeft: 16,paddingBottom: 50,paddingRight: 16,height: 56)
        label.anchor(left: self.view.leftAnchor,bottom: button.topAnchor,right: self.view.rightAnchor,paddingLeft: 16,paddingBottom: 24,paddingRight: 16)

    }
}
