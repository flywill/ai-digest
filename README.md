# AI Builders Digest - Archive System

## 🏗️ 系统架构

这是一个完整的 AI 行业摘要归档网站，具有以下特性：

### 📁 文件结构
```
ai-digest-project/
├── index.html              # 最新一期摘要
├── archives.html           # 历史归档索引页
├── archive/               # 历史归档目录
│   └── 2026-03-28.html    # 历史摘要页面
├── styles.css             # 完整样式表
├── template.html          # 新摘要模板
├── generate-digest.py     # 归档系统生成器
├── complete-workflow.sh   # 完整工作流程脚本
└── vercel.json            # Vercel 配置
```

## 🚀 工作流程

### 每日自动化流程
1. **内容获取** - 通过 Follow Builders 技能获取最新 AI builders 内容
2. **生成摘要** - 将内容转换为双语 HTML 格式
3. **历史归档** - 将当前 index.html 移动到 archive/ 目录
4. **更新主页** - 生成新的 index.html（最新内容）
5. **更新导航** - 更新所有页面的日期导航栏
6. **Git 提交** - 自动提交更改
7. **推送到 GitHub** - 推送到 GitHub 仓库
8. **Vercel 部署** - 自动部署到生产环境

## 📅 归档系统

### 自动归档
- 每次生成新摘要时，旧的 index.html 会自动归档
- 归档文件命名格式：`YYYY-MM-DD.html`
- 从 HTML 内容中自动提取日期

### 日期导航
- 每个页面顶部都有历史归档的日期导航栏
- 点击日期链接可以查看对应的历史摘要
- 导航栏自动更新显示最新的归档

### 归档索引页
- `archives.html` 提供完整的历史归档列表
- 按日期倒序排列
- 方便浏览所有历史内容

## 🎨 功能特性

### 双语内容
- 每个摘要包含中英文双语版本
- 自动翻译和格式化
- 便于不同语言用户阅读

### 响应式设计
- 完美适配桌面和移动设备
- 优化的移动端体验
- 流畅的动画效果

### 自动化部署
- 无需人工干预
- 每天上午 8:00 自动运行
- 全流程自动化

## 🔧 使用说明

### 手动运行完整流程
```bash
cd ~/ai-digest-project
bash complete-workflow.sh
```

### 仅更新归档系统
```bash
cd ~/ai-digest-project
python3 generate-digest.py
```

### 查看部署状态
```bash
cd ~/ai-digest-project
bash monitor-deployment.sh
```

## 🌐 网站访问

- **最新摘要**：https://ai-digest-psi.vercel.app
- **历史归档**：https://ai-digest-psi.vercel.app/archives.html
- **特定日期**：https://ai-digest-psi.vercel.app/archive/2026-03-28.html

## 📊 技术栈

- **内容获取**：Follow Builders 技能
- **部署平台**：Vercel
- **代码托管**：GitHub
- **认证方式**：SSH (ed25519)
- **自动化**：WorkBuddy Cron

## 🎯 优势

### 内容管理
- ✅ 自动归档所有历史内容
- ✅ 便于回溯和查找
- ✅ 永久保存所有摘要

### 用户体验
- ✅ 清晰的日期导航
- ✅ 响应式设计
- ✅ 流畅的加载速度

### 运维效率
- ✅ 完全自动化
- ✅ 无需人工干预
- ✅ 可靠的部署流程

## 📞 相关链接

- GitHub 仓库：https://github.com/flywill/ai-digest
- Vercel 仪表盘：https://vercel.com/flywill/ai-digest
- Follow Builders 技能：https://github.com/zarazhangrui/follow-builders

## 🔄 版本历史

### v2.0 - 归档系统 (2026-03-28)
- ✅ 添加历史归档功能
- ✅ 实现日期导航栏
- ✅ 创建归档索引页
- ✅ 完整的工作流程自动化

### v1.0 - 初始版本
- ✅ 基础摘要功能
- ✅ 双语内容
- ✅ 自动部署

---

**注意**：所有历史内容都会永久保存在 `archive/` 目录中，确保不会丢失任何一期摘要。
