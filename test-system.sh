#!/bin/bash

# AI Builders Digest - 系统测试脚本
# 验证所有功能是否正常工作

PROJECT_DIR="$HOME/ai-digest-project"

echo "🧪 AI Builders Digest - 系统测试"
echo "================================="
echo ""

# 测试 1: 检查文件结构
echo "📋 测试 1: 检查文件结构..."
required_files=(
    "index.html"
    "archives.html"
    "styles.css"
    "template.html"
    "generate-digest.py"
    "complete-workflow.sh"
    "README.md"
)

all_files_exist=true
for file in "${required_files[@]}"; do
    if [ -f "$PROJECT_DIR/$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file - 缺失"
        all_files_exist=false
    fi
done

# 测试 2: 检查归档目录
echo ""
echo "📁 测试 2: 检查归档目录..."
if [ -d "$PROJECT_DIR/archive" ]; then
    archive_count=$(ls -1 "$PROJECT_DIR/archive"/*.html 2>/dev/null | wc -l)
    echo "  ✅ 归档目录存在"
    echo "  📊 归档文件数量: $archive_count"
else
    echo "  ❌ 归档目录不存在"
    all_files_exist=false
fi

# 测试 3: 检查 HTML 内容
echo ""
echo "🔍 测试 3: 检查 HTML 内容..."
if [ -f "$PROJECT_DIR/index.html" ]; then
    # 检查是否包含必要的元素
    if grep -q "AI Builders Digest" "$PROJECT_DIR/index.html"; then
        echo "  ✅ index.html 包含标题"
    else
        echo "  ❌ index.html 缺少标题"
    fi
    
    if grep -q "March.*2026" "$PROJECT_DIR/index.html"; then
        echo "  ✅ index.html 包含日期"
    else
        echo "  ⚠️  index.html 日期格式可能不正确"
    fi
fi

if [ -f "$PROJECT_DIR/archives.html" ]; then
    if grep -q "Archives" "$PROJECT_DIR/archives.html"; then
        echo "  ✅ archives.html 包含归档页面"
    else
        echo "  ❌ archives.html 内容不完整"
    fi
fi

# 测试 4: 检查样式文件
echo ""
echo "🎨 测试 4: 检查样式文件..."
if [ -f "$PROJECT_DIR/styles.css" ]; then
    css_rules=$(grep -c "^[[:space:]]*\." "$PROJECT_DIR/styles.css" || echo 0)
    echo "  ✅ styles.css 存在"
    echo "  📊 CSS 规则数量: $css_rules"
else
    echo "  ❌ styles.css 缺失"
fi

# 测试 5: 检查脚本权限
echo ""
echo "🔧 测试 5: 检查脚本权限..."
scripts=(
    "generate-digest.py"
    "complete-workflow.sh"
)

for script in "${scripts[@]}"; do
    if [ -x "$PROJECT_DIR/$script" ]; then
        echo "  ✅ $script 有执行权限"
    else
        echo "  ⚠️  $script 需要执行权限"
    fi
done

# 测试 6: Git 状态
echo ""
echo "📊 测试 6: Git 状态..."
cd "$PROJECT_DIR" || exit 1
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "  ✅ Git 仓库存在"
    
    # 检查分支
    current_branch=$(git branch --show-current)
    echo "  📌 当前分支: $current_branch"
    
    # 检查远程仓库
    if git remote get-url origin > /dev/null 2>&1; then
        remote_url=$(git remote get-url origin)
        echo "  🔗 远程仓库: $remote_url"
    else
        echo "  ⚠️  没有配置远程仓库"
    fi
    
    # 检查是否有未提交的更改
    if git diff-index --quiet HEAD --; then
        echo "  ✅ 没有未提交的更改"
    else
        echo "  ⚠️  有未提交的更改"
        git status --short
    fi
else
    echo "  ❌ 不是一个 Git 仓库"
fi

# 测试 7: GitHub 连接
echo ""
echo "🌐 测试 7: GitHub 连接..."
if ssh -o ConnectTimeout=5 git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "  ✅ GitHub SSH 连接正常"
else
    echo "  ❌ GitHub SSH 连接失败"
fi

# 总结
echo ""
echo "🎯 测试总结"
echo "==========="
if [ "$all_files_exist" = true ]; then
    echo "✅ 所有关键文件都存在"
else
    echo "❌ 部分文件缺失，需要检查"
fi

echo ""
echo "📋 系统信息:"
echo "  项目目录: $PROJECT_DIR"
echo "  归档目录: $PROJECT_DIR/archive"
echo "  Git 仓库: $PROJECT_DIR/.git"
echo ""

echo "🚀 快速命令:"
echo "  生成新摘要: bash complete-workflow.sh"
echo "  更新归档: python3 generate-digest.py"
echo "  查看状态: bash monitor-deployment.sh"
echo "  访问网站: https://ai-digest-psi.vercel.app"
