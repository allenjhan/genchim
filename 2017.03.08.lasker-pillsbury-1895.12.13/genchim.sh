
if [ ! -d chessimage ]
then
    mkdir chessimage
fi
cd chessimage

#if [ -f test_doc ]
#then
#    rm test_doc
#fi

if [ -f chess-latex.header ]
then
    rm chess-latex.header
fi
printf '\\documentclass[border={0 0 3 0}, convert={density=150}]{standalone} \n \\usepackage{xskak}  \n \\usepackage{chessboard} \n \\usepackage{chessfss} \n \\usepackage{fontspec} \n \\begin{document} \n \\setchessboard{normalboard, showmover=true, moverstyle=triangle,label=false} \n \\setboardfontfamily{merida} \n \\newgame \n' > chess-latex.header

if [ -f chess-latex.footer ]
then
    rm chess-latex.footer
fi
printf '\n \\showboard \n \\end{document} \n' > chess-latex.footer

export texname=$1

if [ -f $texname ]
then
    rm $texname
fi
cp chess-latex.header $texname
for fragment in $@
do
if [ $fragment != $0 ] && [ $fragment != $1 ] 
then
    printf $fragment >> $texname
    printf " " >> $texname
#    printf $fragment >> test_doc
#    printf " " >> test_doc
fi
done
cat chess-latex.footer >> $texname
xelatex --shell-escape $texname
