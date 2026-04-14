# 添加到 ~/.bashrc 或 ~/.zshrc

gp() {
    # 检查是否在 git 仓库中
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        echo "错误：当前目录不是 Git 仓库"
        return 1
    fi
    
    # 获取提交信息
    local msg="${*:-update}"
    
    # 显示状态
    echo "=== 将要提交的文件 ==="
    git status -s
    echo ""
    echo "提交信息: $msg"
    echo ""
    
    # 执行操作
    git add . && \
    git commit -m "$msg" && \
    git push
    
    # 显示结果
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ 成功推送到远程仓库"
    else
        echo ""
        echo "❌ 推送失败，请检查错误信息"
    fi
}

# 使用：
gp                          # 默认 "update"
gp "修复bug"                # 自定义信息
gp 添加 新功能              # 多个单词，不需要引号
