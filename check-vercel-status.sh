#!/bin/bash

# Vercel 部署状态检查脚本
# 快速诊断 Vercel 部署问题

PROJECT_DIR="$HOME/ai-digest-project"

echo "🔍 Vercel 部署状态检查"
echo "======================"
echo ""

# 检查本地 Git 状态
echo "📊 本地 Git 状态"
echo "---------------"
cd "$PROJECT_DIR"
LATEST_LOCAL=$(git log -1 --pretty=format:"%h - %cd" --date=format:"%Y-%m-%d %H:%M:%S")
echo "最新本地提交: $LATEST_LOCAL"
echo ""

# 检查远程 Git 状态
echo "🌐 远程 Git 状态"
echo "---------------"
LATEST_REMOTE=$(git ls-remote origin main | awk '{print $1}')
LATEST_REMOTE_SHORT=$(git rev-parse --short "$LATEST_REMOTE" 2>/dev/null || echo "unknown")
LATEST_REMOTE_DATE=$(git log -1 --pretty=format:"%cd" --date=format:"%Y-%m-%d %H:%M:%S" "$LATEST_REMOTE" 2>/dev/null || echo "unknown")

echo "最新远程提交: $LATEST_REMOTE_SHORT - $LATEST_REMOTE_DATE"
echo ""

# 比较本地和远程
echo "🔄 同步状态"
echo "---------"
LOCAL_COMMIT=$(git rev-parse HEAD)
if [ "$LOCAL_COMMIT" = "$LATEST_REMOTE" ]; then
    echo "✅ 本地和远程已同步"
else
    echo "❌ 本地和远程不同步"
    echo "   本地: $(git rev-parse --short HEAD)"
    echo "   远程: $LATEST_REMOTE_SHORT"
    echo ""
    echo "📝 操作建议：运行 'git push origin main' 推送更改"
fi
echo ""

# 检查文件修改时间
echo "📁 文件修改时间"
echo "-------------"
if [ -f "$PROJECT_DIR/index.html" ]; then
    INDEX_MTIME=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$PROJECT_DIR/index.html" 2>/dev/null || stat -c "%y" "$PROJECT_DIR/index.html" | cut -d'.' -f1)
    echo "index.html 修改时间: $INDEX_MTIME"
fi

if [ -f "$PROJECT_DIR/README.md" ]; then
    README_MTIME=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M:%S" "$PROJECT_DIR/README.md" 2>/dev/null || stat -c "%y" "$PROJECT_DIR/README.md" | cut -d'.' -f1)
    echo "README.md 修改时间: $README_MTIME"
fi
echo ""

# 检查文件内容
echo "📋 文件内容检查"
echo "-------------"
if [ -f "$PROJECT_DIR/index.html" ]; then
    if grep -q "archive" "$PROJECT_DIR/index.html"; then
        echo "✅ index.html 包含归档链接"
    else
        echo "⚠️  index.html 可能不包含导航栏"
    fi

    if grep -q "March.*2026" "$PROJECT_DIR/index.html"; then
        echo "✅ index.html 包含日期信息"
    fi
fi

if [ -f "$PROJECT_DIR/archives.html" ]; then
    echo "✅ archives.html 存在"
else
    echo "❌ archives.html 缺失"
fi

if [ -d "$PROJECT_DIR/archive" ]; then
    ARCHIVE_COUNT=$(ls -1 "$PROJECT_DIR/archive"/*.html 2>/dev/null | wc -l)
    echo "✅ archive/ 目录存在（$ARCHIVE_COUNT 个文件）"
else
    echo "❌ archive/ 目录缺失"
fi
echo ""

# 生成诊断报告
echo "📊 诊断报告"
echo "----------"
echo ""
echo "🌐 访问链接："
echo "  Vercel 项目: https://vercel.com/flywill/ai-digest"
echo "  部署历史: https://vercel.com/flywill/ai-digest/deployments"
echo "  Git 设置: https://vercel.com/flywill/ai-digest/settings/git"
echo "  生产网站: https://ai-digest-tau.vercel.app"
echo ""
echo "🔧 建议操作："
echo "  1. 访问 Vercel 项目检查 Git 集成状态"
echo "  2. 查看 Vercel 部署历史是否有新部署"
echo "  3. 如果 Git 集成有问题，重新连接仓库"
echo "  4. 或使用手动部署：vercel --prod"
echo ""
echo "📝 详细诊断指南："
echo "  cat ~/ai-digest-project/vercel-troubleshoot.md"
