# Gridfinity Extended OpenSCAD 模型

欢迎使用 Gridfinity Extended OpenSCAD 项目！这是用 OpenSCAD 对 Zack Freedman 的 Gridfinity 系统的重新实现，旨在精确复现原版 Gridfinity 收纳盒，同时增加了更多功能和自定义选项。

## 功能特色
- 精确复现 Zack Freedman 原版 Gridfinity 收纳盒。
- 在基础模型基础上增加了额外功能和自定义选项。
- 提供扩展图案，支持进一步个性化和模块化。

## 快速开始
**Gridfinity Extended** 是一套用于生成 Gridfinity 相关 3D 模型的 OpenSCAD 脚本。使用方式主要有两种：
- 使用托管在 [MakerWorld](https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829) 上的官方在线定制器。
- 或者将脚本下载到本地运行。

### 方式一：在线定制器
你可以使用托管在 [MakerWorld](https://makerworld.com) 上的在线版本。这种方式无需下载任何内容，可快速体验各种模型。
上传的脚本功能完整且持续更新，与 GitHub 上的最新版本同步。<br>
- 链接：https://makerworld.com/en/models/481168-gridfinity-extended#profileId-1037829

### 方式二：本地运行
推荐使用本地运行方式。脚本运行速度更快，且可以保存你的配置。但需要在本地机器上下载并安装 OpenSCAD 软件。

1. 安装 OpenSCAD。本项目依赖 **OpenSCAD 开发者版本** 中的特性。请从 [OpenSCAD 开发者版本](https://openscad.org/downloads.html#snapshots) 下载。

2. 克隆或下载本仓库到本地：
   ```bash
   git clone https://github.com/ostat/gridfinity_extended_openscad.git
   ```
   也可以从仓库页面下载 ZIP 文件并解压。

3. 启用 OpenSCAD 功能。
   - 打开 OpenSCAD 应用
   - 进入 `菜单 > 编辑 > 首选项`
   - 在 **首选项** 对话框中进入 **高级** 标签页：
     - 后端：选择 **manifold** 选项，可加速 OpenSCAD 渲染。
   - 然后进入 **功能** 标签页：
     - 勾选 **textmetrics**：启用与底部文字相关的功能。

4. 开始创建你自己的 Gridfinity 零件
   - 打开你想修改的 SCAD 脚本文件，例如：`gridfinity_baseplate.scad`
   - 确保定制器窗口已显示：
      - 视图 → 定制器（如果尚未打开）
   - 渲染模型：
     - 按 F5 进行快速预览
     - 按 F6 进行完整渲染
   - 在定制器中调整参数：
       | 参数 | 示例值 | 说明 |
       |------|--------|------|
       | Width（宽度）| 2 | 模块横向数量 |
       | Depth（深度）| 1 | 模块纵向数量 |
       | Magnets（磁铁）| 启用 | 是否包含磁铁孔 |

       模型会根据你的更改实时更新。

5. 开始探索和定制 Gridfinity 收纳盒及扩展组件！


## 官方文档
每个脚本的详细官方文档请访问：[gridfinity-extended](https://docs.ostat.com/docs/openscad/gridfinity-extended)


## 脚本概览

### Gridfinity 基础杯体（Basic Cup）
脚本：`gridfinity_basic_cup.scad`<br>
此脚本创建基础 **Gridfinity 收纳盒**，支持自定义尺寸、磁铁槽和分隔选项，是大多数 Gridfinity 收纳盒的基础。<br>
[<img src="./Images/gridfinity_basic_cup-demo_text.gif" alt="" width="300">](./Images/gridfinity_basic_cup-demo_text.gif)

### Gridfinity 底板（Base Plate）
脚本：`gridfinity_baseplate.scad`<br>
此脚本生成可自定义的 Gridfinity 底板。包含磁铁放置、配重底座和多种样式选项，适应不同应用场景，支持自定义形状。<br>
[<img src="./Images/gridfinity_baseplate-demo_text.gif" alt="" width="300">](./Images/gridfinity_baseplate-demo_text.gif)

### Gridfinity 抽屉柜（Drawers）
脚本：`gridfinity_drawers.scad`<br>
为 Gridfinity 收纳盒创建模块化抽屉。包含抽屉尺寸、把手和分隔件选项，实现高效整理。

### Gridfinity 物品托架（Item Holder）
脚本：`gridfinity_item_holder.scad`<br>
可自定义的网格式物品托架。内置多种常见存储卡、游戏卡带、电池和工具的尺寸数据。<br>
[<img src="./Images/gridfinity_item_holder-demo_text.gif" alt="" width="300">](./Images/gridfinity_item_holder-demo_text.gif)

### Gridfinity 托盘（Tray）
脚本：`gridfinity_tray.scad`<br>
用于盛放小物品的万能托盘。<br>
[<img src="./Images/gridfinity_tray-demo_text.gif" alt="" width="300">](./Images/gridfinity_tray-demo_text.gif)

### Gridfinity 弹珠滑道（Marble Run）
脚本：`gridfinity_marble.scad`<br>
一个有趣的脚本，用于生成与 Gridfinity 系统兼容的弹珠滑道。适合教育或娱乐用途。

### 盖板（gridfinity_lid.scad）
为 Gridfinity 收纳盒创建盖板。包含滑动盖、铰链盖和磁铁固定盖等选项，确保物品安全存放。

### 餐具收纳（gridfinity_silverware.scad）
为适配 Gridfinity 系统的餐具创建收纳架。非常适合厨房整理。

### 国际象棋（gridfinity_chess.scad）
生成与 Gridfinity 兼容的国际象棋套件。每个棋子都设计为能放入 Gridfinity 系统，便于存储和整理。

### 滑动盖（gridfinity_sliding_lid.scad）
专门用于为 Gridfinity 收纳盒创建滑动盖的脚本。包含锁定机构和顺滑滑动功能选项。

### 套筒扳手架（gridfinity_socket_holder.scad）
为套筒扳手和其他工具生成托架，确保与 Gridfinity 系统兼容。内置常见套筒尺寸的预设参数。

### FLSUN Q5 底板（gridfinity_baseplate_flsun_q5.scad）
专为 FLsun Q5 3D 打印机定制的底板脚本版本，确保与打印机尺寸和功能的兼容性。

## 如何贡献

欢迎贡献代码，共同改进和扩展 Gridfinity Extended 库！贡献方式如下：

1. **Fork 仓库**：创建项目的个人分支以进行修改。
2. **做出改进**：添加新功能、修复 Bug 或改进文档。
3. **提交 Pull Request**：修改完成后，向主仓库提交 Pull Request 以供审查。

## 反馈与支持

你的反馈非常宝贵！如有建议、问题或改进想法，欢迎提交 Issue 或参与项目贡献。

---

感谢探索 Gridfinity Extended OpenSCAD 项目！希望你享受自定义和扩展 Gridfinity 系统的过程。

本项目基于 Zack Freedman 的 [voidstarlab](https://www.voidstarlab.com/) 和 [vector76](https://github.com/vector76/) 的 [gridfinity_openscad](https://github.com/vector76/gridfinity_openscad) 工作成果。
