//
//  RERecipesViewModel.swift
//  Recipes
//
//  Created by Arun on 01/09/21.
//

import UIKit

class RERecipesViewModel: NSObject {
    
    private var networkService: REServices = REServices()
    
    typealias OptionalCompletionClosure = (() -> Void)?
    var tableReloadHandler: (() -> Void)?
    var showLoadingHandler: (() -> Void)?
    var dismissLoadingHandler: (() -> Void)?
    var showErrorAlertHandler: ((_ error: REError) -> Void)?
    var tableReloadSection: ((_ section: Int) -> Void)?
    var showAlertHandler: ((_ title: String, _ message: String, _ buttonTitle: String) -> Void)?
    
    private var allRecipes = [RERecipes]()
    private var recipes = [RERecipes]() {
        didSet {
            self.loadData()
        }
    }
}

// MARK: Fetch Data
private extension RERecipesViewModel {
     func loadData() {
        self.tableReloadHandler?()
        if recipes.isEmpty {
            self.showAlertHandler?(Alert.errorTitle, Alert.noRecipes, Alert.okButtonLabel)
        }
    }
    
    func reloadSection(_ section: Int) {
        self.tableReloadSection?(section)
    }
}

// MARK: Fetch Data
extension RERecipesViewModel {
    func fetchIngredients(completion: OptionalCompletionClosure = nil) {
        self.showLoadingHandler?()
        networkService.fetchIngredients { [weak self] result in
            guard let self = self else {
                return
            }
            self.dismissLoadingHandler?()
            switch result {
            case .success(let ingredients):
                self.recipes = self.filter(recipesList: self.allRecipes, with: ingredients)
            case .failure(let error):
                self.showErrorAlertHandler?(error)
            }
        }
    }
    
    func fetchRecipes(completion: OptionalCompletionClosure = nil) {
        self.showLoadingHandler?()
        networkService.fetchRecipes { [weak self] result in
            guard let self = self else {
                return
            }
            self.dismissLoadingHandler?()
            switch result {
            case .success(let recipes):
                self.allRecipes = recipes
                self.recipes = recipes
            case .failure(let error):
                self.showErrorAlertHandler?(error)
            }
        }
    }
}

// MARK: Filter
extension RERecipesViewModel {
    func filter(recipesList: [RERecipes], with ingredients: Set<String>) -> [RERecipes] {
        return recipesList.filter({ recipe in
            Set(recipe.ingredients).isSubset(of: ingredients)
        })
    }
}

// MARK: TableView Delegate and DataSource
extension RERecipesViewModel: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipes[section].isExpanded {
            return recipes[section].ingredients.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ReuseIdentifier.recipeHeaderView) as! RECustomHeaderView
        headerCell.recipe = recipes[section]
        headerCell.section = section
        headerCell.tableReloadSection = tableReloadSection
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.ingredientsTableViewCell) as! REIngredientsTableViewCell
        cell.ingredient = recipes[indexPath.section].ingredients[indexPath.row]
        return cell
    }
}
