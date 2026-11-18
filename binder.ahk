#SingleInstance, Force
; Справочники и игровые сокращения загружаются из res\Shortcuts.tsv.
; Личные настройки и Punishment.txt создаются автоматически при первом запуске.
#UseHook
#NoEnv
SetWorkingDir %A_ScriptDir%
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
#IfWinActive ahk_exe GTA5.exe

SplashTextoff
ListLines Off
Process, Priority, , A
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
reloadStatus = 0
DayANS = 0
WeekANS = 0
FormatTime, CurrentDate,, ddMM

Usefull = Полезное
Cheatsheet = Меню памятки

IfNotExist, %A_ScriptDir%\res
    FileCreateDir, %A_ScriptDir%\res

settingsPath := A_ScriptDir . "\res\Settings.ini"
IfNotExist, %settingsPath%
{
    settingsText := BinderDefaultConfig()
    FileAppend, %settingsText%, %settingsPath%, UTF-16
    if ErrorLevel {
        MsgBox, 16, Настройки, Не удалось создать Settings.ini.
        ExitApp
    }
}
IfNotExist, %A_ScriptDir%\Punishment.txt 
{
punishmentFile := FileOpen(A_ScriptDir . "\Punishment.txt", "w", "UTF-8")
if IsObject(punishmentFile)
    punishmentFile.Close()
}
FileSetAttrib, -H, %A_ScriptDir%\res

Menu, Tray, add, Показать, Show,
Menu, Tray, Default, Показать,
Menu, Tray, add, Перезагрузить, Reload,
Menu, Tray, add, Скрыть, Hide,
Menu, Tray, add, Закрыть, Close,
Menu, Tray, NoStandard

IniRead, Week, %A_ScriptDir%\res\Settings.ini, ANS, Week
IniRead, CurrentDateT, %A_ScriptDir%\res\Settings.ini, ANS, CurrentDateT
if CurrentDateT=%CurrentDate%
{
IniRead, CurrentDateT, %A_ScriptDir%\res\Settings.ini, ANS, CurrentDateT
IniRead, DayANS, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
}
else
{
    IniWrite, %CurrentDate%, %A_ScriptDir%\res\Settings.ini, ANS, CurrentDateT
    IniWrite, %DayANS%, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
    IniRead, DayANS, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
    IniRead, CurrentDateT, %A_ScriptDir%\res\Settings.ini, ANS, CurrentDateT
}
if Week=%A_YWeek%
{
IniRead, Week, %A_ScriptDir%\res\Settings.ini, ANS, Week
IniRead, WeekANS, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
}
else
{
    IniWrite, %A_YWeek%, %A_ScriptDir%\res\Settings.ini, ANS, Week
    IniWrite, %WeekANS%, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
    IniRead, WeekANS, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
    IniRead, Week, %A_ScriptDir%\res\Settings.ini, ANS, Week
}

IniRead, Radio1, %A_ScriptDir%\res\Settings.ini, Resolution, 1920x1080
IniRead, Radio2, %A_ScriptDir%\res\Settings.ini, Resolution, 1600x900
IniRead, Radio3, %A_ScriptDir%\res\Settings.ini, Resolution, 1680x1050
IniRead, Radio4, %A_ScriptDir%\res\Settings.ini, Resolution, 1366x768
IniRead, Radio5, %A_ScriptDir%\res\Settings.ini, Resolution, 1280x960
IniRead, Radio6, %A_ScriptDir%\res\Settings.ini, Resolution, 1920x10802
IniRead, Radio7, %A_ScriptDir%\res\Settings.ini, Resolution, 1280х1024
IniRead, Radio17, %A_ScriptDir%\res\Settings.ini, Resolution, 2560x1440, 0

IniRead, Radio8, %A_ScriptDir%\res\Settings.ini, Login Commands, /hidecheatinfo
IniRead, Radio9, %A_ScriptDir%\res\Settings.ini, Login Commands, /showcheats
IniRead, Radio10, %A_ScriptDir%\res\Settings.ini, Login Commands, /dl
IniRead, Radio11, %A_ScriptDir%\res\Settings.ini, Login Commands, /esp 3
IniRead, Radio12, %A_ScriptDir%\res\Settings.ini, Login Commands, /templeader
IniRead, Radio13, %A_ScriptDir%\res\Settings.ini, Login Commands, /chide
IniRead, Radio14, %A_ScriptDir%\res\Settings.ini, Login Commands, /zzdebug
IniRead, Radio15, %A_ScriptDir%\res\Settings.ini, Login Commands, /objdl
IniRead, Radio16, %A_ScriptDir%\res\Settings.ini, Login Commands, /netstat
IniRead, LoginAdvToggle, %A_ScriptDir%\res\Settings.ini, Login Commands, /advtoggle 0, 0

IniRead, key1, %A_ScriptDir%\res\Settings.ini, Binds, KEY1
IniRead, key2, %A_ScriptDir%\res\Settings.ini, Binds, KEY2
IniRead, key3, %A_ScriptDir%\res\Settings.ini, Binds, KEY3
IniRead, key4, %A_ScriptDir%\res\Settings.ini, Binds, KEY4
IniRead, key5, %A_ScriptDir%\res\Settings.ini, Binds, KEY5
IniRead, key6, %A_ScriptDir%\res\Settings.ini, Binds, KEY6
IniRead, key7, %A_ScriptDir%\res\Settings.ini, Binds, KEY7
IniRead, key8, %A_ScriptDir%\res\Settings.ini, Binds, KEY8
IniRead, key9, %A_ScriptDir%\res\Settings.ini, Binds, KEY9
IniRead, key10, %A_ScriptDir%\res\Settings.ini, Binds, KEY10
IniRead, key11, %A_ScriptDir%\res\Settings.ini, Binds, KEY11
IniRead, key12, %A_ScriptDir%\res\Settings.ini, Binds, KEY12
IniRead, key13, %A_ScriptDir%\res\Settings.ini, Binds, KEY13
IniRead, key14, %A_ScriptDir%\res\Settings.ini, Binds, KEY14
IniRead, key15, %A_ScriptDir%\res\Settings.ini, Binds, KEY15
IniRead, key16, %A_ScriptDir%\res\Settings.ini, Binds, KEY16
IniRead, key17, %A_ScriptDir%\res\Settings.ini, Binds, KEY17
IniRead, key18, %A_ScriptDir%\res\Settings.ini, Binds, KEY18
IniRead, key19, %A_ScriptDir%\res\Settings.ini, Binds, KEY19
IniRead, key20, %A_ScriptDir%\res\Settings.ini, Binds, KEY20
key1 := NormalizeBinderHotkey(key1)
key2 := NormalizeBinderHotkey(key2)
key3 := NormalizeBinderHotkey(key3)
key4 := NormalizeBinderHotkey(key4)
key5 := NormalizeBinderHotkey(key5)
key6 := NormalizeBinderHotkey(key6)
key7 := NormalizeBinderHotkey(key7)
key8 := NormalizeBinderHotkey(key8)
key9 := NormalizeBinderHotkey(key9)
key10 := NormalizeBinderHotkey(key10)
key11 := NormalizeBinderHotkey(key11)
key12 := NormalizeBinderHotkey(key12)
key13 := NormalizeBinderHotkey(key13)
key14 := NormalizeBinderHotkey(key14)
key15 := NormalizeBinderHotkey(key15)
key16 := NormalizeBinderHotkey(key16)
key17 := NormalizeBinderHotkey(key17)
key18 := NormalizeBinderHotkey(key18)
key19 := NormalizeBinderHotkey(key19)
key20 := NormalizeBinderHotkey(key20)

IniRead, dis, %A_ScriptDir%\res\Settings.ini, Discord, dis
IniRead, gadis, %A_ScriptDir%\res\Settings.ini, Discord, gadis
IniRead, zgadis, %A_ScriptDir%\res\Settings.ini, Discord, zgadis
GreetingText := "Приветствую. Сейчас займусь Вашим обращением."
IniRead, GreetingHotkey, %A_ScriptDir%\res\Settings.ini, Greeting, Hotkey, !e
GreetingHotkey := NormalizeBinderHotkey(GreetingHotkey)
if (GreetingHotkey = "")
    GreetingHotkey := "!e"
IniRead, AdminGender, %A_ScriptDir%\res\Settings.ini, Admin, Gender, male
if (AdminGender != "female")
    AdminGender := "male"
GenderMale := AdminGender = "male" ? 1 : 0
GenderFemale := AdminGender = "female" ? 1 : 0
IniRead, CounterHidden, %A_ScriptDir%\res\Settings.ini, Counter, Hidden, 0
if (CounterHidden != 1)
    CounterHidden := 0

if dis=ERROR
{
IniWrite, Bruno, %A_ScriptDir%\res\Settings.ini, Discord, dis
IniWrite, brunoalvazez, %A_ScriptDir%\res\Settings.ini, Discord, gadis
IniWrite, hewerro, %A_ScriptDir%\res\Settings.ini, Discord, zgadis
}

IniRead, X, %A_ScriptDir%\res\Settings.ini, Coords, X
IniRead, Y, %A_ScriptDir%\res\Settings.ini, Coords, Y
IniRead, X2, %A_ScriptDir%\res\Settings.ini, Coords, X2
IniRead, Y2, %A_ScriptDir%\res\Settings.ini, Coords, Y2
IniRead, Fraction, %A_ScriptDir%\res\Settings.ini, Fraction, Fraction

if X=ERROR
{
IniWrite, 0, %A_ScriptDir%\res\Settings.ini, Coords, X
IniWrite, 0, %A_ScriptDir%\res\Settings.ini, Coords, Y
IniWrite, 0, %A_ScriptDir%\res\Settings.ini, Coords, X2
IniWrite, 0, %A_ScriptDir%\res\Settings.ini, Coords, Y2
IniWrite, 7, %A_ScriptDir%\res\Settings.ini, Fraction, Fraction
reload
}

;гуи счетчика
WinSet_Click_Through(I, T="254") {
IfWinExist, % "ahk_id " I
{
If (T == "Off")
{
WinSet, AlwaysOnTop, Off, % "ahk_id " I
WinSet, Transparent, Off, % "ahk_id " I
WinSet, ExStyle, -0x20, % "ahk_id " I
}
Else
{
WinSet, AlwaysOnTop, On, % "ahk_id " I
If(T < 0 || T > 254 || T == "On")
T := 254
WinSet, Transparent, % T, % "ahk_id " I
WinSet, ExStyle, +0x20, % "ahk_id " I
}
}
Else
Return 0
}

NormalizeBinderHotkey(keyName) {
    russianLower := "йцукенгшщзхъфывапролджэячсмитьбю"
    russianUpper := "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
    latinKeys := "qwertyuiop[]asdfghjkl;'zxcvbnm,."
    Loop, Parse, russianLower
    {
        latinKey := SubStr(latinKeys, A_Index, 1)
        keyName := StrReplace(keyName, A_LoopField, latinKey)
        keyName := StrReplace(keyName, SubStr(russianUpper, A_Index, 1), latinKey)
    }
    keyName := StrReplace(StrReplace(keyName, "ё", "sc029"), "Ё", "sc029")
    return keyName
}

PhysicalBinderHotkey(keyName) {
    if !RegExMatch(keyName, "^([*~$<>^!+#]*)(.)$", parts)
        return keyName
    keyChar := parts2
    StringLower, keyChar, keyChar
    if (keyChar = "ё")
        return parts1 . "sc029"
    russianKeys := "йцукенгшщзхъфывапролджэячсмитьбю"
    latinKeys := "qwertyuiop[]asdfghjkl;'zxcvbnm,."
    scanCodes := ["010", "011", "012", "013", "014", "015", "016", "017", "018", "019", "01A", "01B"
        , "01E", "01F", "020", "021", "022", "023", "024", "025", "026", "027", "028"
        , "02C", "02D", "02E", "02F", "030", "031", "032", "033", "034"]
    keyIndex := InStr(russianKeys, keyChar, true)
    if (!keyIndex)
        keyIndex := InStr(latinKeys, keyChar, true)
    if (!keyIndex)
        return keyName
    return parts1 . "sc" . scanCodes[keyIndex]
}
GreetingConflictIndex(greetingKey, bindKeys) {
    if (greetingKey = "")
        return 0
    physicalKey := PhysicalBinderHotkey(greetingKey)
    if (physicalKey = "^F9" || physicalKey = "^F10")
        return -1
    for bindIndex, bindKey in bindKeys {
        if (bindKey != "" && PhysicalBinderHotkey(bindKey) = physicalKey)
            return bindIndex
    }
    return 0
}
Gui, +LastFound +ToolWindow
ID := WinExist()
Gui, Show, NoActivate, Hide x0 y0 w0 h0, Overlay
WinSet_Click_Through(ID, "On")
GuiControl,, Un-Clickable
CustomColor := "#00FF00"
Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui, Color, cEA3479
Gui, Font,, Proxima Nova
Gui, Font, s10
Gui, Font, q1
Gui, Font, w400
Gui, Add, Text, x9 vMyText cWhite, XXX, YYYY
Gui, Add, Text, x107 y7 vMyTotalR cWhite, XXXXXX, YYYYYY
Gui, Color, 1c2126
WinSet, TransColor, AAAAAA 170
GoSub, UpdateCounter1
Gui, 1:Show, % "NA x" X " y" Y " w212 h30" (CounterHidden ? " Hide" : ""), Overlay

Hotkey, % PhysicalBinderHotkey(KEY1), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY1), Reports, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY2), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY2), delv, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY3), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY3), gm, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY4), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY4), vac, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY5), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY5), mess, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY6), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY6), dimcar, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY7), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY7), gcar, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY8), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY8), mtp, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY9), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY9), repm, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY10), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY10), rep, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY11), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY11), vhod, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY12), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY12), resc, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY14), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY14), Cheatsheet, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY15), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY15), gh, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY16), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY16), chide, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY17), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY17), zzdebug, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY18), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY18), reshp, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY19), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY19), killplayer, On UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY20), Off, UseErrorLevel
Hotkey, % PhysicalBinderHotkey(KEY20), f5, On UseErrorLevel
if (KEY13 != "") {
    Hotkey, % PhysicalBinderHotkey(KEY13), PunishmentHandler, On UseErrorLevel
    punishmentBindGameError := ErrorLevel
    Hotkey, IfWinActive, ahk_exe ragemp_v.exe
    Hotkey, % PhysicalBinderHotkey(KEY13), PunishmentHandler, On UseErrorLevel
    punishmentBindRageError := ErrorLevel
    Hotkey, IfWinActive, ahk_exe GTA5.exe
}

; Главное окно: темная палитра и розовый акцент Majestic.
IniRead, Dinamic, %A_ScriptDir%\res\Settings.ini, ID, Dinamic,
Gui, Main: -Caption +Border +MinimizeBox +LastFound
Gui, Main: Color, 12131A, 1B1D27
Gui, Main: Font, s10 cE9EAF0, Segoe UI
Gui, Main: Add, Progress, x0 y0 w1040 h78 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Add, Text, x265 y0 w330 h76 +BackgroundTrans gMainDrag hwndMainDragZone
Gui, Main: Font, s17 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x24 y15 w230 h30 +BackgroundTrans gMainDrag hwndMainBrand, MAJESTIC
Gui, Main: Font, s9 w600 cEA3479, Segoe UI
Gui, Main: Add, Text, x26 y47 w230 h18 +BackgroundTrans gMainDrag hwndMainSubtitle, ADMIN  /  BINDER
Gui, Main: Font, s10 w600 cD9DCE8, Segoe UI
Gui, Main: Add, Text, x610 y27 w174 h28 +0x200 +0x100 Center Background292C38 gMainShowBinds hwndMainNavBinds, БИНДЫ
Gui, Main: Add, Text, x790 y27 w174 h28 +0x200 +0x100 Center Background292C38 gMainShowSettings hwndMainNavSettings, НАСТРОЙКИ
Gui, Main: Add, Progress, x610 y57 w174 h3 cEA3479 BackgroundEA3479 Disabled vMainTabAccent, 100
Gui, Main: Font, s15 w400 cAEB1BF, Segoe UI
Gui, Main: Add, Text, x972 y25 w28 h30 +0x200 +0x100 Center +BackgroundTrans gHide hwndMainMinimize, −
Gui, Main: Add, Text, x1003 y25 w27 h30 +0x200 +0x100 Center +BackgroundTrans gClose hwndMainClose, ×
Gui, Main: Add, Progress, x0 y77 w1040 h2 cEA3479 BackgroundEA3479 Disabled, 100

; Общая навигация по справочникам.
Gui, Main: Add, Progress, x16 y108 w180 h506 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Font, s9 w700 cEA3479, Segoe UI
Gui, Main: Add, Text, x28 y129 w156 h20 Center +BackgroundTrans, РАЗДЕЛЫ
Gui, Main: Font, s10 w500 cE9EAF0, Segoe UI
Gui, Main: Add, Text, x28 y162 w156 h34 +0x200 +0x100 Center Background292C38 gInfo hwndMainInfo, Общая информация
Gui, Main: Add, Text, x28 y204 w156 h34 +0x200 +0x100 Center Background292C38 gCommandlist hwndMainCommands, Команды
Gui, Main: Add, Text, x28 y246 w156 h34 +0x200 +0x100 Center Background292C38 gAnswers hwndMainAnswers, Ответы
Gui, Main: Add, Text, x28 y288 w156 h34 +0x200 +0x100 Center Background292C38 gPunish hwndMainPunish, Наказания
Gui, Main: Add, Text, x28 y330 w156 h34 +0x200 +0x100 Center Background292C38 gUsefull hwndMainUseful, Полезное
Gui, Main: Add, Text, x28 y390 w156 h34 +0x200 +0x100 Center Background292C38 gShortcutEditorOpen, Редактор сокращений
Gui, Main: Add, Progress, x28 y198 w156 h3 cEA3479 BackgroundEA3479 Disabled Hidden vMainSectionAccent, 100
; Tab2 находится за границей окна: его дочерние поля остаются видимыми.
Gui, Main: Add, Tab2, x-200 y-200 w1 h1 vMainTabs gMainTabChanged, Бинды|Настройки|Справочник
Gui, Main: Tab, 1
Gui, Main: Add, Progress, x212 y108 w548 h506 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Add, Progress, x776 y108 w248 h432 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Add, Progress, x776 y544 w248 h70 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Font, s15 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x230 y126 w290 h31 +BackgroundTrans, Горячие клавиши
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x230 y158 w490 h22 +BackgroundTrans, Назначьте сочетания для частых действий администрации
Gui, Main: Font, s12 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x794 y127 w210 h28 +BackgroundTrans, Команды при входе
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x794 y155 w210 h20 +BackgroundTrans, Отметьте нужные команды

bindRows := [[1, "Открыть репорты"], [2, "Удалить транспорт"], [3, "Вкл/выкл /gm"]
    , [4, "Вакцина"], [5, "Первое сообщение"], [7, "ТП авто к себе"]
    , [8, "ТП на метку"], [9, "Убрать -1 репорт"], [10, "Добавить +1 репорт"]
    , [12, "Воскресить игрока"], [19, "Убить игрока"], [13, "Выдача наказаний"]
    , [16, "Вкл/выкл /chide"], [17, "Вкл/выкл /zzdebug"], [18, "HP 0 + rescue"]
    , [15, "Вкл/выкл /gh"], [11, "Команды при входе"], [20, "Уйти в F5"]
    , [6, "Машина после воды"], [14, "Памятка"]]
mainBindLabelHwnds := {}
for rowIndex, bind in bindRows
{
    col := rowIndex > 10 ? 1 : 0
    row := Mod(rowIndex - 1, 10)
    left := col ? 497 : 230
    top := 190 + row * 40
    name := "KEY" bind[1]
    keyValue := %name%
    Gui, Main: Add, Progress, % "x" left " y" top " w248 h33 c272A36 Background272A36 Disabled", 100
    Gui, Main: Font, s9 w500 cE9EAF0, Segoe UI
    bindLabelOptions := "x" (left + 11) " y" (top + 7) " w165 h18 hwndBindLabelHwnd"
    if (bind[1] = 13)
        bindLabelOptions .= " gPunishmentOpenFromGui"
    Gui, Main: Add, Text, % bindLabelOptions, % bind[2]
    mainBindLabelHwnds[bindLabelHwnd] := true
    Gui, Main: Font, s9 w500 cFFFFFF, Segoe UI
    Gui, Main: Add, Hotkey, % "x" (left + 179) " y" (top + 4) " w61 h25 vHot" bind[1] " hwndBindHotkeyHwnd Background343746", %keyValue%
    if (bind[1] = 13)
        mainPunishmentHotkeyHwnd := bindHotkeyHwnd
}

Gui, Main: Font, s10 w500 cE9EAF0, Segoe UI
Gui, Main: Add, CheckBox, x794 y189 w210 h28 vRadio8 hwndMainLogin8 Checked%Radio8%, /hidecheatinfo
Gui, Main: Add, CheckBox, x794 y225 w210 h28 vRadio9 hwndMainLogin9 Checked%Radio9%, /showcheats
Gui, Main: Add, CheckBox, x794 y261 w210 h28 vRadio10 hwndMainLogin10 Checked%Radio10%, /dl
Gui, Main: Add, CheckBox, x794 y297 w210 h28 vRadio11 hwndMainLogin11 Checked%Radio11%, /esp 3
Gui, Main: Add, CheckBox, x794 y333 w210 h28 vRadio12 hwndMainLogin12 Checked%Radio12%, /templeader %Fraction%
Gui, Main: Add, CheckBox, x794 y369 w210 h28 vRadio13 hwndMainLogin13 Checked%Radio13%, /chide
Gui, Main: Add, CheckBox, x794 y405 w210 h28 vRadio14 hwndMainLogin14 Checked%Radio14%, /zzdebug
Gui, Main: Add, CheckBox, x794 y441 w210 h28 vRadio15 hwndMainLogin15 Checked%Radio15%, /objdl
Gui, Main: Add, CheckBox, x794 y477 w210 h28 vRadio16 hwndMainLogin16 Checked%Radio16%, /netstat
Gui, Main: Add, CheckBox, x794 y509 w210 h28 vLoginAdvToggle hwndMainLoginAdvToggle Checked%LoginAdvToggle%, /advtoggle 0
mainLoginHwnds := {}
Loop, 9 {
    loginIndex := A_Index + 7
    loginName := "MainLogin" loginIndex
    loginHwnd := %loginName%
    mainLoginHwnds[loginHwnd] := true
}
mainLoginHwnds[MainLoginAdvToggle] := true
Gui, Main: Font, s10 w600 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x794 y558 w105 h25 +BackgroundTrans, Ваш статик
Gui, Main: Add, Edit, x901 y555 w50 h27 +Number vDinamic, %Dinamic%
Gui, Main: Font, s10 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x960 y555 w48 h27 +0x200 +0x100 Center BackgroundEA3479 gSaveData1 hwndMainSaveDynamic, ✓

Gui, Main: Tab, 2
Gui, Main: Add, Progress, x212 y108 w250 h506 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Add, Progress, x476 y108 w266 h506 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Add, Progress, x756 y108 w268 h506 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Font, s13 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x230 y130 w218 h28 +BackgroundTrans, Экран
Gui, Main: Add, Text, x494 y130 w230 h28 +BackgroundTrans, Администрация
Gui, Main: Add, Text, x774 y130 w235 h28 +BackgroundTrans, Ответы и оверлей
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x230 y160 w218 h36 +BackgroundTrans, Разрешение для игровых действий
Gui, Main: Add, Text, x494 y160 w230 h36 +BackgroundTrans, Данные для команд и связи
Gui, Main: Add, Text, x774 y160 w235 h36 +BackgroundTrans, Положение счётчика и форма ответов
Gui, Main: Font, s10 cE9EAF0, Segoe UI
Gui, Main: Add, Radio, x230 y210 w215 h27 Group vRadio17 hwndMainResolution17 Checked%Radio17%, 2560 × 1440 (2K)
Gui, Main: Add, Radio, x230 y249 w215 h27 vRadio1 hwndMainResolution1 Checked%Radio1%, 1920 × 1080
Gui, Main: Add, Radio, x230 y288 w215 h27 vRadio6 hwndMainResolution6 Checked%Radio6%, 1920 × 1080 (5:4)
Gui, Main: Add, Radio, x230 y327 w215 h27 vRadio3 hwndMainResolution3 Checked%Radio3%, 1680 × 1050
Gui, Main: Add, Radio, x230 y366 w215 h27 vRadio2 hwndMainResolution2 Checked%Radio2%, 1600 × 900
Gui, Main: Add, Radio, x230 y405 w215 h27 vRadio4 hwndMainResolution4 Checked%Radio4%, 1366 × 768
Gui, Main: Add, Radio, x230 y444 w215 h27 vRadio5 hwndMainResolution5 Checked%Radio5%, 1280 × 960
Gui, Main: Add, Radio, x230 y483 w215 h27 vRadio7 hwndMainResolution7 Checked%Radio7%, 1280 × 1024
mainSettingsRadioHwnds := {}
for _, radioHwnd in [MainResolution17, MainResolution1, MainResolution6, MainResolution3
    , MainResolution2, MainResolution4, MainResolution5, MainResolution7]
    mainSettingsRadioHwnds[radioHwnd] := true

Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x494 y208 w230 h20 +BackgroundTrans, ФРАКЦИЯ
Gui, Main: Add, Text, x494 y242 w75 h22 +0x200 +BackgroundTrans, ID фракции
Gui, Main: Add, Edit, x610 y240 w110 h27 +Number vFraction, %Fraction%
Gui, Main: Add, Text, x494 y301 w230 h20 +BackgroundTrans, DISCORD
Gui, Main: Add, Text, x494 y337 w75 h22 +0x200 +BackgroundTrans, Админ
Gui, Main: Add, Edit, x568 y335 w152 h27 vdis, %dis%
Gui, Main: Add, Text, x494 y378 w75 h22 +0x200 +BackgroundTrans, ГА
Gui, Main: Add, Edit, x568 y376 w152 h27 vgadis, %gadis%
Gui, Main: Add, Text, x494 y419 w75 h22 +0x200 +BackgroundTrans, ЗГА
Gui, Main: Add, Edit, x568 y417 w152 h27 vzgadis, %zgadis%
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x494 y467 w226 h21 +BackgroundTrans, ПРИВЕТСТВИЕ
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x494 y499 w103 h27 +0x200 +BackgroundTrans, Клавиша
Gui, Main: Font, s10 cFFFFFF, Segoe UI
greetingHotkeyLabel := GreetingHotkeyDisplayText(GreetingHotkey)
Gui, Main: Add, Text, x610 y499 w110 h27 +0x200 +0x100 Center Background343746 vGreetingHotkeyDisplay gGreetingHotkeyBegin, %greetingHotkeyLabel%
Gui, Main: Add, Hotkey, x610 y499 w110 h27 vGreetingHotkey hwndGreetingHotkeyHwnd Hidden, %GreetingHotkey%
Gui, Main: Font, s8 c989DAD, Segoe UI
Gui, Main: Add, Text, x494 y540 w226 h34 +BackgroundTrans, Нажмите на поле, чтобы выбрать сочетание.

Gui, Main: Font, s9 w600 cEA3479, Segoe UI
Gui, Main: Add, Text, x774 y210 w225 h22 +BackgroundTrans, СЧЁТЧИК
Gui, Main: Font, s10 w700 q0 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x762 y247 w256 h34 +0x200 +0x100 Center vCounterMoveAction hwndcounterMoveButtonHwnd gCounterMoveStart, ИЗМЕНИТЬ ПОЛОЖЕНИЕ СЧЁТЧИКА
Gui, Main: Font, s10 w700 q0 cAEB1BF, Segoe UI
Gui, Main: Add, Text, x762 y247 w256 h34 +0x200 Center vCounterMoveInactive hwndcounterMoveInactiveHwnd Hidden, ИЗМЕНИТЬ ПОЛОЖЕНИЕ СЧЁТЧИКА
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Progress, x774 y289 w230 h34 c292C38 Background292C38 Disabled, 100
Gui, Main: Font, s9 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x774 y289 w230 h34 +0x200 +0x100 Center +BackgroundTrans vCounterVisibilityAction gCounterVisibilityToggle, % CounterHidden ? "ПОКАЗАТЬ СЧЁТЧИК" : "СКРЫТЬ СЧЁТЧИК"
CounterUpdateMoveButton()
Gui, Main: Font, s9 w600 cEA3479, Segoe UI
Gui, Main: Add, Text, x774 y371 w225 h22 +BackgroundTrans, ПОЛ АДМИНИСТРАТОРА
Gui, Main: Font, s10 cE9EAF0, Segoe UI
Gui, Main: Add, Radio, x774 y410 w112 h28 vGenderMale gSelectMale Group Checked%GenderMale%, Мужской
Gui, Main: Add, Radio, x890 y410 w112 h28 vGenderFemale gSelectFemale Checked%GenderFemale%, Женский
Gui, Main: Font, s8 c989DAD, Segoe UI
Gui, Main: Add, Text, x774 y448 w229 h45 +BackgroundTrans, Выбор меняет формулировки ответов и подсказок после сохранения.

Gui, Main: Tab, 3
Gui, Main: Add, Progress, x212 y108 w812 h506 c1B1D27 Background1B1D27 Disabled, 100
Gui, Main: Font, s15 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Text, x230 y126 w776 h31 vMainSectionTitle +BackgroundTrans, Справочник
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x230 y160 w776 h22 vMainSectionSubtitle +BackgroundTrans, Быстрые ответы и команды администрации
Gui, Main: Font, s9 w700 cEA3479, Segoe UI
Gui, Main: Add, Text, x641 y133 w62 h23 vMainUsefulSearchLabel +BackgroundTrans Hidden, ПОИСК
Gui, Main: Font, s10 w400 cE9EAF0, Segoe UI
Gui, Main: Add, Edit, x710 y129 w245 h28 vMainUsefulSearch gMainUsefulSearchChanged hwndMainUsefulSearchHwnd -Border Background292C38 Hidden
DllCall("SendMessage", "Ptr", MainUsefulSearchHwnd, "UInt", 0x1501, "Ptr", 1, "WStr", "Поиск по разделам")
Gui, Main: Font, s15 w400 cEA3479, Segoe UI
Gui, Main: Add, Text, x958 y129 w25 h28 vMainUsefulSearchClear gMainUsefulSearchClear +0x200 +0x100 Center Background292C38 Hidden, ×
Gui, Main: Add, Progress, x710 y158 w273 h2 cEA3479 BackgroundEA3479 Disabled vMainUsefulSearchAccent Hidden, 100
Gui, Main: Font, s9 w700 cEA3479, Segoe UI
Gui, Main: Add, Text, x641 y133 w62 h23 vMainAnswersSearchLabel +BackgroundTrans Hidden, ПОИСК
Gui, Main: Font, s10 w400 cE9EAF0, Segoe UI
Gui, Main: Add, Edit, x710 y129 w245 h28 vMainAnswersSearch gMainAnswersSearchChanged hwndMainAnswersSearchHwnd -Border Background292C38 Hidden
DllCall("SendMessage", "Ptr", MainAnswersSearchHwnd, "UInt", 0x1501, "Ptr", 1, "WStr", "Поиск по разделам")
Gui, Main: Font, s15 w400 cEA3479, Segoe UI
Gui, Main: Add, Text, x958 y129 w25 h28 vMainAnswersSearchClear gMainAnswersSearchClear +0x200 +0x100 Center Background292C38 Hidden, ×
Gui, Main: Add, Progress, x710 y158 w273 h2 cEA3479 BackgroundEA3479 Disabled vMainAnswersSearchAccent Hidden, 100
richEditModule := DllCall("LoadLibrary", "Str", "Msftedit.dll", "Ptr")
if (!richEditModule) {
    MsgBox, 16, Справочник, Не удалось загрузить компонент подсветки текста.
    ExitApp
}
Gui, Main: Font, s11 w400 cE9EAF0, Segoe UI
Gui, Main: Add, Custom, ClassRICHEDIT50W x230 y193 w690 h399 vMainSectionBody hwndMainSectionBodyHwnd +0x4 +0x40 +0x800 -Border
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x443, "Ptr", 0, "Ptr", 0x271D1B)
VarSetCapacity(sectionTextFormat, 116, 0)
NumPut(116, sectionTextFormat, 0, "UInt")
NumPut(0x40000000, sectionTextFormat, 4, "UInt")
NumPut(0xF0EAE9, sectionTextFormat, 20, "UInt")
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x444, "Ptr", 0, "Ptr", &sectionTextFormat)
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x435, "Ptr", 0, "Ptr", 1000000)
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xD3, "Ptr", 3, "Ptr", 12 | (12 << 16))
Gui, Main: Add, Text, x994 y193 w12 h399 +0x100 Background292C38 gMainSectionScrollClick vMainSectionScrollTrack hwndMainSectionScrollTrackHwnd, % Chr(160)
Gui, Main: Add, Progress, x996 y195 w8 h32 cEA3479 BackgroundEA3479 Disabled vMainSectionScrollThumb hwndMainSectionScrollThumbHwnd Hidden, 100
mainAnswerActions := []
mainAnswerButtonY := []
Loop, 24 {
    Gui, Main: Font, s11 cEA3479, Segoe UI Symbol
    Gui, Main: Add, Text, % "x929 y193 w25 h22 Center +0x200 +0x100 Background292C38 Hidden vMainAnswerEdit" A_Index " gMainAnswerEdit", ✎
    Gui, Main: Font, s11 cEA3479, Segoe UI Emoji
    Gui, Main: Add, Text, % "x958 y193 w25 h22 Center +0x200 +0x100 Background292C38 Hidden vMainAnswerDelete" A_Index " gMainAnswerDelete", 🗑
}
Gui, Main: Font, s9 w700 cEA3479, Segoe UI
Gui, Main: Add, Text, x230 y129 w125 h28 +0x200 +0x100 Center Background292C38 vMainChaptersBack gMainChaptersBack Hidden, ← К ГЛАВАМ
answerChapters := ["Вики", "Информация", "Адм Ответы", "asms", "Приветствие", "Discord"]
punishmentChapters := ["demorgan", "mute", "warn", "ban", "gunban"]
usefulChapters := ["Предметы", "Локации", "БП", "Рейд", "Влияние", "Предметы события", "Валюта события", "Такси", "Дрифт", "Навыки", "Телепорты"]
mainChaptersVisible := false
mainShownChapterCount := 0
mainShownChapterSection := ""
Loop, 11 {
    chapterIndex := A_Index
    chapterX := 230 + Mod(chapterIndex - 1, 2) * 388
    chapterY := 203 + Floor((chapterIndex - 1) / 2) * 64
    Gui, Main: Add, Progress, % "x" chapterX " y" chapterY " w370 h50 c292C38 Background292C38 Disabled vMainChapterBg" chapterIndex " Hidden", 100
    Gui, Main: Font, s11 w700 cFFFFFF, Segoe UI
    Gui, Main: Add, Text, % "x" chapterX " y" chapterY " w370 h50 +0x200 +0x100 Center +BackgroundTrans vMainChapter" chapterIndex " gMainChapterChoose Hidden"
}

Gui, Main: Tab
Gui, Main: Font, s9 c989DAD, Segoe UI
Gui, Main: Add, Text, x214 y631 w560 h20 vMainFooterHint +BackgroundTrans, Изменения вступят в силу после сохранения
Gui, Main: Font, s10 w700 cFFFFFF, Segoe UI
Gui, Main: Add, Progress, x806 y623 w218 h34 cEA3479 BackgroundEA3479 Disabled vMainSaveBackground, 100
Gui, Main: Add, Text, x806 y623 w218 h34 +0x200 +0x100 Center +BackgroundTrans gSaveData vMainSaveAction hwndMainSave, СОХРАНИТЬ И ПРИМЕНИТЬ
mainSectionBrush := DllCall("CreateSolidBrush", "UInt", 0x271D1B, "Ptr")
mainBindRowBrush := DllCall("CreateSolidBrush", "UInt", 0x362A27, "Ptr")
mainActionBrush := DllCall("CreateSolidBrush", "UInt", 0x7934EA, "Ptr")
mainInactiveActionBrush := DllCall("CreateSolidBrush", "UInt", 0x463734, "Ptr")
OnMessage(0x133, "MainSectionControlColor")
OnMessage(0x135, "MainSectionControlColor")
OnMessage(0x138, "MainSectionControlColor")
Gui, Main: Show, w1040 h666, Majestic Admin Binder
Gui, Main: +LastFound
mainGuiHwnd := WinExist()
if (KEY13 != "") {
    Hotkey, IfWinActive, % "ahk_id " mainGuiHwnd
    Hotkey, % "~" PhysicalBinderHotkey(KEY13), PunishmentHandler, On UseErrorLevel
    punishmentBindMainError := ErrorLevel
    Hotkey, IfWinActive, ahk_exe GTA5.exe
    if (punishmentBindGameError || punishmentBindRageError || punishmentBindMainError)
        GuiControl, Main:, MainFooterHint, Не удалось назначить клавишу наказаний. Выберите другую и сохраните.
}
if (GreetingHotkey != "") {
    greetingConflict := GreetingConflictIndex(GreetingHotkey, [KEY1, KEY2, KEY3, KEY4, KEY5
        , KEY6, KEY7, KEY8, KEY9, KEY10, KEY11, KEY12, KEY13, KEY14, KEY15
        , KEY16, KEY17, KEY18, KEY19, KEY20])
    if (greetingConflict)
        GuiControl, Main:, MainFooterHint, Клавиша приветствия занята. Выберите другое сочетание в настройках.
    else {
        Hotkey, IfWinActive, ahk_exe GTA5.exe
        Hotkey, % PhysicalBinderHotkey(GreetingHotkey), GreetingHandler, On UseErrorLevel
        greetingGameError := ErrorLevel
        Hotkey, IfWinActive, ahk_exe ragemp_v.exe
        Hotkey, % PhysicalBinderHotkey(GreetingHotkey), GreetingHandler, On UseErrorLevel
        greetingRageError := ErrorLevel
        Hotkey, IfWinActive, ahk_exe GTA5.exe
        if (greetingGameError || greetingRageError)
            GuiControl, Main:, MainFooterHint, Не удалось назначить клавишу приветствия. Выберите другую и сохраните.
    }
}
mainSectionDragging := false
greetingCaptureOpen := false
counterMoveActive := false
OnMessage(0x20A, "MainSectionWheel")
OnMessage(0x201, "MainSectionScrollMouseDown")
OnMessage(0x200, "MainSectionScrollMouseMove")
OnMessage(0x202, "MainSectionScrollMouseUp")
OnMessage(0x232, "CounterMoveFinish")
ShortcutEditorInit()
IniRead, initialSetupComplete, %settingsPath%, InitialSetup, Complete, 0
if (initialSetupComplete != 1) {
    Gui, InitialSetup: +OwnerMain -Caption +Border
    Gui, InitialSetup: Color, 12131A, 1B1D27
    Gui, InitialSetup: Font, s10 cE9EAF0, Segoe UI
    Gui, InitialSetup: Add, Progress, x0 y0 w640 h78 c1B1D27 Background1B1D27 Disabled, 100
    Gui, InitialSetup: Add, Text, x230 y0 w340 h76 +BackgroundTrans gInitialSetupDrag
    Gui, InitialSetup: Font, s17 w700 cFFFFFF, Segoe UI
    Gui, InitialSetup: Add, Text, x24 y15 w230 h30 +BackgroundTrans gInitialSetupDrag, MAJESTIC
    Gui, InitialSetup: Font, s9 w600 cEA3479, Segoe UI
    Gui, InitialSetup: Add, Text, x26 y47 w330 h18 +BackgroundTrans gInitialSetupDrag, ADMIN  /  BINDER
    Gui, InitialSetup: Font, s15 w400 cAEB1BF, Segoe UI
    Gui, InitialSetup: Add, Text, x599 y25 w27 h30 +0x200 +0x100 Center +BackgroundTrans gInitialSetupContinue, ×
    Gui, InitialSetup: Add, Progress, x0 y77 w640 h2 cEA3479 BackgroundEA3479 Disabled, 100
    Gui, InitialSetup: Add, Progress, x16 y98 w608 h270 c1B1D27 Background1B1D27 Disabled, 100
    Gui, InitialSetup: Font, s14 w700 cFFFFFF, Segoe UI
    Gui, InitialSetup: Add, Text, x34 y116 w570 h30 +BackgroundTrans, Обязательная первоначальная настройка
    Gui, InitialSetup: Font, s10 w500 cE9EAF0, Segoe UI
    Gui, InitialSetup: Add, Text, x34 y154 w570 h160 +BackgroundTrans, 1. Поместите биндер в отдельную папку: он создаст папку res и файл Punishment.txt.`n2. Выберите ваше разрешение в настройках.`n3. Заполните данные для команд и связи.`n4. Настройте положение счётчика и ваш пол.`n5. Расставьте удобные хоткеи в биндах и укажите ваш статик.`n6. По завершении нажмите «Сохранить и применить».
    Gui, InitialSetup: Add, CheckBox, x34 y326 w570 h28 vInitialSetupConfirmed, Первоначальная настройка выполнена. Больше не показывать это окно.
    Gui, InitialSetup: Font, s9 c989DAD, Segoe UI
    Gui, InitialSetup: Add, Text, x24 y400 w340 h20 +BackgroundTrans, Окно появится снова до подтверждения настройки
    Gui, InitialSetup: Add, Progress, x406 y389 w218 h36 cEA3479 BackgroundEA3479 Disabled, 100
    Gui, InitialSetup: Font, s10 w700 cFFFFFF, Segoe UI
    Gui, InitialSetup: Add, Text, x406 y389 w218 h36 +0x200 +0x100 Center +BackgroundTrans gInitialSetupContinue, ПРОДОЛЖИТЬ
    Gui, InitialSetup: Add, Button, Hidden Default gInitialSetupContinue
    Gui, InitialSetup: Show, w640 h446, Первоначальная настройка биндера
    Gui, InitialSetup: +LastFound
    initialSetupHwnd := WinExist()
}
return

InitialSetupDrag:
DllCall("ReleaseCapture")
PostMessage, 0xA1, 2,,, % "ahk_id " initialSetupHwnd
return

InitialSetupContinue:
InitialSetupGuiClose:
Gui, InitialSetup: Submit, NoHide
if (InitialSetupConfirmed) {
    IniWrite, 1, %settingsPath%, InitialSetup, Complete
    if ErrorLevel {
        MsgBox, 16, Настройки, Не удалось сохранить подтверждение в Settings.ini.
        return
    }
}
Gui, InitialSetup: Destroy
return

CounterMoveStart:
if (CounterHidden)
    return
if (counterMoveActive) {
    CounterMoveFinish(0, 0, 0, ID)
    return
}
counterMoveActive := true
WinSet_Click_Through(ID, "Off")
WinSet, AlwaysOnTop, On, % "ahk_id " ID
GuiControl, Main:, CounterMoveAction, ГОТОВО
GuiControl, Main:, MainFooterHint, Перетащите счётчик мышью или нажмите «ГОТОВО»
return

CounterVisibilityToggle:
if (counterMoveActive) {
    CounterMoveFinish(0, 0, 0, ID)
    if (counterMoveActive)
        return
}
CounterHidden := !CounterHidden
IniWrite, %CounterHidden%, %A_ScriptDir%\res\Settings.ini, Counter, Hidden
if ErrorLevel {
    CounterHidden := !CounterHidden
    MsgBox, 16, Счётчик, Не удалось сохранить настройку видимости.
    return
}
if (CounterHidden) {
    Gui, 1:Hide
    GuiControl, Main:, CounterVisibilityAction, ПОКАЗАТЬ СЧЁТЧИК
    GuiControl, Main:, MainFooterHint, Счётчик скрыт. Нажмите кнопку, чтобы показать его.
} else {
    Gui, 1:Show, NA x%X% y%Y% w212 h30, Overlay
    GuiControl, Main:, CounterVisibilityAction, СКРЫТЬ СЧЁТЧИК
    GuiControl, Main:, MainFooterHint, Счётчик снова отображается на экране.
}
CounterUpdateMoveButton()
return

CounterUpdateMoveButton() {
    global CounterHidden
    GuiControl, % "Main:" (CounterHidden ? "Hide" : "Show"), CounterMoveAction
    GuiControl, % "Main:" (CounterHidden ? "Show" : "Hide"), CounterMoveInactive
}

CounterMoveFinish(wParam, lParam, msg, hwnd) {
    global ID, X, Y, settingsPath, counterMoveActive
    if (!counterMoveActive || hwnd != ID)
        return
    WinGetPos, newX, newY,,, % "ahk_id " ID
    if (newX = "" || newY = "") {
        MsgBox, 16, Счётчик, Не удалось определить положение счётчика.
        return
    }
    IniWrite, %newX%, %settingsPath%, Coords, X
    xSaveError := ErrorLevel
    IniWrite, %newY%, %settingsPath%, Coords, Y
    ySaveError := ErrorLevel
    if (!xSaveError && !ySaveError) {
        X := newX
        Y := newY
        GuiControl, Main:, MainFooterHint, Положение счётчика сохранено
    } else
        MsgBox, 16, Счётчик, Не удалось сохранить положение в Settings.ini.
    counterMoveActive := false
    WinSet_Click_Through(ID, "On")
    WinSet, TransColor, AAAAAA 170, % "ahk_id " ID
    GuiControl, Main:, CounterMoveAction, ИЗМЕНИТЬ ПОЛОЖЕНИЕ СЧЁТЧИКА
}

MainDrag:
DllCall("ReleaseCapture")
PostMessage, 0xA1, 2,,, % "ahk_id " mainGuiHwnd
return

SelectMale:
GuiControl, Main:, GenderMale, 1
GuiControl, Main:, GenderFemale, 0
return

SelectFemale:
GuiControl, Main:, GenderMale, 0
GuiControl, Main:, GenderFemale, 1
return

GreetingHotkeyBegin:
greetingCaptureOpen := true
GuiControl, Main:Hide, GreetingHotkeyDisplay
GuiControl, Main:Show, GreetingHotkey
GuiControl, Main:Focus, GreetingHotkey
SetTimer, GreetingHotkeyRefresh, 100
return

GreetingHotkeyRefresh:
if (!greetingCaptureOpen) {
    SetTimer, GreetingHotkeyRefresh, Off
    return
}
GuiControlGet, selectedTab, Main:, MainTabs
if (selectedTab = "Настройки" && WinActive("ahk_id " mainGuiHwnd)
    && DllCall("GetFocus", "Ptr") = GreetingHotkeyHwnd)
    return
GreetingFinishHotkeyCapture()
return

GreetingFinishHotkeyCapture() {
    global greetingCaptureOpen
    if (!greetingCaptureOpen)
        return
    greetingCaptureOpen := false
    SetTimer, GreetingHotkeyRefresh, Off
    GuiControlGet, selectedKey, Main:, GreetingHotkey
    GuiControl, Main:, GreetingHotkeyDisplay, % GreetingHotkeyDisplayText(selectedKey)
    GuiControl, Main:Hide, GreetingHotkey
    GuiControl, Main:Show, GreetingHotkeyDisplay
}

GreetingHotkeyDisplayText(keyName) {
    keyName := NormalizeBinderHotkey(keyName)
    if (keyName = "")
        return "НАЗНАЧИТЬ"
    StringUpper, keyName, keyName
    keyName := StrReplace(keyName, "+", "Shift + ")
    keyName := StrReplace(keyName, "^", "Ctrl + ")
    keyName := StrReplace(keyName, "!", "Alt + ")
    return StrReplace(keyName, "#", "Win + ")
}

MainShowBinds:
SetTimer, MainRefreshSectionScroll, Off
GuiControl, Main:Choose, MainTabs, 1
MainUpdateAnswerActions()
GuiControl, Main:Hide, MainSectionAccent
GuiControl, Main:Show, MainTabAccent
GuiControl, Main:Move, MainTabAccent, x610 y57
GuiControl, Main:Show, MainSaveBackground
GuiControl, Main:Show, MainSaveAction
GuiControl, Main:, MainFooterHint, Изменения вступят в силу после сохранения
return

MainShowSettings:
SetTimer, MainRefreshSectionScroll, Off
GuiControl, Main:Choose, MainTabs, 2
MainUpdateAnswerActions()
GuiControl, Main:Hide, MainSectionAccent
GuiControl, Main:Show, MainTabAccent
GuiControl, Main:Move, MainTabAccent, x790 y57
GuiControl, Main:Show, MainSaveBackground
GuiControl, Main:Show, MainSaveAction
GuiControl, Main:, MainFooterHint, Изменения вступят в силу после сохранения
return

MainTabChanged:
GuiControlGet, selectedTab, Main:, MainTabs
if (selectedTab = "Настройки")
    GuiControl, Main:MoveDraw, MainTabAccent, x790 y57
else if (selectedTab = "Бинды")
    GuiControl, Main:MoveDraw, MainTabAccent, x610 y57
return

MainRefreshSectionScroll:
if (shortcutEditorHwnd && DllCall("GetForegroundWindow", "Ptr") = shortcutEditorHwnd)
    return
MainUpdateSectionScroll()
return

MainHighlightDeferred:
MainHighlightVisibleMatches()
return

MainAnswerEdit:
actionIndex := RegExReplace(A_GuiControl, "\D")
action := mainAnswerActions[actionIndex]
if (IsObject(action)) {
    shortcutOpenRecord := action.index
    shortcutOpenSection := action.section
    shortcutOpenChapter := action.chapter
    Gosub, ShortcutEditorOpen
}
return

MainAnswerDelete:
actionIndex := RegExReplace(A_GuiControl, "\D")
action := mainAnswerActions[actionIndex]
if (IsObject(action)) {
    deleted := ShortcutDeleteRecord(action.index)
    if (deleted = 1) {
        MainRenderSearchSection(mainCurrentSection, mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch")
        GuiControl, Main:, MainFooterHint, % "Удалено: " shortcutDeletedAlias
    } else if (deleted = -1)
        MsgBox, 16, Сокращения, Не удалось обновить файл Shortcuts.tsv.
}
return

MainSectionScrollClick:
MainScrollSectionToMouse()
return

MainSectionControlColor(wParam, lParam, msg, hwnd) {
    global MainSectionBodyHwnd, mainSectionBrush, mainBindRowBrush
    global mainBindLabelHwnds, mainLoginHwnds, mainSettingsRadioHwnds
    global mainActionBrush, mainInactiveActionBrush, counterMoveButtonHwnd, counterMoveInactiveHwnd
    global shortcutEditorHwnd, shortcutConfirmHwnd, shortcutConfirmInactiveHwnd, shortcutTranslitHwnd
    if (msg = 0x138) {
        if (lParam = counterMoveButtonHwnd || (hwnd = shortcutEditorHwnd && lParam = shortcutConfirmHwnd)) {
            DllCall("SetBkColor", "Ptr", wParam, "UInt", 0x7934EA)
            DllCall("SetTextColor", "Ptr", wParam, "UInt", 0xFFFFFF)
            return mainActionBrush
        }
        if (lParam = counterMoveInactiveHwnd || (hwnd = shortcutEditorHwnd && lParam = shortcutConfirmInactiveHwnd)) {
            DllCall("SetBkColor", "Ptr", wParam, "UInt", 0x463734)
            DllCall("SetTextColor", "Ptr", wParam, "UInt", 0xBFB1AE)
            return mainInactiveActionBrush
        }
        if (hwnd = shortcutEditorHwnd && lParam = shortcutTranslitHwnd) {
            DllCall("SetBkColor", "Ptr", wParam, "UInt", 0x271D1B)
            DllCall("SetTextColor", "Ptr", wParam, "UInt", 0xF0EAE9)
            return mainSectionBrush
        }
    }
    if (mainBindLabelHwnds.HasKey(lParam)) {
        DllCall("SetBkColor", "Ptr", wParam, "UInt", 0x362A27)
        DllCall("SetTextColor", "Ptr", wParam, "UInt", 0xF0EAE9)
        return mainBindRowBrush
    }
    if (lParam != MainSectionBodyHwnd && !mainLoginHwnds.HasKey(lParam) && !mainSettingsRadioHwnds.HasKey(lParam))
        return
    DllCall("SetBkColor", "Ptr", wParam, "UInt", 0x271D1B)
    DllCall("SetTextColor", "Ptr", wParam, "UInt", 0xF0EAE9)
    return mainSectionBrush
}

MainSectionScrollMouseDown(wParam, lParam, msg, hwnd) {
    global MainSectionScrollTrackHwnd, mainSectionDragging
    global shortcutScrollTracks, shortcutScrollDragging
    global GreetingHotkeyHwnd, greetingCaptureOpen
    global ID, counterMoveActive
    if (counterMoveActive && (hwnd = ID || DllCall("GetAncestor", "Ptr", hwnd, "UInt", 2, "Ptr") = ID)) {
        DllCall("ReleaseCapture")
        PostMessage, 0xA1, 2,,, % "ahk_id " ID
        return 0
    }
    if (greetingCaptureOpen && hwnd != GreetingHotkeyHwnd)
        GreetingFinishHotkeyCapture()
    if (IsObject(shortcutScrollTracks) && shortcutScrollTracks.HasKey(hwnd)) {
        shortcutScrollDragging := shortcutScrollTracks[hwnd]
        DllCall("SetCapture", "Ptr", hwnd)
        ShortcutScrollToMouse(shortcutScrollDragging)
        return 0
    }
    if (hwnd != MainSectionScrollTrackHwnd)
        return
    mainSectionDragging := true
    DllCall("SetCapture", "Ptr", hwnd)
    MainScrollSectionToMouse()
    return 0
}

MainSectionScrollMouseMove(wParam, lParam, msg, hwnd) {
    global mainSectionDragging, shortcutScrollDragging
    if (shortcutScrollDragging) {
        ShortcutScrollToMouse(shortcutScrollDragging)
        return 0
    }
    if (!mainSectionDragging)
        return
    MainScrollSectionToMouse()
    return 0
}

MainSectionScrollMouseUp(wParam, lParam, msg, hwnd) {
    global mainSectionDragging, shortcutScrollDragging
    if (shortcutScrollDragging) {
        ShortcutScrollToMouse(shortcutScrollDragging)
        shortcutScrollDragging := 0
        DllCall("ReleaseCapture")
        return 0
    }
    if (!mainSectionDragging)
        return
    MainScrollSectionToMouse()
    mainSectionDragging := false
    DllCall("ReleaseCapture")
    return 0
}

MainSectionWheel(wParam, lParam, msg, hwnd) {
    global mainGuiHwnd, MainSectionBodyHwnd, shortcutListHwnd, shortcutEditorHwnd, shortcutScrollTracks
    if (hwnd = shortcutListHwnd)
        return
    WinGet, activeWindow, ID, A
    if (activeWindow = shortcutEditorHwnd && IsObject(shortcutScrollTracks) && shortcutScrollTracks.HasKey(hwnd)) {
        index := shortcutScrollTracks[hwnd]
        info := ShortcutScrollInfo(index)
        delta := (wParam >> 16) & 0xFFFF
        if (delta > 32767)
            delta -= 65536
        ShortcutScrollTo(index, info.first - Round(delta / 120) * 3)
        return 0
    }
    if (activeWindow != mainGuiHwnd)
        return
    GuiControlGet, selectedTab, Main:, MainTabs
    if (selectedTab != "Справочник")
        return
    CoordMode, Mouse, Client
    MouseGetPos, mouseX, mouseY
    if (mouseX < 230 || mouseX > 1008 || mouseY < 193 || mouseY > 592)
        return
    wheelDelta := (wParam >> 16) & 0xFFFF
    if (wheelDelta > 32767)
        wheelDelta -= 65536
    lines := -Round(wheelDelta / 120) * 3
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB6, "Ptr", 0, "Int", lines)
    MainUpdateSectionScroll()
    return 0
}

MainSectionScrollInfo() {
    global MainSectionBodyHwnd
    total := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xBA, "Ptr", 0, "Ptr", 0, "Ptr")
    first := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xCE, "Ptr", 0, "Ptr", 0, "Ptr")
    visible := 21
    maxFirst := Max(total - visible, 0)
    thumbHeight := maxFirst ? Max(30, Round(399 * visible / total)) : 0
    return {first: Min(first, maxFirst), maxFirst: maxFirst, thumbHeight: thumbHeight}
}

MainUpdateSectionScroll(redraw := true) {
    global MainSectionScrollThumbHwnd
    static lastY := "", lastHeight := "", lastFirst := ""
    info := MainSectionScrollInfo()
    scrolled := info.first != lastFirst
    lastFirst := info.first
    if (!redraw)
        MainHighlightVisibleMatches(info.first, false)
    else if (scrolled)
        SetTimer, MainHighlightDeferred, -180
    if (info.maxFirst <= 0) {
        if DllCall("IsWindowVisible", "Ptr", MainSectionScrollThumbHwnd)
            GuiControl, Main:Hide, MainSectionScrollThumb
        if (scrolled || !redraw)
            MainUpdateAnswerActions()
        return
    }
    thumbY := 193 + Round(info.first / info.maxFirst * (399 - info.thumbHeight))
    if (thumbY != lastY || info.thumbHeight != lastHeight) {
        GuiControl, Main:Move, MainSectionScrollThumb, % "x996 y" thumbY " w8 h" info.thumbHeight
        lastY := thumbY
        lastHeight := info.thumbHeight
    }
    if !DllCall("IsWindowVisible", "Ptr", MainSectionScrollThumbHwnd)
        GuiControl, Main:Show, MainSectionScrollThumb
    if (scrolled || !redraw)
        MainUpdateAnswerActions()
}

MainUpdateAnswerActions() {
    global MainSectionBodyHwnd, mainAnswerEntries, mainAnswerActions
    global mainAnswerButtonY, mainCurrentSection, mainChaptersVisible, mainActiveSearchQuery
    GuiControlGet, selectedTab, Main:, MainTabs
    visible := (selectedTab = "Справочник" || selectedTab = 3) && !mainChaptersVisible
        && (mainCurrentSection = "answers" || mainCurrentSection = "useful" || mainActiveSearchQuery != "")
    slot := 0
    if (visible && IsObject(mainAnswerEntries)) {
        for _, entry in mainAnswerEntries {
            if (entry.position < 0 || !entry.index)
                continue
            point := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xD6, "Ptr", entry.position, "Ptr", 0, "UInt")
            y := (point >> 16) & 0xFFFF
            if (y > 32767)
                y -= 65536
            if (y < 0)
                continue
            if (y > 377)
                break
            slot++
            if (slot > 24)
                break
            mainAnswerActions[slot] := entry
            oldY := mainAnswerButtonY[slot]
            if (oldY = "" || oldY != y) {
                for _, action in ["Edit", "Delete"] {
                    control := "MainAnswer" action slot
                    GuiControl, Main:Move, %control%, % "y" (193 + y)
                    if (oldY = "")
                        GuiControl, Main:Show, %control%
                }
                mainAnswerButtonY[slot] := y
            }
        }
    }
    Loop, % 24 - slot {
        index := slot + A_Index
        if (!mainAnswerActions[index] && mainAnswerButtonY[index] = "")
            continue
        mainAnswerActions[index] := 0
        mainAnswerButtonY[index] := ""
        GuiControl, Main:Hide, % "MainAnswerEdit" index
        GuiControl, Main:Hide, % "MainAnswerDelete" index
    }
}

MainScrollSectionToMouse() {
    global MainSectionBodyHwnd
    info := MainSectionScrollInfo()
    if (info.maxFirst <= 0)
        return
    CoordMode, Mouse, Client
    MouseGetPos, mouseX, mouseY
    fraction := (mouseY - 193 - info.thumbHeight / 2) / (399 - info.thumbHeight)
    target := Round(Max(0, Min(1, fraction)) * info.maxFirst)
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB6, "Ptr", 0, "Int", target - info.first)
    MainUpdateSectionScroll()
}

Info:
MainOpenSection("info", "Общая информация", 1)
return

Commandlist:
MainOpenSection("commands", "Команды", 2)
return

Answers:
MainOpenSection("answers", "Ответы", 3)
return

MainAnswersSearchChanged:
if (mainCurrentSection = "answers")
    SetTimer, MainSearchApply, -180
return

MainAnswersSearchClear:
SetTimer, MainSearchApply, Off
GuiControl, Main:, MainAnswersSearch,
GuiControl, Main:Focus, MainAnswersSearch
if (mainCurrentSection = "answers")
    MainSearchChanged("answers", "MainAnswersSearch")
return

MainChapterChoose:
chapterIndex := RegExReplace(A_GuiControl, "\D")
MainShowChapter(mainCurrentSection = "answers" ? answerChapters[chapterIndex] : mainCurrentSection = "punishments" ? punishmentChapters[chapterIndex] : usefulChapters[chapterIndex])
return

MainChaptersBack:
MainShowChapters()
return

Punish:
MainOpenSection("punishments", "Наказания", 4)
return

Usefull:
MainOpenSection("useful", "Полезное", 5)
return

MainUsefulSearchChanged:
if (mainCurrentSection = "useful" || mainCurrentSection = "punishments")
    SetTimer, MainSearchApply, -180
return

MainUsefulSearchClear:
SetTimer, MainSearchApply, Off
GuiControl, Main:, MainUsefulSearch,
GuiControl, Main:Focus, MainUsefulSearch
if (mainCurrentSection = "useful" || mainCurrentSection = "punishments")
    MainSearchChanged(mainCurrentSection, "MainUsefulSearch")
return

MainSearchApply:
if (mainCurrentSection = "answers")
    MainSearchChanged("answers", "MainAnswersSearch")
else if (mainCurrentSection = "useful" || mainCurrentSection = "punishments")
    MainSearchChanged(mainCurrentSection, "MainUsefulSearch")
return

MainOpenSection(sectionFile, sectionTitle, sectionIndex) {
    global AdminGender, mainCurrentSection, mainSelectedChapter
    SetTimer, MainSearchApply, Off
    SetTimer, MainRefreshSectionScroll, Off
    mainCurrentSection := sectionFile
    chapterSection := sectionFile = "answers" || sectionFile = "useful" || sectionFile = "punishments"
    if (chapterSection)
        mainSelectedChapter := ""
    sectionText := BinderGetSectionContent(sectionFile)
    if (sectionText = "") {
        MsgBox, 16, Справочник, % "Не найден встроенный раздел: " sectionFile
        return
    }
    if (chapterSection) {
        sectionText := ""
        entryCount := 0
    } else {
        sectionText := MainFormatReferenceText(sectionFile, sectionText, entryCount)
    }
    GuiControl, Main:, MainSectionTitle, %sectionTitle%
    if (sectionFile = "answers")
        subtitle := entryCount . " готовых ответов  ·  Выбранная форма: " (AdminGender = "female" ? "женская" : "мужская")
    else if (sectionFile = "commands" || sectionFile = "punishments" || sectionFile = "useful")
        subtitle := entryCount . " сокращений  ·  Быстрый доступ к командам и подсказкам"
    else
        subtitle := "Быстрые ответы и команды администрации"
    GuiControl, Main:, MainSectionSubtitle, %subtitle%
    if (chapterSection)
        MainShowChapters()
    else {
        GuiControl, Main:, MainSectionBody, %sectionText%
        for _, searchControl in ["MainUsefulSearchLabel", "MainUsefulSearch", "MainUsefulSearchClear", "MainUsefulSearchAccent"
            , "MainAnswersSearchLabel", "MainAnswersSearch", "MainAnswersSearchClear", "MainAnswersSearchAccent"]
            GuiControl, Main:Hide, %searchControl%
        MainHideChapters()
        MainUpdateAnswerActions()
    }
    GuiControl, Main:Choose, MainTabs, 3
    GuiControl, Main:Hide, MainTabAccent
    accentY := 198 + (sectionIndex - 1) * 42
    GuiControl, Main:MoveDraw, MainSectionAccent, % "x28 y" accentY " w156 h3"
    GuiControl, Main:Show, MainSectionAccent
    GuiControl, Main:Hide, MainSaveBackground
    GuiControl, Main:Hide, MainSaveAction
    GuiControl, Main:, MainFooterHint, Выберите раздел слева или откройте бинды и настройки сверху
    if (!chapterSection) {
        MainUpdateSectionScroll()
        SetTimer, MainRefreshSectionScroll, 100
    }
}

MainShowChapters() {
    global answerChapters, usefulChapters, punishmentChapters, mainCurrentSection, mainSelectedChapter, mainActiveSearchQuery
    global mainChaptersVisible, mainShownChapterCount, mainShownChapterSection, mainAnswerEntries
    SetTimer, MainSearchApply, Off
    mainSelectedChapter := ""
    mainAnswerEntries := []
    MainUpdateAnswerActions()
    mainActiveSearchQuery := ""
    chapterNames := mainCurrentSection = "answers" ? answerChapters : mainCurrentSection = "punishments" ? punishmentChapters : usefulChapters
    GuiControl, Main:MoveDraw, MainSectionTitle, x230 y126 w776 h31
    GuiControl, Main:, MainSectionTitle, % mainCurrentSection = "answers" ? "Ответы" : mainCurrentSection = "punishments" ? "Наказания" : "Полезное"
    GuiControl, Main:, MainSectionSubtitle, Выберите главу или найдите запись в ответах, наказаниях и полезном
    GuiControl, Main:Hide, MainChaptersBack
    if (!mainChaptersVisible) {
        GuiControl, Main:Hide, MainSectionBody
        GuiControl, Main:Hide, MainSectionScrollTrack
        GuiControl, Main:Hide, MainSectionScrollThumb
    }
    Loop, %mainShownChapterCount% {
        if (A_Index <= chapterNames.MaxIndex())
            continue
        GuiControl, Main:Hide, % "MainChapterBg" A_Index
        GuiControl, Main:Hide, % "MainChapter" A_Index
    }
    for chapterIndex, chapterName in chapterNames {
        if (mainShownChapterSection != mainCurrentSection) {
            StringUpper, chapterLabel, chapterName
            GuiControl, Main:, % "MainChapter" chapterIndex, %chapterLabel%
        }
        if (!mainChaptersVisible || chapterIndex > mainShownChapterCount) {
            GuiControl, Main:Show, % "MainChapterBg" chapterIndex
            GuiControl, Main:Show, % "MainChapter" chapterIndex
        }
    }
    mainShownChapterCount := chapterNames.MaxIndex()
    mainShownChapterSection := mainCurrentSection
    mainChaptersVisible := true
    searchControl := mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch"
    otherSearchControl := mainCurrentSection = "answers" ? "MainUsefulSearch" : "MainAnswersSearch"
    for _, controlName in [otherSearchControl "Label", otherSearchControl, otherSearchControl "Clear", otherSearchControl "Accent"]
        GuiControl, Main:Hide, %controlName%
    GuiControlGet, currentSearch, Main:, %searchControl%
    if (currentSearch != "")
        GuiControl, Main:, %searchControl%,
    for _, controlName in [searchControl "Label", searchControl, searchControl "Clear", searchControl "Accent"]
        GuiControl, Main:Show, %controlName%
    SetTimer, MainRefreshSectionScroll, Off
}

MainHideChapters() {
    global mainChaptersVisible, mainShownChapterCount
    if (mainChaptersVisible) {
        Loop, %mainShownChapterCount% {
            GuiControl, Main:Hide, % "MainChapterBg" A_Index
            GuiControl, Main:Hide, % "MainChapter" A_Index
        }
        mainChaptersVisible := false
    }
    GuiControl, Main:Hide, MainChaptersBack
    GuiControl, Main:Show, MainSectionBody
    GuiControl, Main:Show, MainSectionScrollTrack
    GuiControl, Main:MoveDraw, MainSectionTitle, x230 y126 w776 h31
}

MainShowChapter(chapterName) {
    global mainCurrentSection, mainSelectedChapter
    SetTimer, MainSearchApply, Off
    mainSelectedChapter := chapterName
    MainHideChapters()
    GuiControl, Main:Show, MainChaptersBack
    GuiControl, Main:MoveDraw, MainSectionTitle, x370 y126 w250 h31
    GuiControl, Main:, MainSectionTitle, %chapterName%
    searchControl := mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch"
    GuiControlGet, currentSearch, Main:, %searchControl%
    if (currentSearch != "")
        GuiControl, Main:, %searchControl%,
    for _, controlName in [searchControl "Label", searchControl, searchControl "Clear", searchControl "Accent"]
        GuiControl, Main:Show, %controlName%
    MainRenderSearchSection(mainCurrentSection, searchControl)
    SetTimer, MainRefreshSectionScroll, 100
}

MainSearchChanged(sectionName, searchControl) {
    global mainSelectedChapter, mainActiveSearchQuery
    GuiControlGet, query, Main:, %searchControl%
    if (Trim(query) = "") {
        if (mainSelectedChapter = "")
            MainShowChapters()
        else
            MainShowChapter(mainSelectedChapter)
        return
    }
    if (mainActiveSearchQuery = "") {
        MainHideChapters()
        GuiControl, Main:Show, MainChaptersBack
        GuiControl, Main:MoveDraw, MainSectionTitle, x370 y126 w250 h31
        GuiControl, Main:, MainSectionTitle, Результаты поиска
    }
    MainRenderSearchSection(sectionName, searchControl)
    GuiControl, Main:Focus, %searchControl%
    SetTimer, MainRefreshSectionScroll, 100
}

MainRenderUsefulSection() {
    MainRenderSearchSection("useful", "MainUsefulSearch")
}

MainRenderAnswersSection() {
    MainRenderSearchSection("answers", "MainAnswersSearch")
}

MainRenderSearchSection(sectionName, searchControl) {
    global MainSectionBodyHwnd, AdminGender, mainActiveSearchQuery, mainLastHighlightedLine, mainSelectedChapter
    global mainAnswerEntries, shortcutRecords
    GuiControlGet, query, Main:, %searchControl%
    if (Trim(query) = "") {
        source := BinderGetSectionContent(sectionName)
        if (mainSelectedChapter != "")
            source := MainChapterContent(source, mainSelectedChapter)
        filtered := MainFilterReferenceContent(source, query)
        display := MainFormatReferenceText(sectionName, filtered, entryCount)
    } else if (Trim(query) = "." || Trim(query) = "/") {
        display := "Введите сокращение целиком."
        entryCount := 0
    } else {
        display := MainSearchAllSections(query, entryCount)
    }
    if (display = "") {
        display := "По запросу «" Trim(query) "» ничего не найдено."
        entryCount := 0
    }
    GuiControlGet, latestQuery, Main:, %searchControl%
    if !(latestQuery == query) {
        SetTimer, MainSearchApply, -50
        return
    }
    mainAnswerEntries := MainCollectActionEntries(display, sectionName, Trim(query))
    if (Trim(query) != "")
        subtitle := "Найдено: " . entryCount . "  ·  Ответы, наказания и полезное"
    else if (sectionName = "answers")
        subtitle := entryCount . " готовых ответов  ·  Выбранная форма: " (AdminGender = "female" ? "женская" : "мужская")
    else
        subtitle := entryCount . " сокращений  ·  Быстрый доступ к командам и подсказкам"
    GuiControl, Main:, MainSectionSubtitle, %subtitle%
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 0, "Ptr", 0)
    GuiControl, Main:, MainSectionBody, %display%
    nextPosition := 0
    for _, entry in mainAnswerEntries {
        heading := entry.heading
        VarSetCapacity(found, 24, 0)
        NumPut(nextPosition, found, 0, "Int")
        NumPut(-1, found, 4, "Int")
        NumPut(&heading, found, 8, "Ptr")
        entry.position := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x47C, "Ptr", 1, "Ptr", &found, "Int")
        if (entry.position < 0)
            break
        nextPosition := NumGet(found, 20, "Int")
    }
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x115, "Ptr", 6, "Ptr", 0)
    mainActiveSearchQuery := Trim(query)
    mainLastHighlightedLine := -1
    MainUpdateSectionScroll(false)
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 1, "Ptr", 0)
    DllCall("InvalidateRect", "Ptr", MainSectionBodyHwnd, "Ptr", 0, "Int", 1)
    GuiControlGet, latestQuery, Main:, %searchControl%
    if !(latestQuery == query)
        SetTimer, MainSearchApply, -50
}

MainCollectActionEntries(display, sectionName, query) {
    global shortcutRecords, mainSelectedChapter
    entries := []
    recordIndexes := {}
    for index, record in shortcutRecords
        recordIndexes[record.alias] := index
    resultSection := sectionName
    chapter := mainSelectedChapter
    for _, rawLine in StrSplit(display, "`n") {
        line := Trim(rawLine, "`r")
        if (query != "") {
            if (line = "ОТВЕТЫ")
                resultSection := "answers", chapter := ""
            else if (line = "НАКАЗАНИЯ")
                resultSection := "punishments", chapter := ""
            else if (line = "ПОЛЕЗНОЕ")
                resultSection := "useful", chapter := ""
            for _, name in ShortcutSectionChapters(resultSection) {
                StringUpper, title, name
                if (line = title) {
                    chapter := name
                    break
                }
            }
        }
        if !RegExMatch(line, "^◆  (.+)$", match)
            continue
        recordIndex := 0
        index := recordIndexes[ShortcutKey(match1)]
        if (index) {
            for _, ref in shortcutRecords[index].refs {
                if (ref.section = resultSection && ref.chapter = chapter && ref.alias = match1) {
                    recordIndex := index
                    break
                }
            }
        }
        entries.Push({heading: "◆  " match1, index: recordIndex, section: resultSection, chapter: chapter, position: -1})
    }
    return entries
}

MainSearchAllSections(query, ByRef entryCount) {
    entryCount := 0
    display := ""
    for _, section in [["answers", "ОТВЕТЫ"], ["punishments", "НАКАЗАНИЯ"], ["useful", "ПОЛЕЗНОЕ"]] {
        filtered := MainFilterReferenceContent(BinderGetSectionContent(section[1]), query)
        if (filtered = "")
            continue
        sectionText := MainFormatReferenceText(section[1], filtered, sectionCount)
        entryCount += sectionCount
        display .= section[2] "`r`n══════════════════════════════════`r`n`r`n" sectionText "`r`n"
    }
    return display
}

MainChapterContent(source, chapterName) {
    if (chapterName = "")
        return ""
    result := ""
    found := false
    for _, line in StrSplit(StrReplace(source, "`r`n", "`n"), "`n") {
        if RegExMatch(line, "^##\s+(.+)$", heading) {
            if (found)
                break
            found := heading1 = chapterName
        }
        if (found)
            result .= line "`r`n"
    }
    return result = "" ? "" : RTrim(result, "`r`n") . "`r`n"
}

MainFilterUsefulContent(source, query) {
    return MainFilterReferenceContent(source, query)
}

MainFilterReferenceContent(source, query) {
    query := Trim(query)
    if (query = "")
        return source
    StringLower, queryLower, query
    terms := StrSplit(RegExReplace(queryLower, "\s+", " "), " ")
    prefixAlias := StrLen(queryLower) > 1 && (SubStr(queryLower, 1, 1) = "." || SubStr(queryLower, 1, 1) = "/")
        && !InStr(queryLower, " ")
    normalized := StrReplace(StrReplace(source, "`r`n", "`n"), "`r", "`n")
    result := ""
    groupName := ""
    groupNameLower := ""
    groupVisible := false
    for _, line in StrSplit(normalized, "`n") {
        if RegExMatch(line, "^##\s+(.+)$", group) {
            groupName := group1
            StringLower, groupNameLower, groupName
            groupVisible := false
        } else if RegExMatch(line, "^(.+?)\s+-\s+(.*)$", item) {
            if (prefixAlias) {
                StringLower, aliasLower, item1
                matches := SubStr(aliasLower, 1, StrLen(queryLower)) = queryLower
            } else {
                StringLower, lineLower, line
                combined := lineLower . " " . groupNameLower
                matches := true
                for _, term in terms {
                    if (term != "" && !InStr(combined, term)) {
                        matches := false
                        break
                    }
                }
            }
            if (!matches)
                continue
            if (!groupVisible) {
                result .= "## " groupName "`r`n"
                groupVisible := true
            }
            result .= line "`r`n"
        }
    }
    return result
}

MainHighlightVisibleMatches(firstVisible := -1, redraw := true) {
    global MainSectionBodyHwnd, mainCurrentSection, mainActiveSearchQuery, mainLastHighlightedLine
    if (mainCurrentSection != "answers" && mainCurrentSection != "useful" && mainCurrentSection != "punishments")
        return
    query := Trim(RegExReplace(mainActiveSearchQuery, "\s+", " "))
    if (query = "")
        return
    if (firstVisible < 0)
        firstVisible := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xCE, "Ptr", 0, "Ptr", 0, "Int")
    if (firstVisible = mainLastHighlightedLine)
        return
    mainLastHighlightedLine := firstVisible
    rangeStart := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xBB, "Ptr", firstVisible, "Ptr", 0, "Int")
    rangeEnd := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xBB, "Ptr", firstVisible + 25, "Ptr", 0, "Int")
    if (rangeStart < 0)
        return
    VarSetCapacity(savedSelection, 8, 0)
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x434, "Ptr", 0, "Ptr", &savedSelection)
    VarSetCapacity(format, 116, 0)
    NumPut(116, format, 0, "UInt")
    NumPut(0x44000000, format, 4, "UInt") ; Цвет текста и фон совпадения.
    NumPut(0xFFFFFF, format, 20, "UInt")
    NumPut(0x7934EA, format, 96, "UInt")
    if (redraw)
        DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 0, "Ptr", 0)
    for _, term in StrSplit(query, " ") {
        if (term = "")
            continue
        nextPosition := rangeStart
        Loop {
            VarSetCapacity(found, 24, 0)
            NumPut(nextPosition, found, 0, "Int")
            NumPut(rangeEnd, found, 4, "Int")
            NumPut(&term, found, 8, "Ptr")
            position := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x47C, "Ptr", 1, "Ptr", &found, "Ptr")
            if (position = -1)
                break
            matchEnd := NumGet(found, 20, "Int")
            if (matchEnd <= nextPosition)
                break
            DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x437, "Ptr", 0, "Ptr", &found + 16)
            DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x444, "Ptr", 1, "Ptr", &format)
            nextPosition := matchEnd
        }
    }
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x437, "Ptr", 0, "Ptr", &savedSelection)
    currentFirst := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xCE, "Ptr", 0, "Ptr", 0, "Int")
    if (currentFirst != firstVisible)
        DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB6, "Ptr", 0, "Int", firstVisible - currentFirst)
    if (redraw) {
        DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 1, "Ptr", 0)
        DllCall("InvalidateRect", "Ptr", MainSectionBodyHwnd, "Ptr", 0, "Int", 1)
    }
}

MainFormatReferenceText(sectionFile, sectionText, ByRef entryCount) {
    entryCount := 0
    if (sectionFile = "info")
        return sectionText

    normalized := StrReplace(StrReplace(sectionText, "`r`n", "`n"), "`r", "`n")
    lines := StrSplit(normalized, "`n")
    display := ""
    currentAlias := ""
    currentBody := ""

    for index, line in lines {
        line := Trim(line, " `t")
        if (line = "")
            continue

        if RegExMatch(line, "^##\s+(.+)$", group) {
            if (currentAlias != "") {
                display .= MainFormatReferenceEntry(sectionFile, currentAlias, currentBody)
                entryCount++
                currentAlias := ""
            }
            groupTitle := group1
            StringUpper, groupTitle, groupTitle
            display .= groupTitle . "`r`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`r`n`r`n"
            continue
        }

        if RegExMatch(line, "^Часть\s+(\d+)$", part) {
            if (currentAlias != "") {
                display .= MainFormatReferenceEntry(sectionFile, currentAlias, currentBody)
                entryCount++
                currentAlias := ""
            }
            display .= "ЧАСТЬ " . part1 . "`r`n──────────────────────────────────`r`n`r`n"
            continue
        }

        if RegExMatch(line, "^(.+?)\s+-\s+(.*)$", item) {
            if (currentAlias != "") {
                display .= MainFormatReferenceEntry(sectionFile, currentAlias, currentBody)
                entryCount++
            }
            currentAlias := item1
            currentBody := item2
        } else if (currentAlias != "") {
            currentBody .= " " . line
        }
    }

    if (currentAlias != "") {
        display .= MainFormatReferenceEntry(sectionFile, currentAlias, currentBody)
        entryCount++
    }
    return Trim(display, "`r`n") . "`r`n"
}

MainFormatReferenceEntry(sectionFile, alias, body) {
    body := Trim(body)
    if (sectionFile = "skills" && RegExMatch(body, "^(.+?)\s+-\s+(.*)$", skill)) {
        title := skill1
        body := skill2
        StringUpper, title, title
        firstLetter := SubStr(body, 1, 1)
        StringUpper, firstLetter, firstLetter
        body := firstLetter . SubStr(body, 2)
        heading := "◆  " . title . "`r`n     " . alias
    } else {
        heading := "◆  " . alias
    }
    body := RegExReplace(body, "([.!?])\s+(?=[А-ЯЁ])", "$1`r`n")
    if (StrLen(body) > 180)
        body := RegExReplace(body, ";\s+", ";`r`n")
    return heading . "`r`n" . body . "`r`n`r`n──────────────────────────────────`r`n`r`n"
}
; Поле «Ваш статик»; внутреннее имя Dinamic сохранено для совместимости с Settings.ini.
SaveData1: 
Gui, Main: Submit, NoHide
IniWrite, %Dinamic%, %A_ScriptDir%\res\Settings.ini, ID, Dinamic
sleep 200
return

;настройки
SaveData:
Gui, Main: Submit, NoHide
if (GenderMale = GenderFemale) {
    MsgBox, 48, Пол администратора, Выберите один вариант: мужской или женский.
    return
}
GreetingHotkey := NormalizeBinderHotkey(GreetingHotkey)
if (GreetingHotkey = "") {
    MsgBox, 48, Клавиша приветствия, Выберите клавишу приветствия в настройках.
    return
}
Hot1 := NormalizeBinderHotkey(Hot1)
Hot2 := NormalizeBinderHotkey(Hot2)
Hot3 := NormalizeBinderHotkey(Hot3)
Hot4 := NormalizeBinderHotkey(Hot4)
Hot5 := NormalizeBinderHotkey(Hot5)
Hot6 := NormalizeBinderHotkey(Hot6)
Hot7 := NormalizeBinderHotkey(Hot7)
Hot8 := NormalizeBinderHotkey(Hot8)
Hot9 := NormalizeBinderHotkey(Hot9)
Hot10 := NormalizeBinderHotkey(Hot10)
Hot11 := NormalizeBinderHotkey(Hot11)
Hot12 := NormalizeBinderHotkey(Hot12)
Hot13 := NormalizeBinderHotkey(Hot13)
Hot14 := NormalizeBinderHotkey(Hot14)
Hot15 := NormalizeBinderHotkey(Hot15)
Hot16 := NormalizeBinderHotkey(Hot16)
Hot17 := NormalizeBinderHotkey(Hot17)
Hot18 := NormalizeBinderHotkey(Hot18)
Hot19 := NormalizeBinderHotkey(Hot19)
Hot20 := NormalizeBinderHotkey(Hot20)
greetingConflict := GreetingConflictIndex(GreetingHotkey, [Hot1, Hot2, Hot3, Hot4, Hot5
    , Hot6, Hot7, Hot8, Hot9, Hot10, Hot11, Hot12, Hot13, Hot14, Hot15
    , Hot16, Hot17, Hot18, Hot19, Hot20])
if (greetingConflict < 0) {
    MsgBox, 48, Клавиша приветствия, Ctrl+F9 и Ctrl+F10 заняты перезапуском и закрытием биндера. Выберите другое сочетание.
    return
}
if (greetingConflict > 0) {
    MsgBox, 48, Клавиша приветствия, Выбранная клавиша уже назначена на бинд №%greetingConflict%. Выберите другое сочетание.
    return
}
if (Hot13 != "") {
    punishmentKey := PhysicalBinderHotkey(Hot13)
    allHotkeys := [Hot1, Hot2, Hot3, Hot4, Hot5, Hot6, Hot7, Hot8, Hot9, Hot10
        , Hot11, Hot12, Hot13, Hot14, Hot15, Hot16, Hot17, Hot18, Hot19, Hot20]
    for otherIndex, otherHotkey in allHotkeys {
        if (otherIndex != 13 && otherHotkey != "" && PhysicalBinderHotkey(otherHotkey) = punishmentKey) {
            MsgBox, 48, Совпадающие клавиши, Клавиша наказаний уже назначена на бинд №%otherIndex%. Выберите разные клавиши.
            return
        }
    }
}
AdminGender := GenderFemale ? "female" : "male"
IniWrite, %Radio1%, %A_ScriptDir%\res\Settings.ini, Resolution, 1920x1080
IniWrite, %Radio3%, %A_ScriptDir%\res\Settings.ini, Resolution, 1680x1050
IniWrite, %Radio2%, %A_ScriptDir%\res\Settings.ini, Resolution, 1600x900
IniWrite, %Radio4%, %A_ScriptDir%\res\Settings.ini, Resolution, 1366x768
IniWrite, %Radio5%, %A_ScriptDir%\res\Settings.ini, Resolution, 1280x960
IniWrite, %Radio6%, %A_ScriptDir%\res\Settings.ini, Resolution, 1920x10802
IniWrite, %Radio7%, %A_ScriptDir%\res\Settings.ini, Resolution, 1280х1024
IniWrite, %Radio17%, %A_ScriptDir%\res\Settings.ini, Resolution, 2560x1440

IniWrite, %Radio8%, %A_ScriptDir%\res\Settings.ini, Login Commands, /hidecheatinfo
IniWrite, %Radio9%, %A_ScriptDir%\res\Settings.ini, Login Commands, /showcheats
IniWrite, %Radio10%, %A_ScriptDir%\res\Settings.ini, Login Commands, /dl
IniWrite, %Radio11%, %A_ScriptDir%\res\Settings.ini, Login Commands, /esp 3
IniWrite, %Radio12%, %A_ScriptDir%\res\Settings.ini, Login Commands, /templeader
IniWrite, %Radio13%, %A_ScriptDir%\res\Settings.ini, Login Commands, /chide
IniWrite, %Radio14%, %A_ScriptDir%\res\Settings.ini, Login Commands, /zzdebug
IniWrite, %Radio15%, %A_ScriptDir%\res\Settings.ini, Login Commands, /objdl
IniWrite, %Radio16%, %A_ScriptDir%\res\Settings.ini, Login Commands, /netstat
IniWrite, %LoginAdvToggle%, %A_ScriptDir%\res\Settings.ini, Login Commands, /advtoggle 0

IniWrite, %Hot1%, %A_ScriptDir%\res\Settings.ini, Binds, KEY1
IniWrite, %Hot2%, %A_ScriptDir%\res\Settings.ini, Binds, KEY2
IniWrite, %Hot3%, %A_ScriptDir%\res\Settings.ini, Binds, KEY3
IniWrite, %Hot4%, %A_ScriptDir%\res\Settings.ini, Binds, KEY4
IniWrite, %Hot5%, %A_ScriptDir%\res\Settings.ini, Binds, KEY5
IniWrite, %Hot6%, %A_ScriptDir%\res\Settings.ini, Binds, KEY6
IniWrite, %Hot7%, %A_ScriptDir%\res\Settings.ini, Binds, KEY7
IniWrite, %Hot8%, %A_ScriptDir%\res\Settings.ini, Binds, KEY8
IniWrite, %Hot9%, %A_ScriptDir%\res\Settings.ini, Binds, KEY9
IniWrite, %Hot10%, %A_ScriptDir%\res\Settings.ini, Binds, KEY10
IniWrite, %Hot11%, %A_ScriptDir%\res\Settings.ini, Binds, KEY11
IniWrite, %Hot12%, %A_ScriptDir%\res\Settings.ini, Binds, KEY12
IniWrite, %Hot13%, %A_ScriptDir%\res\Settings.ini, Binds, KEY13
IniWrite, %Hot14%, %A_ScriptDir%\res\Settings.ini, Binds, KEY14
IniWrite, %Hot15%, %A_ScriptDir%\res\Settings.ini, Binds, KEY15
IniWrite, %Hot16%, %A_ScriptDir%\res\Settings.ini, Binds, KEY16
IniWrite, %Hot17%, %A_ScriptDir%\res\Settings.ini, Binds, KEY17
IniWrite, %Hot18%, %A_ScriptDir%\res\Settings.ini, Binds, KEY18
IniWrite, %Hot19%, %A_ScriptDir%\res\Settings.ini, Binds, KEY19
IniWrite, %Hot20%, %A_ScriptDir%\res\Settings.ini, Binds, KEY20

IniWrite, %X%, %A_ScriptDir%\res\Settings.ini, Coords, X
IniWrite, %Y%, %A_ScriptDir%\res\Settings.ini, Coords, Y
IniWrite, %Fraction%, %A_ScriptDir%\res\Settings.ini, Fraction, Fraction

IniWrite, %dis%, %A_ScriptDir%\res\Settings.ini, Discord, dis
IniWrite, %gadis%, %A_ScriptDir%\res\Settings.ini, Discord, gadis
IniWrite, %zgadis%, %A_ScriptDir%\res\Settings.ini, Discord, zgadis
IniWrite, %GreetingHotkey%, %A_ScriptDir%\res\Settings.ini, Greeting, Hotkey
IniWrite, %AdminGender%, %A_ScriptDir%\res\Settings.ini, Admin, Gender
Reload
return

;счетчик
mess: 
labelgo:
if (Radio17 == 1)
{
SendInput, {Enter}
Sleep 1000
PixelGetColor, color, 253, 56, Alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  ) | ( Var1 = 0x4415B0 )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (radio1 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 190, 42	
PixelGetColor, color, 190, 42 alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  ) | ( Var1 = 0x4415B0 )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio2 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 152, 45
PixelGetColor, color, 152, 45 alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio3 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 178, 54
PixelGetColor, color, 178, 54  alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio6 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 183, 55
PixelGetColor, color, 183, 55 alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio4 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 130, 40
PixelGetColor, color, 130, 40 alt
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio7 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 174, 51
PixelGetColor, color, 174, 51 alt 
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
else if (Radio5 == 1)
{
SendInput, {Enter}
Sleep 1000
MouseGetPos, 174, 51
PixelGetColor, color, 163, 51 alt 163, 51
Var1 = %color%
if ( Var1 = 0x005A1CE8  ) | ( Var1 = 0x005912FB  ) | ( Var1 = 0x008313FF  ) | ( Var1 = 0x006619E9  )
{
counter++
GoSub, UpdateCounter
Clipboard :=
}
}
return 

UpdateCounter1:
IniWrite, %DayANS%, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
IniRead, DayANS, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
IniWrite, %WeekANS%, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
IniRead, WeekANS, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
GuiControl, 1:, MyText, День: %DayANS%
GuiControl, 1:, MyTotalR, Неделя: %WeekANS%
return

UpdateCounter2:
DayANS-=1
WeekANS-=1
IniWrite, %DayANS%, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
IniRead, DayANS, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
IniWrite, %WeekANS%, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
IniRead, WeekANS, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
GuiControl, 1:, MyText, День: %DayANS%
GuiControl, 1:, MyTotalR, Неделя: %WeekANS%
return

UpdateCounter:
DayANS+=1
WeekANS+=1
IniWrite, %DayANS%, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
IniRead, DayANS, %A_ScriptDir%\res\Settings.ini, ANS, DayANS
IniWrite, %WeekANS%, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
IniRead, WeekANS, %A_ScriptDir%\res\Settings.ini, ANS, WeekANS
GuiControl, 1:, MyText, День: %DayANS%
GuiControl, 1:, MyTotalR, Неделя: %WeekANS%
return

Reports:
sendinput, {F11} 
sleep 50
mousemove 494, 161
return

F5:
SendInput, {F5}
return

; Памятка открывается поверх игры; поиск и страницы доступны по щелчку.
Cheatsheet:
if (Cheatsheet1 && WinActive("ahk_id " cheatsheetGuiHwnd)) {
    ControlGetFocus, focusedControl, % "ahk_id " cheatsheetGuiHwnd
    if RegExMatch(focusedControl, "i)^Edit")
        return
}
if (Cheatsheet1) {
    Gosub, CheatsheetClose
    return
}
Cheatsheet1 := true
CheatsheetPage := 1
CheatsheetSearchActive := false
cheatsheetRules := CheatsheetBuildRules()
cheatsheetFiltered := cheatsheetRules
Gui, Cheatsheet: Destroy
Gui, Cheatsheet: -Caption +Border +AlwaysOnTop +ToolWindow
Gui, Cheatsheet: Color, 12131A
Gui, Cheatsheet: Add, Progress, x0 y0 w1020 h78 c1B1D27 Background1B1D27 Disabled, 100
Gui, Cheatsheet: Add, Text, x260 y0 w344 h76 +BackgroundTrans gCheatsheetDrag
Gui, Cheatsheet: Font, s17 w700 cFFFFFF, Segoe UI
Gui, Cheatsheet: Add, Text, x24 y15 w230 h30 +BackgroundTrans gCheatsheetDrag, MAJESTIC
Gui, Cheatsheet: Font, s9 w600 cEA3479, Segoe UI
Gui, Cheatsheet: Add, Text, x26 y47 w230 h18 +BackgroundTrans gCheatsheetDrag, ADMIN  /  BINDER
Gui, Cheatsheet: Font, s10 w600 cD9DCE8, Segoe UI
Gui, Cheatsheet: Add, Text, x612 y27 w142 h28 +0x200 +0x100 Center Background292C38 gCheatsheetSearchToggle, ПОИСК
Gui, Cheatsheet: Add, Text, x772 y27 w174 h28 +0x200 +0x100 Center Background292C38 gCheatsheetDrag, ПАМЯТКА
Gui, Cheatsheet: Add, Progress, x772 y57 w174 h3 cEA3479 BackgroundEA3479 Disabled, 100
Gui, Cheatsheet: Font, s15 w400 cAEB1BF, Segoe UI
Gui, Cheatsheet: Add, Text, x972 y25 w30 h30 +0x200 +0x100 Center +BackgroundTrans gCheatsheetClose, ×
Gui, Cheatsheet: Add, Progress, x0 y77 w1020 h2 cEA3479 BackgroundEA3479 Disabled, 100

Gui, Cheatsheet: Font, s12 w700 cFFFFFF, Segoe UI
Gui, Cheatsheet: Add, Text, x24 y99 w460 h28 +BackgroundTrans, Фракции
Gui, Cheatsheet: Font, s9 c989DAD, Segoe UI
Gui, Cheatsheet: Add, Text, x696 y105 w300 h19 Right +BackgroundTrans, ID фракций для команд
fractions := CheatsheetReadRows("fractions.txt", 12)
for fractionSlot, fraction in fractions {
    fractionId := fraction[1]
    fractionName := fraction[2]
    chipX := 24 + Mod(fractionSlot - 1, 6) * 162
    chipY := 137 + Floor((fractionSlot - 1) / 6) * 31
    Gui, Cheatsheet: Add, Progress, % "x" chipX " y" chipY " w154 h26 c272A36 Background272A36 Disabled", 100
    Gui, Cheatsheet: Font, s9 w700 cEA3479, Segoe UI
    Gui, Cheatsheet: Add, Text, % "x" (chipX + 12) " y" chipY " w26 h26 +0x200 +BackgroundTrans", %fractionId%
    Gui, Cheatsheet: Font, s9 w600 cFFFFFF, Segoe UI
    Gui, Cheatsheet: Add, Text, % "x" (chipX + 43) " y" chipY " w105 h26 +0x200 +BackgroundTrans", %fractionName%
}
Gui, Cheatsheet: Add, Progress, x24 y205 w972 h1 c343746 Background343746 Disabled, 100
Gui, Cheatsheet: Font, s12 w700 cFFFFFF, Segoe UI
Gui, Cheatsheet: Add, Text, x24 y215 w280 h28 +BackgroundTrans, Наказания
Gui, Cheatsheet: Font, s9 c989DAD, Segoe UI
Gui, Cheatsheet: Add, Text, x537 y220 w459 h20 Right +BackgroundTrans vCheatsheetRulesHint, Сроки из вашей памятки — сверяйте с форумом
Gui, Cheatsheet: Add, Progress, x537 y215 w390 h29 c272A36 Background272A36 Disabled Hidden vCheatsheetSearchBg, 100
Gui, Cheatsheet: Font, s9 cFFFFFF, Segoe UI
Gui, Cheatsheet: Add, Edit, x546 y219 w372 h21 vCheatsheetSearchInput gCheatsheetSearchChanged hwndCheatsheetSearchHwnd Background272A36 -Border -E0x200 Hidden
DllCall("SendMessage", "Ptr", CheatsheetSearchHwnd, "UInt", 0x1501, "Ptr", 1, "WStr", "Название или санкция")
Gui, Cheatsheet: Add, Progress, x934 y215 w62 h29 c292C38 Background292C38 Disabled Hidden vCheatsheetClearBg, 100
Gui, Cheatsheet: Font, s9 w700 cFFFFFF, Segoe UI
Gui, Cheatsheet: Add, Text, x934 y215 w62 h29 +0x200 +0x100 Center +BackgroundTrans gCheatsheetSearchClear Hidden vCheatsheetClearButton, ×

Loop, 10 {
    slot := A_Index
    cardX := slot > 5 ? 518 : 24
    cardY := 253 + Mod(slot - 1, 5) * 78
    Gui, Cheatsheet: Add, Progress, % "x" cardX " y" cardY " w478 h72 c272A36 Background272A36 Disabled vCheatsheetCardBg" slot, 100
    Gui, Cheatsheet: Font, s10 w700 cFFFFFF, Segoe UI
    Gui, Cheatsheet: Add, Text, % "x" (cardX + 12) " y" (cardY + 8) " w454 h22 +BackgroundTrans vCheatsheetCardTitle" slot
    Gui, Cheatsheet: Font, s9 w400 cD4D5E0, Segoe UI
    Gui, Cheatsheet: Add, Text, % "x" (cardX + 12) " y" (cardY + 32) " w454 h37 +BackgroundTrans vCheatsheetCardPenalty" slot
}
Gui, Cheatsheet: Add, Progress, x24 y648 w972 h1 c343746 Background343746 Disabled, 100
Gui, Cheatsheet: Add, Progress, x24 y660 w150 h29 c292C38 Background292C38 Disabled, 100
Gui, Cheatsheet: Font, s9 w700 cFFFFFF, Segoe UI
Gui, Cheatsheet: Add, Text, x24 y660 w150 h29 +0x200 +0x100 Center +BackgroundTrans gCheatsheetPrev, ← НАЗАД
Gui, Cheatsheet: Font, s9 w700 cEA3479, Segoe UI
Gui, Cheatsheet: Add, Text, x445 y660 w130 h29 +0x200 +0x100 Center +BackgroundTrans vCheatsheetPageNumber
Gui, Cheatsheet: Add, Progress, x846 y660 w150 h29 cEA3479 BackgroundEA3479 Disabled, 100
Gui, Cheatsheet: Font, s9 w700 cFFFFFF, Segoe UI
Gui, Cheatsheet: Add, Text, x846 y660 w150 h29 +0x200 +0x100 Center +BackgroundTrans gCheatsheetNext, ДАЛЕЕ →
Gui, Cheatsheet: Font, s12 w600 c989DAD, Segoe UI
Gui, Cheatsheet: Add, Text, x195 y400 w630 h50 +0x200 Center +BackgroundTrans Hidden vCheatsheetNoResults, По вашему запросу ничего не найдено
CheatsheetRenderPage()
sheetX := Max(0, Min(X2 + 0, A_ScreenWidth - 1020))
sheetY := Max(0, Min(Y2 + 0, A_ScreenHeight - 704))
Gui, Cheatsheet: Show, % "NoActivate x" sheetX " y" sheetY " w1020 h704", Памятка администрации
Gui, Cheatsheet: +LastFound
cheatsheetGuiHwnd := WinExist()
WinSet, Transparent, 245, % "ahk_id " cheatsheetGuiHwnd
if (KEY14 != "") {
    Hotkey, IfWinActive, % "ahk_id " cheatsheetGuiHwnd
    Hotkey, % "~" PhysicalBinderHotkey(KEY14), Cheatsheet, On UseErrorLevel
    Hotkey, IfWinActive, ahk_exe GTA5.exe
}
return

CheatsheetPrev:
CheatsheetPage := CheatsheetPage = 1 ? CheatsheetPageCount : CheatsheetPage - 1
CheatsheetRenderPage()
return

CheatsheetNext:
CheatsheetPage := CheatsheetPage = CheatsheetPageCount ? 1 : CheatsheetPage + 1
CheatsheetRenderPage()
return

CheatsheetSearchToggle:
CheatsheetSearchActive := !CheatsheetSearchActive
if (CheatsheetSearchActive) {
    GuiControl, Cheatsheet:Hide, CheatsheetRulesHint
    GuiControl, Cheatsheet:Show, CheatsheetSearchBg
    GuiControl, Cheatsheet:Show, CheatsheetSearchInput
    GuiControl, Cheatsheet:Show, CheatsheetClearBg
    GuiControl, Cheatsheet:Show, CheatsheetClearButton
    WinActivate, % "ahk_id " cheatsheetGuiHwnd
    GuiControl, Cheatsheet:Focus, CheatsheetSearchInput
} else {
    GuiControl, Cheatsheet:Hide, CheatsheetSearchBg
    GuiControl, Cheatsheet:Hide, CheatsheetSearchInput
    GuiControl, Cheatsheet:Hide, CheatsheetClearBg
    GuiControl, Cheatsheet:Hide, CheatsheetClearButton
    GuiControl, Cheatsheet:Show, CheatsheetRulesHint
    GuiControl, Cheatsheet:, CheatsheetSearchInput,
    CheatsheetApplySearch()
}
return

CheatsheetSearchChanged:
CheatsheetApplySearch()
return

CheatsheetSearchClear:
GuiControl, Cheatsheet:, CheatsheetSearchInput,
GuiControl, Cheatsheet:Focus, CheatsheetSearchInput
return

CheatsheetDrag:
DllCall("ReleaseCapture")
PostMessage, 0xA1, 2,,, % "ahk_id " cheatsheetGuiHwnd
return

CheatsheetClose:
CheatsheetGuiClose:
CheatsheetGuiEscape:
if (cheatsheetGuiHwnd && WinExist("ahk_id " cheatsheetGuiHwnd)) {
    WinGetPos, sheetSavedX, sheetSavedY,,, % "ahk_id " cheatsheetGuiHwnd
    if (sheetSavedX != "" && sheetSavedY != "") {
        X2 := sheetSavedX
        Y2 := sheetSavedY
        IniWrite, %X2%, %A_ScriptDir%\res\Settings.ini, Coords, X2
        IniWrite, %Y2%, %A_ScriptDir%\res\Settings.ini, Coords, Y2
    }
}
if (KEY14 != "" && cheatsheetGuiHwnd) {
    Hotkey, IfWinActive, % "ahk_id " cheatsheetGuiHwnd
    Hotkey, % "~" PhysicalBinderHotkey(KEY14), Off, UseErrorLevel
    Hotkey, IfWinActive, ahk_exe GTA5.exe
}
Cheatsheet1 := false
Gui, Cheatsheet: Destroy
cheatsheetGuiHwnd := 0
return

CheatsheetApplySearch() {
    global CheatsheetPage, cheatsheetRules, cheatsheetFiltered
    GuiControlGet, searchText, Cheatsheet:, CheatsheetSearchInput
    searchText := Trim(searchText)
    cheatsheetFiltered := []
    for _, rule in cheatsheetRules {
        if (searchText = "" || InStr(rule[1] . " " . rule[2], searchText, false))
            cheatsheetFiltered.Push(rule)
    }
    CheatsheetPage := 1
    CheatsheetRenderPage()
}

CheatsheetRenderPage() {
    global CheatsheetPage, CheatsheetPageCount, cheatsheetFiltered
    matchCount := cheatsheetFiltered.MaxIndex()
    if (matchCount = "")
        matchCount := 0
    CheatsheetPageCount := Max(1, Ceil(matchCount / 10))
    if (CheatsheetPage > CheatsheetPageCount)
        CheatsheetPage := CheatsheetPageCount
    Loop, 10 {
        slot := A_Index
        ruleIndex := (CheatsheetPage - 1) * 10 + slot
        bgName := "CheatsheetCardBg" . slot
        titleName := "CheatsheetCardTitle" . slot
        penaltyName := "CheatsheetCardPenalty" . slot
        if (ruleIndex > matchCount) {
            GuiControl, Cheatsheet:Hide, %bgName%
            GuiControl, Cheatsheet:Hide, %titleName%
            GuiControl, Cheatsheet:Hide, %penaltyName%
            continue
        }
        rule := cheatsheetFiltered[ruleIndex]
        GuiControl, Cheatsheet:, %titleName%, % rule[1]
        GuiControl, Cheatsheet:, %penaltyName%, % rule[2]
        GuiControl, Cheatsheet:Show, %bgName%
        GuiControl, Cheatsheet:Show, %titleName%
        GuiControl, Cheatsheet:Show, %penaltyName%
    }
    if (matchCount = 0) {
        GuiControl, Cheatsheet:Show, CheatsheetNoResults
        GuiControl, Cheatsheet:, CheatsheetPageNumber, 0 НАЙДЕНО
    } else {
        GuiControl, Cheatsheet:Hide, CheatsheetNoResults
        GuiControl, Cheatsheet:, CheatsheetPageNumber, % "СТРАНИЦА " CheatsheetPage " / " CheatsheetPageCount
    }
}

CheatsheetBuildRules() {
    return CheatsheetReadRows("memo_rules.txt")
}

CheatsheetReadRows(fileName, maxRows := 0) {
    rows := []
    rawText := BinderGetSectionContent(StrReplace(fileName, ".txt"))
    if (rawText = "") {
        MsgBox, 16, Памятка, % "Не найден встроенный раздел: " fileName
        return rows
    }
    normalized := StrReplace(StrReplace(rawText, "`r`n", "`n"), "`r", "`n")
    Loop, Parse, normalized, `n
    {
        line := Trim(A_LoopField)
        if (line = "" || SubStr(line, 1, 1) = "#")
            continue
        separator := InStr(line, "|")
        if (!separator)
            continue
        name := Trim(SubStr(line, 1, separator - 1))
        value := Trim(SubStr(line, separator + 1))
        if (name = "" || value = "")
            continue
        rows.Push([name, value])
        if (maxRows && rows.Length() >= maxRows)
            break
    }
    return rows
}

vac:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {t}
sleep 200
SendInput, /ainfect  0{left 2}
return

repm:
counter++
GoSub, UpdateCounter2
Clipboard :=
return

dimcar:
SendMessage, 0x50,, 0x4190419,, A
SendInput, {T}
Input, car, V, {ctrl}{Enter}
Sleep 750
SendInput, {T}
Sleep 200
SendInput, /getcar %car%{Enter}
Sleep 750
SendInput, {T}
Sleep 200
SendInput, /repair{Enter}
Sleep 750
SendInput, {T}
Sleep 200
SendInput, /setcardim %car% 5{Enter}
Sleep 1200
SendInput, {T}
Sleep 200
SendInput, /setcardim %car% 0{Enter}
Return

reshp:
SendInput, {T}
Input, hId, V, {ctrl} {Enter}
Sleep 750
SendInput, {T}
Sleep 200
SendInput,/hp %hId% 0{Enter}
Sleep 750
SendInput, {T}
Sleep 200
SendInput,/rescue %hId%{Enter}
Return

delv:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /delveh{Enter}
return

killplayer:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /hp  0{left 2}
return

; Команды наказаний хранятся в Punishment.txt и отправляются только из редактора.
PunishmentOpenFromGui:
punishmentFromGui := true
Gosub, PunishmentHandler
return

PunishmentHandler:
if (!punishmentFromGui && WinActive("ahk_id " mainGuiHwnd)) {
    ControlGetFocus, focusedControl, % "ahk_id " mainGuiHwnd
    if RegExMatch(focusedControl, "i)^Edit")
        return
    if RegExMatch(focusedControl, "i)^msctls_hotkey32") {
        ControlGet, focusedHwnd, Hwnd,, %focusedControl%, % "ahk_id " mainGuiHwnd
        if (focusedHwnd != mainPunishmentHotkeyHwnd)
            return
    }
}
punishmentFromGui := false
punishmentGameHwnd := WinActive("ahk_exe GTA5.exe")
if (!punishmentGameHwnd)
    punishmentGameHwnd := WinActive("ahk_exe ragemp_v.exe")
punishmentPath := A_ScriptDir . "\Punishment.txt"
FileRead, punishmentSavedText, %punishmentPath%
if (ErrorLevel)
    punishmentSavedText := ""
Gui, Punishment: Destroy
Gui, Punishment: -Caption +Border +AlwaysOnTop +OwnDialogs
Gui, Punishment: Color, 12131A, 1B1D27
Gui, Punishment: Add, Progress, x0 y0 w620 h78 c1B1D27 Background1B1D27 Disabled, 100
Gui, Punishment: Add, Text, x260 y0 w130 h76 +BackgroundTrans gPunishmentDrag
Gui, Punishment: Font, s17 w700 cFFFFFF, Segoe UI
Gui, Punishment: Add, Text, x24 y15 w230 h30 +BackgroundTrans gPunishmentDrag, MAJESTIC
Gui, Punishment: Font, s9 w600 cEA3479, Segoe UI
Gui, Punishment: Add, Text, x26 y47 w230 h18 +BackgroundTrans gPunishmentDrag, ADMIN  /  BINDER
Gui, Punishment: Font, s10 w600 cD9DCE8, Segoe UI
Gui, Punishment: Add, Text, x399 y27 w160 h28 +0x200 +0x100 Center Background292C38 gPunishmentDrag, НАКАЗАНИЯ
Gui, Punishment: Add, Progress, x399 y57 w160 h3 cEA3479 BackgroundEA3479 Disabled, 100
Gui, Punishment: Font, s15 w400 cAEB1BF, Segoe UI
Gui, Punishment: Add, Text, x575 y25 w30 h30 +0x200 +0x100 Center +BackgroundTrans gPunishmentCancel, ×
Gui, Punishment: Add, Progress, x0 y77 w620 h2 cEA3479 BackgroundEA3479 Disabled, 100
Gui, Punishment: Font, s15 w700 cFFFFFF, Segoe UI
Gui, Punishment: Add, Text, x24 y103 w560 h32 +BackgroundTrans, Выдача наказаний
Gui, Punishment: Font, s9 c989DAD, Segoe UI
Gui, Punishment: Add, Text, x24 y138 w560 h38 +BackgroundTrans, Вставьте команды: по одной в строке. Каждая строка должна начинаться с /.`nПосле отправки список останется в Punishment.txt.
Gui, Punishment: Add, Progress, x24 y188 w572 h236 c1B1D27 Background1B1D27 Disabled, 100
Gui, Punishment: Font, s10 cFFFFFF, Segoe UI
Gui, Punishment: Add, Edit, x32 y196 w556 h220 vPunishmentCommands hwndPunishmentEditHwnd +VScroll -Border -E0x200 Background1B1D27, %punishmentSavedText%
DllCall("SendMessage", "Ptr", PunishmentEditHwnd, "UInt", 0xD3, "Ptr", 3, "Ptr", 8 | (8 << 16))
Gui, Punishment: Font, s9 c989DAD, Segoe UI
Gui, Punishment: Add, Text, x24 y434 w560 h20 +BackgroundTrans, Проверьте ID и срок наказания перед отправкой.
Gui, Punishment: Font, s10 w700 cFFFFFF, Segoe UI
Gui, Punishment: Add, Progress, x24 y468 w130 h36 c292C38 Background292C38 Disabled, 100
Gui, Punishment: Add, Text, x24 y468 w130 h36 +0x200 +0x100 Center +BackgroundTrans gPunishmentCancel, ЗАКРЫТЬ
Gui, Punishment: Add, Progress, x350 y468 w246 h36 cEA3479 BackgroundEA3479 Disabled, 100
Gui, Punishment: Add, Text, x350 y468 w246 h36 +0x200 +0x100 Center +BackgroundTrans gPunishmentSaveAndSend, СОХРАНИТЬ И ОТПРАВИТЬ
Gui, Punishment: Show, w620 h522, Выдача наказаний
Gui, Punishment: +LastFound
punishmentGuiHwnd := WinExist()
return

PunishmentDrag:
DllCall("ReleaseCapture")
PostMessage, 0xA1, 2,,, % "ahk_id " punishmentGuiHwnd
return

PunishmentSaveAndSend:
Gui, Punishment: Submit, NoHide
punishmentLines := []
normalizedPunishment := StrReplace(StrReplace(PunishmentCommands, "`r`n", "`n"), "`r", "`n")
for lineNumber, rawPunishmentLine in StrSplit(normalizedPunishment, "`n") {
    punishmentLine := Trim(rawPunishmentLine, " `t")
    if (punishmentLine = "")
        continue
    if (SubStr(punishmentLine, 1, 1) != "/") {
        MsgBox, 48, Выдача наказаний, Строка %lineNumber% не начинается с /. Исправьте её и повторите отправку.
        return
    }
    punishmentLines.Push(punishmentLine)
}
if (punishmentLines.MaxIndex() = "") {
    MsgBox, 48, Выдача наказаний, Вставьте хотя бы одну команду.
    return
}
punishmentTextToSave := ""
for _, punishmentLine in punishmentLines
    punishmentTextToSave .= punishmentLine . "`r`n"
punishmentFile := FileOpen(punishmentPath, "w", "UTF-8")
if !IsObject(punishmentFile) {
    MsgBox, 16, Выдача наказаний, Не удалось сохранить Punishment.txt.
    return
}
punishmentFile.Write(punishmentTextToSave)
punishmentFile.Close()
gameHwnd := punishmentGameHwnd
if (!gameHwnd || !WinExist("ahk_id " gameHwnd))
    gameHwnd := WinExist("ahk_exe GTA5.exe")
if (!gameHwnd)
    gameHwnd := WinExist("ahk_exe ragemp_v.exe")
if (!gameHwnd) {
    MsgBox, 48, Выдача наказаний, Команды сохранены. Откройте игру и нажмите «Сохранить и отправить» ещё раз.
    return
}
Gui, Punishment: Hide
WinActivate, % "ahk_id " gameHwnd
WinWaitActive, % "ahk_id " gameHwnd, , 3
if (ErrorLevel) {
    Gui, Punishment: Show
    MsgBox, 48, Выдача наказаний, Команды сохранены, но не удалось переключиться на окно игры.
    return
}
sentPunishmentCount := 0
totalPunishmentCount := punishmentLines.MaxIndex()
Gosub, PunishmentProgressShow
for _, punishmentLine in punishmentLines {
    if (!WinActive("ahk_id " gameHwnd)) {
        Gosub, PunishmentProgressHide
        Gui, Punishment: Show
        MsgBox, 48, Выдача наказаний, Отправка остановлена: фокус ушёл из игры. Отправлено %sentPunishmentCount% команд.
        return
    }
    SendInput, {t}
    Sleep, 350
    if (!WinActive("ahk_id " gameHwnd)) {
        Gosub, PunishmentProgressHide
        Gui, Punishment: Show
        MsgBox, 48, Выдача наказаний, Отправка остановлена: фокус ушёл из игры. Отправлено %sentPunishmentCount% команд.
        return
    }
    SendInput, {Raw}%punishmentLine%
    Sleep, 200
    if (!WinActive("ahk_id " gameHwnd)) {
        Gosub, PunishmentProgressHide
        Gui, Punishment: Show
        MsgBox, 48, Выдача наказаний, Отправка остановлена: фокус ушёл из игры. Отправлено %sentPunishmentCount% команд.
        return
    }
    SendInput, {Enter}
    sentPunishmentCount++
    GuiControl, PunishmentProgress:, PunishmentProgressText, % "Выдано " sentPunishmentCount "/" totalPunishmentCount
    Sleep, 500
}
Gui, Punishment: Destroy
SetTimer, PunishmentProgressHide, -2500
return

PunishmentProgressShow:
SetTimer, PunishmentProgressHide, Off
Gui, PunishmentProgress: Destroy
Gui, PunishmentProgress: +AlwaysOnTop -Caption +ToolWindow +E0x20
Gui, PunishmentProgress: Color, 1B1D27
Gui, PunishmentProgress: Add, Progress, x0 y0 w240 h3 cEA3479 BackgroundEA3479 Disabled, 100
Gui, PunishmentProgress: Font, s11 w700 cFFFFFF, Segoe UI
Gui, PunishmentProgress: Add, Text, x8 y5 w224 h34 Center +0x200 +BackgroundTrans vPunishmentProgressText, % "Выдано 0/" totalPunishmentCount
punishmentProgressX := (A_ScreenWidth - 240) // 2
Gui, PunishmentProgress: Show, % "NoActivate x" punishmentProgressX " y20 w240 h44", Отправка наказаний
Gui, PunishmentProgress: +LastFound
punishmentProgressHwnd := WinExist()
WinSet, Transparent, 170, % "ahk_id " punishmentProgressHwnd
return

PunishmentProgressHide:
Gui, PunishmentProgress: Destroy
return

PunishmentCancel:
PunishmentGuiClose:
PunishmentGuiEscape:
Gui, Punishment: Destroy
return

gcar:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /getcar{Space}
return

gm:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /gm{Enter}
return

resc:
SendInput, {sc14}
Sleep 50
SendInput, /rescue{Space}
return

gh:
SendInput, {sc14}
Sleep 50
SendInput, /gh{Space}
return

chide:
SendInput, {sc14}
Sleep 50
SendInput, /chide{Enter}
return

zzdebug:
SendInput, {sc14}
Sleep 50
SendInput, /zzdebug{Enter}
return

mtp:
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 50
SendInput, /mtp{Enter}
return

vhod:
SendMessage, 0x50,, 0x4090409
SendInput, {T}
Sleep 300
SendInput, /gm{Enter}
Sleep 300
if (Radio11==1)
{
SendInput, {T}
Sleep 300
SendInput, /esp 3{Enter}
Sleep 300
}
if (Radio13==1)
{
SendInput, {T}
Sleep 300
SendInput, /chide{Enter}
Sleep 300
}
if (Radio9==1)
{
SendInput, {T}
Sleep 300
SendInput, /showcheats{Enter}
Sleep 300
}
if (Radio8==1)
{
SendInput, {T}
Sleep 300
SendInput, /hidecheatinfo{Enter}
Sleep 300
}
if (Radio10==1)
{
SendInput, {T}
Sleep 300
SendInput, /dl{Enter}
Sleep 300
}
if (Radio14==1)
{
SendInput, {T}
Sleep 300
SendInput, /zzdebug{Enter}
Sleep 300
}
if (Radio15==1)
{
SendInput, {T}
Sleep 300
SendInput, /objdl{Enter}
Sleep 300
}
if (Radio16==1)
{
SendInput, {T}
Sleep 300
SendInput, /netstat{Enter}
Sleep 300
}
if (LoginAdvToggle == 1)
{
SendInput, {T}
Sleep 300
SendInput, /advtoggle 0{Enter}
Sleep 300
}
if (Radio12==1)
{
SendInput, {T}
Sleep 300
SendInput, /templeader %Fraction%{Enter}
}
return

rep:
counter++
GoSub, UpdateCounter
Clipboard :=
return

; ===== РЕДАКТОР СОКРАЩЕНИЙ =====
#If
; Редактор хранит пользовательские записи и список отключённых сокращений отдельно от поставляемых справочников.
ShortcutEditorOpen:
SetTimer, ShortcutEditorDeferredSelection, Off
Gui, Shortcuts: Destroy
shortcutLastAliasInput := ""
shortcutPaintRow := 0
shortcutPaintRect := 0
shortcutListVisibleRows := 0
shortcutPreviousAction := 0
shortcutOtherTextManual := false
Gui, Shortcuts: +OwnerMain -Caption +Border +HwndshortcutEditorHwnd
Gui, Shortcuts: Color, 12131A, 1B1D27
Gui, Shortcuts: Add, Progress, x0 y0 w980 h78 c1B1D27 Background1B1D27 Disabled, 100
Gui, Shortcuts: Add, Text, x250 y0 w446 h76 +BackgroundTrans gShortcutEditorDrag
Gui, Shortcuts: Font, s17 w700 cFFFFFF, Segoe UI
Gui, Shortcuts: Add, Text, x24 y15 w230 h30 +BackgroundTrans gShortcutEditorDrag, MAJESTIC
Gui, Shortcuts: Font, s9 w600 c989DAD, Segoe UI
Gui, Shortcuts: Add, Text, x26 y47 w230 h18 +BackgroundTrans gShortcutEditorDrag, ADMIN  /  BINDER
Gui, Shortcuts: Font, s10 w700 cFFFFFF, Segoe UI
Gui, Shortcuts: Add, Text, x696 y27 w224 h28 +0x200 +0x100 Center Background292C38 gShortcutEditorDrag, РЕДАКТОР СОКРАЩЕНИЙ
Gui, Shortcuts: Add, Progress, x696 y57 w224 h3 cEA3479 BackgroundEA3479 Disabled, 100
Gui, Shortcuts: Font, s15 w400 cAEB1BF, Segoe UI
Gui, Shortcuts: Add, Text, x934 y25 w30 h30 +0x200 +0x100 Center +BackgroundTrans gShortcutEditorClose, ×
Gui, Shortcuts: Add, Progress, x0 y77 w980 h2 cEA3479 BackgroundEA3479 Disabled, 100

Gui, Shortcuts: Add, Progress, x16 y96 w948 h508 c1B1D27 Background1B1D27 Disabled, 100
Gui, Shortcuts: Font, s9 w600 cEA3479, Segoe UI
Gui, Shortcuts: Add, Text, x30 y112 w200 +BackgroundTrans, ДЕЙСТВИЕ
Gui, Shortcuts: Add, Text, x250 y112 w230 +BackgroundTrans, РАЗДЕЛ
Gui, Shortcuts: Add, Text, x500 y112 w450 +BackgroundTrans, ГЛАВА
Gui, Shortcuts: Font, s10 w400 cE9EAF0, Segoe UI
OnMessage(0x2B, "ShortcutDrawComboItem")
; Owner draw с CBS_HASSTRINGS сохраняет стандартный выбор и навигацию клавиатурой.
Gui, Shortcuts: Add, DropDownList, x30 y136 w200 r12 +0x210 Choose1 AltSubmit vShortcutAction hwndshortcutActionHwnd gShortcutEditorRefresh, Добавить|Удалить|Изменить
Gui, Shortcuts: Add, DropDownList, x250 y136 w230 r12 +0x210 Choose1 AltSubmit vShortcutSection hwndshortcutSectionHwnd gShortcutEditorSection, Ответы|Полезное|Наказания
Gui, Shortcuts: Add, DropDownList, x500 y136 w450 r12 +0x210 vShortcutChapter hwndshortcutChapterHwnd gShortcutEditorRefresh
for _, comboHwnd in [shortcutActionHwnd, shortcutSectionHwnd, shortcutChapterHwnd]
    ShortcutStyleCombo(comboHwnd)
Gui, Shortcuts: Font, s10 w400 cE9EAF0, Segoe UI
Gui, Shortcuts: Add, Text, x30 y184 w920 +BackgroundTrans vShortcutAliasLabel, Сокращение (например, .ку)
Gui, Shortcuts: Add, Edit, x30 y210 w330 h30 -Border Background343746 Limit40 vShortcutAlias hwndshortcutAliasHwnd gShortcutEditorAliasChanged
Gui, Shortcuts: Add, Text, x380 y215 w570 vShortcutTranslit hwndshortcutTranslitHwnd
Gui, Shortcuts: Add, Text, x30 y260 w450 +BackgroundTrans vShortcutTextLabel, % AdminGender = "female" ? "Основной текст (женский род)" : "Основной текст (мужской род)"
Gui, Shortcuts: Add, Text, x500 y260 w450 +BackgroundTrans vShortcutOtherTextLabel, % AdminGender = "female" ? "Текст в мужском роде" : "Текст в женском роде"
Gui, Shortcuts: Add, Edit, x30 y286 w450 h303 +Multi +Wrap +VScroll -Border Background343746 Limit2000 vShortcutText hwndshortcutTextHwnd gShortcutEditorTextChanged
Gui, Shortcuts: Add, Edit, x500 y286 w450 h303 +Multi +Wrap +VScroll -Border Background343746 Limit2000 vShortcutOtherText hwndshortcutOtherTextHwnd gShortcutEditorOtherTextChanged
Gui, Shortcuts: Add, Progress, x30 y183 w920 h26 c292C38 Background292C38 Disabled vShortcutListHeaderBg, 100
Gui, Shortcuts: Add, Text, x38 y183 w157 h26 +0x200 +BackgroundTrans vShortcutListHeaderAlias, Сокращение
Gui, Shortcuts: Add, Text, x203 y183 w729 h26 +0x200 +BackgroundTrans vShortcutListHeaderText, Текст
Gui, Shortcuts: Add, ListView, x30 y209 w920 h252 -Multi -Hdr NoSortHdr -Border Background292C38 AltSubmit vShortcutList hwndshortcutListHwnd gShortcutEditorSelect, Сокращение|Текст
ShortcutHookListPainting(shortcutEditorHwnd, shortcutListHwnd)
shortcutListFont := DllCall("SendMessageW", "Ptr", shortcutListHwnd, "UInt", 0x31, "Ptr", 0, "Ptr", 0, "Ptr")
; LVS_EX_DOUBLEBUFFER: список перерисовывается без промежуточных кадров.
SendMessage, 0x1036, 0x10000, 0x10000,, % "ahk_id " shortcutListHwnd
Gui, Shortcuts: Add, Edit, x30 y474 w920 h115 ReadOnly -Border Background292C38 vShortcutPreview hwndshortcutPreviewHwnd
shortcutScrollTracks := {}
shortcutScrollAreas := [{hwnd: shortcutTextHwnd, x: 462, y: 286, h: 303, type: "edit"}
    , {hwnd: shortcutOtherTextHwnd, x: 932, y: 286, h: 303, type: "edit"}
    , {hwnd: shortcutListHwnd, x: 932, y: 209, h: 252, type: "list"}
    , {hwnd: shortcutPreviewHwnd, x: 932, y: 474, h: 115, type: "edit"}]
for index, area in shortcutScrollAreas {
    Gui, Shortcuts: Add, Text, % "x" area.x " y" area.y " w18 h" area.h " +0x100 Background292C38 hwndtrackHwnd vShortcutScrollTrack" index, % Chr(160)
    Gui, Shortcuts: Add, Progress, % "x" (area.x + 5) " y" (area.y + 2) " w8 h30 cEA3479 BackgroundEA3479 Disabled Hidden vShortcutScrollThumb" index, 100
    shortcutScrollTracks[trackHwnd] := index
    area.track := trackHwnd
    ShortcutClipScrollControl(area.hwnd, index <= 2 ? 450 : 920, area.h)
}
Gui, Shortcuts: Font, s9 cE9EAF0, Segoe UI
Gui, Shortcuts: Add, Text, x152 y621 w520 h38 Background12131A vShortcutStatus
Gui, Shortcuts: Font, s10 w700 q0 cFFFFFF, Segoe UI
Gui, Shortcuts: Add, Text, x16 y621 w116 h36 +0x200 +0x100 Center Background292C38 gShortcutEditorClose, ЗАКРЫТЬ
Gui, Shortcuts: Add, Text, x700 y621 w264 h36 +0x200 +0x100 Center vShortcutConfirm hwndshortcutConfirmHwnd gShortcutEditorConfirm, ПОДТВЕРДИТЬ ДОБАВЛЕНИЕ
Gui, Shortcuts: Font, s10 w700 q0 cAEB1BF, Segoe UI
Gui, Shortcuts: Add, Text, x700 y621 w264 h36 +0x200 Center vShortcutConfirmInactive hwndshortcutConfirmInactiveHwnd Hidden
Gosub, ShortcutEditorSection
if (shortcutOpenRecord) {
    for _, ref in shortcutRecords[shortcutOpenRecord].refs {
        if (ref.section != "answers" && ref.section != "useful" && ref.section != "punishments")
            continue
        if (shortcutOpenSection != "" && (ref.section != shortcutOpenSection || ref.chapter != shortcutOpenChapter))
            continue
        GuiControl, Shortcuts:Choose, ShortcutSection, % ref.section = "answers" ? 1 : ref.section = "useful" ? 2 : 3
        Gosub, ShortcutEditorSection
        GuiControl, Shortcuts:ChooseString, ShortcutChapter, % ref.chapter
        GuiControl, Shortcuts:Choose, ShortcutAction, 3
        Gosub, ShortcutEditorRefresh
        for rowIndex, row in shortcutRows {
            if (row.index = shortcutOpenRecord) {
                Gui, Shortcuts: Default
                Gui, ListView, ShortcutList
                LV_Modify(rowIndex, "Select Focus Vis")
                Gosub, ShortcutEditorUpdatePreview
                break
            }
        }
        break
    }
    shortcutOpenRecord := 0
    shortcutOpenSection := ""
    shortcutOpenChapter := ""
}
Gui, Shortcuts: Show, w980 h674, Редактор сокращений
SetTimer, ShortcutRefreshScroll, 100
return

ShortcutEditorDrag:
DllCall("ReleaseCapture")
PostMessage, 0xA1, 2, % DllCall("GetMessagePos", "UInt"),, % "ahk_id " shortcutEditorHwnd
return

ShortcutEditorClose:
ShortcutsGuiClose:
ShortcutsGuiEscape:
SetTimer, ShortcutEditorDeferredSelection, Off
SetTimer, ShortcutRefreshScroll, Off
Gui, Shortcuts: Destroy
shortcutEditorHwnd := 0
shortcutScrollTracks := {}
shortcutScrollDragging := 0
return

ShortcutRefreshScroll:
ShortcutUpdateScroll()
return

ShortcutClipScrollControl(hwnd, width, height) {
    region := DllCall("CreateRectRgn", "Int", 0, "Int", 0, "Int", width - 18, "Int", height, "Ptr")
    if !DllCall("SetWindowRgn", "Ptr", hwnd, "Ptr", region, "Int", 1)
        DllCall("DeleteObject", "Ptr", region)
}

ShortcutScrollInfo(index) {
    global shortcutScrollAreas
    area := shortcutScrollAreas[index]
    if (area.type = "list") {
        total := DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x1004, "Ptr", 0, "Ptr", 0, "Int")
        first := DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x1027, "Ptr", 0, "Ptr", 0, "Int")
        visible := DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x1028, "Ptr", 0, "Ptr", 0, "Int")
    } else {
        total := DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0xBA, "Ptr", 0, "Ptr", 0, "Int")
        first := DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0xCE, "Ptr", 0, "Ptr", 0, "Int")
        dc := DllCall("GetDC", "Ptr", area.hwnd, "Ptr")
        font := DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x31, "Ptr", 0, "Ptr", 0, "Ptr")
        oldFont := DllCall("SelectObject", "Ptr", dc, "Ptr", font, "Ptr")
        VarSetCapacity(metrics, 60, 0)
        DllCall("GetTextMetricsW", "Ptr", dc, "Ptr", &metrics)
        lineHeight := NumGet(metrics, 0, "Int")
        DllCall("SelectObject", "Ptr", dc, "Ptr", oldFont)
        DllCall("ReleaseDC", "Ptr", area.hwnd, "Ptr", dc)
        visible := Max(1, Floor((area.h - 8) / Max(1, lineHeight)))
    }
    maxFirst := Max(0, total - visible)
    thumbHeight := maxFirst ? Max(30, Round(area.h * visible / total)) : 0
    return {first: Min(first, maxFirst), maxFirst: maxFirst, thumbHeight: thumbHeight}
}

ShortcutUpdateScroll() {
    global shortcutScrollAreas
    for index, area in shortcutScrollAreas {
        thumb := "ShortcutScrollThumb" index
        if (!DllCall("IsWindowVisible", "Ptr", area.track)) {
            GuiControl, Shortcuts:Hide, %thumb%
            continue
        }
        info := ShortcutScrollInfo(index)
        if (info.maxFirst <= 0) {
            GuiControl, Shortcuts:Hide, %thumb%
            continue
        }
        y := area.y + Round(info.first / info.maxFirst * (area.h - info.thumbHeight))
        GuiControl, Shortcuts:MoveDraw, %thumb%, % "x" (area.x + 5) " y" y " w8 h" info.thumbHeight
        GuiControl, Shortcuts:Show, %thumb%
    }
}

ShortcutScrollToMouse(index) {
    global shortcutScrollAreas
    area := shortcutScrollAreas[index]
    info := ShortcutScrollInfo(index)
    if (info.maxFirst <= 0)
        return
    CoordMode, Mouse, Client
    MouseGetPos, mouseX, mouseY
    fraction := (mouseY - area.y - info.thumbHeight / 2) / (area.h - info.thumbHeight)
    ShortcutScrollTo(index, Round(Max(0, Min(1, fraction)) * info.maxFirst))
}

ShortcutScrollTo(index, target) {
    global shortcutScrollAreas
    area := shortcutScrollAreas[index]
    info := ShortcutScrollInfo(index)
    target := Max(0, Min(info.maxFirst, target))
    if (area.type = "list") {
        VarSetCapacity(rect, 16, 0)
        if DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x100E, "Ptr", 0, "Ptr", &rect)
            DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x1014, "Ptr", 0, "Ptr", (target - info.first) * (NumGet(rect, 12, "Int") - NumGet(rect, 4, "Int")))
    } else
        DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0xB6, "Ptr", 0, "Ptr", target - info.first)
    ShortcutUpdateScroll()
}

ShortcutEditorSection:
GuiControlGet, ShortcutSection, Shortcuts:, ShortcutSection
choices := "|"
for _, chapter in ShortcutSectionChapters(shortcutSections[ShortcutSection])
    choices .= chapter "|"
GuiControl, Shortcuts:, ShortcutChapter, % RTrim(choices, "|")
GuiControl, Shortcuts:Choose, ShortcutChapter, 1
Gosub, ShortcutEditorRefresh
return

ShortcutEditorRefresh:
Gui, Shortcuts: Submit, NoHide
SetTimer, ShortcutEditorDeferredSelection, Off
deleting := ShortcutAction = 2
editing := ShortcutAction = 3
shortcutFormControls := ["ShortcutAlias", "ShortcutText", "ShortcutOtherText", "ShortcutAliasLabel", "ShortcutTextLabel", "ShortcutOtherTextLabel", "ShortcutTranslit"]
formPositions := editing ? ["y377", "y444 h145", "y444 h145", "y354", "y420", "y420", "y382"] : ["y210", "y286 h303", "y286 h303", "y184", "y260", "y260", "y215"]
for i, control in shortcutFormControls {
    GuiControl, Shortcuts:Move, %control%, % formPositions[i]
    GuiControl, % "Shortcuts:" (deleting ? "Hide" : "Show"), %control%
}
GuiControl, Shortcuts:Move, ShortcutList, % editing ? "y209 h132" : "y209 h252"
for _, control in ["ShortcutListHeaderBg", "ShortcutListHeaderAlias", "ShortcutListHeaderText"]
    GuiControl, % "Shortcuts:" (ShortcutAction = 1 ? "Hide" : "Show"), %control%
for index, area in shortcutScrollAreas {
    area.y := index <= 2 ? (editing ? 444 : 286) : index = 3 ? 209 : 474
    area.h := index <= 2 ? (editing ? 145 : 303) : index = 3 ? (editing ? 132 : 252) : 115
    visible := index <= 2 ? !deleting : index = 3 ? ShortcutAction != 1 : deleting
    track := "ShortcutScrollTrack" index
    GuiControl, Shortcuts:Move, %track%, % "x" area.x " y" area.y " w18 h" area.h
    ShortcutClipScrollControl(area.hwnd, index <= 2 ? 450 : 920, area.h)
    GuiControl, % "Shortcuts:" (visible ? "Show" : "Hide"), %track%
    GuiControl, Shortcuts:Hide, % "ShortcutScrollThumb" index
}
GuiControl, % "Shortcuts:" (ShortcutAction = 1 ? "Hide" : "Show"), ShortcutList
GuiControl, % "Shortcuts:" (deleting ? "Show" : "Hide"), ShortcutPreview
GuiControl, Shortcuts:, ShortcutStatus,
confirmText := deleting ? "ПОДТВЕРДИТЬ УДАЛЕНИЕ" : editing ? "СОХРАНИТЬ ИЗМЕНЕНИЯ" : "ПОДТВЕРДИТЬ ДОБАВЛЕНИЕ"
GuiControl, Shortcuts:, ShortcutConfirm, %confirmText%
GuiControl, Shortcuts:, ShortcutConfirmInactive, %confirmText%
if (ShortcutAction = 1) {
    if (shortcutPreviousAction != 1) {
        shortcutOtherTextManual := false
        GuiControl, Shortcuts:, ShortcutAlias,
        GuiControl, Shortcuts:, ShortcutText,
        GuiControl, Shortcuts:, ShortcutOtherText,
    }
    shortcutPreviousAction := ShortcutAction
    GuiControl, Shortcuts:Enable, ShortcutAlias
    GuiControl, Shortcuts:Enable, ShortcutText
    GuiControl, Shortcuts:Enable, ShortcutOtherText
    Gosub, ShortcutEditorAliasChanged
    return
}
shortcutPreviousAction := ShortcutAction
Gui, Shortcuts: Default
Gui, ListView, ShortcutList
GuiControl, Shortcuts:-Redraw, ShortcutList
shortcutPaintRow := 0
LV_Delete()
shortcutRows := []
section := shortcutSections[ShortcutSection]
for recordIndex, record in shortcutRecords {
    for _, ref in record.refs {
        if (ref.section != section || ref.chapter != ShortcutChapter || ShortcutKey(ref.alias) != record.alias)
            continue
        body := ShortcutReferenceBody(ref)
        listText := StrLen(body) > 220 ? SubStr(body, 1, 219) "…" : body
        shortcutRows.Push({index: recordIndex, alias: ref.alias, body: body, listText: listText
            , male: ref.body, female: ref.female != "" ? ref.female : ref.body})
        LV_Add("", ref.alias, listText)
        break
    }
}
LV_ModifyCol(1, 165)
LV_ModifyCol(2, 730)
shortcutListFirstColWidth := DllCall("SendMessageW", "Ptr", shortcutListHwnd, "UInt", 0x101D, "Ptr", 0, "Ptr", 0, "Int")
shortcutListVisibleRows := DllCall("SendMessageW", "Ptr", shortcutListHwnd, "UInt", 0x1028, "Ptr", 0, "Ptr", 0, "Int")
GuiControl, Shortcuts:+Redraw, ShortcutList
ShortcutUpdateScroll()
shortcutPreviewRow := -1
Gosub, ShortcutEditorUpdatePreview
if (!shortcutRows.Length())
    GuiControl, Shortcuts:, ShortcutStatus, В этой главе нет сокращений.
return

ShortcutEditorAliasChanged:
GuiControlGet, ShortcutAlias, Shortcuts:, ShortcutAlias
if (ShortcutAlias != "" && !RegExMatch(ShortcutAlias, "^[./]")) {
    ShortcutAlias := shortcutLastAliasInput
    GuiControl, Shortcuts:, ShortcutAlias, %ShortcutAlias%
    shortcutCaret := StrLen(ShortcutAlias)
    SendMessage, 0xB1, %shortcutCaret%, %shortcutCaret%,, % "ahk_id " shortcutAliasHwnd
} else
    shortcutLastAliasInput := ShortcutAlias
pair := ShortcutLayoutPair(Trim(ShortcutAlias))
GuiControl, Shortcuts:, ShortcutTranslit, % pair = "" ? "" : "Другая раскладка: " pair
ShortcutEditorUpdateFormConfirm()
return

ShortcutEditorTextChanged:
if (!shortcutOtherTextManual && ShortcutAction != 2) {
    GuiControlGet, currentText, Shortcuts:, ShortcutText
    currentText := ShortcutEditorBody(currentText)
    if (ShortcutAction = 3 && IsObject(shortcutSelected) && ShortcutEditorSameBody(currentText, shortcutSelected.body))
        otherText := AdminGender = "female" ? shortcutSelected.male : shortcutSelected.female
    else
        otherText := ShortcutSuggestGender(currentText, AdminGender = "male")
    GuiControl, Shortcuts:, ShortcutOtherText, %otherText%
}
ShortcutEditorUpdateFormConfirm()
ShortcutUpdateScroll()
return

ShortcutEditorOtherTextChanged:
shortcutOtherTextManual := true
ShortcutEditorUpdateFormConfirm()
ShortcutUpdateScroll()
return

ShortcutEditorSelect:
if (A_GuiEvent = "I" && InStr(ErrorLevel, "S"))
    SetTimer, ShortcutEditorDeferredSelection, -15
return

ShortcutEditorDeferredSelection:
if (shortcutListHwnd && DllCall("IsWindowVisible", "Ptr", shortcutListHwnd))
    Gosub, ShortcutEditorUpdatePreview
return

ShortcutEditorUpdatePreview:
Gui, Shortcuts: Default
Gui, ListView, ShortcutList
shortcutSelectedRow := LV_GetNext()
shortcutPaintRow := shortcutSelectedRow
if (shortcutSelectedRow = shortcutPreviewRow)
    return
shortcutPreviewRow := shortcutSelectedRow
shortcutSelected := shortcutRows[shortcutSelectedRow]
hasSelection := IsObject(shortcutSelected)
if (ShortcutAction = 3) {
    shortcutOtherTextManual := false
    GuiControl, Shortcuts:, ShortcutAlias, % hasSelection ? shortcutSelected.alias : ""
    GuiControl, Shortcuts:, ShortcutText, % hasSelection ? shortcutSelected.body : ""
    GuiControl, Shortcuts:, ShortcutOtherText, % hasSelection ? (AdminGender = "female" ? shortcutSelected.male : shortcutSelected.female) : ""
    GuiControl, % "Shortcuts:" (hasSelection ? "Enable" : "Disable"), ShortcutAlias
    GuiControl, % "Shortcuts:" (hasSelection ? "Enable" : "Disable"), ShortcutText
    GuiControl, % "Shortcuts:" (hasSelection ? "Enable" : "Disable"), ShortcutOtherText
    Gosub, ShortcutEditorAliasChanged
    return
}
GuiControl, Shortcuts:, ShortcutPreview, % hasSelection ? shortcutSelected.alias " — " shortcutSelected.body : ""
ShortcutEditorSetConfirm(hasSelection)
return

ShortcutEditorUpdateFormConfirm() {
    global AdminGender, ShortcutAction, ShortcutSection, ShortcutChapter, shortcutSections, shortcutSelected
    if (ShortcutAction = 2)
        return
    GuiControlGet, aliasInput, Shortcuts:, ShortcutAlias
    GuiControlGet, textInput, Shortcuts:, ShortcutText
    GuiControlGet, otherInput, Shortcuts:, ShortcutOtherText
    alias := ShortcutKey(Trim(aliasInput))
    body := ShortcutEditorBody(textInput)
    other := ShortcutEditorBody(otherInput)
    editing := ShortcutAction = 3
    hasSelection := editing && IsObject(shortcutSelected)
    oldAlias := hasSelection ? ShortcutKey(shortcutSelected.alias) : ""
    validAlias := alias != "" && (alias = oldAlias || ShortcutEditorValidAlias(alias))
    savedOther := hasSelection ? (AdminGender = "female" ? shortcutSelected.male : shortcutSelected.female) : ""
    changed := hasSelection && (alias != oldAlias || !ShortcutEditorSameBody(body, shortcutSelected.body)
        || !ShortcutEditorSameBody(other, savedOther))
    ShortcutEditorSetConfirm(shortcutSections.HasKey(ShortcutSection) && validAlias && body != "" && other != ""
        && ShortcutChapter != "" && (!editing || changed))
}

ShortcutEditorBody(text) {
    return Trim(RegExReplace(text, "[ \t]*[\r\n]+[ \t]*", " "))
}

ShortcutEditorSameBody(body, savedText) {
    return (":" body) == (":" ShortcutEditorBody(savedText))
}

ShortcutSuggestGender(text, toFemale) {
    static forms := [["понял", "поняла"], ["взял", "взяла"], ["выдал", "выдала"]
        , ["заметил", "заметила"], ["наказал", "наказала"], ["увидел", "увидела"]
        , ["услышал", "услышала"], ["видел", "видела"], ["слышал", "слышала"]
        , ["помог", "помогла"], ["смог", "смогла"], ["вынужден", "вынуждена"]
        , ["готов", "готова"], ["рад", "рада"], ["уверен", "уверена"]
        , ["ответил", "ответила"], ["решил", "решила"], ["сделал", "сделала"]
        , ["проверил", "проверила"], ["отправил", "отправила"], ["закрыл", "закрыла"]
        , ["получил", "получила"], ["передал", "передала"], ["написал", "написала"]
        , ["сказал", "сказала"], ["попросил", "попросила"], ["предупредил", "предупредила"]
        , ["объяснил", "объяснила"], ["пересмотрел", "пересмотрела"], ["рассмотрел", "рассмотрела"]
        , ["хотел", "хотела"], ["согласен", "согласна"], ["был", "была"], ["сам", "сама"]
        , ["принял", "приняла"], ["уточнил", "уточнила"], ["проверял", "проверяла"]
        , ["обратился", "обратилась"], ["ошибся", "ошиблась"], ["убедился", "убедилась"]
        , ["разобрался", "разобралась"], ["ознакомился", "ознакомилась"]]
    ; shortcut: подстановка охватывает частые формы говорящего; второе поле позволяет исправить результат.
    subject := "^\h*|[.!?]\h*|(?<![\p{L}\p{N}_])я\h+"
    continuation := "\G(?:(?:\h+|\h*[,;]\h*)(?:(?:а затем|а потом|и|затем|потом)\h+)?"
        . "|[^.!?,;]*?\h+(?:и|а затем|а потом|затем|потом)\h+)"
    modifiers := "(?:(?:не|уже|ещ[её]|только|буду|сразу|также|вс[её]|к сожалению)\h+)*"
    replacements := {}, words := ""
    for _, form in forms {
        from := form[toFemale ? 1 : 2]
        replacements[from] := form[toFemale ? 2 : 1]
        words .= (words = "" ? "" : "|") from
    }
    ending := ")" modifiers "\K(?:" words ")(?![\p{L}\p{N}_])"
    pattern := "i)(?:" subject ending
    offset := 1
    while (at := RegExMatch(text, pattern, word, offset)) {
        to := replacements[ShortcutKey(word)]
        StringUpper, upper, word
        StringUpper, initial, word, T
        replacement := to
        if (word == upper)
            StringUpper, replacement, to
        else if (word == initial)
            StringUpper, replacement, to, T
        text := SubStr(text, 1, at - 1) replacement SubStr(text, at + StrLen(word))
        offset := at + StrLen(replacement)
        pattern := "i)(?:" subject "|" continuation ending
    }
    return text
}

ShortcutEditorSetConfirm(enabled) {
    GuiControl, % "Shortcuts:" (enabled ? "Hide" : "Show"), ShortcutConfirmInactive
    GuiControl, % "Shortcuts:" (enabled ? "Show" : "Hide"), ShortcutConfirm
}

ShortcutEditorConfirm:
Gui, Shortcuts: Submit, NoHide
section := shortcutSections[ShortcutSection]
if (section = "")
    return
oldAlias := "", oldIndex := 0
if (ShortcutAction != 1) {
    Gui, Shortcuts: Default
    Gui, ListView, ShortcutList
    selected := shortcutRows[LV_GetNext()]
    if (!IsObject(selected) || (ShortcutAction = 3 && LV_GetNext() != shortcutPreviewRow))
        return
    oldAlias := ShortcutKey(selected.alias)
    oldIndex := selected.index
}
if (ShortcutAction != 2) {
    alias := ShortcutKey(Trim(ShortcutAlias))
    body := ShortcutEditorBody(ShortcutText)
    other := ShortcutEditorBody(ShortcutOtherText)
    maleBody := AdminGender = "female" ? other : body
    femaleBody := AdminGender = "female" ? body : other
    if ((alias != oldAlias && !ShortcutEditorValidAlias(alias)) || alias = "" || body = "" || other = "" || ShortcutChapter = "") {
        GuiControl, Shortcuts:, ShortcutStatus, Введите сокращение с точки и заполните обе формы текста.
        return
    }
    pair := ShortcutLayoutPair(alias)
    if (ShortcutAliasTaken(alias, oldIndex) || (pair != "" && ShortcutAliasTaken(pair, oldIndex))) {
        GuiControl, Shortcuts:, ShortcutStatus, % "Сокращение " alias " или " pair " уже занято."
        return
    }
    keepMale := ShortcutAction = 3 && ShortcutEditorSameBody(maleBody, selected.male)
    keepFemale := ShortcutAction = 3 && ShortcutEditorSameBody(femaleBody, selected.female)
    if (ShortcutAction = 3 && alias == oldAlias && keepMale && keepFemale)
        return
} else {
    deleted := ShortcutDeleteRecord(oldIndex)
    if (deleted != 1) {
        if (deleted = -1)
            GuiControl, Shortcuts:, ShortcutStatus, Не удалось обновить файл Shortcuts.tsv.
        return
    }
    result := "Удалено: " oldAlias
    Gosub, ShortcutEditorClose
    Gosub, ShortcutEditorRefreshMain
    GuiControl, Main:, MainFooterHint, %result%
    return
}
newRecords := shortcutRecords.Clone()
replacement := ShortcutEditedRecord(shortcutRecords[oldIndex], section, ShortcutChapter, alias
    , maleBody, femaleBody, keepMale, keepFemale)
if (oldIndex)
    newRecords[oldIndex] := replacement
else
    newRecords.Push(replacement)
if !ShortcutEditorSave(newRecords) {
    GuiControl, Shortcuts:, ShortcutStatus, Не удалось обновить файл Shortcuts.tsv.
    return
}
if (oldIndex)
    ShortcutApplyRecord(shortcutRecords[oldIndex], "Off")
shortcutRecords := newRecords
ShortcutApplyRecord(replacement, "On")
result := (ShortcutAction = 3 ? "Изменено: " : "Добавлено: ") alias (pair = "" ? "" : " и " pair)
Gosub, ShortcutEditorClose
Gosub, ShortcutEditorRefreshMain
GuiControl, Main:, MainFooterHint, %result%
return

ShortcutEditorRefreshMain:
GuiControlGet, visibleTab, Main:, MainTabs
if (visibleTab = "Справочник" || visibleTab = 3) {
    if (mainCurrentSection = "commands")
        Gosub, Commandlist
    else if (!mainChaptersVisible && (mainCurrentSection = "answers" || mainCurrentSection = "punishments" || mainCurrentSection = "useful"))
        MainRenderSearchSection(mainCurrentSection, mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch")
}
return

ShortcutDeleteRecord(index) {
    global shortcutRecords, shortcutDeletedAlias
    record := shortcutRecords[index]
    if (!IsObject(record))
        return false
    shortcutDeletedAlias := record.alias
    if !ShortcutDeleteConfirm(record)
        return false
    newRecords := shortcutRecords.Clone()
    newRecords.RemoveAt(index)
    if !ShortcutEditorSave(newRecords)
        return -1
    ShortcutApplyRecord(record, "Off")
    shortcutRecords := newRecords
    return 1
}

ShortcutDeleteConfirm(record) {
    global shortcutEditorHwnd, shortcutDeleteGuiHwnd, shortcutDeleteConfirmed
    global ShortcutDeleteCard, ShortcutDeletePreviewBackground, ShortcutDeletePreview
    shortcutDeleteConfirmed := false
    Gui, ShortcutDelete: Destroy
    if (shortcutEditorHwnd)
        Gui, ShortcutDelete: +OwnerShortcuts -Caption +Border +HwndshortcutDeleteGuiHwnd
    else
        Gui, ShortcutDelete: +OwnerMain -Caption +Border +HwndshortcutDeleteGuiHwnd
    Gui, ShortcutDelete: Color, 12131A, 1B1D27
    Gui, ShortcutDelete: Add, Progress, x0 y0 w500 h78 c1B1D27 Background1B1D27 Disabled, 100
    Gui, ShortcutDelete: Font, s16 w700 cFFFFFF, Segoe UI
    Gui, ShortcutDelete: Add, Text, x24 y17 w300 h30 +BackgroundTrans gShortcutDeleteDrag, MAJESTIC
    Gui, ShortcutDelete: Font, s9 w600 cEA3479, Segoe UI
    Gui, ShortcutDelete: Add, Text, x26 y47 w300 h18 +BackgroundTrans gShortcutDeleteDrag, ADMIN  /  BINDER
    Gui, ShortcutDelete: Font, s15 w400 cAEB1BF, Segoe UI
    Gui, ShortcutDelete: Add, Text, x459 y22 w27 h30 +0x200 +0x100 Center +BackgroundTrans gShortcutDeleteCancel, ×
    Gui, ShortcutDelete: Add, Progress, x0 y77 w500 h2 cEA3479 BackgroundEA3479 Disabled, 100
    Gui, ShortcutDelete: Add, Progress, x16 y96 w468 h150 c1B1D27 Background1B1D27 Disabled vShortcutDeleteCard, 100
    Gui, ShortcutDelete: Font, s14 w700 cFFFFFF, Segoe UI
    Gui, ShortcutDelete: Add, Text, x32 y110 w436 h30 +BackgroundTrans, % "Удалить " record.alias "?"
    preview := ShortcutReferenceBody(record.refs[1])
    Gui, ShortcutDelete: Add, Progress, x32 y151 w436 h48 c292C38 Background292C38 Disabled vShortcutDeletePreviewBackground, 100
    Gui, ShortcutDelete: Font, s10 cE9EAF0, Segoe UI
    Gui, ShortcutDelete: Add, Text, x40 y157 w420 +BackgroundTrans vShortcutDeletePreview, %preview%
    GuiControlGet, previewPos, ShortcutDelete:Pos, ShortcutDeletePreview
    extraHeight := Max(0, previewPosH - 38)
    GuiControl, ShortcutDelete:Move, ShortcutDeletePreviewBackground, % "h" (48 + extraHeight)
    GuiControl, ShortcutDelete:Move, ShortcutDeleteCard, % "h" (150 + extraHeight)
    Gui, ShortcutDelete: Font, s9 c989DAD, Segoe UI
    Gui, ShortcutDelete: Add, Text, % "x32 y" (210 + extraHeight) " w436 h32 +BackgroundTrans", Сокращение, оба текста и команды другой раскладки исчезнут из всех глав.
    Gui, ShortcutDelete: Font, s10 w700 cFFFFFF, Segoe UI
    Gui, ShortcutDelete: Add, Text, % "x16 y" (259 + extraHeight) " w160 h36 +0x200 +0x100 Center Background292C38 gShortcutDeleteCancel", ОТМЕНА
    Gui, ShortcutDelete: Add, Progress, % "x324 y" (259 + extraHeight) " w160 h36 cEA3479 BackgroundEA3479 Disabled", 100
    Gui, ShortcutDelete: Add, Text, % "x324 y" (259 + extraHeight) " w160 h36 +0x200 +0x100 Center +BackgroundTrans gShortcutDeleteAccept", УДАЛИТЬ
    Gui, ShortcutDelete: Add, Button, Hidden Default gShortcutDeleteAccept
    if (shortcutEditorHwnd)
        Gui, Shortcuts: +Disabled
    else
        Gui, Main: +Disabled
    Gui, ShortcutDelete: Show, % "w500 h" (311 + extraHeight), Подтверждение удаления
    WinWaitClose, % "ahk_id " shortcutDeleteGuiHwnd
    if (shortcutEditorHwnd)
        Gui, Shortcuts: -Disabled
    else
        Gui, Main: -Disabled
    return shortcutDeleteConfirmed
}

ShortcutDeleteDrag:
DllCall("ReleaseCapture")
PostMessage, 0xA1, 2,,, % "ahk_id " shortcutDeleteGuiHwnd
return

ShortcutDeleteAccept:
shortcutDeleteConfirmed := true
Gosub, ShortcutDeleteDismiss
return

ShortcutDeleteDismiss:
if (shortcutEditorHwnd)
    Gui, Shortcuts: -Disabled
else
    Gui, Main: -Disabled
Gui, ShortcutDelete: Destroy
return

ShortcutDeleteCancel:
ShortcutDeleteGuiClose:
ShortcutDeleteGuiEscape:
shortcutDeleteConfirmed := false
Gosub, ShortcutDeleteDismiss
return

ShortcutStyleCombo(hwnd) {
    static proc := RegisterCallback("ShortcutComboProc", "Fast", 6)
    DllCall("Comctl32\SetWindowSubclass", "Ptr", hwnd, "Ptr", proc, "Ptr", 1, "Ptr", 0)
    DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x153, "Ptr", -1, "Ptr", Round(26 * A_ScreenDPI / 96))
    DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x153, "Ptr", 0, "Ptr", Round(28 * A_ScreenDPI / 96))
}

ShortcutComboProc(hwnd, msg, wParam, lParam, subclassId, data) {
    if (msg = 0xF || msg = 0x318) { ; WM_PAINT / WM_PRINTCLIENT
        VarSetCapacity(paint, 80, 0)
        dc := msg = 0xF ? DllCall("BeginPaint", "Ptr", hwnd, "Ptr", &paint, "Ptr") : wParam
        VarSetCapacity(rect, 16, 0)
        DllCall("GetClientRect", "Ptr", hwnd, "Ptr", &rect)
        DllCall("FillRect", "Ptr", dc, "Ptr", &rect, "Ptr", ShortcutThemeBrush("field"))
        if (DllCall("GetFocus", "Ptr") = hwnd)
            DllCall("FrameRect", "Ptr", dc, "Ptr", &rect, "Ptr", ShortcutThemeBrush("accent"))
        font := DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x31, "Ptr", 0, "Ptr", 0, "Ptr")
        previousFont := font ? DllCall("SelectObject", "Ptr", dc, "Ptr", font, "Ptr") : 0
        selected := DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x147, "Ptr", 0, "Ptr", 0, "Int")
        arrowWidth := Round(32 * A_ScreenDPI / 96)
        width := NumGet(rect, 8, "Int")
        NumPut(width - arrowWidth, rect, 8, "Int")
        ShortcutDrawText(dc, &rect, ShortcutComboText(hwnd, selected))
        NumPut(width - arrowWidth, rect, 0, "Int")
        NumPut(width, rect, 8, "Int")
        ShortcutDrawText(dc, &rect, "▾", true)
        if (previousFont)
            DllCall("SelectObject", "Ptr", dc, "Ptr", previousFont)
        if (msg = 0xF)
            DllCall("EndPaint", "Ptr", hwnd, "Ptr", &paint)
        return 0
    }
    if (msg = 0x14) ; WM_ERASEBKGND
        return 1
    if (msg = 0x134) { ; WM_CTLCOLORLISTBOX
        DllCall("SetBkColor", "Ptr", wParam, "UInt", 0x463734)
        DllCall("SetTextColor", "Ptr", wParam, "UInt", 0xF0EAE9)
        return ShortcutThemeBrush("field")
    }
    result := DllCall("Comctl32\DefSubclassProc", "Ptr", hwnd, "UInt", msg, "Ptr", wParam, "Ptr", lParam, "Ptr")
    if (msg = 0x7 || msg = 0x8 || msg = 0x14E) ; фокус или CB_SETCURSEL
        DllCall("InvalidateRect", "Ptr", hwnd, "Ptr", 0, "Int", 0)
    return result
}

ShortcutDrawComboItem(wParam, lParam, msg, hwnd) {
    global shortcutEditorHwnd, shortcutActionHwnd, shortcutSectionHwnd, shortcutChapterHwnd
    if (hwnd != shortcutEditorHwnd || NumGet(lParam + 0, 0, "UInt") != 3) ; ODT_COMBOBOX
        return
    pointerOffset := A_PtrSize = 8 ? 24 : 20
    combo := NumGet(lParam + 0, pointerOffset, "Ptr")
    if (combo != shortcutActionHwnd && combo != shortcutSectionHwnd && combo != shortcutChapterHwnd)
        return
    dc := NumGet(lParam + 0, pointerOffset + A_PtrSize, "Ptr")
    rect := lParam + pointerOffset + 2 * A_PtrSize
    index := NumGet(lParam + 0, 8, "Int")
    state := NumGet(lParam + 0, 16, "UInt")
    picked := (state & 1) && !(state & 0x1000) ; ODS_SELECTED / ODS_COMBOBOXEDIT
    DllCall("FillRect", "Ptr", dc, "Ptr", rect, "Ptr", ShortcutThemeBrush(picked ? "accent" : "field"))
    ShortcutDrawText(dc, rect, ShortcutComboText(combo, index), false, picked)
    return 1
}

ShortcutComboText(hwnd, index) {
    if (index < 0)
        return ""
    length := DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x149, "Ptr", index, "Ptr", 0, "Int")
    if (length < 0)
        return ""
    VarSetCapacity(text, (length + 1) * 2, 0)
    DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x148, "Ptr", index, "Ptr", &text)
    return StrGet(&text, length, "UTF-16")
}

ShortcutHookListPainting(editorHwnd, listHwnd) {
    static parentProc := RegisterCallback("ShortcutListParentProc", "Fast", 6)
    static listProc := RegisterCallback("ShortcutListProc", "Fast", 6)
    DllCall("Comctl32\SetWindowSubclass", "Ptr", editorHwnd, "Ptr", parentProc, "Ptr", 1, "Ptr", parentProc)
    DllCall("Comctl32\SetWindowSubclass", "Ptr", listHwnd, "Ptr", listProc, "Ptr", 1, "Ptr", listProc)
}

ShortcutListParentProc(hwnd, msg, wParam, lParam, id, proc) {
    if (msg = 0x4E && lParam) { ; WM_NOTIFY
        result := ShortcutDrawSelectedRow(wParam, lParam, msg, hwnd)
        if (result != "")
            return result
    } else if (msg = 0x82) ; WM_NCDESTROY
        DllCall("Comctl32\RemoveWindowSubclass", "Ptr", hwnd, "Ptr", proc, "Ptr", id)
    return DllCall("Comctl32\DefSubclassProc", "Ptr", hwnd, "UInt", msg, "Ptr", wParam, "Ptr", lParam, "Ptr")
}

ShortcutListProc(hwnd, msg, wParam, lParam, id, proc) {
    global shortcutPaintRow, shortcutPaintRect, shortcutListVisibleRows
    if (shortcutPaintRow && (msg = 0xF || msg = 0x317 || msg = 0x318)) {
        top := DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x1027, "Ptr", 0, "Ptr", 0, "Int")
        VarSetCapacity(bounds, 16, 0)
        previousRect := shortcutPaintRect
        shortcutPaintRect := 0
        if (shortcutPaintRow > top && shortcutPaintRow <= top + shortcutListVisibleRows + 1
            && DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x100E, "Ptr", shortcutPaintRow - 1, "Ptr", &bounds))
            shortcutPaintRect := &bounds
        result := DllCall("Comctl32\DefSubclassProc", "Ptr", hwnd, "UInt", msg, "Ptr", wParam, "Ptr", lParam, "Ptr")
        shortcutPaintRect := previousRect
        return result
    } else if (msg = 0x82)
        DllCall("Comctl32\RemoveWindowSubclass", "Ptr", hwnd, "Ptr", proc, "Ptr", id)
    return DllCall("Comctl32\DefSubclassProc", "Ptr", hwnd, "UInt", msg, "Ptr", wParam, "Ptr", lParam, "Ptr")
}

ShortcutDrawSelectedRow(wParam, lParam, msg, hwnd) {
    global shortcutEditorHwnd, shortcutListHwnd, shortcutRows, shortcutPaintRow, shortcutListFirstColWidth
    global shortcutPaintRect, shortcutListFont
    if (hwnd != shortcutEditorHwnd || NumGet(lParam + 0, 0, "Ptr") != shortcutListHwnd)
        return
    headerSize := 3 * A_PtrSize
    notification := NumGet(lParam + 0, 2 * A_PtrSize, "Int")
    if (notification = -101) { ; LVN_ITEMCHANGED
        stateChanged := NumGet(lParam + 0, headerSize + 16, "UInt") & 8
        if (stateChanged) {
            rowNumber := NumGet(lParam + 0, headerSize, "Int") + 1
            newState := NumGet(lParam + 0, headerSize + 8, "UInt")
            if (newState & 2)
                shortcutPaintRow := rowNumber
            else if (rowNumber = shortcutPaintRow)
                shortcutPaintRow := 0
        }
        return
    }
    if (notification != -12) ; NM_CUSTOMDRAW
        return
    stage := NumGet(lParam + 0, headerSize, "UInt")
    if (stage = 1)
        return shortcutPaintRect ? 0x10 : 0 ; CDRF_NOTIFYPOSTPAINT
    if (stage != 2 || !shortcutPaintRect)
        return 0
    row := shortcutRows[shortcutPaintRow]
    if (!IsObject(row))
        return 0
    ; Список сам рисует строки. Поверх него окрашиваем только одно видимое выделение.
    dc := NumGet(lParam + 0, headerSize + A_PtrSize, "Ptr")
    oldFont := shortcutListFont ? DllCall("SelectObject", "Ptr", dc, "Ptr", shortcutListFont, "Ptr") : 0
    VarSetCapacity(rect, 16)
    DllCall("RtlMoveMemory", "Ptr", &rect, "Ptr", shortcutPaintRect, "UPtr", 16)
    DllCall("FillRect", "Ptr", dc, "Ptr", &rect, "Ptr", ShortcutThemeBrush("accent"))
    right := NumGet(rect, 8, "Int")
    split := NumGet(rect, 0, "Int") + shortcutListFirstColWidth
    NumPut(split, rect, 8, "Int")
    ShortcutDrawText(dc, &rect, row.alias, false, true)
    NumPut(split, rect, 0, "Int")
    NumPut(right, rect, 8, "Int")
    ShortcutDrawText(dc, &rect, row.listText, false, true)
    if (oldFont)
        DllCall("SelectObject", "Ptr", dc, "Ptr", oldFont)
    return 0
}

ShortcutDrawText(dc, rect, text, center := false, white := false) {
    VarSetCapacity(bounds, 16)
    DllCall("RtlMoveMemory", "Ptr", &bounds, "Ptr", rect, "UPtr", 16)
    if (!center) {
        padding := Round(8 * A_ScreenDPI / 96)
        NumPut(NumGet(bounds, 0, "Int") + padding, bounds, 0, "Int")
        NumPut(NumGet(bounds, 8, "Int") - padding, bounds, 8, "Int")
    }
    previousMode := DllCall("SetBkMode", "Ptr", dc, "Int", 1)
    previousColor := DllCall("SetTextColor", "Ptr", dc, "UInt", white ? 0xFFFFFF : 0xF0EAE9, "UInt")
    DllCall("DrawTextW", "Ptr", dc, "WStr", text, "Int", -1, "Ptr", &bounds, "UInt", 0x8824 | (center ? 1 : 0))
    DllCall("SetTextColor", "Ptr", dc, "UInt", previousColor)
    DllCall("SetBkMode", "Ptr", dc, "Int", previousMode)
}

ShortcutThemeBrush(name) {
    static field := DllCall("CreateSolidBrush", "UInt", 0x463734, "Ptr")
    static accent := DllCall("CreateSolidBrush", "UInt", 0x7934EA, "Ptr")
    return name = "accent" ? accent : field
}

ShortcutSectionChapters(section) {
    global answerChapters, usefulChapters, punishmentChapters
    return section = "commands" ? ["Команды"] : section = "answers" ? answerChapters
        : section = "punishments" ? punishmentChapters : usefulChapters
}

ShortcutKey(alias) {
    StringLower, alias, alias
    return alias
}

ShortcutEditorValidAlias(alias) {
    return RegExMatch(alias, "^\.[а-яё0-9]{1,39}$")
}

ShortcutLayoutPair(alias) {
    alias := ShortcutKey(alias)
    prefix := SubStr(alias, 1, 1)
    if (prefix != "." && prefix != "/")
        return ""
    ru := "йцукенгшщзхъфывапролджэячсмитьбюё"
    en := "qwertyuiop[]asdfghjkl;'zxcvbnm,." Chr(96)
    from := prefix = "." ? ru : en
    to := prefix = "." ? en : ru
    pair := prefix = "." ? "/" : "."
    keys := SubStr(alias, 2)
    Loop, Parse, keys
    {
        i := InStr(from, A_LoopField, true)
        if (i)
            pair .= SubStr(to, i, 1)
        else if RegExMatch(A_LoopField, "^[0-9 ]$")
            pair .= A_LoopField
        else
            return ""
    }
    return pair
}

ShortcutAliasTaken(alias, ignoreIndex := 0) {
    global shortcutRecords
    for index, record in shortcutRecords {
        if (index = ignoreIndex)
            continue
        if (record.alias = alias)
            return true
        for _, variant in record.hot
            if (ShortcutKey(variant.alias) = alias)
                return true
    }
    return false
}

ShortcutEditedRecord(old, section, chapter, alias, male, female, keepMale, keepFemale) {
    record := {alias: alias, refs: [], hot: []}
    keepText := keepMale && keepFemale
    if (IsObject(old)) {
        for _, ref in old.refs {
            if (ShortcutKey(ref.alias) != old.alias)
                continue
            refMale := keepMale ? ref.body : male
            refFemale := keepFemale ? (ref.female != "" ? ref.female : ref.body) : female
            record.refs.Push({section: ref.section, chapter: ref.chapter, alias: alias
                , body: refMale, female: ShortcutEditorSameBody(refMale, refFemale) ? "" : refFemale})
        }
    }
    if (!record.refs.Length())
        record.refs.Push({section: section, chapter: chapter, alias: alias
            , body: male, female: ShortcutEditorSameBody(male, female) ? "" : female})

    pair := ShortcutLayoutPair(alias)
    seen := {}
    if (IsObject(old)) {
        oldPair := ShortcutLayoutPair(old.alias)
        for _, variant in old.hot {
            key := ShortcutKey(variant.alias)
            if (alias != old.alias && key != old.alias && key != oldPair)
                continue
            target := key = old.alias ? alias : key = oldPair ? pair : variant.alias
            if (target = "")
                continue
            if (keepText) {
                record.hot.Push({alias: target, gender: variant.gender, mode: variant.mode, body: variant.body})
                if (variant.gender = "all" || variant.gender = "male")
                    seen[target "|male"] := true
                if (variant.gender = "all" || variant.gender = "female")
                    seen[target "|female"] := true
                continue
            }
            for _, gender in ["male", "female"] {
                slot := target "|" gender
                if ((variant.gender != "all" && variant.gender != gender) || seen.HasKey(slot))
                    continue
                keep := gender = "male" ? keepMale : keepFemale
                mode := variant.mode
                if (!keep && mode != "count" && mode != "paste" && mode != "send")
                    mode := mode = "dis" || mode = "gadis" || mode = "zgadis" ? "paste" : "text"
                record.hot.Push({alias: target, gender: gender, mode: mode
                    , body: keep ? variant.body : gender = "male" ? male : female})
                seen[slot] := true
            }
        }
    }
    for _, target in [alias, pair] {
        if (target = "")
            continue
        if (!seen.HasKey(target "|male") && !seen.HasKey(target "|female") && ShortcutEditorSameBody(male, female)) {
            record.hot.Push({alias: target, gender: "all", mode: section = "punishments" ? "send" : "text", body: male})
            continue
        }
        if (!seen.HasKey(target "|male"))
            record.hot.Push({alias: target, gender: "male", mode: section = "punishments" ? "send" : "text", body: male})
        if (!seen.HasKey(target "|female"))
            record.hot.Push({alias: target, gender: "female", mode: section = "punishments" ? "send" : "text", body: female})
    }
    return record
}

ShortcutApplyRecord(record, state) {
    global AdminGender
    Hotkey, IfWinActive, ahk_exe GTA5.exe
    active := {}
    for _, variant in record.hot {
        if (state = "On" && variant.gender != "all" && variant.gender != AdminGender)
            continue
        alias := ShortcutKey(variant.alias)
        if (active.HasKey(alias))
            continue
        active[alias] := true
        if (state = "Off") {
            try Hotstring(":?:" alias, , "Off")
            continue
        }
        if (variant.mode = "send")
            Hotstring(":?:" alias, variant.body, "On")
        else if (variant.mode = "text")
            Hotstring(":?TC1:" alias, variant.body, "On")
        else
            Hotstring(":?:" alias, Func("ShortcutSendReply").Bind(variant.mode, variant.body), "On")
    }
}

ShortcutSendReply(mode, body) {
    global counter, dis, gadis, zgadis
    if (mode = "dis")
        body .= dis
    else if (mode = "gadis")
        body .= gadis
    else if (mode = "zgadis")
        body .= zgadis
    BinderPasteReply(body, 1)
    if (mode = "count") {
        counter++
        Gosub, UpdateCounter
    }
}

ShortcutEditorInit() {
    global shortcutRecords := [], shortcutSections := ["answers", "useful", "punishments"]
    global shortcutPath := A_ScriptDir "\res\Shortcuts.tsv", shortcutDiskData, shortcutReadError := false
    if (!FileExist(shortcutPath))
        ShortcutEditorSave(shortcutRecords, true)
    FileRead, shortcutDiskData, *P65001 %shortcutPath%
    if (ErrorLevel) {
        shortcutReadError := true
    } else {
        try {
            parsed := ShortcutParseFile(shortcutDiskData)
            for _, record in parsed
                ShortcutApplyRecord(record, "On")
            shortcutRecords := parsed
        } catch e {
            if (IsObject(parsed))
                for _, record in parsed
                    ShortcutApplyRecord(record, "Off")
            shortcutReadError := true
        }
    }
    if (shortcutReadError)
        MsgBox, 16, Сокращения, Не удалось загрузить res\Shortcuts.tsv.
}

ShortcutParseFile(data) {
    records := [], current := "", lineNo := 0
    for _, line in StrSplit(data, "`n", "`r") {
        lineNo++
        if (line = "" || SubStr(line, 1, 1) = "#")
            continue
        fields := StrSplit(line, "`t")
        for i, field in fields
            fields[i] := ShortcutDecode(field)
        if (fields[1] = "R" && fields.Length() = 2 && fields[2] != "") {
            current := {alias: ShortcutKey(fields[2]), refs: [], hot: []}
            records.Push(current)
        } else if (IsObject(current) && fields[1] = "V" && fields.Length() = 6) {
            current.refs.Push({section: fields[2], chapter: fields[3], alias: fields[4], body: fields[5], female: fields[6]})
        } else if (IsObject(current) && fields[1] = "H" && fields.Length() = 5
            && RegExMatch(fields[2], "^[^:\r\n\t]{1,40}$")
            && RegExMatch(fields[3], "^(all|male|female)$")
            && RegExMatch(fields[4], "^(send|text|paste|count|dis|gadis|zgadis)$")) {
            current.hot.Push({alias: fields[2], gender: fields[3], mode: fields[4], body: fields[5]})
        } else
            throw Exception("Строка " lineNo " в Shortcuts.tsv")
    }
    return records
}

ShortcutEncode(value) {
    return StrReplace(StrReplace(StrReplace(StrReplace(value, "%", "%25"), "`t", "%09"), "`r", "%0D"), "`n", "%0A")
}

ShortcutDecode(value) {
    return StrReplace(StrReplace(StrReplace(StrReplace(value, "%09", "`t"), "%0D", "`r"), "%0A", "`n"), "%25", "%")
}

ShortcutDataLine(fields) {
    line := ""
    for i, field in fields
        line .= (i = 1 ? "" : "`t") ShortcutEncode(field)
    return line "`r`n"
}

ShortcutEditorSave(records, create := false) {
    global shortcutPath, shortcutDiskData, shortcutReadError
    if (shortcutReadError)
        return false
    if (!create) {
        FileRead, currentData, *P65001 %shortcutPath%
        if (ErrorLevel || !(currentData == shortcutDiskData))
            return false
    }
    data := "# R — основное сокращение; V — раздел, глава, сокращение, текст и женская форма; H — сокращение, пол, действие и текст. Поля разделены табуляцией.`r`n"
    for _, record in records {
        data .= ShortcutDataLine(["R", record.alias])
        for _, ref in record.refs
            data .= ShortcutDataLine(["V", ref.section, ref.chapter, ref.alias, ref.body, ref.female])
        for _, variant in record.hot
            data .= ShortcutDataLine(["H", variant.alias, variant.gender, variant.mode, variant.body])
        data .= "`r`n"
    }
    tempPath := shortcutPath ".tmp"
    file := FileOpen(tempPath, "w", "UTF-8")
    if (!IsObject(file))
        return false
    written := file.Write(data)
    file.Close()
    if (written != StrPut(data, "UTF-8") - 1)
        return false
    FileMove, %tempPath%, %shortcutPath%, % !create
    if (ErrorLevel)
        return false
    shortcutDiskData := data
    return true
}

ShortcutReferenceBody(ref) {
    global AdminGender
    return AdminGender = "female" && ref.female != "" ? ref.female : ref.body
}

ShortcutEditorReference(section) {
    global shortcutRecords
    chapterLines := {}
    for _, record in shortcutRecords {
        for _, ref in record.refs {
            if (ref.section = section)
                chapterLines[ref.chapter] .= ref.alias " - " ShortcutReferenceBody(ref) "`r`n"
        }
    }
    output := ""
    for _, chapter in ShortcutSectionChapters(section)
        output .= "## " chapter "`r`n" chapterLines[chapter]
    return output
}

#IfWinActive ahk_exe GTA5.exe
GreetingHandler:
if (GreetingText != "") {
    GreetingSendText(GreetingText)
    SendInput, {Enter}
    counter++
    Gosub, UpdateCounter
}
return

GreetingSendText(text) {
    SendInput, {Text}%text%
}
Reload:
reload
return

^F9::reload
^F10::Exitapp

Close:
exitapp

Hide:
Gui, Main: Hide
return

Show:
Gui, Main: Show
return

guiclose2:
gui, Main:hide
return

; ===== РЕДАКТИРУЕМЫЕ ТЕКСТЫ РАЗДЕЛОВ =====
; Меняйте текст внутри кавычек. Кавычку внутри текста записывайте дважды: "".
; Дубли раскладки скрыты из справочника, но их игровые хотстроки продолжают работать.
BinderGetSectionContent(sectionName) {
    if (sectionName = "commands" || sectionName = "punishments" || sectionName = "answers" || sectionName = "useful")
        return ShortcutEditorReference(sectionName)
    ; ----- ОБЩАЯ ИНФОРМАЦИЯ -----
    if (sectionName = "info") {
        content := ""
        content .= "ГЛАВНОЕ ОКНО`r`n"
        content .= "«БИНДЫ» — назначение горячих клавиш, команды при входе и поле «Ваш статик».`r`n"
        content .= "«НАСТРОЙКИ» — разрешение, данные администрации и связи, клавиша приветствия, положение счётчика и пол администратора.`r`n"
        content .= "«СОХРАНИТЬ И ПРИМЕНИТЬ» — сохраняет изменения биндов и настроек в res\Settings.ini и перезапускает биндер.`r`n"
        content .= "Значок ✓ рядом с полем «Ваш статик» сохраняет только статик. Знак − скрывает главное окно, знак × закрывает биндер.`r`n`r`n"
        content .= "РАЗДЕЛЫ СЛЕВА`r`n"
        content .= "«Общая информация» — описание интерфейса.`r`n"
        content .= "«Команды» — сокращения команд. «Ответы» — выберите главу: Вики, Информация, Адм Ответы, asms, Приветствие или Discord. «← К ГЛАВАМ» возвращает к выбору.`r`n"
        content .= "«Наказания» — выберите главу demorgan, mute, warn, ban или gunban; для выдачи наказания откройте отдельный редактор в «Биндах».`r`n"
        content .= "«Полезное» — игровые подсказки, навыки и телепорты по главам. Поиск в «Ответах», «Наказаниях» и «Полезном» охватывает все три раздела; «Общая информация» и «Команды» в нём не участвуют.`r`n"
        content .= "В главах «Ответов» и «Полезного», а также в результатах поиска значок ✎ справа от записи открывает её в редакторе, а 🗑 удаляет после подтверждения вместе с обеими формами и командой другой раскладки.`r`n"
        content .= "Текст раздела прокручивается колёсиком мыши или полосой справа. Чтобы вернуться, выберите другой раздел либо «БИНДЫ» или «НАСТРОЙКИ».`r`n`r`n"
        content .= "РЕДАКТОР СОКРАЩЕНИЙ`r`n"
        content .= "Нажмите «Редактор сокращений» в меню слева. Выберите действие, раздел «Ответы», «Полезное» или «Наказания» и нужную главу.`r`n"
        content .= "Добавить — введите сокращение с точки, например .ку, и основной текст в роде, выбранном в настройках. Биндер предложит текст во втором роде и создаст сокращение для другой раскладки. Проверьте вторую форму, при необходимости исправьте её и нажмите «Подтвердить добавление».`r`n"
        content .= "Изменить — выберите запись, исправьте сокращение или текст в любой из двух форм и нажмите «Сохранить изменения». Обе формы сохраняются вместе, а при переименовании обновляется сокращение для другой раскладки.`r`n"
        content .= "Удалить — выберите запись, нажмите «Подтвердить удаление», затем «Да». Из всех глав, где встречается сокращение, удалятся обе формы и варианты для другой раскладки.`r`n"
        content .= "После успешного действия окно закроется. Изменения сразу применяются и сохраняются в res\Shortcuts.tsv. Чтобы выйти без сохранения, нажмите «Закрыть» или ×.`r`n`r`n"
        content .= "ВКЛАДКА «БИНДЫ»`r`n"
        content .= "Нажмите на поле справа от действия и задайте хоткей. Галочки «Команды при входе» выбирают команды для соответствующего бинда.`r`n"
        content .= "Доступные действия: открыть репорты, удалить транспорт, переключить /gm, вакцина, первое сообщение, машина после воды, телепортировать авто к себе или на метку, убрать или добавить один репорт.`r`n"
        content .= "Также доступны: команды при входе, воскресить игрока, выдача наказаний, памятка, переключение /gh, /chide и /zzdebug, HP 0 + rescue, убить игрока, уйти в F5.`r`n"
        content .= "В списке команд при входе: /hidecheatinfo, /showcheats, /dl, /esp 3, /templeader, /chide, /zzdebug, /objdl, /netstat и /advtoggle 0.`r`n"
        content .= "«Ваш статик» — введите ID и нажмите ✓. Нажатие на строку «Выдача наказаний» открывает редактор; для остальных действий используйте назначенные клавиши.`r`n"
        content .= "Бинд «Памятка» открывает отдельное окно с фракциями и наказаниями.`r`n`r`n"
        content .= "ВКЛАДКА «НАСТРОЙКИ»`r`n"
        content .= "«Экран» — выберите разрешение игры. «Администрация» — укажите ID фракции и Discord-контакты администратора, ГА и ЗГА.`r`n"
        content .= "Нажмите на поле «Клавиша» в блоке «Приветствие» и выберите сочетание. Приветствие отправляет текст и добавляет один репорт в счётчик.`r`n"
        content .= "«Ответы и оверлей» — нажмите «ИЗМЕНИТЬ ПОЛОЖЕНИЕ СЧЁТЧИКА», перетащите счётчик мышью и выберите мужской или женский вариант для «Ответов» и «Полезного». Положение сохранится сразу; остальные изменения примените кнопкой «СОХРАНИТЬ И ПРИМЕНИТЬ».`r`n`r`n"
        content .= "ДОПОЛНИТЕЛЬНЫЕ ОКНА`r`n"
        content .= "Окно первоначальной настройки: прочитайте шаги, затем нажмите «ПРОДОЛЖИТЬ» или ×. Галочка подтверждения отключает показ этого окна при следующих запусках.`r`n"
        content .= "«Памятка»: «ПОИСК» открывает или скрывает поиск, × у поля очищает запрос, «← НАЗАД» и «ДАЛЕЕ →» листают страницы, × вверху закрывает окно. Окно можно двигать за верхнюю панель; его положение сохраняется при закрытии.`r`n"
        content .= "«Выдача наказаний»: введите команды по одной в строке, начиная с /. «СОХРАНИТЬ И ОТПРАВИТЬ» записывает их в Punishment.txt и отправляет в игру; «ЗАКРЫТЬ» и × закрывают редактор. При отправке появляется счётчик выполнения.`r`n"
        content .= "Оверлей счётчика показывает репорты за день и неделю. После перетаскивания он снова пропускает клики мыши.`r`n`r`n"
        content .= "ЗНАЧОК В ТРЕЕ И КЛАВИШИ`r`n"
        content .= "Меню значка: «Показать» открывает главное окно, «Скрыть» убирает его, «Перезагрузить» перезапускает биндер, «Закрыть» завершает работу.`r`n"
        content .= "Ctrl + F9 — перезагрузить биндер. Ctrl + F10 — закрыть биндер.`r`n"
        return content
    }

    ; ----- ПАМЯТКА: САНКЦИИ -----
    if (sectionName = "memo_rules") {
        content := ""
        content .= "# Название | Санкция`r`n"
        content .= "# Источник: https://forum.majestic-rp.ru/threads/osnovnyye-pravila-proyekta.8036/`r`n"
        content .= "# HTML-копия сохранена 16.11.2026. Изменяйте только строки без #.`r`n"
        content .= "1.6 Срыв RP процесса | Наказание за нарушение увеличивается в 1,5 раза`r`n"
        content .= "4.2 Завуалированное оскорбление родных | Ban 5-30 дней / HardBan 15 дней`r`n"
        content .= "4.3 Прямое оскорбление родных | HardBan 30-60 дней`r`n"
        content .= "4.7 OOC травля и грубые оскорбления | Demorgan 15-60 минут / Ban 3-10 дней`r`n"
        content .= "5.2 DM | GunBan 8 часов / Demorgan 120 минут / WARN / Ban 3-30 дней`r`n"
        content .= "5.3 DB | Demorgan 30-90 минут / WARN / Ban / HardBan 3-30 дней`r`n"
        content .= "5.4 NonRP поведение | Demorgan 15-90 минут / WARN / Ban / HardBan 3-30 дней`r`n"
        content .= "5.4 NonRP Drive | Demorgan 15-90 минут / WARN / Ban / HardBan 3-30 дней`r`n"
        content .= "5.4 NonRP Fly | Demorgan 15-90 минут / WARN / Ban / HardBan 3-30 дней`r`n"
        content .= "5.5 NLR | Demorgan 90 минут / WARN`r`n"
        content .= "5.6 PG | Demorgan 35-90 минут / WARN / Ban 2-7 дней`r`n"
        content .= "5.7 SK | GunBan 8 часов / Ban 2-5 дней / HardBan 2-7 дней`r`n"
        content .= "5.8 TK | GunBan 2-6 часов / Demorgan 50-120 минут / WARN / Ban 3-10 дней`r`n"
        content .= "5.9 MG | Demorgan 20-90 минут / WARN / Ban 2-5 дней`r`n"
        content .= "5.10 Уход от RP | WARN / HardBan 4-8 дней`r`n"
        content .= "5.11 Криминальные действия против EMS | Demorgan 90 минут / WARN всем участникам`r`n"
        content .= "5.12 Сохранение спецоружия при смерти | Изъятие + Demorgan 100 минут / Ban 2-5 дней / HardBan 3-7 дней`r`n"
        content .= "5.13 Вызов госструктур ради провокации | Demorgan 15-60 минут / Ban 2 дня`r`n"
        content .= "5.14 Провокация игроков на нарушение | Demorgan 35-90 минут / Ban 3-30 дней / HardBan 15-30 дней`r`n"
        content .= "5.18 Неуместные отыгровки /me, /do, /try | Demorgan 10-35 минут`r`n"
        content .= "5.19 Отыгровки в свою пользу | Demorgan 15-35 минут`r`n"
        content .= "6.1 Помеха работе администрации | Kick / Mute 10-60 минут / Demorgan 10-100 минут / WARN / Ban 3-30 дней`r`n"
        content .= "6.12 Дискриминация по полу и другим признакам | Demorgan 90 минут / Ban 3-15 дней / HardBan 3-15 дней`r`n"
        content .= "6.13 Завуалированное оскорбление религии и нации | Ban 15-30 дней / HardBan 15-30 дней / PermBan`r`n"
        content .= "6.14 Прямое оскорбление религии и нации | HardBan 30-60 дней / PermBan`r`n"
        content .= "6.29 Помеха RP процессу | Ban 2-5 дней`r`n"
        return content
    }

    ; ----- ПАМЯТКА: ФРАКЦИИ -----
    if (sectionName = "fractions") {
        content := ""
        content .= "# ID | Название. Не более 12 строк — памятка рассчитана на две строки по шесть фракций.`r`n"
        content .= "1 | LSPD`r`n"
        content .= "2 | EMS`r`n"
        content .= "3 | SD`r`n"
        content .= "4 | SANG`r`n"
        content .= "5 | GOV`r`n"
        content .= "6 | WN`r`n"
        content .= "7 | FIB`r`n"
        content .= "8 | Ballas`r`n"
        content .= "9 | Vagos`r`n"
        content .= "10 | Fam`r`n"
        content .= "11 | Bloods`r`n"
        content .= "12 | Mara`r`n"
        return content
    }

    return ""
}

BinderPasteReply(text, submit := 0) {
    GreetingSendText(text)
    if (submit)
        SendInput, {Enter}
}
; ===== НАСТРОЙКИ НОВОГО АДМИНИСТРАТОРА =====
; Создаются один раз при первом запуске. Личные изменения сохраняются в res\Settings.ini.
BinderDefaultConfig() {
    config := ""
    config .= "[ANS]`r`n"
    config .= "CurrentDateT=0`r`n"
    config .= "DayANS=0`r`n"
    config .= "Week=0`r`n"
    config .= "WeekANS=0`r`n"
    config .= "[Discord]`r`n"
    config .= "dis=`r`n"
    config .= "gadis=`r`n"
    config .= "zgadis=`r`n"
    config .= "[Coords]`r`n"
    config .= "X=0`r`n"
    config .= "Y=0`r`n"
    config .= "X2=0`r`n"
    config .= "Y2=0`r`n"
    config .= "[Fraction]`r`n"
    config .= "Fraction=0`r`n"
    config .= "[ID]`r`n"
    config .= "Dinamic=`r`n"
    config .= "[Resolution]`r`n"
    config .= "1920x1080=1`r`n"
    config .= "1680x1050=0`r`n"
    config .= "1600x900=0`r`n"
    config .= "1366x768=0`r`n"
    config .= "1280x960=0`r`n"
    config .= "1920x10802=0`r`n"
    config .= "1280х1024=0`r`n"
    config .= "2560x1440=0`r`n"
    config .= "[Login Commands]`r`n"
    config .= "/hidecheatinfo=0`r`n"
    config .= "/showcheats=0`r`n"
    config .= "/dl=0`r`n"
    config .= "/esp 3=0`r`n"
    config .= "/templeader=0`r`n"
    config .= "/chide=0`r`n"
    config .= "/zzdebug=0`r`n"
    config .= "/objdl=0`r`n"
    config .= "/netstat=0`r`n"
    config .= "/advtoggle 0=0`r`n"
    config .= "[Binds]`r`n"
    config .= "KEY1=`r`n"
    config .= "KEY2=`r`n"
    config .= "KEY3=`r`n"
    config .= "KEY4=`r`n"
    config .= "KEY5=`r`n"
    config .= "KEY6=`r`n"
    config .= "KEY7=`r`n"
    config .= "KEY8=`r`n"
    config .= "KEY9=`r`n"
    config .= "KEY10=`r`n"
    config .= "KEY11=`r`n"
    config .= "KEY12=`r`n"
    config .= "KEY13=`r`n"
    config .= "KEY14=`r`n"
    config .= "KEY15=`r`n"
    config .= "KEY16=`r`n"
    config .= "KEY17=`r`n"
    config .= "KEY18=`r`n"
    config .= "KEY19=`r`n"
    config .= "KEY20=`r`n"
    config .= "[Greeting]`r`n"
    config .= "Hotkey=!e`r`n"
    config .= "[Admin]`r`n"
    config .= "Gender=male`r`n"
    config .= "[InitialSetup]`r`n"
    config .= "Complete=0`r`n"
    return config
}
