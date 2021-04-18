（１）レポジトリを作る
（２）設定する。Github＿Portableへのショートカットから。"…or create a new repository on the command line"のとおり
echo "# dashboard_map" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/DiNOV-Tokyo/dashboard_map.git
git push -u origin main

（３）これ以降は、RStudioからコミット->Pushできる。