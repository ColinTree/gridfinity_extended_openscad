# Gridfinity Extended OpenSCAD 模型

欢迎来到 Gridfinity Extended OpenSCAD 项目！这是使用 OpenSCAD 对 Zack Freedman 的 Gridfinity 系统的重新实现，旨在精确还原原版 Gridfinity 收纳盒，同时增加更多额外功能和自定义选项。

## 主要特性
- 精确还原 Zack Freedman 原版 Gridfinity 收纳盒。
- 在原版基础上新增更多功能和自定义选项。
- 支持扩展图案，提供更丰富的个性化和模块化能力。

## 快速开始

**Gridfinity Extended** 是一套用于生成 Gridfinity 相关 3D 模型的 OpenSCAD 脚本集合。使用方式有两种：
- 官方在线定制器，托管于 [MakerWorld](https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829)。
- 也可以下载脚本在本地运行。

### 方式一：在线定制器

你可以使用托管在 [MakerWorld](https://makerworld.com) 上的在线版本，无需下载任何内容即可快速体验模型效果。
上传的脚本功能完整，与 GitHub 版本保持同步更新。<br>
- 链接：https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829

### 方式二：本地运行

本地运行是推荐方式，速度更快且可以保存配置，但需要在本地安装 OpenSCAD 软件。

1. 安装 OpenSCAD。本项目依赖 **OpenSCAD 开发者版本** 的特性，请从 [OpenSCAD 开发者版本](https://openscad.org/downloads.html#snapshots) 下载安装。

2. 克隆或下载本仓库到本地：
   ```bash
   git clone https://github.com/ostat/gridfinity_extended_openscad.git
   ```
   也可以从仓库页面下载 ZIP 文件并解压。

3. 启用 OpenSCAD 功能。
   - 打开 OpenSCAD 应用程序
   - 进入 `菜单 > Edit > Preferences`（编辑 > 首选项）
   - 在 **Preferences** 对话框中，选择 **Advanced**（高级）标签：
     - Backend（后端）：选择 **manifold** 选项，可加快 OpenSCAD 渲染速度。
   - 再选择 **Features**（功能）标签：
     - 勾选 **textmetrics**：启用底部文字等文字相关功能。

4. 开始创建你的 Gridfinity 零件
   - 打开你想修改的 SCAD 脚本文件，例如：`gridfinity_baseplate.scad`
   - 确保 Customizer（定制器）窗口可见：
      - 菜单 View → Customizer（如未打开）。
   - 渲染模型：
     - 按 F5 快速预览
     - 按 F6 完整渲染
   - 在 Customizer 中调整参数：
       | 参数 | 示例值 | 说明 |
       |------|--------|------|
       | Width（宽度） | 2 | 模块宽度（格数） |
       | Depth（深度） | 1 | 模块深度（格数） |
       | Magnets（磁铁） | Enabled | 是否包含磁铁孔 |

       参数修改后，模型会实时更新。

5. 开始探索和定制你的 Gridfinity 收纳盒和扩展件！


## 官方文档

每个脚本的详细文档请访问：[gridfinity-extended](https://docs.ostat.com/docs/openscad/gridfinity-extended)


## 脚本说明

### Gridfinity 基础收纳盒（Basic Cup）
脚本：`gridfinity_basic_cup.scad`<br>
创建基础的 **Gridfinity 收纳盒**，支持自定义尺寸、磁铁槽和内部分隔等选项。是大多数 Gridfinity 收纳盒的基础脚本。<br>
[<img src="./Images/gridfinity_basic_cup-demo_text.gif" alt="" width="300">](./Images/gridfinity_basic_cup-demo_text.gif)

### Gridfinity 底板（Base Plate）
脚本：`gridfinity_baseplate.scad`<br>
生成可自定义的 Gridfinity 底板。支持磁铁孔、配重底座和多种样式，适应不同使用场景，也支持自定义外形轮廓。<br>
[<img src="./Images/gridfinity_baseplate-demo_text.gif" alt="" width="300">](./Images/gridfinity_baseplate-demo_text.gif)


### Gridfinity 抽屉柜（Drawers）
脚本：`gridfinity_drawers.scad`<br>
为 Gridfinity 收纳盒创建模块化抽屉柜。支持设置抽屉尺寸、拉手和分隔，实现高效收纳。

### Gridfinity 物品固定器（Item Holder）
脚本：`gridfinity_item_holder.scad`<br>
可定制的网格物品固定器，内置了内存卡、游戏卡带、电池和各类工具的预定义尺寸。<br>
[<img src="./Images/gridfinity_item_holder-demo_text.gif" alt="" width="300">](./Images/gridfinity_item_holder-demo_text.gif)

### Gridfinity 托盘（Tray）
脚本：`gridfinity_tray.scad`<br>
用于盛放小物件的多格托盘。<br>
[<img src="./Images/gridfinity_tray-demo_text.gif" alt="" width="300">](./Images/gridfinity_tray-demo_text.gif)

### Gridfinity 弹珠轨道（Marble Run）
脚本：`gridfinity_marble.scad`<br>
一个有趣的创意脚本，生成与 Gridfinity 系统兼容的弹珠轨道，适合教育或娱乐用途。

### gridfinity_lid.scad（盖子）
为 Gridfinity 收纳盒创建盖子，支持滑动盖、翻盖和磁铁固定盖等多种样式。

### gridfinity_silverware.scad（餐具收纳）
创建适配 Gridfinity 系统的餐具收纳盒，非常适合厨房整理。

### gridfinity_chess.scad（国际象棋）
生成 Gridfinity 兼容的国际象棋套件，每个棋子设计为适配 Gridfinity 系统，便于存放和整理。

### gridfinity_sliding_lid.scad（滑动盖）
专门用于创建 Gridfinity 收纳盒滑动盖的脚本，支持锁定机制和平滑滑动功能。

### gridfinity_socket_holder.scad（套筒收纳）
生成套筒和其他工具的收纳架，与 Gridfinity 系统兼容，内置常见套筒尺寸的预设值。

### gridfinity_baseplate_flsun_q5.scad（FLSUN Q5 专用底板）
专为 FLsun Q5 3D 打印机定制的底板脚本，确保与打印机的打印尺寸和特性兼容。

## 如何贡献

欢迎贡献代码，共同改进和扩展 Gridfinity Extended 库！贡献方式：

1. **Fork 仓库**：Fork 本项目，在你自己的副本上进行修改。
2. **做出改进**：添加新功能、修复 Bug 或改善文档。
3. **提交 Pull Request**：修改完成后，向主仓库提交 Pull Request 进行审查。

## 反馈与支持

非常欢迎你的反馈！如有建议、问题或改进想法，欢迎提 Issue 或参与贡献。

---

感谢你探索 Gridfinity Extended OpenSCAD 项目！希望你能享受定制和扩展自己的 Gridfinity 收纳系统的乐趣。

本项目基于 Zack Freedman 的 [voidstarlab](https://www.voidstarlab.com/) 作品以及 [vector76](https://github.com/vector76/) 的 [gridfinity_openscad](https://github.com/vector76/gridfinity_openscad) 进行开发。
