//
//  MoviesViewController.swift
//  MovieListApp
//
//  Created by Станислав Коцарь on 28.01.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import UIKit
import CoreData

class MoviesViewController: UITableViewController {

    var selectedCategory : Category? {
        didSet{
            loadMovies()
        }
    }
    var movies = [Movie]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "movieCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieViewCell
        
    
        
        cell.movieTitle.text = movies[indexPath.row].title
        cell.movieRating.text = String(movies[indexPath.row].rating)
        cell.movieYear.text = String(movies[indexPath.row].year)
        return cell
    }

    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140.0
    }
    
    func loadMovies (with request: NSFetchRequest<Movie> = Movie.fetchRequest(), predicate: NSPredicate? = nil) {
        
        let categoryPredicate = NSPredicate(format: "movieCategory.name MATCHES %@", selectedCategory!.name!)
        
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        do{
            try movies = context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
        
        
        
        configureTableView()
    }
    
    
    func saveMovies () {
        
        do{
            try context.save()
        } catch {
            print(error)
        }
        
        tableView.reloadData()
        
    }
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textfieldTitle = UITextField()
        var textfieldYear = UITextField()
        var textfieldRating = UITextField()
        
        let alert = UIAlertController(title: "Add new \(String(describing: selectedCategory!.name)) movie", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add movie", style: .default) { (action) in
            let movie  = Movie(context: self.context)
            
            
            movie.title = textfieldTitle.text!
            movie.year = Int32(textfieldYear.text!)!
            movie.rating = Double(textfieldRating.text!)!
            movie.movieCategory = self.selectedCategory
            
            self.movies.append(movie)
            self.saveMovies()
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            self.tableView.reloadData()
        }
        
        alert.addTextField { (title) in
            title.placeholder = "Add new movie title"
            textfieldTitle = title
        }
        
        alert.addTextField { (year) in
            year.placeholder = "Add  movie year"
            textfieldYear = year
        }
        
        alert.addTextField { (rating) in
            rating.placeholder = "Add  movie rating"
            textfieldRating = rating
        }
        
        alert.addAction(cancelAction)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        
    }
    

}
