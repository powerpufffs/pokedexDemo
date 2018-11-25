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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow(frame: UIScreen.main.bounds)
//        let ViewController = UIViewController()
//        ViewController.view.backgroundColor = UIColor.white
//        window?.rootViewController = ViewController()
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let navController = UINavigationController(rootViewController: ViewController())
        
        window?.rootViewController = navController
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

