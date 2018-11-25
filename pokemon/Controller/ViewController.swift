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
        
//        URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
//            guard let data = data else { return }
//
//            do {
//                pokedex = try JSONDecoder().decode(Pokedex.self, from: data)
//
//                for pokemon in pokedex.results {
//                    guard let jsonURL = pokemon.url else { return }
//                    guard let newURL = URL(string: jsonURL) else { return }
//
//                    URLSession.shared.dataTask(with: newURL) {(data, response, error) in
//                        guard let data = data else { return }
//
//                        do {
//                            let load = try JSONDecoder().decode(Pokemon.self, from: data)
//                            self.pokemons.append(load)
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData()
//                            }
//
//                        } catch let jsonErr {
//                            print("Error serializing inner JSON:", jsonErr)
//                        }
//                    }.resume()
//                }
//            } catch let jsonErr{
//                print("Error serializing JSON: ", jsonErr)
//            }
//        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        
        navigationItem.title = "Pokemon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.red.withAlphaComponent(0.5)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "By Id"
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = pokedex?.results.count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        guard let pokedexTemp = pokedex else { return cell }
        
        let name = pokedexTemp.results[indexPath.row].name
        cell.textLabel?.text = "\(name ?? "")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        guard let jsonUrl = pokedex?.results[indexPath.row].url else { return }
        guard let url = URL(string: jsonUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            do {
                let load = try JSONDecoder().decode(Pokemon.self, from: data)
                self.pokemon = load
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let jsonErr {
                print("Error serializing inner JSON:", jsonErr)
            }
            }.resume()
        
        detailVC.name = self.pokemon?.name ?? ""
        detailVC.weight = self.pokemon?.weight ?? 0
        detailVC.height = self.pokemon?.height ?? 0
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
