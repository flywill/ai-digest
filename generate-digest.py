#!/usr/bin/env python3
"""
AI Builders Digest 生成器
生成新的 digest HTML 并更新历史归档
"""

import os
import json
import shutil
from datetime import datetime
from pathlib import Path

# 项目根目录
PROJECT_DIR = Path.home() / "ai-digest-project"
ARCHIVE_DIR = PROJECT_DIR / "archive"
CONTENT_DIR = PROJECT_DIR / "content"

# 确保目录存在
ARCHIVE_DIR.mkdir(exist_ok=True)
CONTENT_DIR.mkdir(exist_ok=True)

def get_current_date():
    """获取当前日期字符串 YYYY-MM-DD"""
    return datetime.now().strftime("%Y-%m-%d")

def archive_current_index():
    """归档当前的 index.html 到历史文件夹"""
    index_file = PROJECT_DIR / "index.html"
    
    if not index_file.exists():
        print("ℹ️  当前没有 index.html 需要归档")
        return None
    
    # 尝试从文件中提取日期
    try:
        with open(index_file, 'r', encoding='utf-8') as f:
            content = f.read()
            # 查找日期格式 March 28, 2026
            import re
            date_match = re.search(r'(\w+)\s+(\d+),\s+(\d{4})', content)
            if date_match:
                month, day, year = date_match.groups()
                # 转换为 YYYY-MM-DD 格式
                date_str = datetime.strptime(f"{month} {day} {year}", "%B %d %Y").strftime("%Y-%m-%d")
            else:
                # 如果找不到日期，使用当前日期
                date_str = get_current_date()
    except Exception as e:
        print(f"⚠️  无法从文件提取日期，使用当前日期: {e}")
        date_str = get_current_date()
    
    # 复制到归档文件夹
    archive_file = ARCHIVE_DIR / f"{date_str}.html"
    shutil.copy2(index_file, archive_file)
    print(f"✅ 已归档当前 index.html 到: {archive_file}")
    
    return date_str

def generate_archive_list():
    """生成历史归档列表"""
    if not ARCHIVE_DIR.exists():
        return []
    
    # 获取所有归档文件并按日期排序
    archives = sorted(ARCHIVE_DIR.glob("*.html"), reverse=True)
    return [(arc.stem, arc.name) for arc in archives]

def generate_navigation():
    """生成日期导航栏 HTML"""
    archives = generate_archive_list()
    
    nav_html = """
    <div class="date-navigation">
        <div class="nav-container">
            <div class="nav-title">📅 Historical Archives</div>
            <div class="nav-links">
"""
    
    for date_str, filename in archives:
        nav_html += f'                <a href="archive/{filename}" class="nav-link">{date_str}</a>\n'
    
    nav_html += """            </div>
        </div>
    </div>
"""
    
    return nav_html

def add_navigation_to_html(html_content):
    """在 HTML 中添加导航栏"""
    # 在 body 标签后插入导航栏
    import re
    
    # 查找第一个 </div> 或 </header> 之后插入
    nav_html = generate_navigation()
    
    # 在 container div 的开头添加导航
    pattern = r'(<div class="container">)'
    replacement = r'\1\n    ' + nav_html.strip() + '\n    '
    
    modified_content = re.sub(pattern, replacement, html_content, count=1)
    
    return modified_content

def update_index_with_navigation():
    """更新当前 index.html，添加导航栏"""
    index_file = PROJECT_DIR / "index.html"
    
    if not index_file.exists():
        print("❌ index.html 不存在")
        return False
    
    # 读取当前内容
    with open(index_file, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 检查是否已经有导航栏
    if 'date-navigation' in content:
        print("ℹ️  index.html 已经包含导航栏")
        return True
    
    # 添加导航栏
    modified_content = add_navigation_to_html(content)
    
    # 写回文件
    with open(index_file, 'w', encoding='utf-8') as f:
        f.write(modified_content)
    
    print("✅ 已为 index.html 添加导航栏")
    return True

def generate_archives_page():
    """生成完整的归档索引页面"""
    archives = generate_archive_list()
    
    archives_html = """
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Builders Digest - All Archives</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>📚 AI Builders Digest Archives</h1>
            <p class="subtitle">Complete collection of daily digests</p>
            <div class="date">🗂️ All Historical Issues</div>
        </div>

        <div class="content">
            <div class="archives-list">
                <h2>📋 All Issues</h2>
                <div class="archive-items">
"""
    
    for date_str, filename in archives:
        archives_html += f"""
                    <a href="archive/{filename}" class="archive-item">
                        <div class="archive-date">📅 {date_str}</div>
                        <div class="archive-link">View Digest →</div>
                    </a>
"""
    
    archives_html += """
                </div>
            </div>
        </div>

        <div class="footer">
            <p><a href="/">← Back to Latest Digest</a></p>
        </div>
    </div>
</body>
</html>
"""
    
    archives_file = PROJECT_DIR / "archives.html"
    with open(archives_file, 'w', encoding='utf-8') as f:
        f.write(archives_html)
    
    print(f"✅ 已生成归档索引页面: {archives_file}")

def main():
    """主函数"""
    print("🚀 AI Builders Digest 归档系统")
    print("=" * 50)
    
    # 1. 归档当前的 index.html
    archived_date = archive_current_index()
    
    # 2. 更新归档列表
    archives = generate_archive_list()
    print(f"📚 历史归档数量: {len(archives)}")
    
    # 3. 生成归档索引页面
    generate_archives_page()
    
    print(f"\n✅ 归档系统更新完成！")
    print(f"📁 归档目录: {ARCHIVE_DIR}")
    print(f"📄 归档索引: archives.html")
    
    return archived_date

if __name__ == "__main__":
    main()
