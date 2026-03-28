#!/bin/bash

# 更新项目以使用新的 Vercel 域名
# 从 ai-digest-psi.vercel.app 更新到 ai-digest-tau.vercel.app

PROJECT_DIR="$HOME/ai-digest-project"

echo "🔄 更新域名配置"
echo "=================="
echo ""
echo "旧域名: ai-digest-psi.vercel.app"
echo "新域名: ai-digest-tau.vercel.app"
echo ""

# 需要更新的文件
FILES_TO_UPDATE=(
    "README.md"
    "uninstall-guide.md"
    "vercel-troubleshoot.md"
    "monitor-deployment.sh"
    "complete-workflow.sh"
    "check-vercel-status.sh"
)

echo "📝 更新文件中的域名引用..."
echo "--------------------------------"

for file in "${FILES_TO_UPDATE[@]}"; do
    if [ -f "$PROJECT_DIR/$file" ]; then
        echo "🔧 更新: $file"
        sed -i '' 's/ai-digest-psi\.vercel\.app/ai-digest-tau.vercel.app/g' "$PROJECT_DIR/$file"
        echo "   ✅ 完成"
    else
        echo "⚠️  跳过: $file (文件不存在)"
    fi
done

echo ""
echo "📋 检查更新结果..."
echo "-----------------------"

# 检查 README.md
if [ -f "$PROJECT_DIR/README.md" ]; then
    echo "📖 README.md:"
    grep -o "ai-digest.*\.vercel\.app" "$PROJECT_DIR/README.md" | sort -u
fi

echo ""
echo "✅ 域名更新完成！"
echo ""
echo "🌐 新的网站链接:"
echo "   最新摘要: https://ai-digest-tau.vercel.app"
echo "   历史归档: https://ai-digest-tau.vercel.app/archives.html"
echo ""
echo "📊 Vercel 项目信息:"
echo "   项目名称: ai-digest (在 Vercel 中)"
echo "   生产域名: ai-digest-tau.vercel.app"
echo ""
echo "🎯 下一步:"
echo "   1. 访问新域名验证网站正常"
echo "   2. 提交这些更改到 Git"
echo "   3. 更新自动化配置（如果需要）"
