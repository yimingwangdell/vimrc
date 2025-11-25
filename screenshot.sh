#!/bin/bash

# 屏幕截图脚本：screenshot.sh
# 支持区域截图和全屏截图
# 保存截图、复制到剪贴板并发送通知

# 配置截图保存目录
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# 生成时间戳
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# 定义截图文件路径
FILE="$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"

# 判断截图模式
if [ "$1" == "full" ]; then
    MODE="全屏截图"
    # 使用 grim 进行全屏截图
    grim "$FILE"
else
    MODE="区域截图"
    # 使用 slurp 选择截图区域并使用 grim 进行截图
    grim -g "$(slurp)" "$FILE"
fi

# 检查截图是否成功
if [ $? -eq 0 ]; then
    # 复制截图到剪贴板
    wl-clipboard < "$FILE"

    # 发送截图完成通知
    echo "succ"
else
    echo "fail"
fi

exit 0
