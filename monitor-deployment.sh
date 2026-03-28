#!/bin/bash

# Vercel 部署监控脚本
# 使用此脚本检查部署状态

echo "🔄 检查 Vercel 部署状态..."
echo "=========================="
echo ""

echo "📊 GitHub 仓库状态:"
echo "  仓库: https://github.com/flywill/ai-digest"
echo "  分支: main"
echo ""

echo "🌐 Vercel 项目状态:"
echo "  网站: https://ai-digest-tau.vercel.app"
echo "  仪表盘: https://vercel.com/flywill/ai-digest"
echo ""

echo "⏱️  部署时间线:"
echo "  - 刚才推送了代码到 GitHub"
echo "  - Vercel 应该在 1-2 分钟内开始部署"
echo "  - 完整部署通常需要 30-60 秒"
echo ""

echo "🔍 如何检查部署状态:"
echo "  方法 1: 访问 Vercel 仪表盘"
echo "    https://vercel.com/flywill/ai-digest/deployments"
echo ""
echo "  方法 2: 检查网站是否更新"
echo "    打开: https://ai-digest-tau.vercel.app"
echo ""

echo "✅ 部署成功的标志:"
echo "  - Vercel 仪表盘显示最新的部署状态为 'Ready'"
echo "  - 网站内容包含今天的 AI Builders Digest"
echo "  - 访问速度正常"
echo ""

echo "⚠️  如果部署失败:"
echo "  - 检查 Vercel 仪表盘的错误日志"
echo "  - 确保 index.html 和 vercel.json 存在"
echo "  - 确保 GitHub 仓库正确连接到 Vercel"
echo ""

echo "📱 移动设备测试:"
echo "  在手机浏览器打开网站测试响应式设计"
echo "  https://ai-digest-tau.vercel.app"
echo ""

# 检查本地文件状态
echo "📋 本地文件状态:"
if [ -f "index.html" ]; then
    echo "  ✅ index.html 存在 ($(wc -l < index.html) 行)"
else
    echo "  ❌ index.html 缺失"
fi

if [ -f "vercel.json" ]; then
    echo "  ✅ vercel.json 存在"
else
    echo "  ❌ vercel.json 缺失"
fi

echo ""
echo "🎯 下次自动运行将自动部署!"
echo "   每天上午 8:00 自动运行并部署最新内容"
