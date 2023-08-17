//
//  ListView.swift
//  BookmarkUI
//
//  Created by Dinmukhambet Turysbay on 06.05.2023.
//

import UIKit
import SafariServices

struct Link {
    var title: String
    var url: String
}

extension Link {
    static var links: [Link] = []
//    [
//        Link(title: "Google", url: "https://www.google.com"),
//        Link(title: "NFactorial School", url: "https://www.nfactorial.school/ios"),
//        Link(title: "NY Times", url: "https://www.nytimes.com/"),
//        Link(title: "Bloomberg", url: "https://www.bloomberg.com/"),
//    ]
}

class ListView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @objc private func addBookmarkButtonPressed(){
        DispatchQueue.main.async {
            self.present(self.addAlert, animated: true, completion: nil)
        }
    }
    
    private func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    private lazy var appTitle: UILabel = {
        let title = UILabel()
        title.text = "List"
        title.font = .systemFont(ofSize: 17,weight: .semibold)
        title.textColor = .black
        title.textAlignment = .center
        return title
    }()
    
    private lazy var textCenter: UILabel = {
        let textCenter = UILabel()
        textCenter.text = "Save your first\nbookmark"
        textCenter.font = .systemFont(ofSize: 36,weight: .bold)
        textCenter.textColor = .black
        textCenter.textAlignment = .center
        textCenter.numberOfLines = 2
        return textCenter
    }()
    
    private lazy var addAlert: UIAlertController = {
        let alert = UIAlertController(title: "Add", message: "", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            textField.placeholder = "Bookmark title"
        })
        
        alert.addTextField(configurationHandler: { (textField : UITextField!) -> Void in
            textField.placeholder = "Bookmark link"
        })
        
        print(alert.textFields![0])
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { alertAction -> Void in
            var firstText = alert.textFields![0].text!
            var secondText = alert.textFields![1].text!
            
            if(!firstText.isEmpty && !secondText.isEmpty){
                if(self.verifyUrl(urlString: secondText)){
                    Link.links.append(Link(title: firstText, url: secondText))
                }else{
                    Link.links.append(Link(title: firstText, url: "https://www.google.com/search?q=\(secondText)"))
                }
                alert.textFields![0].text! = ""
                alert.textFields![1].text! = ""
                self.tableView.reloadData()
            }
            self.viewDidLoad()
        }))
    
        return alert
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 16
        button.setTitle("Add Bookmark", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(addBookmarkButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "List"
        self.view.backgroundColor = .white
        
        [appTitle,textCenter,button,tableView].forEach {
            view.addSubview($0)
        }
        
        appTitle.anchor(top: self.view.topAnchor,left: self.view.leftAnchor,right: self.view.rightAnchor,paddingTop: 58,paddingLeft: 130,paddingRight: 130)
        
        button.anchor(left: self.view.leftAnchor,bottom: self.view.bottomAnchor,right: self.view.rightAnchor,paddingLeft: 16,paddingBottom: 50,paddingRight: 16,height: 56)
        
        if(Link.links.count != 0){
            tableView.anchor(top: appTitle.bottomAnchor,left: self.view.leftAnchor,bottom: button.topAnchor,right: self.view.rightAnchor,paddingTop: 30,paddingBottom: 30)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(LinkCell.self, forCellReuseIdentifier: "LinkCell")
        }else{
            textCenter.anchor(top: appTitle.bottomAnchor, left: self.view.leftAnchor,right: self.view.rightAnchor,paddingTop: 298)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Link.links.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LinkCell", for: indexPath) as? LinkCell else { return UITableViewCell() }
        cell.configureView(link: Link.links[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                Link.links.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SFSafariViewController(url: URL(string: Link.links[indexPath.row].url)!)
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

class LinkCell: UITableViewCell {
    @objc private func gotoLinkButtonPressed(){
        print("pressed")
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private var iconButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(named: "goto-link-icon"), for: .normal)
        button.addTarget(LinkCell.self, action: #selector(gotoLinkButtonPressed), for: .touchDown)
        return button
    }()

    private let phonelabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configureView(link: Link) {
        self.label.text = link.title
    }

    private func setUI() {
        self.backgroundColor = .white
        [label,iconButton].forEach { self.addSubview($0) }
        
        label.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 25, paddingLeft: 16)
        iconButton.anchor(top: self.topAnchor, right: self.rightAnchor, paddingTop: 25, paddingLeft: 16,paddingRight: 16)
    }
}


