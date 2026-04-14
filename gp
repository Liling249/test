#!/bin/bash

# 检查是否在 git 仓库中
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "错误：当前目录不是 Git 仓库"
    return 1
fi
        
if [ $# -eq 0 ]; then
    msg="update"
else
    msg="$*"
fi

echo "=== gp 开始执行 ==="

# 检查是否有需要提交的内容
if git status --porcelain | grep -q .; then
    echo "→ 添加所有变更"
    git add .
    
    echo "→ 提交变更: $msg"
    if git commit -m "$msg"; then
        echo "→ 推送至远程仓库"
        git push
        if [ $? -eq 0 ]; then
            echo "✅ 成功推送到远程仓库"
        else
            echo "❌ 推送失败，请检查网络或权限"
        fi
    else
        echo "❌ commit 失败"
    fi
else
    echo "ℹ️  没有检测到文件变更，无需提交"
fi

echo "=== gp 执行完毕 ==="

# 使用：
gp                          # 默认 "update"
gp "修复bug"                # 自定义信息
gp 添加 新功能              # 多个单词，不需要引号