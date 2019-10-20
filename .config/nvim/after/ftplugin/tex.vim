inoremap ;em \emph{}<++><Esc>T{i
inoremap ;bf \textbf{}<++><Esc>T{i


" Runs a script that cleans out tex build files whenever I close out of a .tex file. From Luke Smith
autocmd VimLeave *.tex !texclear %
