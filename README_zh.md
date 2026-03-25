# Gridfinity Extended OpenSCAD 模型

欢迎使用 Gridfinity Extended OpenSCAD 项目！本项目是用 OpenSCAD 对 Zack Freedman 的 Gridfinity 系统的重新实现，旨在精确还原原版 Gridfinity 收纳格，同时添加更多功能和自定义选项。

## 功能特性
- 精确还原 Zack Freedman 原版 Gridfinity 收纳格。
- 为基础模型提供额外功能和自定义选项。
- 支持扩展图案，便于个性化定制和模块化组合。

## 快速开始
**Gridfinity Extended** 是一套用于生成 Gridfinity 相关 3D 模型的 OpenSCAD 脚本。使用方式主要有两种：
- 官方在线定制器，托管于 [MakerWorld](https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829)。
- 也可以将脚本下载到本地运行。

### 方式一：在线定制器
你可以直接使用托管在 [MakerWorld](https://makerworld.com) 上的在线版本。该方式无需下载任何内容，即可快速体验模型效果。
上传的脚本功能完整且持续维护，始终与 GitHub 最新版本保持同步。<br>
- 链接：https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829

### 方式二：本地运行
推荐本地运行方式，速度更快且可保存配置，但需要在本地安装 OpenSCAD 软件。

1. 安装 OpenSCAD。本项目依赖 **OpenSCAD 开发者版本** 中的特性，请从 [OpenSCAD 开发版下载页](https://openscad.org/downloads.html#snapshots) 获取。

2. 克隆或下载本仓库到本地：
   ```bash
   git clone https://github.com/ostat/gridfinity_extended_openscad.git
   ```
   也可以从仓库页面下载 ZIP 文件并解压。

3. 启用 OpenSCAD 功能：
   - 打开 OpenSCAD 应用程序
   - 前往 `菜单 > 编辑 > 首选项`。
   - 在 **首选项** 对话框中切换到 **高级** 选项卡：
     - 后端（Backend）：选择 **manifold** 选项，可加快 OpenSCAD 渲染速度。
   - 然后切换到 **功能（Features）** 选项卡：
     - 勾选 **textmetrics**：启用底部文字所需的文本相关功能。

4. 开始创建你的 Gridfinity 零件：
   - 打开你想修改的 SCAD 文件，例如：`gridfinity_baseplate.scad`
   - 确保定制器（Customizer）窗口可见：
      - 视图 → 定制器（如果尚未打开）。
   - 渲染模型：
     - 按 F5 进行快速预览
     - 按 F6 进行完整渲染
   - 在定制器中调整参数：

       | 参数 | 示例值 | 说明 |
       |------|--------|------|
       | 宽度（Width） | 2 | 模块宽度（格数） |
       | 深度（Depth） | 1 | 模块深度（格数） |
       | 磁铁（Magnets） | 启用 | 是否包含磁铁孔 |

       模型将根据你的更改实时更新。

5. 开始探索和定制你的 Gridfinity 收纳格与扩展组件！


## 官方文档
各脚本的详细文档请访问：[gridfinity-extended](https://docs.ostat.com/docs/openscad/gridfinity-extended)


## 脚本概览

### Gridfinity 基础收纳格
脚本：`gridfinity_basic_cup.scad`<br>
生成可自定义尺寸、磁铁槽和分隔选项的基础 **Gridfinity 收纳格**，是大多数 Gridfinity 收纳格的基础。<br>
[<img src="./Images/gridfinity_basic_cup-demo_text.gif" alt="" width="300">](./Images/gridfinity_basic_cup-demo_text.gif)

### Gridfinity 底板
脚本：`gridfinity_baseplate.scad`<br>
生成可自定义的 Gridfinity 底板，支持磁铁放置、配重底座及多种样式，适用于不同场景。支持创建自定义形状。<br>
[<img src="./Images/gridfinity_baseplate-demo_text.gif" alt="" width="300">](./Images/gridfinity_baseplate-demo_text.gif)

### Gridfinity 抽屉柜
脚本：`gridfinity_drawers.scad`<br>
为 Gridfinity 收纳格创建模块化抽屉柜，包含抽屉尺寸、把手和分隔选项，实现高效收纳组织。

### Gridfinity 物品收纳架
脚本：`gridfinity_item_holder.scad`<br>
可自定义的网格式物品收纳架，内置多种常见存储卡、游戏卡带、电池和工具的尺寸规格。<br>
[<img src="./Images/gridfinity_item_holder-demo_text.gif" alt="" width="300">](./Images/gridfinity_item_holder-demo_text.gif)

### Gridfinity 托盘
脚本：`gridfinity_tray.scad`<br>
用于存放小物件的万用托盘。<br>
[<img src="./Images/gridfinity_tray-demo_text.gif" alt="" width="300">](./Images/gridfinity_tray-demo_text.gif)

### Gridfinity 弹珠跑道
脚本：`gridfinity_marble.scad`<br>
一个有趣的创意脚本，用于生成与 Gridfinity 系统兼容的弹珠跑道，适合教育或娱乐用途。

### gridfinity_lid.scad
为 Gridfinity 收纳格创建盖子，支持滑动盖、铰链盖和磁吸盖等多种方式，保持物品安全存放。

### gridfinity_silverware.scad
创建适配 Gridfinity 系统的餐具收纳格，非常适合厨房整理。

### gridfinity_chess.scad
生成兼容 Gridfinity 系统的国际象棋套件，每个棋子均设计为适合 Gridfinity 尺寸，便于存放和整理。

### gridfinity_sliding_lid.scad
专用于创建 Gridfinity 收纳格滑动盖的脚本，支持锁定机构和顺滑滑动功能。

### gridfinity_socket_holder.scad
生成适配 Gridfinity 系统的套筒扳手及工具收纳架，包含常见套筒尺寸的预设规格。

### gridfinity_baseplate_flsun_q5.scad
为 FLsun Q5 3D 打印机特别定制的底板脚本版本，确保与该打印机的构建尺寸和功能兼容。

## 如何贡献

欢迎贡献代码，帮助完善和扩展 Gridfinity Extended 库！贡献方式如下：

1. **Fork 仓库**：创建你自己的 Fork 以进行修改。
2. **改进代码**：添加新功能、修复 Bug 或改善文档。
3. **提交 Pull Request**：修改完成后，向主仓库提交 Pull Request 供审核。

## 反馈与支持

欢迎你的反馈！如有建议、问题或改进想法，请随时提交 Issue 或参与贡献。

---

感谢你探索 Gridfinity Extended OpenSCAD 项目！希望你享受自定义和扩展 Gridfinity 系统的乐趣。

本项目基于 [voidstarlab](https://www.voidstarlab.com/) 的 Zack Freedman 以及 [vector76](https://github.com/vector76/) 的 [gridfinity_openscad](https://github.com/vector76/gridfinity_openscad) 的工作成果。
