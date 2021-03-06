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
    var selectUseImage:UIImage?
   
    let searchController = UISearchController(searchResultsController: nil)

    
    @IBOutlet weak var postsTableView: UITableView! {
        didSet {
            
           
            postsTableView.delegate = self
            postsTableView.dataSource = self
 
        }
    }
    
    @IBOutlet weak var textLabel: UILabel!{
        didSet{
            textLabel.text = "Advertisements".localizeed
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        
    }
    func getPosts() {
        let ref = Firestore.firestore()
        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DB ERROR Posts",error.localizedDescription)
            }
            if let snapshot = snapshot {
                print("POST CANGES:",snapshot.documentChanges.count)
                snapshot.documentChanges.forEach { diff in
                    let postData = diff.document.data()
                    switch diff.type {
                    case .added :
                        
                        if let userId = postData["userId"] as? String {
                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                if let error = error {
                                    print("ERROR user Data",error.localizedDescription)
                                    
                                }
                                if let userSnapshot = userSnapshot,
                                   let userData = userSnapshot.data(){
                                    let user = User(dict:userData)
                                    let post = Post(dict:postData,id:diff.document.documentID,user:user)
                                    self.postsTableView.beginUpdates()
                                    if snapshot.documentChanges.count != 1 {
                                        self.posts.append(post)
                                      
                                        self.postsTableView.insertRows(at: [IndexPath(row:self.posts.count - 1,section: 0)],with: .automatic)
                                    }else {
                                        self.posts.insert(post,at:0)
                                      
                                        self.postsTableView.insertRows(at: [IndexPath(row: 0,section: 0)],with: .automatic)
                                    }
                                  
                                    self.postsTableView.endUpdates()
                                    
                                    
                                }
                            }
                        }
                    case .modified:
                        let postId = diff.document.documentID
                        if let currentPost = self.posts.first(where: {$0.id == postId}),
                           let updateIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            let newPost = Post(dict:postData, id: postId, user: currentPost.user)
                            self.posts[updateIndex] = newPost
                         
                                self.postsTableView.beginUpdates()
                                self.postsTableView.deleteRows(at: [IndexPath(row: updateIndex,section: 0)], with: .left)
                                self.postsTableView.insertRows(at: [IndexPath(row: updateIndex,section: 0)],with: .left)
                                self.postsTableView.endUpdates()
                            
                        }
                    case .removed:
                        let postId = diff.document.documentID
                        if let deleteIndex = self.posts.firstIndex(where: {$0.id == postId}){
                            self.posts.remove(at: deleteIndex)
                          
                                self.postsTableView.beginUpdates()
                                self.postsTableView.deleteRows(at: [IndexPath(row: deleteIndex,section: 0)], with: .automatic)
                                self.postsTableView.endUpdates()
                            
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
                vc.selectUserImage = selectUseImage
            }else if identifier == "toDetailsVC" {
                let vc = segue.destination as! DetailsViewController
                vc.selectedPost = selectedPost
                vc.selectedPostImage = selectedPostImage
                vc.selectUserImage = selectUseImage
            
            }
        }
     
    }
    //    to exit button
        @IBAction func rootViewController(segue: UIStoryboardSegue){
            print("Unwind to Root ViewController")
        }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredPost.count : posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCellViewController") as! PostCellViewController
        let post11 = searchController.isActive ? filteredPost[indexPath.row] : posts[indexPath.row]
        DispatchQueue.main.async {
            cell.postStageLabel.text = post11.stage
            cell.postSubjectLabel.text = post11.subject
            cell.postCityLabel.text = post11.city
            cell.userNameLabel.text = post11.user.name
            cell.postImageView.loadImageUsingCache(with: post11.imageUrl)
            cell.userImageView.loadImageUsingCache(with: post11.user.imageUrl)
        }
        
        
        cell.selectionStyle = .none
        
        return cell
//            .configure(with: posts[indexPath.row])
    }

}

extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PostCellViewController
        selectedPostImage = cell.postImageView.image
        selectUseImage = cell.userImageView.image
        selectedPost = posts[indexPath.row]
        print("AUTH",posts[indexPath.row].user.id)
        
        if let currentUser = Auth.auth().currentUser,
           currentUser.uid == posts[indexPath.row].user.id{
          performSegue(withIdentifier: "toPostVC", sender: self)
        }else {
            performSegue(withIdentifier: "toDetailsVC", sender: self)
            
        }
    }
}

        

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filteredPost = posts.filter({ selectedPost in
            return selectedPost.stage.lowercased().contains(searchController.searchBar.text!.lowercased())
            || selectedPost.subject.lowercased().contains(searchController.searchBar.text!.lowercased()) || selectedPost.city.lowercased().contains(searchController.searchBar.text!.lowercased()) || selectedPost.user.name.lowercased().contains(searchController.searchBar.text!.lowercased())
        })
        postsTableView.reloadData()
    }
}
