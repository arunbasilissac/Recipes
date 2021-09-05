//
//  ViewController.swift
//  Recipes
//
//  Created by Arun on 28/08/21.
//

import UIKit

class RERecipesViewController: UIViewController {
    
    @IBOutlet weak var tableViewRecipes: UITableView!
    private var viewModel: RERecipesViewModel? {
        didSet {
            setHandlers()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: Button Actions
    @IBAction func didClickCheckIngredients(_ sender: Any) {
        viewModel?.fetchIngredients()
    }
}
// MARK: Initial Setup
private extension RERecipesViewController {
    
    func setup() {
        viewModel = RERecipesViewModel()
        tableViewRecipes.register(RECustomHeaderView.self,
                                  forHeaderFooterViewReuseIdentifier: ReuseIdentifier.recipeHeaderView)
        tableViewRecipes.dataSource = viewModel
        tableViewRecipes.delegate = viewModel
        viewModel?.fetchRecipes()
    }
    
    func setHandlers() {
        viewModel?.tableReloadHandler = { [weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
            self.tableViewRecipes.reloadData()
            }
        }
        
        viewModel?.showLoadingHandler = { [weak self] in
            guard let self = self else {
                return
            }
            self.showLoadingView()
        }
        
        viewModel?.dismissLoadingHandler = { [weak self] in
            guard let self = self else {
                return
            }
            self.dismissLoadingView()
        }
        
        viewModel?.showErrorAlertHandler = { [weak self] error in
            guard let self = self else {
                return
            }
            self.presentREAlert(title: Alert.errorTitle, message: error.description, buttonTitle: Alert.okButtonLabel)
        }
        
        viewModel?.tableReloadSection = { [weak self] section in
            guard let self = self else {
                return
            }
            self.tableViewRecipes.reloadSections([section], with: .automatic)
        }
        
        viewModel?.showAlertHandler = { [weak self] title, message, buttonTitle in
            guard let self = self else {
                return
            }
            self.presentREAlert(title: title, message: message, buttonTitle: Alert.okButtonLabel)
        }
    }
}
