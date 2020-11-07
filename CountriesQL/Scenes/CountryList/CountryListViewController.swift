import UIKit

final class CountryListViewController: BaseViewController<CountryListView> {

    //MARK: Private variables

    private var viewModel: CountryListViewModelProtocol

    //MARK: Initializers

    init(viewModel: CountryListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        
        setupNavigationBar()
        setupTableView()
        setupErrorView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Overridden functions

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestData()
    }

    //MARK: Private functions

    private func setupNavigationBar() {
        title = viewModel.continentName
    }
    
    private func setupTableView() {
        customView.tableView.refreshControl = customView.refreshControl
        customView.tableView.allowsSelection = false
        customView.tableView.dataSource = self
        customView.refreshControl.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.requestData()
        }), for: .valueChanged)
    }
    
    private func setupErrorView() {
        customView.errorView.addRetryAction(UIAction(handler: { [weak self] _ in
            self?.customView.errorView.removeFromSuperview()
            self?.viewModel.requestData()
        }))
    }
}

extension CountryListViewController: CountryListViewModelDelegate {
    func setLoading(_ loading: Bool) {
        let refreshControl = customView.refreshControl
        loading ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
    }
    
    func reloadTable() {
        customView.tableView.reloadData()
    }
    
    func showError(message: String) {
        customView.errorView.title = message
        customView.errorView.insert(onto: customView)
    }
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = viewModel.countries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.imageView?.image = country.emoji.image()
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.native
        
        return cell
    }
}
