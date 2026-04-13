#!/bin/bash
# 提交前检查脚本

if [[ -n $(git status -s) ]]; then
    echo "⚠️  有未提交的修改："
    git status -s
    exit 1
else
    echo "✓ 工作目录干净"
fi
