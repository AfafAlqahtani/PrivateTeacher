//
//  HomeViewController.swift
//  PrivateTeacher
//
//  Created by Afaf Yahya on 23/05/1443 AH.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {
    var posts = [Post]()
    var selectedPost:Post?
    var filteredPost: [Post] = []
    var selectedPostImage:UIImage?
//    var filterePosts: [String]!
   
    let searchController = UISearchController(searchResultsController: nil)
//    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var postsTableView: UITableView! {
        didSet {
            
           
            postsTableView.delegate = self
            postsTableView.dataSource = self
           
//            searchBar.delegate = self
                
            
//            postsTableView.register(UINib(nibName: "PostCellViewController", bundle: nil), forCellReuseIdentifier: "PostCellViewController")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search subject"
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        
//        filterePosts = posts
//        postsTableView.removeFromSuperview()
//        if posts.count == 0 {
//            postsTableView.isHidden = true
//            let imgErrorPhoto = UIImageView(frame: CGRect(x: 50, y: 100, width: self.view.frame.width - 100, height: 200))
//            imgErrorPhoto.image = UIImage(systemName: "icloud.slash")
//            imgErrorPhoto.tintColor = UIColor.gray
//            self.view.addSubview(imgErrorPhoto)
//
//            let lblMsg = UILabel(frame: CGRect(x: imgErrorPhoto.frame.minX, y: imgErrorPhoto.frame.maxX + 15, width: imgErrorPhoto.frame.width, height: 30))
//
//
//            lblMsg.text = "No Data to Display"
//            lblMsg.textAlignment = .center
//            self.view.addSubview(lblMsg)
//
//        }
        // Do any additional setup after loading the view.
    }
    func getPosts() {
        let ref = Firestore.firestore()
        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DB ERROR Posts",error.localizedDescription)
            }
            if let snapshot = snapshot {
                snapshot.documentChanges.forEach { diff in
                    let post = diff.document.data()
                    switch diff.type {
                    case .added :
                        if let userId = post["userId"] as? String {
                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                if let error = error {
                                    print("ERROR user Data",error.localizedDescription)
                                    
                                }
                                if let userSnapshot = userSnapshot,
                                   let userData = userSnapshot.data(){
                                    let user = User(dict:userData)
                                    let post = Post(dict:post,id:diff.document.documentID,user:user)
                                    self.posts.insert(post, at: 0)
                                    DispatchQueue.main.async {
                                        self.postsTableView.reloadData()
                                    }
                                    
                                }
                            }
                        }
                        case .modified:
                        let postId = diff.document.documentID
                        if let currentPost = self.posts.first(where: {$0.id == postId}),
                           let updateIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            let newPost = Post(dict:post, id: postId, user: currentPost.user)
                            self.posts[updateIndex] = newPost
                            DispatchQueue.main.async {
                                self.postsTableView.reloadData()
                            }
                        }
                    case .removed:
                        let postId = diff.document.documentID
                        if let deleteIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            self.posts.remove(at: deleteIndex)
                            DispatchQueue.main.async {
                                self.postsTableView.reloadData()
                            }
                        }
                        }
                    }
                }
            }
        }
      
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toPostVC" {
                let vc = segue.destination as! PostViewController
                vc.selectedPost = selectedPost
                vc.selectedPostImage = selectedPostImage
            }else if identifier == "toDetailsVC" {
                let vc = segue.destination as! DetailsViewController
                vc.selectedPost = selectedPost
                vc.selectedPostImage = selectedPostImage
            }
        }
     
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ?filteredPost.count : posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellViewController") as! PostCellViewController
        let post = searchController.isActive ? filteredPost[indexPath.row]: posts[indexPath.row]
        cell.configure(with: post)
        
        return cell.configure(with: posts[indexPath.row])
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterePosts = []
//        if searchText == "" {
//            filterePosts = posts
//        }
            
//        for information in posts {
//            if  information.lowercased().contains(searchText.lowercased()) {
//                filterePosts.append(information)
//            }
//        self.postsTableView.reloadData()
//
//
//    }
    
}
//}
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PostCellViewController
        selectedPostImage = cell.postImageView.image
        selectedPost = posts[indexPath.row]
        if let currentUser = Auth.auth().currentUser,
           currentUser.uid == posts[indexPath.row].user.id{
          performSegue(withIdentifier: "toPostVC", sender: self)
        }else {
            performSegue(withIdentifier: "toDetailsVC", sender: self)
            
        }
    }
}
//extension HomeViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filteredPost = posts.filter({ selectedPost in
//            return selectedPost.subject.lowercased().contains(searchController.searchBar.text!.lowercased())
//        })
//filteredPost.append(posts.filter({ selectedPost in
//            return selectedPost.stage.lowercased().contains(searchController.searchBar.text!.lowercased())
//        })
//
//filteredPost.append(posts.filter({ selectedPost in
//            return selectedPost.city.lowercased().contains(searchController.searchBar.text!.lowercased())
//        })
//        postsTableView.reloadData()
//
//    }
//        }
        

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredPost = posts.filter({ selectedPost in
            return selectedPost.subject.lowercased().contains(searchController.searchBar.text!.lowercased()) || selectedPost.city.lowercased().contains(searchController.searchBar.text!.lowercased()) || selectedPost.stage.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        postsTableView.reloadData()

    }
}
