//
//  RECustomHeaderView.swift
//  Recipes
//
//  Created by Arun on 02/09/21.
//

import UIKit



class RECustomHeaderView: UITableViewHeaderFooterView {
    private let labelTitle = UILabel()
    private let buttonStatus = UIButton()
    var tableReloadSection: ((_ section: Int) -> Void)?
    
    var recipe: RERecipes? {
        didSet {
            setData()
        }
    }
    var section: Int?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        buttonStatus.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonStatus.addTarget(self, action: #selector(didClickExpandCloseButton), for: .touchUpInside)
        contentView.addSubview(buttonStatus)
        contentView.addSubview(labelTitle)

        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            buttonStatus.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            buttonStatus.widthAnchor.constraint(equalToConstant: 50),
            buttonStatus.heightAnchor.constraint(equalToConstant: 50),
            buttonStatus.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            labelTitle.heightAnchor.constraint(equalToConstant: 30),
            labelTitle.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor,
                   constant: 8),
            labelTitle.trailingAnchor.constraint(equalTo:
                   buttonStatus.leadingAnchor),
            labelTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func setData() {
        guard let recipe = self.recipe else {
            return
        }
        labelTitle.text = recipe.name
        if recipe.isExpanded {
            buttonStatus.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            buttonStatus.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
    }
    
    @objc func didClickExpandCloseButton(_ sender: UIButton) {
        recipe?.isExpanded.toggle()
        setData()
        guard let section = self.section else {
            return
        }
        self.tableReloadSection?(section)
    }
}
