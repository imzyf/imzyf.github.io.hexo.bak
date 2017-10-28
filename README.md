# https://ZYF.IM 源文件
## 初始化环境
```bash
npm install hexo-cli -g
yarn add
mkdir public && cd public
git init .
git remote add origin root@zyf.im:/home/yifan/project/imzyf
```

## Hexo command
```bash
# generate
hexo g

# server
hexo s
```

## 博文
- [所有文章原始 Markdown 文件](source/_posts)

## theme even 本地化
1. `_config.yml` 的修改。
2. 移除 `source` 中的 `favicon.ico` `robots.txt`
3. 修改 `source/image/reward` 打赏图片。
4. 修改 `layout/_partial/footer.swig` 添加 `statcounter` 统计代码。
