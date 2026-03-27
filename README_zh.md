# Gridfinity Extended OpenSCAD 模型

欢迎使用 Gridfinity Extended OpenSCAD 项目！本项目是 Zack Freedman 的 Gridfinity 系统在 OpenSCAD 中的重现，旨在精确复现原版 Gridfinity 收纳盒，同时增加了额外功能和自定义选项。

## 功能特点

- 精确复现 Zack Freedman 原版 Gridfinity 收纳盒。
- 在基础模型上增加了额外功能与自定义选项。
- 提供扩展图案，支持个性化和模块化设计。

## 快速入门

**Gridfinity Extended** 是一套用于生成 Gridfinity 相关 3D 模型的 OpenSCAD 脚本。主要有两种使用方式：

- 官方在线定制器，托管于 [MakerWorld](https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829)。
- 也可以下载脚本在本地运行。

### 方式一：在线定制器

你可以直接使用托管在 [MakerWorld](https://makerworld.com) 上的在线版本，无需下载任何内容，快速体验模型效果。在线脚本保持与 GitHub 最新版同步。

- 链接：https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829

### 方式二：本地运行

推荐使用本地运行方式，速度更快，且可保存配置。但需要在本地安装 OpenSCAD。

1. **安装 OpenSCAD**。本项目依赖 **OpenSCAD 开发者版**中的特性，请从 [OpenSCAD 开发者版下载页](https://openscad.org/downloads.html#snapshots) 下载。

2. **克隆或下载本仓库**：
   ```bash
   git clone https://github.com/ostat/gridfinity_extended_openscad.git
   ```
   也可以从仓库页面下载 ZIP 文件并解压。

3. **启用 OpenSCAD 功能**：
   - 打开 OpenSCAD 应用程序
   - 进入 `菜单 > 编辑 > 首选项`
   - 在 **首选项** 对话框的 **高级** 选项卡中：
     - Backend（后端）：选择 **manifold**，可大幅提升渲染速度。
   - 然后在 **功能** 选项卡中：
     - 勾选 **textmetrics**：启用底部文字相关功能。

4. **开始创建你的 Gridfinity 零件**：
   - 打开你想修改的 SCAD 文件，例如：`gridfinity_baseplate.scad`
   - 确保 Customizer（定制器）窗口可见：
      - 视图 → Customizer（如未打开则点击）
   - 渲染模型：
     - 按 F5 进行快速预览
     - 按 F6 进行完整渲染
   - 在 Customizer 中调整参数：

     | 参数 | 示例值 | 说明 |
     |------|--------|------|
     | Width（宽度） | 2 | 模块宽度数量 |
     | Depth（深度） | 1 | 模块深度数量 |
     | Magnets（磁铁） | Enabled（启用） | 是否包含磁铁孔 |

     模型会根据你的修改实时更新。

5. 开始探索并自定义 Gridfinity 收纳盒和扩展组件吧！

## 官方文档

每个脚本的详细文档请访问：[gridfinity-extended](https://docs.ostat.com/docs/openscad/gridfinity-extended)

## 脚本概览

### Gridfinity 基础收纳盒 / Gridfinity Basic Cup
脚本：`gridfinity_basic_cup.scad`

创建带有可自定义尺寸、磁铁槽和分隔选项的基础 Gridfinity 收纳盒，是大多数 Gridfinity 收纳盒的基础。

[<img src="./Images/gridfinity_basic_cup-demo_text.gif" alt="" width="300">](./Images/gridfinity_basic_cup-demo_text.gif)

### Gridfinity 底板 / Gridfinity Base Plate
脚本：`gridfinity_baseplate.scad`

生成可自定义的 Gridfinity 底板，支持磁铁放置、配重底座和多种样式。支持创建自定义形状。

[<img src="./Images/gridfinity_baseplate-demo_text.gif" alt="" width="300">](./Images/gridfinity_baseplate-demo_text.gif)

### Gridfinity 抽屉系统 / Gridfinity Drawers
脚本：`gridfinity_drawers.scad`

创建用于放置 Gridfinity 收纳盒的模块化抽屉系统，支持自定义抽屉尺寸、把手和分隔选项。

### Gridfinity 物品夹持器 / Gridfinity Extended Item Holder
脚本：`gridfinity_item_holder.scad`

可自定义的网格式物品夹持器，内置多种常见存储卡、游戏卡带、电池和工具的尺寸。

[<img src="./Images/gridfinity_item_holder-demo_text.gif" alt="" width="300">](./Images/gridfinity_item_holder-demo_text.gif)

### Gridfinity 托盘 / Gridfinity Extended Tray
脚本：`gridfinity_tray.scad`

用于存放小物件的通用托盘。

[<img src="./Images/gridfinity_tray-demo_text.gif" alt="" width="300">](./Images/gridfinity_tray-demo_text.gif)

### Gridfinity 弹珠跑道 / Gridfinity Marble Run
脚本：`gridfinity_marble.scad`

创建与 Gridfinity 系统兼容的弹珠跑道，适合教育或娱乐用途。

### Gridfinity 盖子 / gridfinity_lid.scad

为 Gridfinity 收纳盒创建盖子，支持滑动盖、铰链盖和磁吸盖等选项。

### Gridfinity 餐具收纳 / gridfinity_silverware.scad

创建适合 Gridfinity 系统的餐具整理盒，非常适合厨房整理。

### Gridfinity 国际象棋 / gridfinity_chess.scad

生成与 Gridfinity 系统兼容的国际象棋套件，每个棋子均可方便存放。

### Gridfinity 滑动盖 / gridfinity_sliding_lid.scad

专用于创建 Gridfinity 收纳盒滑动盖的脚本，支持锁止机构和顺滑滑动功能。

### Gridfinity 套筒收纳 / gridfinity_socket_holder.scad

生成适配 Gridfinity 系统的套筒及工具收纳架，内置常见套筒尺寸预设。

### Gridfinity FLSUN Q5 底板 / gridfinity_baseplate_flsun_q5.scad

专为 FLsun Q5 3D 打印机定制的底板脚本，确保与打印机构建尺寸和特性兼容。

## 如何贡献

我们欢迎任何形式的贡献来帮助改进和扩展 Gridfinity Extended 库！贡献步骤如下：

1. **Fork 仓库**：创建你自己的项目 Fork。
2. **进行改进**：添加新功能、修复 Bug 或改善文档。
3. **提交 Pull Request**：修改完成后，向主仓库提交 Pull Request 等待审核。

## 反馈与支持

你的反馈非常宝贵！如有建议、问题或改进想法，欢迎提交 Issue 或参与贡献。

---

感谢你探索 Gridfinity Extended OpenSCAD 项目！希望你享受自定义和扩展 Gridfinity 系统的乐趣。

本项目基于 Zack Freedman 的 [voidstarlab](https://www.voidstarlab.com/) 作品，以及 [vector76](https://github.com/vector76/) 的 [gridfinity_openscad](https://github.com/vector76/gridfinity_openscad) 项目。
