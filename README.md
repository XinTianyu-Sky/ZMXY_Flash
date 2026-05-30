# ZMXY_Flash

造梦西游3再续天庭 v0.85 — 反编译工程，可编辑改造。

## 项目结构

```
ZMXY_Flash/
├── src/                    # 整理后的可编辑源码
│   ├── launch/             # 启动器 (MainLoad, allConst, fileHandler)
│   ├── core/               # 核心逻辑 (Config, AllEquipment, User, MainGame)
│   ├── hero/               # 角色类 (BaseHero, Role1~4: 悟空/唐僧/八戒/沙僧)
│   ├── monster/            # 怪物类 (BaseMonster, BaseBullet, BasePet)
│   ├── ui/                 # UI 类 (GMain, Aloader)
│   └── data/               # 提取的数值配置表 (JSON)
├── decompiled/             # JPEXS 完整反编译输出 (全部 ~4400 .as, ~6200 .png)
├── scripts/
│   ├── decode_all.sh       # 一键解码+反编译全部 SWF
│   ├── inject.bat          # 快速注入修改到 SWF
│   └── run_test.bat        # 启动测试游戏
├── build/
│   ├── zmxy_decoder.exe    # SWF 头解密工具 (pivot=200, 造3)
│   └── zmxy_decoder_v2.exe # SWF 头解密工具 (pivot=96, 造2参数, 用于asset SWF)
├── tools/
│   ├── ffdec.jar           # JPEXS Flash Decompiler
│   └── ffdec_15.0.0/       # JPEXS 完整分发版
└── dist/                   # 构建+测试输出
```

## 游戏架构

```
MainLoad (launch.swf) → 解密嵌入的 game core → Loader.loadBytes()
    ↓
GMain → Aloader → 加载 12 个模块 SWF (角色/UI/宠物/法宝/音乐)
    ↓
Config (全局状态) → User/AllEquipment/GameTask/PhysicsWorld
    ↓
BaseGameSence → 按关卡名动态加载 bg/monster 类
```

## 快速修改流程

```
1. 编辑 src/ 中的 .as 文件
2. scripts\inject.bat <swf路径> <脚本文件>
   例: inject.bat launch.swf src\launch\allConst.as
3. scripts\run_test.bat
```

## 关键数据文件

| 文件                     | 行数 | 内容                   |
| ------------------------ | ---- | ---------------------- |
| src/core/AllEquipment.as | 1750 | 全部装备/道具/宝石数值 |
| src/core/Config.as       | 1025 | 游戏全局状态管理       |
| src/core/User.as         | ~300 | 玩家数据模型           |
| src/core/MainGame.as     | ~800 | 战斗引擎               |
| src/launch/allConst.as   | 33   | 版本号/调试开关/密钥   |

## SWF 解密说明

游戏 SWF 文件头被置换加密：

- Asset SWF: 用 zmxy_decoder_v2.exe (pivot=96)
- launch.swf: 无需解密 (标准 CWS 头)

工具链: 解码 → JPEXS 修改 → 编码 → 测试

## 版本

基于 造梦西游3再续天庭 v0.85 (dusk/夕眼 开发)

[变更记录](docs/CHANGELOG.md)
