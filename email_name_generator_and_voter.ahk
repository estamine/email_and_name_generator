;#Persistent
#SingleInstance

CoordMode, Mouse, Screen  

Loop {
	
If ( A_Hour >= 8 and A_Hour <= 23 )
	
{

MouseMove, 0, 0
IniRead, quantas, email_name_generator_and_voter.ini, main, quantas

ToolTip %quantas%


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

ArrayCount = 0
Loop, Read, %A_ScriptDir%\emails.txt   ; This loop retrieves each line from the file, one at a time.
{
    ArrayCount += 1  ; Keep track of how many items are in the array.
    emails%ArrayCount% := A_LoopReadLine  ; Store this line in the next array element.
}

ArrayCount = 0
Loop, Read, %A_ScriptDir%\separador.txt   ; This loop retrieves each line from the file, one at a time.
{
    ArrayCount += 1  ; Keep track of how many items are in the array.
    separador%ArrayCount% := A_LoopReadLine  ; Store this line in the next array element.
}

	
	Random , rand, 1, 845
	nome1 := % proprio%rand%

	Random , rand, 1, 792
	nome2 := % familia%rand%

	Random , rand, 1, 14
	emailend := % emails%rand%
	
	Random , rand, 1, 4
	separa := % separador%rand%
	
	Random, rand, 1, 5
	If ( rand = 1 )
	{
		email := % nome1 . separa . nome2 . "@" . emailend
	}
	If ( rand = 2 )
	{
		email := % nome2 . separa . nome1 . "@" . emailend
	}
	If ( rand = 3 )
	{
		Random , ano, 50, 99
		email := % nome1 . separa . ano . "@" . emailend
	}
	If ( rand = 4 )
	{
		Random , ano, 50, 99
		email := % nome2 . separa . ano . "@" . emailend
	}
	If ( rand = 5 )
	{
		StringLeft, nomeumaletra, nome1, 1
		email := % nomeumaletra . separa . nome2 . "@" . emailend
	}
	
	StringLower , email, email

	;MsgBox %nome1% %nome2% - %email%
	
	If ( WinExist("OSTERKUNST") )
	{
		WinActivate
	}
	else
	{
		Process, Close, IEXPLORE.EXE
		Sleep,5000
		Run,iexplore.exe "http://www.hoefe-am-bruehl.de/osterkunst.html"
		Sleep,15000
	}
		
		WinActivate
		Sleep 500
		Send,{F4}
		Sleep 500
		Send,http://www.hoefe-am-bruehl.de/osterkunst.html{Enter}
		Sleep 10000
		Send,{PGDN}{PGDN}{PGDN}{PGDN}{PGDN}{PGUP}
		Sleep 1000
		ImageSearch, botaox, botaoy, 0, 0, A_ScreenWidth, A_ScreenHeight, C:\Documents and Settings\rui\Desktop\votarnuno\votar.bmp
		
		botaoxx := botaox + 141
		botaoyy := botaoy
		
		Sleep 5000

		MouseMove, botaoxx, botaoyy
		MouseClick, left, botaoxx, botaoyy
		
		Sleep 10000
		
		Send,{PGDN}
		
		Sleep 1000
		
		ImageSearch, botaox, botaoy, 0, 0, A_ScreenWidth, A_ScreenHeight, C:\Documents and Settings\rui\Desktop\votarnuno\field.bmp
		
		botaoxx := botaox + 170
		botaoyy := botaoy + 20
		
		Sleep 5000

		MouseMove, botaoxx, botaoyy
		MouseClick, left, botaoxx, botaoyy
		
		Sleep 1000

		Send,%nome1%
		Send,{Tab}
		Send,%nome2%
		Send,{Tab}
		Send,%email%
		Send,{Enter}
		

quantas := quantas + 1
IniWrite, %quantas%, email_name_generator_and_voter.ini, main, quantas

IniRead, tempomin, email_name_generator_and_voter.ini, main, tempomin
IniRead, tempomax, email_name_generator_and_voter.ini, main, tempomax

tempomin := tempomin * 1000
tempomax := tempomax * 1000


Random, randsleep, tempomin, tempomax
Sleep,randsleep
}
}