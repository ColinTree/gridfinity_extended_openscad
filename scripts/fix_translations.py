#!/usr/bin/env python3
"""
Fix duplicate Chinese translations in SCAD files.
Remove intermediate duplicate Chinese segments.
"""

import re
import glob

def fix_duplicate_translations(line):
    """Fix cases like '// A / B / C text' where A is part of B."""
    # Pattern: // Chinese1 / Chinese2 / EnglishText -> // Chinese2 / EnglishText
    # Handle specific known duplicates
    
    # Fix "Z轴 / Z轴高度（不含）" -> "Z轴高度（不含）"
    line = line.replace('Z轴 / Z轴高度（不含）', 'Z轴高度（不含）')
    
    # Fix "外壁厚度 / 壁厚 / Wall thickness" -> "外壁厚度 / Wall thickness"
    line = line.replace('外壁厚度 / 壁厚 / Wall thickness', '外壁厚度 / Wall thickness')
    
    # Fix "启用磁铁 / 在托盒角落启用磁铁" -> "在托盒角落启用磁铁"
    line = line.replace('启用磁铁 / 在托盒角落启用磁铁', '在托盒角落启用磁铁')
    
    # Fix "X轴 / X轴分隔数 / X dimension" -> "X轴分隔数 / X dimension"
    line = line.replace('X轴 / X轴分隔数', 'X轴分隔数')
    
    # Fix "壁厚 / wall thickness" inside longer comments (not as leading translation)
    # e.g. "ratio of bottom 壁厚 / wall thickness" should be "ratio of bottom wall thickness"
    import re
    line = re.sub(r'壁厚 / wall thickness', 'wall thickness', line)
    
    # Fix "启用日志 / Enable logging" duplicates where original line said "loging"
    line = line.replace('启用日志 / enable logging of help messages during render.', 
                        '渲染时启用帮助日志 / enable logging of help messages during render.')
    line = line.replace('启用日志 / Enable logging of help messages during render.', 
                        '渲染时启用帮助日志 / Enable logging of help messages during render.')

    # More general: look for pattern "A / B / C" where A appears in B
    # E.g., "// 片段最小角度 / minimum angle for a fragment" is correct, keep it.
    
    return line

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    new_lines = []
    changed = False
    for line in lines:
        fixed = fix_duplicate_translations(line)
        if fixed != line:
            changed = True
        new_lines.append(fixed)
    
    if changed:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.writelines(new_lines)
        print(f"Fixed: {filepath}")
    else:
        print(f"OK: {filepath}")

if __name__ == '__main__':
    for f in sorted(glob.glob('/workspace/*.scad')):
        process_file(f)
    print("Done.")
