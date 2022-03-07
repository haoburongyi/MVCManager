# MVCManager
MVC 优雅的分离 Controller 和 View

越来越多的人开发从 MVC 转向了 MVVM，原因是臃肿的 Controller 让项目难于维护
该项目的目的就是为了剥离 Controller 层和 View 层，让 Controller 只对 view 进行配置，view 对 UI 视图进行管理
为 Controller 添加一个默认属性 contrainer，container 为自定义 view，可以直接使用该自定义 view 内的属性及方法进行配置

使用直接复制 MVCManager 和 MVCProcotol 到自己项目，对要分离 Controller 和 View 的控制器在 MVCProcotol 的底部添加以下代码就可以了

extension ProfileController: MVCProtocol { typealias Container = ProfileView }
