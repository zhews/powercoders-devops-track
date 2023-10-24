cd lessons

for file in *.md; do
	name=$(basename $file .md)
	pandoc --standalone --embed-resources -t revealjs -s $name.md -o $name.html
done

cd ..
