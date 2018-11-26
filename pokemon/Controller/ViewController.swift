//Pokedex
//
//Using the a public Pokemon API (https://pokeapi.co), create an app that displays a list of all Pokemon. Upon selecting a Pokemon, display a detail page with information about the selected Pokemon. Here are some guidelines to follow:
//
//Write all code in Swift.
//The initial view controller should simply display the names of the Pokemon sorted by their ID.
//The detail view controller should display at least the Pokemon's name, weight, and height. Any other information (image, description, types, etc) is not mandatory.
//Demonstrate clean code & good coding practices. (e.g. avoid magic variables, follow MVC principles, avoid force unwrapping, add comments, etc.)
//Use GitHub to store and version your code. Learn how to use git from the command line if you don’t already know how.
//
//Use the Pokeapi V2 documentation to help you understand the attributes returned by the service and how to access the ones you’ll need.  The following request will get you the initial list of Pokemon: http://pokeapi.co/api/v2/pokemon/.  If you have any questions about the project specs, feel free to reach out to me.
//
//Of course, I’m not expecting a master piece. I actually don’t even care whether or not it works in the end. I just want to see your way of tackling the problem and to see how far you can get. Please put your code into a public GitHub repository so that I can see it when you’re done. When you’re finished, email me back with a link to your GitHub repository so that I can review it and potentially set up an interview.
//
//I will be sending this same coding challenge to all other applicants. All applications will be due prior to next Friday, November 30th. To be considered for an interview, please respond with your challenge before then.

import UIKit

class ViewController : UITableViewController {
    var pokedex : Pokedex?
    var pokemon : Pokemon?
    let cellId = "cellId"

    func loadJSON() {
        let url = "https://pokeapi.co/api/v2/pokemon/"
        guard let jsonUrl = URL(string: url) else { return }
        
        //First API Call to retrieve list of Pokemon. Could be done better if it was dynamically called as the user scrolls down
        URLSession.shared.dataTask(with: jsonUrl) {(data, response, error) in
            guard let data = data else { return }
            do {
                let load = try JSONDecoder().decode(Pokedex.self, from: data)
                self.pokedex = load;
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let jsonErr{
                print("Error serializing JSON: ", jsonErr)
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        
        //Set up Navigation Bar
        navigationItem.title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red.withAlphaComponent(0.5)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setTitleImage()
    }
    
    //Style of section headers
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "By Id"
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        return label
    }
    
    //Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Returns number of Cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = pokedex?.results.count else { return 0 }
        return count
    }
    
    //Sets characteristics of each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        guard let pokedexTemp = pokedex else { return cell }
        
        let name = pokedexTemp.results[indexPath.row].name?.capitalizingFirstLetter()
        cell.textLabel?.text = "\(name ?? "")"
        return cell
    }
    
    //Prepares for push segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        guard let jsonUrl = pokedex?.results[indexPath.row].url else { return }
        guard let url = URL(string: jsonUrl) else { return }
        
        //Second API call to fetch individual Pokemon Data
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                let load = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemon = load
                DispatchQueue.main.sync {
                    //Pass values to next VC
                    detailVC.name = self.pokemon?.name ?? ""
                    detailVC.weight = self.pokemon?.weight ?? 0
                    detailVC.height = self.pokemon?.height ?? 0
                }
            } catch let jsonErr {
                print("Error serializing inner JSON:", jsonErr)
            }
            }.resume()
        
        //Initiate push segue
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setTitleImage() {
        var buttonImage : UIImageView {
            let imageView = UIImageView()
            imageView.image = #imageLiteral(resourceName: "pokeball")
            imageView.frame = CGRect(x: view.frame.maxX, y: view.frame.minY, width: 100, height: 100)
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
        
        navigationItem.titleView = buttonImage
        
//        //Adding the button
//        let buttonImage = #imageLiteral(resourceName: "button")
//        let circleImage = #imageLiteral(resourceName: "whiteCircle")
//
//        var buttonView : UIImageView {
//            let view = UIImageView(image: buttonImage)
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.frame = CGRect(x: self.view.frame.maxX - 100, y: self.view.frame.minY-100, width: 200, height: 200)
//            view.backgroundColor = .clear
//            return view
//        }
//
//        var circle : UIImageView {
//            let view = UIImageView(image: circleImage)
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.frame = CGRect(x: 0, y: 0, width: 130, height: 130)
//            view.center = buttonView.center
//            return view
//        }
//
//        view.addSubview(circle)
//        view.addSubview(buttonView)
//
//        NSLayoutConstraint.activate([
//            buttonView.heightAnchor.constraint(equalToConstant: 200),
//            buttonView.widthAnchor.constraint(equalToConstant: 200),
//            buttonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
//            buttonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -300),
//
//            //            circle.heightAnchor.constraint(equalToConstant: 200),
//            //            circle.widthAnchor.constraint(equalToConstant: 200),
//            //            circle.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//            //            circle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            ])
    }
}
