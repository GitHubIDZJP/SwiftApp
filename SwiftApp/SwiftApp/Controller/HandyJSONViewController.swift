import MJRefresh
import SnapKit
import UIKit

import MJRefresh
import Moya
import SnapKit
import UIKit

class HandyJSONViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableview = UITableView()
    private var articles: [TouTiaoModel] = [] // 使用自定义模型数组

    // Initialize Moya provider
    private let provider = MoyaProvider<TouTiaoNetworkRequest>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadArticles() // Load articles from API
        // 调整分隔线的 inset
//        let topInset = JH_NavBarHeight // 你可以根据导航条的高度进行调整
        tableview.contentInset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
        tableview.scrollIndicatorInsets = tableview.contentInset // 确保滚动指示器也适应 inset
    }

    private func setupTableView() {
        tableview = UITableView(frame: CGRect(x: 0, y: JH_NavBarHeight, width: ScreenWidth, height: ScreenHeight - JH_NavBarHeight), style: .grouped)
        tableview.dataSource = self
        tableview.delegate = self

//        self.tableview.backgroundColor = .red //tabColor

//        self.tableview.estimatedRowHeight = UITableView.automaticDimension
//        self.tableview.rowHeight = 76

        // Register custom cell
        tableview.register(TouTiaoCellTableViewCell.self, forCellReuseIdentifier: "TouTiaoCell")

        view.addSubview(tableview)

        // Add pull-to-refresh
        tableview.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadArticles))
    }

    @objc private func loadArticles() {
        // Fetch articles from the API
        provider.request(.fetchNews) { result in
            switch result {
            case let .success(response):
                // 打印响应状态码
                print("Response status code: \(response.statusCode)")
                do {
                    // 尝试将响应数据解析为 JSON
                    if let json = try? response.mapJSON() as? [String: Any] {
                        print("Response JSON: \(json)") // 打印完整的 JSON 数据

                        // 确认 JSON 的结构
                        if let result = json["result"] as? [String: Any],
                           let data = result["data"] as? [[String: Any]] {
                            // 打印解析前的数据
                            print("Raw data: \(data)") // 打印原始数据

//                            2选1 得跟TouTiaoModel对应上
                            // 解析数据--HandyJSON
//                            self.articles = data.compactMap { TouTiaoModel.deserialize(from: $0) }

                            // 解析数据--ObjectMapper
                            self.articles = data.compactMap { TouTiaoModel(JSON: $0) }

                            // 打印解析后的文章
                            print("Fetched articles: \(self.articles)") // 打印解析后的数据
                        } else {
                            print("Error: 'data' not found in JSON response")
                        }
                    }
                } catch {
                    print("Error parsing response: \(error)")
                }

                self.tableview.reloadData()
                self.tableview.mj_header?.endRefreshing()

            case let .failure(error):
                print("Error fetching articles: \(error)")
                self.tableview.mj_header?.endRefreshing()
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TouTiaoCell", for: indexPath) as! TouTiaoCellTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.authorLabel.text = article.author_name
        cell.thumbnailImageView.image = nil

        // 确保有有效的图片 URL
        if let imageUrlString = article.thumbnail_pic_s, let imageUrl = URL(string: imageUrlString) {
            // 使用 SDWebImage 加载图像
            cell.thumbnailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder")) { _, error, _, _ in
                if let error = error {
                    print("Error loading image: \(error)")
                }
            }
        } else {
            // 如果没有有效的图片 URL，设置占位图
            cell.thumbnailImageView.image = UIImage(named: "placeholder")
        }
        // Here you could load the thumbnail image asynchronously
        return cell
    }

    // 使用 FDTemplateLayoutCell 自动计算高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.fd_heightForCell(withIdentifier: "TouTiaoCell", cacheBy: indexPath) { cell in
            (cell as! TouTiaoCellTableViewCell).titleLabel.text = self.articles[indexPath.row].title
            (cell as! TouTiaoCellTableViewCell).authorLabel.text = self.articles[indexPath.row].author_name
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消选中效果
        tableView.deselectRow(at: indexPath, animated: true)

        // 获取选中的文章
        let selectedArticle = articles[indexPath.row]

        if indexPath.row == 0 {
            let iqKeyboardVC = IQKeyboardManagerViewController()

            navigationController?.pushViewController(iqKeyboardVC, animated: true)
        } else if indexPath.row == 1 {
            let wcdbVC = WCDBViewController()
            navigationController?.pushViewController(wcdbVC, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 调整布局，确保首行没有空白
        tableview.layoutIfNeeded()
    }
}
