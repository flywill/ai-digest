# AI Builders Digest - 卸载和移除指南

## ⚠️ 重要提醒

**在进行任何删除操作前，请确保：**
1. 你真的不需要这个项目了
2. 已经备份了所有重要数据
3. 理解这些操作是**不可逆的**

## 🚫 从 Vercel 移除项目

### 方法 1: 通过 Vercel Dashboard（推荐）

1. **登录 Vercel Dashboard**：
   - 访问：https://vercel.com/dashboard
   - 登录你的账户

2. **找到项目**：
   - 在项目列表中找到 `ai-digest` 或 `flywill/ai-digest`
   - 点击项目名称进入项目页面

3. **删除项目**：
   - 点击项目顶部的 **"Settings"** 标签
   - 滚动到页面底部
   - 找到 **"Danger Zone"** 区域
   - 点击 **"Delete Project"** 按钮
   - 在确认框中输入项目名称：`flywill/ai-digest` 或 `ai-digest-psi`
   - 点击 **"Delete"** 确认删除

4. **确认删除**：
   - 你会收到删除确认邮件
   - 域名会自动释放
   - 所有部署历史会被删除

### 方法 2: 通过 Vercel CLI（如果你安装了）

```bash
# 1. 登录 Vercel（如果还没登录）
vercel login

# 2. 列出所有项目
vercel list

# 3. 删除特定项目
vercel remove flywill/ai-digest

# 确认删除时，输入项目的 ID 或完整名称
```

## 🗑️ 从 GitHub 删除仓库（可选）

### 方法 1: 通过 GitHub 网页界面

1. **访问仓库设置**：
   - 访问：https://github.com/flywill/ai-digest/settings

2. **危险区域设置**：
   - 滚动到页面底部的 **"Danger Zone"** 区域
   - 点击 **"Delete this repository"** 按钮

3. **确认删除**：
   - 在确认框中输入：`flywill/ai-digest`
   - 点击 **"I understand the consequences, delete this repository"**
   - 确认删除操作

### 方法 2: 通过 GitHub CLI

```bash
# 删除远程仓库
gh repo delete flywill/ai-digest --confirm

# 或者交互式删除（会要求确认）
gh repo delete flywill/ai-digest
```

### 方法 3: 通过 Git 命令行

```bash
# 只删除远程仓库（保留本地）
cd ~/ai-digest-project
git remote remove origin

# 然后可以在 GitHub 网页界面删除
```

## 💾 备份重要数据（删除前必读）

### 1. 备份代码

```bash
# 创建备份目录
mkdir -p ~/backups/ai-digest-backup

# 复制整个项目
cp -r ~/ai-digest-project ~/backups/ai-digest-backup/

# 创建压缩备份
cd ~/backups
tar -czf ai-digest-backup-$(date +%Y%m%d).tar.gz ai-digest-backup/
```

### 2. 备份归档内容

```bash
# 备份所有历史归档
cp -r ~/ai-digest-project/archive ~/backups/

# 备份 README 和配置
cp ~/ai-digest-project/README.md ~/backups/
cp ~/ai-digest-project/vercel.json ~/backups/
```

### 3. 备份 GitHub 内容（可选）

如果你想保存完整的 GitHub 内容：

```bash
# 进入项目目录
cd ~/ai-digest-project

# 克隆完整仓库（包括所有历史）
cd ~/backups
git clone --mirror git@github.com:flywill/ai-digest.git ai-digest-mirror
```

## 🚫 禁用 WorkBuddy 自动化（删除前）

### 1. 查看当前自动化设置

```bash
# 查看 WorkBuddy 自动化列表
#（根据你的具体环境，命令可能不同）

# 检查 crontab
crontab -l | grep ai-builders-digest
```

### 2. 禁用或删除自动化

```bash
# 删除 crontab 任务
crontab -l | grep -v ai-builders-digest | crontab -

# 或者编辑 crontab
crontab -e
# 找到并删除与 ai-builders-digest 相关的行
```

### 3. 清理 WorkBuddy 配置

```bash
# 删除 WorkBuddy 自动化配置
rm -rf /Users/priscillazhang/WorkBuddy/automation-claw-20260327231608/.codebuddy/automations/ai-builders-digest/

# 删除工作记忆（可选）
# rm /Users/priscillazhang/WorkBuddy/automation-claw-20260327231608/.workbuddy/memory/2026-03-28.md
```

## 🧹 完全卸载步骤（从零开始）

如果你想完全清理所有相关内容：

### Step 1: 禁用自动化
```bash
# 停止所有相关的自动化任务
#（根据你的具体环境）
```

### Step 2: 删除本地项目
```bash
# 确认你真的要删除本地项目
# 先备份！
mkdir -p ~/deleted-projects
mv ~/ai-digest-project ~/deleted-projects/

# 或者直接删除（不推荐，因为无法恢复）
# rm -rf ~/ai-digest-project
```

### Step 3: 删除 Vercel 项目
- 访问：https://vercel.com/dashboard
- 找到并删除 `ai-digest` 项目

### Step 4: 删除 GitHub 仓库（可选）
- 访问：https://github.com/flywill/ai-digest/settings
- 删除仓库

### Step 5: 清理 SSH key（可选）

如果你只为这个项目创建了 SSH key：

```bash
# 查看当前 SSH keys
ls -la ~/.ssh/

# 如果确定不再需要，可以删除
# rm ~/.ssh/id_ed25519
# rm ~/.ssh/id_ed25519.pub

# 从 GitHub 删除 key
# 访问：https://github.com/settings/keys
# 找到并删除 "Priscilla's Mac" key
```

### Step 6: 清理配置文件（可选）

```bash
# 删除 Follow Builders 配置（如果不再需要）
# rm -rf ~/.follow-builders/

# 删除备份文件（如果确认不需要）
# rm -rf ~/backups/ai-digest-backup*
```

## 🔄 临时禁用而不是删除

如果你只是想暂停这个项目一段时间：

### 选项 1: 暂停自动化
```bash
# 停止 cron 任务
crontab -l | grep -v ai-builders-digest | crontab -
```

### 选项 2: 暂停 Vercel 部署（保留数据）
- 保留 Vercel 项目，但不推送新代码
- 项目会保持当前状态，不会有更新

### 选项 3: 停止 GitHub 同步
- 在 Vercel 设置中断开 Git 连接
- 手动部署时才触发更新

## 📊 删除影响评估

### 删除 Vercel 项目
- ✅ 网站会立即下线
- ✅ 域名 `ai-digest-tau.vercel.app` 会释放
- ✅ 所有部署历史会丢失
- ✅ 环境变量和配置会丢失
- ❌ 无法恢复

### 删除 GitHub 仓库
- ✅ 所有代码历史会丢失
- ✅ Issues 和 PRs 会丢失
- ✅ Wiki 和其他内容会丢失
- ❌ 无法恢复

### 删除本地项目
- ✅ 释放磁盘空间
- ✅ 清理文件系统
- ❌ 无法恢复（除非有备份）

## 🎯 推荐做法

### 如果你可能将来重新使用
1. **备份所有内容**
2. **暂停自动化**
3. **停止新部署**
4. **保留 Vercel 项目和 GitHub 仓库**

### 如果你确定不再需要
1. **创建完整备份**
2. **删除 Vercel 项目**
3. **删除 GitHub 仓库**
4. **删除本地文件**
5. **清理自动化配置**
6. **清理 SSH keys（仅限专用）**

## 📝 删除后检查清单

删除完成后，确认以下项目：

- [ ] Vercel Dashboard 中不再显示该项目
- [ ] GitHub 中不再有 `flywill/ai-digest` 仓库
- [ ] 本地不再有 `~/ai-digest-project/` 目录
- [ ] crontab 中没有相关任务
- [ ] 工作记忆中已清理相关内容
- [ ] SSH keys 已清理（如需要）

## 🚨 恢复方案（万一后悔）

如果你删除后想恢复：

### 从备份恢复
```bash
# 从备份恢复本地项目
cp -r ~/backups/ai-digest-backup* ~/ai-digest-project/

# 重新连接到 GitHub（如果仓库还存在）
cd ~/ai-digest-project
git remote add origin git@github.com:flywill/ai-digest.git
git push origin main
```

### 重建项目
如果所有备份都丢失了，可以从零开始重建：
- 重新创建 GitHub 仓库
- 重新创建 Vercel 项目
- 重新配置自动化

---

**记住：删除操作是不可逆的！请确保你有备份！**
