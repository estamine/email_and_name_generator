;#Persistent
#SingleInstance

CoordMode, Mouse, Screen  

agora = %A_Now%

Loop, 100 {

	; 845 nomes proprios
	; 792 nomes familia
	; 12 mails
	; 4 separadores

ArrayCount = 0
Loop, Read, %A_ScriptDir%\proprio.txt   ; This loop retrieves each line from the file, one at a time.
{
    ArrayCount += 1  ; Keep track of how many items are in the array.
    proprio%ArrayCount% := A_LoopReadLine  ; Store this line in the next array element.
}

ArrayCount = 0
Loop, Read, %A_ScriptDir%\familia.txt   ; This loop retrieves each line from the file, one at a time.
{
    ArrayCount += 1  ; Keep track of how many items are in the array.
    familia%ArrayCount% := A_LoopReadLine  ; Store this line in the next array element.
}
	
	Random , rand, 1, 845
	nome1 := % proprio%rand%

	Random , rand, 1, 792
	nome2 := % familia%rand%

FileAppend, %nome1% %nome2%`n, %A_ScriptDir%\%agora%nomes.txt
	
}
