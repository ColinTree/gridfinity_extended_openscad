# Gridfinity Extended OpenSCAD 模型

欢迎使用 Gridfinity Extended OpenSCAD 项目！本项目是用 OpenSCAD 对 Zack Freedman 的 Gridfinity 系统的重新实现，旨在精确还原原版 Gridfinity 收纳格的同时，新增更多功能和自定义选项。

## 功能特性

- 精确还原 Zack Freedman 原版 Gridfinity 收纳格。
- 在基础模型上新增更多功能和自定义选项。
- 支持扩展纹样，进一步个性化和模块化。

## 快速上手

**Gridfinity Extended** 是一套用于生成 Gridfinity 相关 3D 模型的 OpenSCAD 脚本。主要有两种使用方式：

- 官方在线定制器，托管于 [MakerWorld](https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829)。
- 也可以下载脚本在本地运行。

### 方式一：在线定制器

可以使用托管于 [MakerWorld](https://makerworld.com) 的在线版本，无需下载即可快速体验模型。
上传的脚本为完整版本，并与 GitHub 最新版本保持同步。

- 链接：https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829

### 方式二：本地运行

推荐使用本地运行方式。脚本运行更快，且可以保存配置。但需要在本地机器上下载安装 OpenSCAD 软件。

1. 安装 OpenSCAD。本项目依赖 **OpenSCAD 开发版** 的功能，请从 [OpenSCAD 开发版下载页](https://openscad.org/downloads.html#snapshots) 下载。

2. 克隆或下载本仓库到本地机器：
   ```bash
   git clone https://github.com/ostat/gridfinity_extended_openscad.git
   ```
   也可以从仓库页面下载 ZIP 文件并解压。

3. 开启 OpenSCAD 功能：
   - 打开 OpenSCAD 应用
   - 进入 `菜单 > 编辑 > 首选项`
   - 在**首选项**对话框中进入**高级**选项卡：
     - 后端（Backend）：选择 **manifold** 选项，可加速 OpenSCAD 运行。
   - 然后进入**功能**（Features）选项卡：
     - 勾选 **textmetrics**：启用底部文字相关功能。

4. 开始创建自己的 Gridfinity 零件：
   - 打开你想修改的 SCAD 库文件，例如：`gridfinity_baseplate.scad`
   - 确认定制器窗口已显示：
     - 视图（View） → 定制器（Customizer）（如未打开则点击开启）
   - 渲染模型：
     - 按 F5 快速预览
     - 按 F6 完整渲染
   - 在定制器中调整参数：
     - 参数名　示例值　说明
     - 宽度（Width）　2　模块宽度（格数）
     - 深度（Depth）　1　模块深度（格数）
     - 磁铁（Magnets）　启用　包含磁铁孔
     - 模型将根据你的修改实时更新。

5. 开始探索和定制 Gridfinity 收纳格及扩展件！


## 官方文档

各脚本的详细官方文档请访问 [gridfinity-extended](https://docs.ostat.com/docs/openscad/gridfinity-extended)


## 脚本概览

### Gridfinity 基础收纳格
脚本：`gridfinity_basic_cup.scad`<br>
此脚本用于创建可自定义尺寸、磁铁槽和分隔选项的基础 **Gridfinity 收纳格**，是大多数 Gridfinity 收纳格的基础。<br>
[<img src="./Images/gridfinity_basic_cup-demo_text.gif"  alt="" width="300">](./Images/gridfinity_basic_cup-demo_text.gif)

### Gridfinity 底板
脚本：`gridfinity_baseplate.scad`<br>
此脚本用于生成可自定义的 Gridfinity 底板，支持磁铁放置、配重底座和多种样式，适应不同使用场景，并支持创建自定义形状。<br>
[<img src="./Images/gridfinity_baseplate-demo_text.gif"  alt="" width="300">](./Images/gridfinity_baseplate-demo_text.gif)


### Gridfinity 抽屉柜
脚本：`gridfinity_drawers.scad`<br>
用于创建 Gridfinity 收纳格的模块化抽屉柜，包含抽屉尺寸、把手和分隔板选项，实现高效收纳整理。

### Gridfinity Extended 物品收纳
脚本：`gridfinity_item_holder.scad`<br>
基于网格的可定制物品收纳器，内置多种常见内存卡、卡带、电池和工具的尺寸数据。<br>
[<img src="./Images/gridfinity_item_holder-demo_text.gif" alt="" width="300">](./Images/gridfinity_item_holder-demo_text.gif)

### Gridfinity Extended 托盘
脚本：`gridfinity_tray.scad`<br>
用于盛放小物件的通用托盘。<br>
[<img src="./Images/gridfinity_tray-demo_text.gif" alt="" width="300">](./Images/gridfinity_tray-demo_text.gif)

### Gridfinity 弹珠轨道
脚本：`gridfinity_marble.scad`<br>
用于生成与 Gridfinity 系统兼容的弹珠轨道的趣味创意脚本，非常适合教育或娱乐用途。

### gridfinity_lid.scad
为 Gridfinity 收纳格创建盖板，支持滑动盖、铰链盖和磁吸盖等选项，安全固定物品。

### gridfinity_silverware.scad
在 Gridfinity 系统中创建餐具整理器，非常适合厨房收纳。

### gridfinity_chess.scad
生成 Gridfinity 兼容的国际象棋套装，每个棋子均设计为适合 Gridfinity 系统，便于收纳和整理。

### gridfinity_sliding_lid.scad
用于创建 Gridfinity 收纳格滑动盖的专用脚本，支持锁定机构和顺滑滑动功能。

### gridfinity_socket_holder.scad
生成套筒和其他工具的收纳器，确保与 Gridfinity 系统兼容，并内置常见套筒尺寸的预设数据。

### gridfinity_baseplate_flsun_q5.scad
专为 FLsun Q5 3D 打印机定制的底板脚本，确保与该打印机的热床尺寸和功能兼容。

## 如何参与贡献

欢迎贡献以帮助改进和扩展 Gridfinity Extended 库！贡献方式：

1. **Fork 仓库**：创建项目的个人分支以进行修改。
2. **进行改进**：添加新功能、修复 Bug 或完善文档。
3. **提交 Pull Request**：修改完成后，向主仓库提交 PR 以供审查。

## 反馈与支持

非常期待你的反馈！如有建议、问题或改进想法，欢迎在 Issues 中提出或参与贡献。

---

感谢探索 Gridfinity Extended OpenSCAD 项目！希望你享受定制和扩展 Gridfinity 系统的过程。

本项目基于 [voidstarlab](https://www.voidstarlab.com/) 的 Zack Freedman 及 [vector76](https://github.com/vector76/) 的 [gridfinity_openscad](https://github.com/vector76/gridfinity_openscad) 作品。
