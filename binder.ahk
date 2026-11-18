#Requires AutoHotkey v2.0
#Warn LocalSameAsGlobal, Off
#SingleInstance Force
; Справочники и игровые сокращения загружаются из res\Shortcuts.tsv.
; Личные настройки и Punishment.txt создаются автоматически при первом запуске.
#UseHook
SetWorkingDir(A_ScriptDir)
A_MaxHotkeysPerInterval := 99000000
A_HotkeyInterval := 99000000
KeyHistory(0)
CoordMode("Pixel", "Window")
#HotIf WinActive("ahk_exe GTA5.exe")

ListLines(false)
try ProcessSetPriority("AboveNormal")
SetMouseDelay(-1)
SetDefaultMouseSpeed(0)
reloadStatus := 0
DayANS := 0
WeekANS := 0
punishmentFromGui := false
CurrentDate := FormatTime(, "ddMM")

if !FileExist(A_ScriptDir "\res")
    DirCreate(A_ScriptDir "\res")

settingsPath := A_ScriptDir . "\res\Settings.ini"
if !FileExist(settingsPath)
{
    settingsText := BinderDefaultConfig()
    try FileAppend(settingsText, settingsPath, "UTF-16")
    catch Error {
        MsgBox("Не удалось создать Settings.ini.", "Настройки", 16)
        ExitApp()
    }
}
if !FileExist(A_ScriptDir "\Punishment.txt")
{
punishmentFile := FileOpen(A_ScriptDir . "\Punishment.txt", "w", "UTF-8")
if IsObject(punishmentFile)
    punishmentFile.Close()
}
FileSetAttrib("-H", A_ScriptDir "\res")

Tray := A_TrayMenu
Tray.Delete()
Tray.add("Показать", Show)
Tray.Default := "Показать"
Tray.Add("Перезагрузить", ReloadBinder)
Tray.add("Скрыть", Hide)
Tray.add("Закрыть", Close)

Week := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "Week", 0)
CurrentDateT := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "CurrentDateT", 0)
if (CurrentDateT = CurrentDate)
{
CurrentDateT := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "CurrentDateT", 0)
DayANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "DayANS", 0)
}
else
{
    IniWrite(CurrentDate, A_ScriptDir "\res\Settings.ini", "ANS", "CurrentDateT")
    IniWrite(DayANS, A_ScriptDir "\res\Settings.ini", "ANS", "DayANS")
    DayANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "DayANS", 0)
    CurrentDateT := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "CurrentDateT", 0)
}
if (Week = A_YWeek)
{
Week := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "Week", 0)
WeekANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS", 0)
}
else
{
    IniWrite(A_YWeek, A_ScriptDir "\res\Settings.ini", "ANS", "Week")
    IniWrite(WeekANS, A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS")
    WeekANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS", 0)
    Week := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "Week", 0)
}

Radio1 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "1920x1080", 0)
Radio2 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "1600x900", 0)
Radio3 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "1680x1050", 0)
Radio4 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "1366x768", 0)
Radio5 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "1280x960", 0)
Radio6 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "1920x10802", 0)
Radio7 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "1280х1024", 0)
Radio17 := IniRead(A_ScriptDir "\res\Settings.ini", "Resolution", "2560x1440", 0)

Radio8 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/hidecheatinfo", 0)
Radio9 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/showcheats", 0)
Radio10 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/dl", 0)
Radio11 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/esp 3", 0)
Radio12 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/templeader", 0)
Radio13 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/chide", 0)
Radio14 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/zzdebug", 0)
Radio15 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/objdl", 0)
Radio16 := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/netstat", 0)
LoginAdvToggle := IniRead(A_ScriptDir "\res\Settings.ini", "Login Commands", "/advtoggle 0", 0)

key1 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY1", "")
key2 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY2", "")
key3 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY3", "")
key4 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY4", "")
key5 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY5", "")
key6 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY6", "")
key7 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY7", "")
key8 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY8", "")
key9 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY9", "")
key10 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY10", "")
key11 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY11", "")
key12 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY12", "")
key13 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY13", "")
key14 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY14", "")
key15 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY15", "")
key16 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY16", "")
key17 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY17", "")
key18 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY18", "")
key19 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY19", "")
key20 := IniRead(A_ScriptDir "\res\Settings.ini", "Binds", "KEY20", "")
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

dis := IniRead(A_ScriptDir "\res\Settings.ini", "Discord", "dis", "ERROR")
gadis := IniRead(A_ScriptDir "\res\Settings.ini", "Discord", "gadis", "ERROR")
zgadis := IniRead(A_ScriptDir "\res\Settings.ini", "Discord", "zgadis", "ERROR")
GreetingText := "Приветствую. Сейчас займусь Вашим обращением."
GreetingHotkey := IniRead(A_ScriptDir "\res\Settings.ini", "Greeting", "Hotkey", "!e")
GreetingHotkey := NormalizeBinderHotkey(GreetingHotkey)
if (GreetingHotkey = "")
    GreetingHotkey := "!e"
AdminGender := IniRead(A_ScriptDir "\res\Settings.ini", "Admin", "Gender", "male")
if (AdminGender != "female")
    AdminGender := "male"
GenderMale := AdminGender = "male" ? 1 : 0
GenderFemale := AdminGender = "female" ? 1 : 0
CounterHidden := IniRead(A_ScriptDir "\res\Settings.ini", "Counter", "Hidden", 0)
if (CounterHidden != 1)
    CounterHidden := 0
ClickerEnabled := IniRead(settingsPath, "Clicker", "Enabled", 0) = 1 ? 1 : 0
ClickerKey := IniRead(settingsPath, "Clicker", "Key", "XButton1")
ClickerInterval := IniRead(settingsPath, "Clicker", "Interval", 100)
clickerRunning := false
clickerEnabledDraft := ClickerEnabled
clickerCapture := ""
if !ClickerKey
    ClickerKey := "XButton1"
clickerPendingKey := ClickerKey
if !RegExMatch(ClickerInterval, "^\d+$") || ClickerInterval < 10 || ClickerInterval > 10000
    ClickerInterval := 100

if (dis = "ERROR")
{
IniWrite("Bruno", A_ScriptDir "\res\Settings.ini", "Discord", "dis")
IniWrite("brunoalvazez", A_ScriptDir "\res\Settings.ini", "Discord", "gadis")
IniWrite("hewerro", A_ScriptDir "\res\Settings.ini", "Discord", "zgadis")
}

X := IniRead(A_ScriptDir "\res\Settings.ini", "Coords", "X", "ERROR")
Y := IniRead(A_ScriptDir "\res\Settings.ini", "Coords", "Y", "ERROR")
X2 := IniRead(A_ScriptDir "\res\Settings.ini", "Coords", "X2", 0)
Y2 := IniRead(A_ScriptDir "\res\Settings.ini", "Coords", "Y2", 0)
Fraction := IniRead(A_ScriptDir "\res\Settings.ini", "Fraction", "Fraction", "ERROR")

if (X = "ERROR")
{
IniWrite(0, A_ScriptDir "\res\Settings.ini", "Coords", "X")
IniWrite(0, A_ScriptDir "\res\Settings.ini", "Coords", "Y")
IniWrite(0, A_ScriptDir "\res\Settings.ini", "Coords", "X2")
IniWrite(0, A_ScriptDir "\res\Settings.ini", "Coords", "Y2")
IniWrite(7, A_ScriptDir "\res\Settings.ini", "Fraction", "Fraction")
Reload()
}

;гуи счетчика
WinSet_Click_Through(I, T := "254") {
    if WinExist("ahk_id " I)
    {
    If (T == "Off")
    {
    WinSetAlwaysOnTop(0, "ahk_id " I)
    WinSetTransparent("Off", "ahk_id " I)
    WinSetExStyle("-0x20", "ahk_id " I)
    }
    Else
    {
    WinSetAlwaysOnTop(1, "ahk_id " I)
    if (!IsNumber(T) || T < 0 || T > 254)
    T := 254
    WinSetTransparent(T, "ahk_id " I)
    WinSetExStyle("+0x20", "ahk_id " I)
    }
    }
    Else
    Return 0
}

NormalizeBinderHotkey(keyName) {
    russianLower := "йцукенгшщзхъфывапролджэячсмитьбю"
    russianUpper := "ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ"
    latinKeys := "qwertyuiop[]asdfghjkl;'zxcvbnm,."
    Loop Parse, russianLower
    {
        latinKey := SubStr(latinKeys, A_Index, 1)
        keyName := StrReplace(keyName, A_LoopField, latinKey)
        keyName := StrReplace(keyName, SubStr(russianUpper, A_Index, 1), latinKey)
    }
    keyName := StrReplace(StrReplace(keyName, "ё", "sc029"), "Ё", "sc029")
    return keyName
}

PhysicalBinderHotkey(keyName) {
    if !RegExMatch(keyName, "^([*~$<>^!+#]*)(.)$", &parts)
        return keyName
    keyChar := parts[2]
    keyChar := StrLower(keyChar)
    if (keyChar = "ё")
        return parts[1] . "sc029"
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
    return parts[1] . "sc" . scanCodes[keyIndex]
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

myGui := Gui("+AlwaysOnTop -Caption +ToolWindow", "Overlay")
ID := myGui.Hwnd
myGui.BackColor := "1c2126"
myGui.SetFont("s10 q1 w400", "Proxima Nova")
ogcMyText := myGui.Add("Text", "x9 vMyText cWhite", "XXX, YYYY")
ogcTextMyTotalR := myGui.Add("Text", "x107 y7 vMyTotalR cWhite", "XXXXXX, YYYYYY")
WinSet_Click_Through(ID, "On")
WinSetTransColor("AAAAAA 170", ID)
UpdateCounter1()
myGui.Show("NA x" X " y" Y " w212 h30" (CounterHidden ? " Hide" : ""))

HotIfWinActive("ahk_exe GTA5.exe")
BinderRegisterHotkey(PhysicalBinderHotkey(KEY1), Reports)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY2), delv)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY3), gm)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY4), vac)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY5), mess)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY6), dimcar)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY7), gcar)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY8), mtp)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY9), repm)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY10), rep)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY11), vhod)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY12), resc)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY14), Cheatsheet)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY15), gh)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY16), chide)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY17), zzdebug)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY18), reshp)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY19), killplayer)
BinderRegisterHotkey(PhysicalBinderHotkey(KEY20), f5)
if (KEY13 != "") {
    punishmentBindGameError := !BinderRegisterHotkey(PhysicalBinderHotkey(KEY13), PunishmentHandler, "On")
    HotIfWinActive("ahk_exe ragemp_v.exe")
    punishmentBindRageError := !BinderRegisterHotkey(PhysicalBinderHotkey(KEY13), PunishmentHandler, "On")
    HotIfWinActive("ahk_exe GTA5.exe")
}

; Главное окно: темная палитра и розовый акцент Majestic.
Dinamic := IniRead(A_ScriptDir "\res\Settings.ini", "ID", "Dinamic", "")
Main := Gui()
Main.OnEvent("Close", guiclose2)
Main.Opt("-Caption +Border +MinimizeBox +LastFound")
Main.BackColor := "12131A"
Main.SetFont("s10 cE9EAF0", "Segoe UI")
Main.Add("Progress", "x0 y0 w1040 h78 c1B1D27 Background1B1D27 Disabled", "100")
Text1 := Main.Add("Text", "x265 y0 w160 h76 +BackgroundTrans"), MainDragZone := Text1.hwnd
Text1.OnEvent("Click", MainDrag)
Main.SetFont("s17 w700 cFFFFFF", "Segoe UI")
ogcMAJESTICMainBrand := Main.Add("Text", "x24 y15 w230 h30 +BackgroundTrans", "MAJESTIC"), MainBrand := ogcMAJESTICMainBrand.hwnd
ogcMAJESTICMainBrand.OnEvent("Click", MainDrag)
Main.SetFont("s9 w600 cEA3479", "Segoe UI")
ogcADMINBINDERMainSubtitle := Main.Add("Text", "x26 y47 w230 h18 +BackgroundTrans", "ADMIN  /  BINDER"), MainSubtitle := ogcADMINBINDERMainSubtitle.hwnd
ogcADMINBINDERMainSubtitle.OnEvent("Click", MainDrag)
Main.SetFont("s10 w600 cD9DCE8", "Segoe UI")
clickerNav := Main.Add("Text", "x430 y27 w174 h28 +0x200 +0x100 Center Background292C38", "КЛИКЕР")
clickerNav.OnEvent("Click", MainShowClicker)
Text4 := Main.Add("Text", "x610 y27 w174 h28 +0x200 +0x100 Center Background292C38", "БИНДЫ"), MainNavBinds := Text4.hwnd
Text4.OnEvent("Click", MainShowBinds)
Text5 := Main.Add("Text", "x790 y27 w174 h28 +0x200 +0x100 Center Background292C38", "НАСТРОЙКИ"), MainNavSettings := Text5.hwnd
Text5.OnEvent("Click", MainShowSettings)
ogcProgressMainTabAccent := Main.Add("Progress", "x610 y57 w174 h3 cEA3479 BackgroundEA3479 Disabled vMainTabAccent", "100")
Main.SetFont("s15 w400 cAEB1BF", "Segoe UI")
Text6 := Main.Add("Text", "x972 y25 w28 h30 +0x200 +0x100 Center +BackgroundTrans", "−"), MainMinimize := Text6.hwnd
Text6.OnEvent("Click", Hide)
Text7 := Main.Add("Text", "x1003 y25 w27 h30 +0x200 +0x100 Center +BackgroundTrans", "×"), MainClose := Text7.hwnd
Text7.OnEvent("Click", Close)
Main.Add("Progress", "x0 y77 w1040 h2 cEA3479 BackgroundEA3479 Disabled", "100")

; Общая навигация по справочникам.
Main.Add("Progress", "x16 y108 w180 h506 c1B1D27 Background1B1D27 Disabled", "100")
Main.SetFont("s9 w700 cEA3479", "Segoe UI")
Main.Add("Text", "x28 y129 w156 h20 Center +BackgroundTrans", "РАЗДЕЛЫ")
Main.SetFont("s10 w500 cE9EAF0", "Segoe UI")
Text9 := Main.Add("Text", "x28 y162 w156 h34 +0x200 +0x100 Center Background292C38", "Общая информация"), MainInfo := Text9.hwnd
Text9.OnEvent("Click", Info)
Text10 := Main.Add("Text", "x28 y204 w156 h34 +0x200 +0x100 Center Background292C38", "Команды"), MainCommands := Text10.hwnd
Text10.OnEvent("Click", Commandlist)
Text11 := Main.Add("Text", "x28 y246 w156 h34 +0x200 +0x100 Center Background292C38", "Ответы"), MainAnswers := Text11.hwnd
Text11.OnEvent("Click", Answers)
Text12 := Main.Add("Text", "x28 y288 w156 h34 +0x200 +0x100 Center Background292C38", "Наказания"), MainPunish := Text12.hwnd
Text12.OnEvent("Click", Punish)
Text13 := Main.Add("Text", "x28 y330 w156 h34 +0x200 +0x100 Center Background292C38", "Полезное"), MainUseful := Text13.hwnd
Text13.OnEvent("Click", Usefull)
ogcText := Main.Add("Text", "x28 y390 w156 h34 +0x200 +0x100 Center Background292C38", "Редактор сокращений")
ogcText.OnEvent("Click", ShortcutEditorOpen)
ogcProgressMainSectionAccent := Main.Add("Progress", "x28 y198 w156 h3 cEA3479 BackgroundEA3479 Disabled Hidden vMainSectionAccent", "100")
; Tab2 находится за границей окна: его дочерние поля остаются видимыми.
V2TabCtrl := ogcTab2MainTabs := Main.Add("Tab2", "x-200 y-200 w1 h1 vMainTabs", ["Бинды", "Настройки", "Справочник", "Кликер"])
ogcTab2MainTabs.OnEvent("Change", MainTabChanged)
V2TabCtrl.UseTab(1)
Main.Add("Progress", "x212 y108 w548 h506 c1B1D27 Background1B1D27 Disabled", "100")
Main.Add("Progress", "x776 y108 w248 h432 c1B1D27 Background1B1D27 Disabled", "100")
Main.Add("Progress", "x776 y544 w248 h70 c1B1D27 Background1B1D27 Disabled", "100")
Main.SetFont("s15 w700 cFFFFFF", "Segoe UI")
Main.Add("Text", "x230 y126 w290 h31 +BackgroundTrans", "Горячие клавиши")
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x230 y158 w490 h22 +BackgroundTrans", "Назначьте сочетания для частых действий администрации")
Main.SetFont("s12 w700 cFFFFFF", "Segoe UI")
Main.Add("Text", "x794 y127 w210 h28 +BackgroundTrans", "Команды при входе")
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x794 y155 w210 h20 +BackgroundTrans", "Отметьте нужные команды")

bindRows := [[1, "Открыть репорты"], [2, "Удалить транспорт"], [3, "Вкл/выкл /gm"]
    , [4, "Вакцина"], [5, "Первое сообщение"], [7, "ТП авто к себе"]
    , [8, "ТП на метку"], [9, "Убрать -1 репорт"], [10, "Добавить +1 репорт"]
    , [12, "Воскресить игрока"], [19, "Убить игрока"], [13, "Выдача наказаний"]
    , [16, "Вкл/выкл /chide"], [17, "Вкл/выкл /zzdebug"], [18, "HP 0 + rescue"]
    , [15, "Вкл/выкл /gh"], [11, "Команды при входе"], [20, "Уйти в F5"]
    , [6, "Машина после воды"], [14, "Памятка"]]
mainBindLabelHwnds := Map()
for rowIndex, bind in bindRows
{
    col := rowIndex > 10 ? 1 : 0
    row := Mod(rowIndex - 1, 10)
    left := col ? 497 : 230
    top := 190 + row * 40
    name := "KEY" bind[1]
    keyValue := %name%
    Main.Add("Progress", "x" left " y" top " w248 h33 c272A36 Background272A36 Disabled", "100")
    Main.SetFont("s9 w500 cE9EAF0", "Segoe UI")
    bindLabel := Main.Add("Text", "x" (left + 11) " y" (top + 7) " w165 h18", bind[2])
    if (bind[1] = 13)
        bindLabel.OnEvent("Click", PunishmentOpenFromGui)
    mainBindLabelHwnds[bindLabel.Hwnd] := true
    Main.SetFont("s9 w500 cFFFFFF", "Segoe UI")
    ogcHotkeyHotbind := Main.Add("Hotkey", "x" (left + 179) " y" (top + 4) " w61 h25 vHot" bind[1] "", keyValue), BindHotkeyHwnd := ogcHotkeyHotbind.hwnd
    if (bind[1] = 13)
        mainPunishmentHotkeyHwnd := bindHotkeyHwnd
}

Main.SetFont("s10 w500 cE9EAF0", "Segoe UI")
ogcCheckBoxRadio8 := Main.Add("CheckBox", "x794 y189 w210 h28 vRadio8 Checked" . Radio8, "/hidecheatinfo"), MainLogin8 := ogcCheckBoxRadio8.hwnd
ogcCheckBoxRadio9 := Main.Add("CheckBox", "x794 y225 w210 h28 vRadio9 Checked" . Radio9, "/showcheats"), MainLogin9 := ogcCheckBoxRadio9.hwnd
ogcCheckBoxRadio10 := Main.Add("CheckBox", "x794 y261 w210 h28 vRadio10 Checked" . Radio10, "/dl"), MainLogin10 := ogcCheckBoxRadio10.hwnd
ogcCheckBoxRadio11 := Main.Add("CheckBox", "x794 y297 w210 h28 vRadio11 Checked" . Radio11, "/esp 3"), MainLogin11 := ogcCheckBoxRadio11.hwnd
ogcCheckBoxRadio12 := Main.Add("CheckBox", "x794 y333 w210 h28 vRadio12 Checked" . Radio12, "/templeader " . Fraction), MainLogin12 := ogcCheckBoxRadio12.hwnd
ogcCheckBoxRadio13 := Main.Add("CheckBox", "x794 y369 w210 h28 vRadio13 Checked" . Radio13, "/chide"), MainLogin13 := ogcCheckBoxRadio13.hwnd
ogcCheckBoxRadio14 := Main.Add("CheckBox", "x794 y405 w210 h28 vRadio14 Checked" . Radio14, "/zzdebug"), MainLogin14 := ogcCheckBoxRadio14.hwnd
ogcCheckBoxRadio15 := Main.Add("CheckBox", "x794 y441 w210 h28 vRadio15 Checked" . Radio15, "/objdl"), MainLogin15 := ogcCheckBoxRadio15.hwnd
ogcCheckBoxRadio16 := Main.Add("CheckBox", "x794 y477 w210 h28 vRadio16 Checked" . Radio16, "/netstat"), MainLogin16 := ogcCheckBoxRadio16.hwnd
ogcCheckBoxLoginAdvToggle := Main.Add("CheckBox", "x794 y509 w210 h28 vLoginAdvToggle Checked" . LoginAdvToggle, "/advtoggle 0"), MainLoginAdvToggle := ogcCheckBoxLoginAdvToggle.hwnd
mainLoginHwnds := Map()
Loop 9 {
    loginIndex := A_Index + 7
    loginName := "MainLogin" loginIndex
    loginHwnd := %loginName%
    mainLoginHwnds[loginHwnd] := true
}
mainLoginHwnds[MainLoginAdvToggle] := true
Main.SetFont("s10 w600 cFFFFFF", "Segoe UI")
Main.Add("Text", "x794 y558 w105 h25 +BackgroundTrans", "Ваш статик")
ogcEditDinamic := Main.Add("Edit", "x901 y555 w50 h27 +Number vDinamic", Dinamic)
Main.SetFont("s10 w700 cFFFFFF", "Segoe UI")
Text21 := Main.Add("Text", "x960 y555 w48 h27 +0x200 +0x100 Center BackgroundEA3479", "✓"), MainSaveDynamic := Text21.hwnd
Text21.OnEvent("Click", SaveData1)

V2TabCtrl.UseTab(2)
Main.Add("Progress", "x212 y108 w250 h506 c1B1D27 Background1B1D27 Disabled", "100")
Main.Add("Progress", "x476 y108 w266 h506 c1B1D27 Background1B1D27 Disabled", "100")
Main.Add("Progress", "x756 y108 w268 h506 c1B1D27 Background1B1D27 Disabled", "100")
Main.SetFont("s13 w700 cFFFFFF", "Segoe UI")
Main.Add("Text", "x230 y130 w218 h28 +BackgroundTrans", "Экран")
Main.Add("Text", "x494 y130 w230 h28 +BackgroundTrans", "Администрация")
Main.Add("Text", "x774 y130 w235 h28 +BackgroundTrans", "Ответы и оверлей")
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x230 y160 w218 h36 +BackgroundTrans", "Разрешение для игровых действий")
Main.Add("Text", "x494 y160 w230 h36 +BackgroundTrans", "Данные для команд и связи")
Main.Add("Text", "x774 y160 w235 h36 +BackgroundTrans", "Положение счётчика и форма ответов")
Main.SetFont("s10 cE9EAF0", "Segoe UI")
ogcRadio17 := Main.Add("Radio", "x230 y210 w215 h27 Group vRadio17 Checked" . Radio17, "2560 × 1440 (2K)"), MainResolution17 := ogcRadio17.hwnd
ogcRadio1 := Main.Add("Radio", "x230 y249 w215 h27 vRadio1 Checked" . Radio1, "1920 × 1080"), MainResolution1 := ogcRadio1.hwnd
ogcRadio6 := Main.Add("Radio", "x230 y288 w215 h27 vRadio6 Checked" . Radio6, "1920 × 1080 (5:4)"), MainResolution6 := ogcRadio6.hwnd
ogcRadio3 := Main.Add("Radio", "x230 y327 w215 h27 vRadio3 Checked" . Radio3, "1680 × 1050"), MainResolution3 := ogcRadio3.hwnd
ogcRadio2 := Main.Add("Radio", "x230 y366 w215 h27 vRadio2 Checked" . Radio2, "1600 × 900"), MainResolution2 := ogcRadio2.hwnd
ogcRadio4 := Main.Add("Radio", "x230 y405 w215 h27 vRadio4 Checked" . Radio4, "1366 × 768"), MainResolution4 := ogcRadio4.hwnd
ogcRadio5 := Main.Add("Radio", "x230 y444 w215 h27 vRadio5 Checked" . Radio5, "1280 × 960"), MainResolution5 := ogcRadio5.hwnd
ogcRadio7 := Main.Add("Radio", "x230 y483 w215 h27 vRadio7 Checked" . Radio7, "1280 × 1024"), MainResolution7 := ogcRadio7.hwnd
mainSettingsRadioHwnds := Map()
for _, radioHwnd in [MainResolution17, MainResolution1, MainResolution6, MainResolution3
    , MainResolution2, MainResolution4, MainResolution5, MainResolution7]
    mainSettingsRadioHwnds[radioHwnd] := true

Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x494 y208 w230 h20 +BackgroundTrans", "ФРАКЦИЯ")
Main.Add("Text", "x494 y242 w75 h22 +0x200 +BackgroundTrans", "ID фракции")
ogcEditFraction := Main.Add("Edit", "x610 y240 w110 h27 +Number vFraction", Fraction)
Main.Add("Text", "x494 y301 w230 h20 +BackgroundTrans", "DISCORD")
Main.Add("Text", "x494 y337 w75 h22 +0x200 +BackgroundTrans", "Админ")
ogcEditdis := Main.Add("Edit", "x568 y335 w152 h27 vdis", dis)
Main.Add("Text", "x494 y378 w75 h22 +0x200 +BackgroundTrans", "ГА")
ogcEditgadis := Main.Add("Edit", "x568 y376 w152 h27 vgadis", gadis)
Main.Add("Text", "x494 y419 w75 h22 +0x200 +BackgroundTrans", "ЗГА")
ogcEditzgadis := Main.Add("Edit", "x568 y417 w152 h27 vzgadis", zgadis)
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x494 y467 w226 h21 +BackgroundTrans", "ПРИВЕТСТВИЕ")
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x494 y499 w103 h27 +0x200 +BackgroundTrans", "Клавиша")
Main.SetFont("s10 cFFFFFF", "Segoe UI")
greetingHotkeyLabel := GreetingHotkeyDisplayText(GreetingHotkey)
ogcTextGreetingHotkeyDisplay := Main.Add("Text", "x610 y499 w110 h27 +0x200 +0x100 Center Background343746 vGreetingHotkeyDisplay", greetingHotkeyLabel)
ogcTextGreetingHotkeyDisplay.OnEvent("Click", GreetingHotkeyBegin)
ogcGreetingHotkey := Main.Add("Hotkey", "x610 y499 w110 h27 vGreetingHotkey Hidden", GreetingHotkey), GreetingHotkeyHwnd := ogcGreetingHotkey.hwnd
Main.SetFont("s8 c989DAD", "Segoe UI")
Main.Add("Text", "x494 y540 w226 h34 +BackgroundTrans", "Нажмите на поле, чтобы выбрать сочетание.")

Main.SetFont("s9 w600 cEA3479", "Segoe UI")
Main.Add("Text", "x774 y210 w225 h22 +BackgroundTrans", "СЧЁТЧИК")
Main.SetFont("s10 w700 q0 cFFFFFF", "Segoe UI")
ogcTextCounterMoveAction := Main.Add("Text", "x762 y247 w256 h34 +0x200 +0x100 Center vCounterMoveAction", "ИЗМЕНИТЬ ПОЛОЖЕНИЕ СЧЁТЧИКА"), counterMoveButtonHwnd := ogcTextCounterMoveAction.hwnd
ogcTextCounterMoveAction.OnEvent("Click", CounterMoveStart)
Main.SetFont("s10 w700 q0 cAEB1BF", "Segoe UI")
ogcTextCounterMoveInactive := Main.Add("Text", "x762 y247 w256 h34 +0x200 Center vCounterMoveInactive Hidden", "ИЗМЕНИТЬ ПОЛОЖЕНИЕ СЧЁТЧИКА"), counterMoveInactiveHwnd := ogcTextCounterMoveInactive.hwnd
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Progress", "x774 y289 w230 h34 c292C38 Background292C38 Disabled", "100")
Main.SetFont("s9 w700 cFFFFFF", "Segoe UI")
ogcCounterVisibilityAction := Main.Add("Text", "x774 y289 w230 h34 +0x200 +0x100 Center +BackgroundTrans vCounterVisibilityAction", CounterHidden ? "ПОКАЗАТЬ СЧЁТЧИК" : "СКРЫТЬ СЧЁТЧИК")
ogcCounterVisibilityAction.OnEvent("Click", CounterVisibilityToggle)
CounterUpdateMoveButton()
Main.SetFont("s9 w600 cEA3479", "Segoe UI")
Main.Add("Text", "x774 y371 w225 h22 +BackgroundTrans", "ПОЛ АДМИНИСТРАТОРА")
Main.SetFont("s10 cE9EAF0", "Segoe UI")
ogcRadioGenderMale := Main.Add("Radio", "x774 y410 w112 h28 vGenderMale Group Checked" . GenderMale, "Мужской")
ogcRadioGenderMale.OnEvent("Click", SelectMale)
ogcRadioGenderFemale := Main.Add("Radio", "x890 y410 w112 h28 vGenderFemale Checked" . GenderFemale, "Женский")
ogcRadioGenderFemale.OnEvent("Click", SelectFemale)
Main.SetFont("s8 c989DAD", "Segoe UI")
Main.Add("Text", "x774 y448 w229 h45 +BackgroundTrans", "Выбор меняет формулировки ответов и подсказок после сохранения.")
Main.SetFont("s10 w700 cFFFFFF", "Segoe UI")
ogcTextUpdateBinder := Main.Add("Text", "x774 y520 w230 h34 +0x200 +0x100 Center BackgroundEA3479", "Обновить")
ogcTextUpdateBinder.OnEvent("Click", UpdateBinder)

V2TabCtrl.UseTab(3)
Main.Add("Progress", "x212 y108 w812 h506 c1B1D27 Background1B1D27 Disabled", "100")
Main.SetFont("s15 w700 cFFFFFF", "Segoe UI")
ogcTextMainSectionTitle := Main.Add("Text", "x230 y126 w776 h31 vMainSectionTitle +BackgroundTrans", "Справочник")
Main.SetFont("s9 c989DAD", "Segoe UI")
ogcTextMainSectionSubtitle := Main.Add("Text", "x230 y160 w776 h22 vMainSectionSubtitle +BackgroundTrans", "Быстрые ответы и команды администрации")
Main.SetFont("s9 w700 cEA3479", "Segoe UI")
ogcTextMainUsefulSearchLabel := Main.Add("Text", "x641 y133 w62 h23 vMainUsefulSearchLabel +BackgroundTrans Hidden", "ПОИСК")
Main.SetFont("s10 w400 cE9EAF0", "Segoe UI")
ogcEditMainUsefulSearch := Main.Add("Edit", "x710 y129 w245 h28 vMainUsefulSearch -Border Background292C38 Hidden"), MainUsefulSearchHwnd := ogcEditMainUsefulSearch.hwnd
ogcEditMainUsefulSearch.OnEvent("Change", MainUsefulSearchChanged)
DllCall("SendMessage", "Ptr", MainUsefulSearchHwnd, "UInt", 0x1501, "Ptr", 1, "WStr", "Поиск по разделам")
Main.SetFont("s15 w400 cEA3479", "Segoe UI")
ogcTextMainUsefulSearchClear := Main.Add("Text", "x958 y129 w25 h28 vMainUsefulSearchClear +0x200 +0x100 Center Background292C38 Hidden", "×")
ogcTextMainUsefulSearchClear.OnEvent("Click", MainUsefulSearchClear)
ogcProgressMainUsefulSearchAccent := Main.Add("Progress", "x710 y158 w273 h2 cEA3479 BackgroundEA3479 Disabled vMainUsefulSearchAccent Hidden", "100")
Main.SetFont("s9 w700 cEA3479", "Segoe UI")
ogcTextMainAnswersSearchLabel := Main.Add("Text", "x641 y133 w62 h23 vMainAnswersSearchLabel +BackgroundTrans Hidden", "ПОИСК")
Main.SetFont("s10 w400 cE9EAF0", "Segoe UI")
ogcEditMainAnswersSearch := Main.Add("Edit", "x710 y129 w245 h28 vMainAnswersSearch -Border Background292C38 Hidden"), MainAnswersSearchHwnd := ogcEditMainAnswersSearch.hwnd
ogcEditMainAnswersSearch.OnEvent("Change", MainAnswersSearchChanged)
DllCall("SendMessage", "Ptr", MainAnswersSearchHwnd, "UInt", 0x1501, "Ptr", 1, "WStr", "Поиск по разделам")
Main.SetFont("s15 w400 cEA3479", "Segoe UI")
ogcTextMainAnswersSearchClear := Main.Add("Text", "x958 y129 w25 h28 vMainAnswersSearchClear +0x200 +0x100 Center Background292C38 Hidden", "×")
ogcTextMainAnswersSearchClear.OnEvent("Click", MainAnswersSearchClear)
ogcProgressMainAnswersSearchAccent := Main.Add("Progress", "x710 y158 w273 h2 cEA3479 BackgroundEA3479 Disabled vMainAnswersSearchAccent Hidden", "100")
richEditModule := DllCall("LoadLibrary", "Str", "Msftedit.dll", "Ptr")
if (!richEditModule) {
    MsgBox("Не удалось загрузить компонент подсветки текста.", "Справочник", 16)
    ExitApp()
}
Main.SetFont("s11 w400 cE9EAF0", "Segoe UI")
ogcCustomMainSectionBody := Main.Add("Custom", "ClassRICHEDIT50W x230 y193 w690 h399 vMainSectionBody +0x4 +0x40 +0x800 -Border"), MainSectionBodyHwnd := ogcCustomMainSectionBody.hwnd
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x443, "Ptr", 0, "Ptr", 0x271D1B)
sectionTextFormat := Buffer(116, 0)
NumPut("UInt", 116, sectionTextFormat, 0)
NumPut("UInt", 0x40000000, sectionTextFormat, 4)
NumPut("UInt", 0xF0EAE9, sectionTextFormat, 20)
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x444, "Ptr", 0, "Ptr", sectionTextFormat.Ptr)
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x435, "Ptr", 0, "Ptr", 1000000)
DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xD3, "Ptr", 3, "Ptr", 12 | (12 << 16))
ogcTextMainSectionScrollTrack := Main.Add("Text", "x994 y193 w12 h399 +0x100 Background292C38 vMainSectionScrollTrack", Chr(160)), MainSectionScrollTrackHwnd := ogcTextMainSectionScrollTrack.hwnd
ogcTextMainSectionScrollTrack.OnEvent("Click", MainSectionScrollClick)
ogcProgressMainSectionScrollThumb := Main.Add("Progress", "x996 y195 w8 h32 cEA3479 BackgroundEA3479 Disabled vMainSectionScrollThumb Hidden", "100"), MainSectionScrollThumbHwnd := ogcProgressMainSectionScrollThumb.hwnd
mainAnswerActions := Map()
mainAnswerButtonY := Map()
Loop 24 {
    Main.SetFont("s11 cEA3479", "Segoe UI Symbol")
    ogcTextMainAnswerEditA_Index := Main.Add("Text", "x929 y193 w25 h22 Center +0x200 +0x100 Background292C38 Hidden vMainAnswerEdit" A_Index, "✎")
    ogcTextMainAnswerEditA_Index.OnEvent("Click", MainAnswerEdit)
    Main.SetFont("s11 cEA3479", "Segoe UI Emoji")
    ogcTextMainAnswerDeleteA_Index := Main.Add("Text", "x958 y193 w25 h22 Center +0x200 +0x100 Background292C38 Hidden vMainAnswerDelete" A_Index, "🗑")
    ogcTextMainAnswerDeleteA_Index.OnEvent("Click", MainAnswerDelete)
}
Main.SetFont("s9 w700 cEA3479", "Segoe UI")
ogcTextMainChaptersBack := Main.Add("Text", "x230 y129 w125 h28 +0x200 +0x100 Center Background292C38 vMainChaptersBack Hidden", "← К ГЛАВАМ")
ogcTextMainChaptersBack.OnEvent("Click", MainChaptersBack)
answerChapters := ["Вики", "Информация", "Адм Ответы", "asms", "Приветствие", "Discord"]
punishmentChapters := ["demorgan", "mute", "warn", "ban", "gunban"]
usefulChapters := ["Предметы", "Локации", "БП", "Рейд", "Влияние", "Предметы события", "Валюта события", "Такси", "Дрифт", "Навыки", "Телепорты"]
mainActiveSearchQuery := ""
mainAnswerEntries := []
mainCurrentSection := ""
mainLastHighlightedLine := -1
mainSelectedChapter := ""
Cheatsheet1 := false
mainChaptersVisible := false
mainShownChapterCount := 0
mainShownChapterSection := ""
Loop 11 {
    chapterIndex := A_Index
    chapterX := 230 + Mod(chapterIndex - 1, 2) * 388
    chapterY := 203 + Floor((chapterIndex - 1) / 2) * 64
    ogcProgressMainChapterBgchapterIndex := Main.Add("Progress", "x" chapterX " y" chapterY " w370 h50 c292C38 Background292C38 Disabled vMainChapterBg" chapterIndex " Hidden", "100")
    Main.SetFont("s11 w700 cFFFFFF", "Segoe UI")
    ogcTextMainChapterchapterIndex := Main.Add("Text", "x" chapterX " y" chapterY " w370 h50 +0x200 +0x100 Center +BackgroundTrans vMainChapter" chapterIndex " Hidden")
    ogcTextMainChapterchapterIndex.OnEvent("Click", MainChapterChoose)
}

V2TabCtrl.UseTab(4)
Main.Add("Progress", "x212 y108 w812 h506 c1B1D27 Background1B1D27 Disabled", "100")
Main.SetFont("s15 w700 cFFFFFF", "Segoe UI")
Main.Add("Text", "x230 y126 w776 h31 +BackgroundTrans", "Настройки кликера")
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x230 y160 w776 h22 +BackgroundTrans", "Удерживайте назначенную кнопку для повторных нажатий левой кнопкой мыши в игре")
Main.SetFont("s10 w600 cE9EAF0", "Segoe UI")
Main.Add("Text", "x230 y214 w200 h28 +BackgroundTrans", "Кликер")
clickerSwitch := Main.Add("Text", "x610 y211 w190 h30 +0x200 +0x100 Center Background1B1D27", ClickerEnabled ? "●  ВКЛЮЧЁН" : "○  ВЫКЛЮЧЕН")
clickerSwitch.OnEvent("Click", ClickerToggle)
Main.Add("Text", "x230 y268 w250 h28 +BackgroundTrans", "Кнопка удержания")
clickerKeyDisplay := Main.Add("Text", "x610 y263 w190 h30 +0x200 +0x100 Center Background292C38", ClickerKeyLabel(ClickerKey))
clickerKeyDisplay.OnEvent("Click", ClickerBeginCapture)
Main.Add("Text", "x230 y322 w250 h28 +BackgroundTrans", "Интервал между кликами")
Main.SetFont("s10 w700 cFFFFFF", "Segoe UI")
clickerIntervalEdit := Main.Add("Edit", "x610 y317 w110 h28 +Number -Border Background292C38 vClickerInterval", ClickerInterval)
Main.SetFont("s10 w600 cE9EAF0", "Segoe UI")
Main.Add("Text", "x730 y322 w80 h28 +BackgroundTrans", "мс")
Main.SetFont("s9 c989DAD", "Segoe UI")
Main.Add("Text", "x230 y376 w720 h44 +BackgroundTrans", "Нажмите на поле, затем нужную клавишу или кнопку мыши. Настройки применятся после сохранения.")

V2TabCtrl.UseTab()
Main.SetFont("s9 c989DAD", "Segoe UI")
ogcTextMainFooterHint := Main.Add("Text", "x214 y631 w560 h20 vMainFooterHint +BackgroundTrans", "Изменения вступят в силу после сохранения")
Main.SetFont("s10 w700 cFFFFFF", "Segoe UI")
ogcProgressMainSaveBackground := Main.Add("Progress", "x806 y623 w218 h34 cEA3479 BackgroundEA3479 Disabled vMainSaveBackground", "100")
ogcTextMainSaveAction := Main.Add("Text", "x806 y623 w218 h34 +0x200 +0x100 Center +BackgroundTrans vMainSaveAction", "СОХРАНИТЬ И ПРИМЕНИТЬ"), MainSave := ogcTextMainSaveAction.hwnd
ogcTextMainSaveAction.OnEvent("Click", SaveData)
mainSectionBrush := DllCall("CreateSolidBrush", "UInt", 0x271D1B, "Ptr")
mainBindRowBrush := DllCall("CreateSolidBrush", "UInt", 0x362A27, "Ptr")
mainActionBrush := DllCall("CreateSolidBrush", "UInt", 0x7934EA, "Ptr")
mainInactiveActionBrush := DllCall("CreateSolidBrush", "UInt", 0x463734, "Ptr")
shortcutEditorHwnd := 0
shortcutOpenRecord := 0
shortcutOpenSection := ""
shortcutOpenChapter := ""
shortcutListHwnd := 0
shortcutPaintRect := 0
shortcutScrollTracks := Map()
shortcutScrollDragging := 0
cheatsheetGuiHwnd := 0
punishmentGameHwnd := 0
mainPunishmentHotkeyHwnd := IsSet(mainPunishmentHotkeyHwnd) ? mainPunishmentHotkeyHwnd : 0
OnMessage(0x133, MainSectionControlColor)
OnMessage(0x135, MainSectionControlColor)
OnMessage(0x138, MainSectionControlColor)
Main.Title := "Majestic Admin Binder"
mainGuiHwnd := Main.Hwnd
Main.Show("w1040 h666")
if ClickerEnabled {
    HotIfWinActive("ahk_exe GTA5.exe")
    clickerGameError := !BinderRegisterHotkey("~*" ClickerKey, ClickerStart)
    HotIfWinActive("ahk_exe ragemp_v.exe")
    clickerRageError := !BinderRegisterHotkey("~*" ClickerKey, ClickerStart)
    HotIfWinActive("ahk_exe GTA5.exe")
    if (clickerGameError || clickerRageError)
        ogcTextMainFooterHint.Value := "Не удалось назначить кнопку кликера. Выберите другую и сохраните."
}
if (KEY13 != "") {
    HotIfWinActive("ahk_id " mainGuiHwnd)
    punishmentBindMainError := !BinderRegisterHotkey("~" PhysicalBinderHotkey(KEY13), PunishmentHandler, "On")
    HotIfWinActive("ahk_exe GTA5.exe")
    if (punishmentBindGameError || punishmentBindRageError || punishmentBindMainError)
        ogcTextMainFooterHint.Value := "Не удалось назначить клавишу наказаний. Выберите другую и сохраните."
}
if (GreetingHotkey != "") {
    greetingConflict := GreetingConflictIndex(GreetingHotkey, [KEY1, KEY2, KEY3, KEY4, KEY5
        , KEY6, KEY7, KEY8, KEY9, KEY10, KEY11, KEY12, KEY13, KEY14, KEY15
        , KEY16, KEY17, KEY18, KEY19, KEY20])
    if (greetingConflict)
        ogcTextMainFooterHint.Value := "Клавиша приветствия занята. Выберите другое сочетание в настройках."
    else {
        HotIfWinActive("ahk_exe GTA5.exe")
        greetingGameError := !BinderRegisterHotkey(PhysicalBinderHotkey(GreetingHotkey), GreetingHandler, "On")
        HotIfWinActive("ahk_exe ragemp_v.exe")
        greetingRageError := !BinderRegisterHotkey(PhysicalBinderHotkey(GreetingHotkey), GreetingHandler, "On")
        HotIfWinActive("ahk_exe GTA5.exe")
        if (greetingGameError || greetingRageError)
            ogcTextMainFooterHint.Value := "Не удалось назначить клавишу приветствия. Выберите другую и сохраните."
    }
}
mainSectionDragging := false
greetingCaptureOpen := false
counterMoveActive := false
OnMessage(0x20A, MainSectionWheel)
OnMessage(0x201, MainSectionScrollMouseDown)
OnMessage(0x201, ClickerMouseCaptured)
OnMessage(0x204, ClickerMouseCaptured)
OnMessage(0x207, ClickerMouseCaptured)
OnMessage(0x20B, ClickerMouseCaptured)
OnMessage(0x200, MainSectionScrollMouseMove)
OnMessage(0x202, MainSectionScrollMouseUp)
OnMessage(0x232, CounterMoveFinish)
ShortcutEditorInit()
initialSetupComplete := IniRead(settingsPath, "InitialSetup", "Complete", 0)
if (initialSetupComplete != 1) {
    InitialSetup := Gui()
    InitialSetup.OnEvent("Close", InitialSetupGuiClose)
    InitialSetup.Opt("+Owner" Main.Hwnd " -Caption +Border")
    InitialSetup.BackColor := "12131A"
    InitialSetup.SetFont("s10 cE9EAF0", "Segoe UI")
    InitialSetup.Add("Progress", "x0 y0 w640 h78 c1B1D27 Background1B1D27 Disabled", "100")
    ogcText := InitialSetup.Add("Text", "x230 y0 w340 h76 +BackgroundTrans")
    ogcText.OnEvent("Click", InitialSetupDrag)
    InitialSetup.SetFont("s17 w700 cFFFFFF", "Segoe UI")
    ogcTextMAJESTIC := InitialSetup.Add("Text", "x24 y15 w230 h30 +BackgroundTrans", "MAJESTIC")
    ogcTextMAJESTIC.OnEvent("Click", InitialSetupDrag)
    InitialSetup.SetFont("s9 w600 cEA3479", "Segoe UI")
    ogcTextADMINBINDER := InitialSetup.Add("Text", "x26 y47 w330 h18 +BackgroundTrans", "ADMIN  /  BINDER")
    ogcTextADMINBINDER.OnEvent("Click", InitialSetupDrag)
    InitialSetup.SetFont("s15 w400 cAEB1BF", "Segoe UI")
    ogcText := InitialSetup.Add("Text", "x599 y25 w27 h30 +0x200 +0x100 Center +BackgroundTrans", "×")
    ogcText.OnEvent("Click", InitialSetupContinue)
    InitialSetup.Add("Progress", "x0 y77 w640 h2 cEA3479 BackgroundEA3479 Disabled", "100")
    InitialSetup.Add("Progress", "x16 y98 w608 h270 c1B1D27 Background1B1D27 Disabled", "100")
    InitialSetup.SetFont("s14 w700 cFFFFFF", "Segoe UI")
    InitialSetup.Add("Text", "x34 y116 w570 h30 +BackgroundTrans", "Обязательная первоначальная настройка")
    InitialSetup.SetFont("s10 w500 cE9EAF0", "Segoe UI")
    InitialSetup.Add("Text", "x34 y154 w570 h160 +BackgroundTrans", "1. Поместите биндер в отдельную папку: он создаст папку res и файл Punishment.txt.`n2. Выберите ваше разрешение в настройках.`n3. Заполните данные для команд и связи.`n4. Настройте положение счётчика и ваш пол.`n5. Расставьте удобные хоткеи в биндах и укажите ваш статик.`n6. По завершении нажмите «Сохранить и применить».")
    ogcCheckBoxInitialSetupConfirmed := InitialSetup.Add("CheckBox", "x34 y326 w570 h28 vInitialSetupConfirmed", "Первоначальная настройка выполнена. Больше не показывать это окно.")
    InitialSetup.SetFont("s9 c989DAD", "Segoe UI")
    InitialSetup.Add("Text", "x24 y400 w340 h20 +BackgroundTrans", "Окно появится снова до подтверждения настройки")
    InitialSetup.Add("Progress", "x406 y389 w218 h36 cEA3479 BackgroundEA3479 Disabled", "100")
    InitialSetup.SetFont("s10 w700 cFFFFFF", "Segoe UI")
    ogcText := InitialSetup.Add("Text", "x406 y389 w218 h36 +0x200 +0x100 Center +BackgroundTrans", "ПРОДОЛЖИТЬ")
    ogcText.OnEvent("Click", InitialSetupContinue)
    ogcButton := InitialSetup.Add("Button", "Hidden Default")
    ogcButton.OnEvent("Click", InitialSetupContinue)
    InitialSetup.Title := "Первоначальная настройка биндера"
    InitialSetup.Show("w640 h446")
    InitialSetup.Opt("+LastFound")
    initialSetupHwnd := WinExist()
}
return

CounterUpdateMoveButton() {
    global CounterHidden
    ogcTextCounterMoveAction.Visible := !(CounterHidden)
    ogcTextCounterMoveInactive.Visible := (CounterHidden)
}

CounterMoveFinish(wParam, lParam, msg, hwnd) {
    global ID, X, Y, settingsPath, counterMoveActive
    if (!counterMoveActive || hwnd != ID)
        return
    WinGetPos(&newX, &newY, , , "ahk_id " ID)
    if (newX = "" || newY = "") {
        MsgBox("Не удалось определить положение счётчика.", "Счётчик", 16)
        return
    }
    try {
        IniWrite(newX, settingsPath, "Coords", "X")
        IniWrite(newY, settingsPath, "Coords", "Y")
        X := newX
        Y := newY
        ogcTextMainFooterHint.Value := "Положение счётчика сохранено"
    } catch Error {
        MsgBox("Не удалось сохранить положение в Settings.ini.", "Счётчик", 16)
    }
    counterMoveActive := false
    WinSet_Click_Through(ID, "On")
    WinSetTransColor("AAAAAA 170", "ahk_id " ID)
    ogcTextCounterMoveAction.Value := "ИЗМЕНИТЬ ПОЛОЖЕНИЕ СЧЁТЧИКА"
}

GreetingFinishHotkeyCapture() {
    global greetingCaptureOpen
    if (!greetingCaptureOpen)
        return
    greetingCaptureOpen := false
    SetTimer(GreetingHotkeyRefresh, 0)
    selectedKey := ogcGreetingHotkey.Value
    ogcTextGreetingHotkeyDisplay.Value := GreetingHotkeyDisplayText(selectedKey)
    ogcGreetingHotkey.Visible := false
    ogcTextGreetingHotkeyDisplay.Visible := true
}

GreetingHotkeyDisplayText(keyName) {
    keyName := NormalizeBinderHotkey(keyName)
    if (keyName = "")
        return "НАЗНАЧИТЬ"
    keyName := StrUpper(keyName)
    keyName := StrReplace(keyName, "+", "Shift + ")
    keyName := StrReplace(keyName, "^", "Ctrl + ")
    keyName := StrReplace(keyName, "!", "Alt + ")
    return StrReplace(keyName, "#", "Win + ")
}

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
    if (mainBindLabelHwnds.Has(lParam)) {
        DllCall("SetBkColor", "Ptr", wParam, "UInt", 0x362A27)
        DllCall("SetTextColor", "Ptr", wParam, "UInt", 0xF0EAE9)
        return mainBindRowBrush
    }
    if (lParam != MainSectionBodyHwnd && !mainLoginHwnds.Has(lParam) && !mainSettingsRadioHwnds.Has(lParam))
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
        PostMessage(0xA1, 2, , , "ahk_id " ID)
        return 0
    }
    if (greetingCaptureOpen && hwnd != GreetingHotkeyHwnd)
        GreetingFinishHotkeyCapture()
    if (IsObject(shortcutScrollTracks) && shortcutScrollTracks.Has(hwnd)) {
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
    activeWindow := WinExist("A")
    if (activeWindow = shortcutEditorHwnd && IsObject(shortcutScrollTracks) && shortcutScrollTracks.Has(hwnd)) {
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
    selectedTab := ogcTab2MainTabs.Value
    if (selectedTab != 3)
        return
    CoordMode("Mouse", "Client")
    MouseGetPos(&mouseX, &mouseY)
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
        SetTimer(MainHighlightDeferred, -180)
    if (info.maxFirst <= 0) {
        if DllCall("IsWindowVisible", "Ptr", MainSectionScrollThumbHwnd)
            ogcProgressMainSectionScrollThumb.Visible := false
        if (scrolled || !redraw)
            MainUpdateAnswerActions()
        return
    }
    thumbY := 193 + Round(info.first / info.maxFirst * (399 - info.thumbHeight))
    if (thumbY != lastY || info.thumbHeight != lastHeight) {
        ogcProgressMainSectionScrollThumb.Move(, thumbY, 8, info.thumbHeight)
        lastY := thumbY
        lastHeight := info.thumbHeight
    }
    if !DllCall("IsWindowVisible", "Ptr", MainSectionScrollThumbHwnd)
        ogcProgressMainSectionScrollThumb.Visible := true
    if (scrolled || !redraw)
        MainUpdateAnswerActions()
}

MainUpdateAnswerActions() {
    global MainSectionBodyHwnd, mainAnswerEntries, mainAnswerActions
    global mainAnswerButtonY, mainCurrentSection, mainChaptersVisible, mainActiveSearchQuery
    selectedTab := ogcTab2MainTabs.Value
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
            oldY := mainAnswerButtonY.Get(slot, "")
            if (oldY = "" || oldY != y) {
                for _, action in ["Edit", "Delete"] {
                    control := "MainAnswer" action slot
                    Main[control].Move(, (193 + y))
                    if (oldY = "")
                        Main[control].Visible := true
                }
                mainAnswerButtonY[slot] := y
            }
        }
    }
    Loop 24 - slot {
        index := slot + A_Index
        if (!mainAnswerActions.Get(index, 0) && mainAnswerButtonY.Get(index, "") = "")
            continue
        mainAnswerActions[index] := 0
        mainAnswerButtonY[index] := ""
        Main["MainAnswerEdit" index].Visible := false
        Main["MainAnswerDelete" index].Visible := false
    }
}

MainScrollSectionToMouse() {
    global MainSectionBodyHwnd
    info := MainSectionScrollInfo()
    if (info.maxFirst <= 0)
        return
    CoordMode("Mouse", "Client")
    MouseGetPos(&mouseX, &mouseY)
    fraction := (mouseY - 193 - info.thumbHeight / 2) / (399 - info.thumbHeight)
    target := Round(Max(0, Min(1, fraction)) * info.maxFirst)
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB6, "Ptr", 0, "Int", target - info.first)
    MainUpdateSectionScroll()
}

MainOpenSection(sectionFile, sectionTitle, sectionIndex) {
    global AdminGender, mainCurrentSection, mainSelectedChapter
    SetTimer(MainSearchApply, 0)
    SetTimer(MainRefreshSectionScroll, 0)
    mainCurrentSection := sectionFile
    chapterSection := sectionFile = "answers" || sectionFile = "useful" || sectionFile = "punishments"
    if (chapterSection)
        mainSelectedChapter := ""
    sectionText := BinderGetSectionContent(sectionFile)
    if (sectionText = "") {
        MsgBox("Не найден встроенный раздел: " sectionFile, "Справочник", 16)
        return
    }
    if (chapterSection) {
        sectionText := ""
        entryCount := 0
    } else {
        sectionText := MainFormatReferenceText(sectionFile, sectionText, &entryCount)
    }
    ogcTextMainSectionTitle.Value := sectionTitle
    if (sectionFile = "answers")
        subtitle := entryCount . " готовых ответов  ·  Выбранная форма: " (AdminGender = "female" ? "женская" : "мужская")
    else if (sectionFile = "commands" || sectionFile = "punishments" || sectionFile = "useful")
        subtitle := entryCount . " сокращений  ·  Быстрый доступ к командам и подсказкам"
    else
        subtitle := "Быстрые ответы и команды администрации"
    ogcTextMainSectionSubtitle.Value := subtitle
    if (chapterSection)
        MainShowChapters()
    else {
        ControlSetText(sectionText, MainSectionBodyHwnd)
        for _, searchControl in ["MainUsefulSearchLabel", "MainUsefulSearch", "MainUsefulSearchClear", "MainUsefulSearchAccent"
            , "MainAnswersSearchLabel", "MainAnswersSearch", "MainAnswersSearchClear", "MainAnswersSearchAccent"]
            Main[searchControl].Visible := false
        MainHideChapters()
        MainUpdateAnswerActions()
    }
    ogcTab2MainTabs.Choose(3)
    ogcProgressMainTabAccent.Visible := false
    accentY := 198 + (sectionIndex - 1) * 42
    ogcProgressMainSectionAccent.Move(, accentY, 156, 3)
    ogcProgressMainSectionAccent.Visible := true
    ogcProgressMainSaveBackground.Visible := false
    ogcTextMainSaveAction.Visible := false
    ogcTextMainFooterHint.Value := "Выберите раздел слева или откройте бинды и настройки сверху"
    if (!chapterSection) {
        MainUpdateSectionScroll()
        SetTimer(MainRefreshSectionScroll, 100)
    }
}

MainShowChapters() {
    global answerChapters, usefulChapters, punishmentChapters, mainCurrentSection, mainSelectedChapter, mainActiveSearchQuery
    global mainChaptersVisible, mainShownChapterCount, mainShownChapterSection, mainAnswerEntries
    SetTimer(MainSearchApply, 0)
    mainSelectedChapter := ""
    mainAnswerEntries := []
    MainUpdateAnswerActions()
    mainActiveSearchQuery := ""
    chapterNames := mainCurrentSection = "answers" ? answerChapters : mainCurrentSection = "punishments" ? punishmentChapters : usefulChapters
    ogcTextMainSectionTitle.Move(230, 126, 776, 31)
    ogcTextMainSectionTitle.Value := mainCurrentSection = "answers" ? "Ответы" : mainCurrentSection = "punishments" ? "Наказания" : "Полезное"
    ogcTextMainSectionSubtitle.Value := "Выберите главу или найдите запись в ответах, наказаниях и полезном"
    ogcTextMainChaptersBack.Visible := false
    if (!mainChaptersVisible) {
        ogcCustomMainSectionBody.Visible := false
        ogcTextMainSectionScrollTrack.Visible := false
        ogcProgressMainSectionScrollThumb.Visible := false
    }
    Loop mainShownChapterCount {
        if (A_Index <= chapterNames.Length)
            continue
        Main["MainChapterBg" A_Index].Visible := false
        Main["MainChapter" A_Index].Visible := false
    }
    for chapterIndex, chapterName in chapterNames {
        if (mainShownChapterSection != mainCurrentSection) {
            chapterLabel := StrUpper(chapterName)
            Main["MainChapter" chapterIndex].Value := chapterLabel
        }
        if (!mainChaptersVisible || chapterIndex > mainShownChapterCount) {
            Main["MainChapterBg" chapterIndex].Visible := true
            Main["MainChapter" chapterIndex].Visible := true
        }
    }
    mainShownChapterCount := chapterNames.Length
    mainShownChapterSection := mainCurrentSection
    mainChaptersVisible := true
    searchControl := mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch"
    otherSearchControl := mainCurrentSection = "answers" ? "MainUsefulSearch" : "MainAnswersSearch"
    for _, controlName in [otherSearchControl "Label", otherSearchControl, otherSearchControl "Clear", otherSearchControl "Accent"]
        Main[controlName].Visible := false
    currentSearch := Main[searchControl].Value
    if (currentSearch != "")
        Main[searchControl].Value := ""
    for _, controlName in [searchControl "Label", searchControl, searchControl "Clear", searchControl "Accent"]
        Main[controlName].Visible := true
    SetTimer(MainRefreshSectionScroll, 0)
}

MainHideChapters() {
    global mainChaptersVisible, mainShownChapterCount
    if (mainChaptersVisible) {
        Loop mainShownChapterCount {
            Main["MainChapterBg" A_Index].Visible := false
            Main["MainChapter" A_Index].Visible := false
        }
        mainChaptersVisible := false
    }
    ogcTextMainChaptersBack.Visible := false
    ogcCustomMainSectionBody.Visible := true
    ogcTextMainSectionScrollTrack.Visible := true
    ogcTextMainSectionTitle.Move(230, 126, 776, 31)
}

MainShowChapter(chapterName) {
    global mainCurrentSection, mainSelectedChapter
    SetTimer(MainSearchApply, 0)
    mainSelectedChapter := chapterName
    MainHideChapters()
    ogcTextMainChaptersBack.Visible := true
    ogcTextMainSectionTitle.Move(370, 126, 250, 31)
    ogcTextMainSectionTitle.Value := chapterName
    searchControl := mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch"
    currentSearch := Main[searchControl].Value
    if (currentSearch != "")
        Main[searchControl].Value := ""
    for _, controlName in [searchControl "Label", searchControl, searchControl "Clear", searchControl "Accent"]
        Main[controlName].Visible := true
    MainRenderSearchSection(mainCurrentSection, searchControl)
    SetTimer(MainRefreshSectionScroll, 100)
}

MainSearchChanged(sectionName, searchControl) {
    global mainSelectedChapter, mainActiveSearchQuery
    query := Main[searchControl].Value
    if (Trim(query) = "") {
        if (mainSelectedChapter = "")
            MainShowChapters()
        else
            MainShowChapter(mainSelectedChapter)
        return
    }
    if (mainActiveSearchQuery = "") {
        MainHideChapters()
        ogcTextMainChaptersBack.Visible := true
        ogcTextMainSectionTitle.Move(370, 126, 250, 31)
        ogcTextMainSectionTitle.Value := "Результаты поиска"
    }
    MainRenderSearchSection(sectionName, searchControl)
    Main[searchControl].Focus()
    SetTimer(MainRefreshSectionScroll, 100)
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
    query := Main[searchControl].Value
    if (Trim(query) = "") {
        source := BinderGetSectionContent(sectionName)
        if (mainSelectedChapter != "")
            source := MainChapterContent(source, mainSelectedChapter)
        filtered := MainFilterReferenceContent(source, query)
        display := MainFormatReferenceText(sectionName, filtered, &entryCount)
    } else if (Trim(query) = "." || Trim(query) = "/") {
        display := "Введите сокращение целиком."
        entryCount := 0
    } else {
        display := MainSearchAllSections(query, &entryCount)
    }
    if (display = "") {
        display := "По запросу «" Trim(query) "» ничего не найдено."
        entryCount := 0
    }
    latestQuery := Main[searchControl].Value
    if !(latestQuery == query) {
        SetTimer(MainSearchApply, -50)
        return
    }
    mainAnswerEntries := MainCollectActionEntries(display, sectionName, Trim(query))
    if (Trim(query) != "")
        subtitle := "Найдено: " . entryCount . "  ·  Ответы, наказания и полезное"
    else if (sectionName = "answers")
        subtitle := entryCount . " готовых ответов  ·  Выбранная форма: " (AdminGender = "female" ? "женская" : "мужская")
    else
        subtitle := entryCount . " сокращений  ·  Быстрый доступ к командам и подсказкам"
    ogcTextMainSectionSubtitle.Value := subtitle
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 0, "Ptr", 0)
    ControlSetText(display, MainSectionBodyHwnd)
    nextPosition := 0
    for _, entry in mainAnswerEntries {
        heading := entry.heading
        found := Buffer(16 + A_PtrSize, 0)
        NumPut("Int", nextPosition, found, 0)
        NumPut("Int", -1, found, 4)
        NumPut("Ptr", StrPtr(heading), found, 8)
        entry.position := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x47C, "Ptr", 1, "Ptr", found.Ptr, "Int")
        if (entry.position < 0)
            break
        nextPosition := NumGet(found, 12 + A_PtrSize, "Int")
    }
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x115, "Ptr", 6, "Ptr", 0)
    mainActiveSearchQuery := Trim(query)
    mainLastHighlightedLine := -1
    MainUpdateSectionScroll(false)
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 1, "Ptr", 0)
    DllCall("InvalidateRect", "Ptr", MainSectionBodyHwnd, "Ptr", 0, "Int", 1)
    latestQuery := Main[searchControl].Value
    if !(latestQuery == query)
        SetTimer(MainSearchApply, -50)
}

MainCollectActionEntries(display, sectionName, query) {
    global shortcutRecords, mainSelectedChapter
    entries := []
    recordIndexes := Map()
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
                title := StrUpper(name)
                if (line = title) {
                    chapter := name
                    break
                }
            }
        }
        if !RegExMatch(line, "^◆  (.+)$", &match)
            continue
        recordIndex := 0
        index := recordIndexes.Get(ShortcutKey(match[1]), 0)
        if (index) {
            for _, ref in shortcutRecords[index].refs {
                if (ref.section = resultSection && ref.chapter = chapter && ref.alias = match[1]) {
                    recordIndex := index
                    break
                }
            }
        }
        entries.Push({heading: "◆  " match[1], index: recordIndex, section: resultSection, chapter: chapter, position: -1})
    }
    return entries
}

MainSearchAllSections(query, &entryCount) {
    entryCount := 0
    display := ""
    for _, section in [["answers", "ОТВЕТЫ"], ["punishments", "НАКАЗАНИЯ"], ["useful", "ПОЛЕЗНОЕ"]] {
        filtered := MainFilterReferenceContent(BinderGetSectionContent(section[1]), query)
        if (filtered = "")
            continue
        sectionText := MainFormatReferenceText(section[1], filtered, &sectionCount)
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
        if RegExMatch(line, "^##\s+(.+)$", &heading) {
            if (found)
                break
            found := heading[1] = chapterName
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
    queryLower := StrLower(query)
    terms := StrSplit(RegExReplace(queryLower, "\s+", " "), " ")
    prefixAlias := StrLen(queryLower) > 1 && (SubStr(queryLower, 1, 1) = "." || SubStr(queryLower, 1, 1) = "/")
        && !InStr(queryLower, " ")
    normalized := StrReplace(StrReplace(source, "`r`n", "`n"), "`r", "`n")
    result := ""
    groupName := ""
    groupNameLower := ""
    groupVisible := false
    for _, line in StrSplit(normalized, "`n") {
        if RegExMatch(line, "^##\s+(.+)$", &group) {
            groupName := group[1]
            groupNameLower := StrLower(groupName)
            groupVisible := false
        } else if RegExMatch(line, "^(.+?)\s+-\s+(.*)$", &item) {
            if (prefixAlias) {
                aliasLower := StrLower(item[1])
                matches := SubStr(aliasLower, 1, StrLen(queryLower)) = queryLower
            } else {
                lineLower := StrLower(line)
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
    savedSelection := Buffer(8, 0)
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x434, "Ptr", 0, "Ptr", savedSelection.Ptr)
    format := Buffer(116, 0)
    NumPut("UInt", 116, format, 0)
    NumPut("UInt", 0x44000000, format, 4) ; Цвет текста и фон совпадения.
    NumPut("UInt", 0xFFFFFF, format, 20)
    NumPut("UInt", 0x7934EA, format, 96)
    if (redraw)
        DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 0, "Ptr", 0)
    for _, term in StrSplit(query, " ") {
        if (term = "")
            continue
        nextPosition := rangeStart
        Loop{
            found := Buffer(16 + A_PtrSize, 0)
            NumPut("Int", nextPosition, found, 0)
            NumPut("Int", rangeEnd, found, 4)
            NumPut("Ptr", StrPtr(term), found, 8)
            position := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x47C, "Ptr", 1, "Ptr", found.Ptr, "Ptr")
            if (position = -1)
                break
            matchEnd := NumGet(found, 12 + A_PtrSize, "Int")
            if (matchEnd <= nextPosition)
                break
            DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x437, "Ptr", 0, "Ptr", found.Ptr + 8 + A_PtrSize)
            DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x444, "Ptr", 1, "Ptr", format.Ptr)
            nextPosition := matchEnd
        }
    }
    DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0x437, "Ptr", 0, "Ptr", savedSelection.Ptr)
    currentFirst := DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xCE, "Ptr", 0, "Ptr", 0, "Int")
    if (currentFirst != firstVisible)
        DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB6, "Ptr", 0, "Int", firstVisible - currentFirst)
    if (redraw) {
        DllCall("SendMessage", "Ptr", MainSectionBodyHwnd, "UInt", 0xB, "Ptr", 1, "Ptr", 0)
        DllCall("InvalidateRect", "Ptr", MainSectionBodyHwnd, "Ptr", 0, "Int", 1)
    }
}

MainFormatReferenceText(sectionFile, sectionText, &entryCount) {
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

        if RegExMatch(line, "^##\s+(.+)$", &group) {
            if (currentAlias != "") {
                display .= MainFormatReferenceEntry(sectionFile, currentAlias, currentBody)
                entryCount++
                currentAlias := ""
            }
            groupTitle := group[1]
            groupTitle := StrUpper(groupTitle)
            display .= groupTitle . "`r`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`r`n`r`n"
            continue
        }

        if RegExMatch(line, "^Часть\s+(\d+)$", &part) {
            if (currentAlias != "") {
                display .= MainFormatReferenceEntry(sectionFile, currentAlias, currentBody)
                entryCount++
                currentAlias := ""
            }
            display .= "ЧАСТЬ " . part[1] . "`r`n──────────────────────────────────`r`n`r`n"
            continue
        }

        if RegExMatch(line, "^(.+?)\s+-\s+(.*)$", &item) {
            if (currentAlias != "") {
                display .= MainFormatReferenceEntry(sectionFile, currentAlias, currentBody)
                entryCount++
            }
            currentAlias := item[1]
            currentBody := item[2]
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
    if (sectionFile = "skills" && RegExMatch(body, "^(.+?)\s+-\s+(.*)$", &skill)) {
        title := skill[1]
        body := skill[2]
        title := StrUpper(title)
        firstLetter := SubStr(body, 1, 1)
        firstLetter := StrUpper(firstLetter)
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

;настройки

;счетчик

; Памятка открывается поверх игры; поиск и страницы доступны по щелчку.

CheatsheetApplySearch() {
    global CheatsheetPage, cheatsheetRules, cheatsheetFiltered
    searchText := ogcEditCheatsheetSearchInput.Value
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
    matchCount := cheatsheetFiltered.Length
    if (matchCount = "")
        matchCount := 0
    CheatsheetPageCount := Max(1, Ceil(matchCount / 10))
    if (CheatsheetPage > CheatsheetPageCount)
        CheatsheetPage := CheatsheetPageCount
    Loop 10 {
        slot := A_Index
        ruleIndex := (CheatsheetPage - 1) * 10 + slot
        bgName := "CheatsheetCardBg" . slot
        titleName := "CheatsheetCardTitle" . slot
        penaltyName := "CheatsheetCardPenalty" . slot
        if (ruleIndex > matchCount) {
            SheetGui[bgName].Visible := false
            SheetGui[titleName].Visible := false
            SheetGui[penaltyName].Visible := false
            continue
        }
        rule := cheatsheetFiltered[ruleIndex]
        SheetGui[titleName].Value := rule[1]
        SheetGui[penaltyName].Value := rule[2]
        SheetGui[bgName].Visible := true
        SheetGui[titleName].Visible := true
        SheetGui[penaltyName].Visible := true
    }
    if (matchCount = 0) {
        ogcTextCheatsheetNoResults.Visible := true
        ogcTextCheatsheetPageNumber.Value := "0 НАЙДЕНО"
    } else {
        ogcTextCheatsheetNoResults.Visible := false
        ogcTextCheatsheetPageNumber.Value := "СТРАНИЦА " CheatsheetPage " / " CheatsheetPageCount
    }
}

CheatsheetBuildRules() {
    return CheatsheetReadRows("memo_rules.txt")
}

CheatsheetReadRows(fileName, maxRows := 0) {
    rows := []
    rawText := BinderGetSectionContent(StrReplace(fileName, ".txt"))
    if (rawText = "") {
        MsgBox("Не найден встроенный раздел: " fileName, "Памятка", 16)
        return rows
    }
    normalized := StrReplace(StrReplace(rawText, "`r`n", "`n"), "`r", "`n")
    Loop Parse, normalized, "`n"
    {
        line := Trim(A_LoopField)
        if (line = "" || SubStr(line, 1, 1) = "#")
            continue
        separator := InStr(line, "|")
        if (!separator)
            continue
        name := Trim(SubStr(line, 1, separator - 1))
        value := Trim(SubStr(line, (separator + 1)<1 ? (separator + 1)-1 : (separator + 1)))
        if (name = "" || value = "")
            continue
        rows.Push([name, value])
        if (maxRows && rows.Length >= maxRows)
            break
    }
    return rows
}

; Команды наказаний хранятся в Punishment.txt и отправляются только из редактора.

; ===== РЕДАКТОР СОКРАЩЕНИЙ =====
#HotIf
; Редактор хранит пользовательские записи и список отключённых сокращений отдельно от поставляемых справочников.

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
        metrics := Buffer(60, 0)
        DllCall("GetTextMetricsW", "Ptr", dc, "Ptr", metrics.Ptr)
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
            Shortcuts[thumb].Visible := false
            continue
        }
        info := ShortcutScrollInfo(index)
        if (info.maxFirst <= 0) {
            Shortcuts[thumb].Visible := false
            continue
        }
        y := area.y + Round(info.first / info.maxFirst * (area.h - info.thumbHeight))
        Shortcuts[thumb].Move((area.x + 5), y, 8, info.thumbHeight)
        Shortcuts[thumb].Visible := true
    }
}

ShortcutScrollToMouse(index) {
    global shortcutScrollAreas
    area := shortcutScrollAreas[index]
    info := ShortcutScrollInfo(index)
    if (info.maxFirst <= 0)
        return
    CoordMode("Mouse", "Client")
    MouseGetPos(&mouseX, &mouseY)
    fraction := (mouseY - area.y - info.thumbHeight / 2) / (area.h - info.thumbHeight)
    ShortcutScrollTo(index, Round(Max(0, Min(1, fraction)) * info.maxFirst))
}

ShortcutScrollTo(index, target) {
    global shortcutScrollAreas
    area := shortcutScrollAreas[index]
    info := ShortcutScrollInfo(index)
    target := Max(0, Min(info.maxFirst, target))
    if (area.type = "list") {
        rect := Buffer(16, 0)
        if DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x100E, "Ptr", 0, "Ptr", rect.Ptr)
            DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0x1014, "Ptr", 0, "Ptr", (target - info.first) * (NumGet(rect, 12, "Int") - NumGet(rect, 4, "Int")))
    } else
        DllCall("SendMessage", "Ptr", area.hwnd, "UInt", 0xB6, "Ptr", 0, "Ptr", target - info.first)
    ShortcutUpdateScroll()
}

ShortcutEditorUpdateFormConfirm() {
    global AdminGender, ShortcutAction, ShortcutSection, ShortcutChapter, shortcutSections, shortcutSelected
    if (ShortcutAction = 2)
        return
    aliasInput := ogcEditShortcutAlias.Value
    textInput := ogcEditShortcutText.Value
    otherInput := ogcEditShortcutOtherText.Value
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
    ShortcutEditorSetConfirm(shortcutSections.Has(ShortcutSection) && validAlias && body != "" && other != ""
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
    replacements := Map(), words := ""
    for _, form in forms {
        from := form[toFemale ? 1 : 2]
        replacements[from] := form[toFemale ? 2 : 1]
        words .= (words = "" ? "" : "|") from
    }
    ending := ")" modifiers "\K(?:" words ")(?![\p{L}\p{N}_])"
    pattern := "i)(?:" subject ending
    offset := 1
    while (at := RegExMatch(text, pattern, &word, offset)) {
        to := replacements[ShortcutKey((word&&word[0]))]
        upper := StrUpper((word&&word[0]))
        initial := StrTitle((word&&word[0]))
        replacement := to
        if ((word&&word[0]) == upper)
            replacement := StrUpper(to)
        else if ((word&&word[0]) == initial)
            replacement := StrTitle(to)
        text := SubStr(text, 1, at - 1) replacement SubStr(text, (at + StrLen((word&&word[0])))<1 ? (at + StrLen((word&&word[0])))-1 : (at + StrLen((word&&word[0]))))
        offset := at + StrLen(replacement)
        pattern := "i)(?:" subject "|" continuation ending
    }
    return text
}

ShortcutEditorSetConfirm(enabled) {
    ogcTextShortcutConfirmInactive.Visible := !(enabled)
    ogcTextShortcutConfirm.Visible := (enabled)
}

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
    global ShortcutDelete, shortcutEditorHwnd, shortcutDeleteGuiHwnd, shortcutDeleteConfirmed
    global ShortcutDeleteCard, ShortcutDeletePreviewBackground, ShortcutDeletePreview
    shortcutDeleteConfirmed := false
    try ShortcutDelete.Destroy()
    ShortcutDelete := Gui("+Owner" (shortcutEditorHwnd ? Shortcuts.Hwnd : Main.Hwnd) " -Caption +Border")
    ShortcutDelete.OnEvent("Close", ShortcutDeleteGuiEscape)
    ShortcutDelete.OnEvent("Escape", ShortcutDeleteGuiEscape)
    shortcutDeleteGuiHwnd := ShortcutDelete.Hwnd
    ShortcutDelete.BackColor := "12131A"
    ShortcutDelete.Add("Progress", "x0 y0 w500 h78 c1B1D27 Background1B1D27 Disabled", "100")
    ShortcutDelete.SetFont("s16 w700 cFFFFFF", "Segoe UI")
    ogcTextMAJESTIC := ShortcutDelete.Add("Text", "x24 y17 w300 h30 +BackgroundTrans", "MAJESTIC")
    ogcTextMAJESTIC.OnEvent("Click", ShortcutDeleteDrag)
    ShortcutDelete.SetFont("s9 w600 cEA3479", "Segoe UI")
    ogcTextADMINBINDER := ShortcutDelete.Add("Text", "x26 y47 w300 h18 +BackgroundTrans", "ADMIN  /  BINDER")
    ogcTextADMINBINDER.OnEvent("Click", ShortcutDeleteDrag)
    ShortcutDelete.SetFont("s15 w400 cAEB1BF", "Segoe UI")
    ogcText := ShortcutDelete.Add("Text", "x459 y22 w27 h30 +0x200 +0x100 Center +BackgroundTrans", "×")
    ogcText.OnEvent("Click", ShortcutDeleteCancel)
    ShortcutDelete.Add("Progress", "x0 y77 w500 h2 cEA3479 BackgroundEA3479 Disabled", "100")
    ogcProgressShortcutDeleteCard := ShortcutDelete.Add("Progress", "x16 y96 w468 h150 c1B1D27 Background1B1D27 Disabled vShortcutDeleteCard", "100")
    ShortcutDelete.SetFont("s14 w700 cFFFFFF", "Segoe UI")
    ShortcutDelete.Add("Text", "x32 y110 w436 h30 +BackgroundTrans", "Удалить " record.alias "?")
    preview := ShortcutReferenceBody(record.refs[1])
    ogcProgressShortcutDeletePreviewBackground := ShortcutDelete.Add("Progress", "x32 y151 w436 h48 c292C38 Background292C38 Disabled vShortcutDeletePreviewBackground", "100")
    ShortcutDelete.SetFont("s10 cE9EAF0", "Segoe UI")
    ogcTextShortcutDeletePreview := ShortcutDelete.Add("Text", "x40 y157 w420 +BackgroundTrans vShortcutDeletePreview", preview)
    ogcTextShortcutDeletePreview.GetPos(&previewPosX, &previewPosY, &previewPosW, &previewPosH)
    extraHeight := Max(0, previewPosH - 38)
    ogcProgressShortcutDeletePreviewBackground.Move(, , , (48 + extraHeight))
    ogcProgressShortcutDeleteCard.Move(, , , (150 + extraHeight))
    ShortcutDelete.SetFont("s9 c989DAD", "Segoe UI")
    ShortcutDelete.Add("Text", "x32 y" (210 + extraHeight) " w436 h32 +BackgroundTrans", "Сокращение, оба текста и команды другой раскладки исчезнут из всех глав.")
    ShortcutDelete.SetFont("s10 w700 cFFFFFF", "Segoe UI")
    ogcText := ShortcutDelete.Add("Text", "x16 y" (259 + extraHeight) " w160 h36 +0x200 +0x100 Center Background292C38", "ОТМЕНА")
    ogcText.OnEvent("Click", ShortcutDeleteCancel)
    ShortcutDelete.Add("Progress", "x324 y" (259 + extraHeight) " w160 h36 cEA3479 BackgroundEA3479 Disabled", "100")
    ogcText := ShortcutDelete.Add("Text", "x324 y" (259 + extraHeight) " w160 h36 +0x200 +0x100 Center +BackgroundTrans", "УДАЛИТЬ")
    ogcText.OnEvent("Click", ShortcutDeleteAccept)
    ogcButton := ShortcutDelete.Add("Button", "Hidden Default")
    ogcButton.OnEvent("Click", ShortcutDeleteAccept)
    if (shortcutEditorHwnd)
        Shortcuts.Opt("+Disabled")
    else
        Main.Opt("+Disabled")
    ShortcutDelete.Title := "Подтверждение удаления"
    ShortcutDelete.Show("w500 h" (311 + extraHeight))
    WinWaitClose("ahk_id " shortcutDeleteGuiHwnd)
    if (shortcutEditorHwnd)
        Shortcuts.Opt("-Disabled")
    else
        Main.Opt("-Disabled")
    return shortcutDeleteConfirmed
}

ShortcutStyleCombo(hwnd) {
    static proc := CallbackCreate(ShortcutComboProc, "Fast", 6)
    DllCall("Comctl32\SetWindowSubclass", "Ptr", hwnd, "Ptr", proc, "Ptr", 1, "Ptr", 0)
    DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x153, "Ptr", -1, "Ptr", Round(26 * A_ScreenDPI / 96))
    DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x153, "Ptr", 0, "Ptr", Round(28 * A_ScreenDPI / 96))
}

ShortcutComboProc(hwnd, msg, wParam, lParam, subclassId, data) {
    if (msg = 0xF || msg = 0x318) { ; WM_PAINT / WM_PRINTCLIENT
        paint := Buffer(80, 0)
        dc := msg = 0xF ? DllCall("BeginPaint", "Ptr", hwnd, "Ptr", paint.Ptr, "Ptr") : wParam
        rect := Buffer(16, 0)
        DllCall("GetClientRect", "Ptr", hwnd, "Ptr", rect.Ptr)
        DllCall("FillRect", "Ptr", dc, "Ptr", rect.Ptr, "Ptr", ShortcutThemeBrush("field"))
        if (DllCall("GetFocus", "Ptr") = hwnd)
            DllCall("FrameRect", "Ptr", dc, "Ptr", rect.Ptr, "Ptr", ShortcutThemeBrush("accent"))
        font := DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x31, "Ptr", 0, "Ptr", 0, "Ptr")
        previousFont := font ? DllCall("SelectObject", "Ptr", dc, "Ptr", font, "Ptr") : 0
        selected := DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x147, "Ptr", 0, "Ptr", 0, "Int")
        arrowWidth := Round(32 * A_ScreenDPI / 96)
        width := NumGet(rect, 8, "Int")
        NumPut("Int", width - arrowWidth, rect, 8)
        ShortcutDrawText(dc, rect.Ptr, ShortcutComboText(hwnd, selected))
        NumPut("Int", width - arrowWidth, rect, 0)
        NumPut("Int", width, rect, 8)
        ShortcutDrawText(dc, rect.Ptr, "▾", true)
        if (previousFont)
            DllCall("SelectObject", "Ptr", dc, "Ptr", previousFont)
        if (msg = 0xF)
            DllCall("EndPaint", "Ptr", hwnd, "Ptr", paint.Ptr)
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
    text := Buffer((length + 1) * 2, 0)
    DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x148, "Ptr", index, "Ptr", text.Ptr)
    return StrGet(text.Ptr, length, "UTF-16")
}

ShortcutHookListPainting(editorHwnd, listHwnd) {
    static parentProc := CallbackCreate(ShortcutListParentProc, "Fast", 6)
    static listProc := CallbackCreate(ShortcutListProc, "Fast", 6)
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
        bounds := Buffer(16, 0)
        previousRect := shortcutPaintRect
        shortcutPaintRect := 0
        if (shortcutPaintRow > top && shortcutPaintRow <= top + shortcutListVisibleRows + 1
            && DllCall("SendMessageW", "Ptr", hwnd, "UInt", 0x100E, "Ptr", shortcutPaintRow - 1, "Ptr", bounds.Ptr))
            shortcutPaintRect := bounds.Ptr
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
    row := shortcutRows.Has(shortcutPaintRow) ? shortcutRows[shortcutPaintRow] : ""
    if (!IsObject(row))
        return 0
    ; Список сам рисует строки. Поверх него окрашиваем только одно видимое выделение.
    dc := NumGet(lParam + 0, headerSize + A_PtrSize, "Ptr")
    oldFont := shortcutListFont ? DllCall("SelectObject", "Ptr", dc, "Ptr", shortcutListFont, "Ptr") : 0
    rect := Buffer(16)
    DllCall("RtlMoveMemory", "Ptr", rect.Ptr, "Ptr", shortcutPaintRect, "UPtr", 16)
    DllCall("FillRect", "Ptr", dc, "Ptr", rect.Ptr, "Ptr", ShortcutThemeBrush("accent"))
    right := NumGet(rect, 8, "Int")
    split := NumGet(rect, 0, "Int") + shortcutListFirstColWidth
    NumPut("Int", split, rect, 8)
    ShortcutDrawText(dc, rect.Ptr, row.alias, false, true)
    NumPut("Int", split, rect, 0)
    NumPut("Int", right, rect, 8)
    ShortcutDrawText(dc, rect.Ptr, row.listText, false, true)
    if (oldFont)
        DllCall("SelectObject", "Ptr", dc, "Ptr", oldFont)
    return 0
}

ShortcutDrawText(dc, rect, text, center := false, white := false) {
    bounds := Buffer(16)
    DllCall("RtlMoveMemory", "Ptr", bounds.Ptr, "Ptr", rect, "UPtr", 16)
    if (!center) {
        padding := Round(8 * A_ScreenDPI / 96)
        NumPut("Int", NumGet(bounds, 0, "Int") + padding, bounds, 0)
        NumPut("Int", NumGet(bounds, 8, "Int") - padding, bounds, 8)
    }
    previousMode := DllCall("SetBkMode", "Ptr", dc, "Int", 1)
    previousColor := DllCall("SetTextColor", "Ptr", dc, "UInt", white ? 0xFFFFFF : 0xF0EAE9, "UInt")
    DllCall("DrawTextW", "Ptr", dc, "WStr", text, "Int", -1, "Ptr", bounds.Ptr, "UInt", 0x8824 | (center ? 1 : 0))
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
    alias := StrLower(alias)
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
    Loop Parse, keys
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
    if (!record.refs.Length)
        record.refs.Push({section: section, chapter: chapter, alias: alias
            , body: male, female: ShortcutEditorSameBody(male, female) ? "" : female})

    pair := ShortcutLayoutPair(alias)
    seen := Map()
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
                if ((variant.gender != "all" && variant.gender != gender) || seen.Has(slot))
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
        if (!seen.Has(target "|male") && !seen.Has(target "|female") && ShortcutEditorSameBody(male, female)) {
            record.hot.Push({alias: target, gender: "all", mode: section = "punishments" ? "send" : "text", body: male})
            continue
        }
        if (!seen.Has(target "|male"))
            record.hot.Push({alias: target, gender: "male", mode: section = "punishments" ? "send" : "text", body: male})
        if (!seen.Has(target "|female"))
            record.hot.Push({alias: target, gender: "female", mode: section = "punishments" ? "send" : "text", body: female})
    }
    return record
}

ShortcutApplyRecord(record, state) {
    global AdminGender
    HotIfWinActive("ahk_exe GTA5.exe")
    active := Map()
    for _, variant in record.hot {
        if (state = "On" && variant.gender != "all" && variant.gender != AdminGender)
            continue
        alias := ShortcutKey(variant.alias)
        if (active.Has(alias))
            continue
        active[alias] := true
        if (state = "Off") {
            try Hotstring(":?:" alias, , "Off")
            try Hotstring(":?TC1:" alias, , "Off")
            continue
        }
        if (variant.mode = "send")
            Hotstring(":?:" alias, ShortcutSendLiteral.Bind(variant.body), "On")
        else if (variant.mode = "text")
            Hotstring(":?TC1:" alias, variant.body, "On")
        else
            Hotstring(":?:" alias, ShortcutSendReply.Bind(variant.mode, variant.body), "On")
    }
}

ShortcutSendLiteral(body, *) {
    pos := 1
    while found := RegExMatch(body, "\{[^{}]+\}", &key, pos) {
        if (found > pos)
            GreetingSendText(SubStr(body, pos, found - pos))
        SendInput(key[0])
        pos := found + StrLen(key[0])
    }
    GreetingSendText(SubStr(body, pos))
    if (A_EndChar = "`n" && RegExMatch(body, "i)\{Enter\}"))
        return
    if (A_EndChar = "`n")
        SendInput("{Enter}")
    else if (A_EndChar != "")
        GreetingSendText(A_EndChar)
}

ShortcutSendReply(mode, body, *) {
    global dis, gadis, zgadis
    if (mode = "dis")
        body .= dis
    else if (mode = "gadis")
        body .= gadis
    else if (mode = "zgadis")
        body .= zgadis
    BinderPasteReply(body, 1)
    if (mode = "count") {

        UpdateCounter()
    }
}

ShortcutEditorInit() {
    global shortcutRecords := [], shortcutSections := ["answers", "useful", "punishments"]
    global shortcutPath := A_ScriptDir "\res\Shortcuts.tsv", shortcutDiskData, shortcutReadError := false
    if (!FileExist(shortcutPath))
        ShortcutEditorSave(shortcutRecords, true)
    parsed := []
    try {
        shortcutDiskData := FileRead(shortcutPath, "UTF-8")
        parsed := ShortcutParseFile(shortcutDiskData)
        for _, record in parsed
            ShortcutApplyRecord(record, "On")
        shortcutRecords := parsed
    } catch Error {
        for _, record in parsed
            try ShortcutApplyRecord(record, "Off")
        shortcutReadError := true
    }
    if (shortcutReadError)
        MsgBox("Не удалось загрузить res\Shortcuts.tsv.", "Сокращения", 16)
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
        if (fields[1] = "R" && fields.Length = 2 && fields[2] != "") {
            current := {alias: ShortcutKey(fields[2]), refs: [], hot: []}
            records.Push(current)
        } else if (IsObject(current) && fields[1] = "V" && fields.Length = 6) {
            current.refs.Push({section: fields[2], chapter: fields[3], alias: fields[4], body: fields[5], female: fields[6]})
        } else if (IsObject(current) && fields[1] = "H" && fields.Length = 5
            && RegExMatch(fields[2], "^[^:\r\n\t]{1,40}$")
            && RegExMatch(fields[3], "^(all|male|female)$")
            && RegExMatch(fields[4], "^(send|text|paste|count|dis|gadis|zgadis)$")) {
            current.hot.Push({alias: fields[2], gender: fields[3], mode: fields[4], body: fields[5]})
        } else
            throw Error("Строка " lineNo " в Shortcuts.tsv")
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
        try currentData := FileRead(shortcutPath, "UTF-8")
        catch Error
            return false
        if !(currentData == shortcutDiskData)
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
    try {
        file := FileOpen(tempPath, "w", "UTF-8")
        try written := file.Write(data)
        finally file.Close()
        if (written != StrPut(data, "UTF-8") - 1)
            return false
        FileMove(tempPath, shortcutPath, !create)
    } catch Error {
        return false
    }
    shortcutDiskData := data
    return true
}

ShortcutReferenceBody(ref) {
    global AdminGender
    return AdminGender = "female" && ref.female != "" ? ref.female : ref.body
}

ShortcutEditorReference(section) {
    global shortcutRecords
    chapterLines := Map()
    for _, record in shortcutRecords {
        for _, ref in record.refs {
            if (ref.section = section)
                chapterLines[ref.chapter] := chapterLines.Get(ref.chapter, "") . ref.alias " - " ShortcutReferenceBody(ref) "`r`n"
        }
    }
    output := ""
    for _, chapter in ShortcutSectionChapters(section)
        output .= "## " chapter "`r`n" chapterLines.Get(chapter, "")
    return output
}

#HotIf WinActive("ahk_exe GTA5.exe")

GreetingSendText(text) {
    SendInput("{Text}" text)
}

^F9::Reload()
^F10::ExitApp()

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
        SendInput("{Enter}")
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

InitialSetupDrag(*) {
    global
    DllCall("ReleaseCapture")
    PostMessage(0xA1, 2, , , "ahk_id " initialSetupHwnd)
    return
}
InitialSetupContinue(*) {
    global
    InitialSetupGuiClose()
}
InitialSetupGuiClose(*) {
    global
    oSaved := InitialSetup.Submit(0)
    try InitialSetupConfirmed := oSaved.InitialSetupConfirmed
    if (InitialSetupConfirmed) {
        try IniWrite(1, settingsPath, "InitialSetup", "Complete")
        catch Error {
            MsgBox("Не удалось сохранить подтверждение в Settings.ini.", "Настройки", 16)
            return
        }
    }
    try InitialSetup.Destroy()
    return
}
CounterMoveStart(*) {
    global
    if (CounterHidden)
        return
    if (counterMoveActive) {
        CounterMoveFinish(0, 0, 0, ID)
        return
    }
    counterMoveActive := true
    WinSet_Click_Through(ID, "Off")
    WinSetAlwaysOnTop(1, "ahk_id " ID)
    ogcTextCounterMoveAction.Value := "ГОТОВО"
    ogcTextMainFooterHint.Value := "Перетащите счётчик мышью или нажмите «ГОТОВО»"
    return
}
CounterVisibilityToggle(*) {
    global
    if (counterMoveActive) {
        CounterMoveFinish(0, 0, 0, ID)
        if (counterMoveActive)
            return
    }
    CounterHidden := !CounterHidden
    try IniWrite(CounterHidden, settingsPath, "Counter", "Hidden")
    catch Error {
        CounterHidden := !CounterHidden
        MsgBox("Не удалось сохранить настройку видимости.", "Счётчик", 16)
        return
    }
    if (CounterHidden) {
        myGui.Hide()
        ogcCounterVisibilityAction.Value := "ПОКАЗАТЬ СЧЁТЧИК"
        ogcTextMainFooterHint.Value := "Счётчик скрыт. Нажмите кнопку, чтобы показать его."
    } else {
        myGui.Title := "Overlay"
        myGui.Show("NA x" . X . " y" . Y . " w212 h30")
        ogcCounterVisibilityAction.Value := "СКРЫТЬ СЧЁТЧИК"
        ogcTextMainFooterHint.Value := "Счётчик снова отображается на экране."
    }
    CounterUpdateMoveButton()
    return
}
MainDrag(*) {
    global
    DllCall("ReleaseCapture")
    PostMessage(0xA1, 2, , , "ahk_id " mainGuiHwnd)
    return
}
SelectMale(*) {
    global
    ogcRadioGenderMale.Value := 1
    ogcRadioGenderFemale.Value := 0
    return
}
SelectFemale(*) {
    global
    ogcRadioGenderMale.Value := 0
    ogcRadioGenderFemale.Value := 1
    return
}
GreetingHotkeyBegin(*) {
    global
    greetingCaptureOpen := true
    ogcTextGreetingHotkeyDisplay.Visible := false
    ogcGreetingHotkey.Visible := true
    ogcGreetingHotkey.Focus()
    SetTimer(GreetingHotkeyRefresh, 100)
    return
}
GreetingHotkeyRefresh() {
    global
    if (!greetingCaptureOpen) {
        SetTimer(GreetingHotkeyRefresh, 0)
        return
    }
    selectedTab := ogcTab2MainTabs.Value
    if (selectedTab = "Настройки" && WinActive("ahk_id " mainGuiHwnd)
        && DllCall("GetFocus", "Ptr") = GreetingHotkeyHwnd)
        return
    GreetingFinishHotkeyCapture()
    return
}
MainShowBinds(*) {
    global
    SetTimer(MainRefreshSectionScroll, 0)
    ogcTab2MainTabs.Choose(1)
    MainUpdateAnswerActions()
    ogcProgressMainSectionAccent.Visible := false
    ogcProgressMainTabAccent.Visible := true
    ogcProgressMainTabAccent.Move(610, 57)
    ogcProgressMainSaveBackground.Visible := true
    ogcTextMainSaveAction.Visible := true
    ogcTextMainFooterHint.Value := "Изменения вступят в силу после сохранения"
    return
}
MainShowSettings(*) {
    global
    SetTimer(MainRefreshSectionScroll, 0)
    ogcTab2MainTabs.Choose(2)
    MainUpdateAnswerActions()
    ogcProgressMainSectionAccent.Visible := false
    ogcProgressMainTabAccent.Visible := true
    ogcProgressMainTabAccent.Move(790, 57)
    ogcProgressMainSaveBackground.Visible := true
    ogcTextMainSaveAction.Visible := true
    ogcTextMainFooterHint.Value := "Изменения вступят в силу после сохранения"
    return
}
MainShowClicker(*) {
    global
    SetTimer(MainRefreshSectionScroll, 0)
    ogcTab2MainTabs.Choose(4)
    MainUpdateAnswerActions()
    ogcProgressMainSectionAccent.Visible := false
    ogcProgressMainTabAccent.Visible := true
    ogcProgressMainTabAccent.Move(430, 57)
    ogcProgressMainSaveBackground.Visible := true
    ogcTextMainSaveAction.Visible := true
    ogcTextMainFooterHint.Value := "Изменения вступят в силу после сохранения"
}
MainTabChanged(*) {
    global
    selectedTab := ogcTab2MainTabs.Value
    if (selectedTab != "Кликер" && IsObject(clickerCapture)) {
        clickerCapture.Stop()
        clickerCapture := ""
        clickerKeyDisplay.Value := ClickerKeyLabel(clickerPendingKey)
    }
    if (selectedTab = "Настройки")
        ogcProgressMainTabAccent.Move(790, 57)
    else if (selectedTab = "Бинды")
        ogcProgressMainTabAccent.Move(610, 57)
    else if (selectedTab = "Кликер")
        ogcProgressMainTabAccent.Move(430, 57)
    return
}
ClickerToggle(*) {
    global clickerEnabledDraft, clickerSwitch
    clickerEnabledDraft := !clickerEnabledDraft
    clickerSwitch.Value := clickerEnabledDraft ? "●  ВКЛЮЧЁН" : "○  ВЫКЛЮЧЕН"
}
ClickerBeginCapture(*) {
    global clickerCapture, clickerKeyDisplay
    if IsObject(clickerCapture)
        clickerCapture.Stop()
    clickerKeyDisplay.Value := "НАЖМИТЕ КНОПКУ"
    clickerCapture := InputHook("L0")
    clickerCapture.KeyOpt("{All}", "N")
    clickerCapture.OnKeyDown := ClickerKeyboardCaptured
    clickerCapture.Start()
}
ClickerKeyboardCaptured(input, vk, sc) {
    global clickerCapture
    if (input != clickerCapture)
        return
    ClickerSetKey(sc ? Format("sc{:03X}", sc) : Format("vk{:02X}", vk))
}
ClickerMouseCaptured(wParam, lParam, msg, hwnd) {
    global clickerCapture, clickerKeyDisplay
    if (!IsObject(clickerCapture) || hwnd != clickerKeyDisplay.Hwnd)
        return
    key := msg = 0x201 ? "LButton" : msg = 0x204 ? "RButton" : msg = 0x207 ? "MButton"
        : (wParam >> 16 & 0xFFFF) = 1 ? "XButton1" : "XButton2"
    ClickerSetKey(key)
}
ClickerSetKey(key) {
    global clickerCapture, clickerPendingKey, clickerKeyDisplay
    clickerCapture.Stop()
    clickerCapture := ""
    clickerPendingKey := key
    clickerKeyDisplay.Value := ClickerKeyLabel(key)
}
ClickerKeyLabel(key) {
    name := GetKeyName(key)
    return StrLen(name) = 1 ? StrUpper(NormalizeBinderHotkey(name)) : name
}
MainRefreshSectionScroll() {
    global
    if (shortcutEditorHwnd && DllCall("GetForegroundWindow", "Ptr") = shortcutEditorHwnd)
        return
    MainUpdateSectionScroll()
    return
}
MainHighlightDeferred() {
    global
    MainHighlightVisibleMatches()
    return
}
MainAnswerEdit(control, *) {
    global
    actionIndex := Integer(RegExReplace(control.Name, "\D"))
    action := mainAnswerActions[actionIndex]
    if (IsObject(action)) {
        shortcutOpenRecord := action.index
        shortcutOpenSection := action.section
        shortcutOpenChapter := action.chapter
        ShortcutEditorOpen()
    }
    return
}
MainAnswerDelete(control, *) {
    global
    actionIndex := Integer(RegExReplace(control.Name, "\D"))
    action := mainAnswerActions[actionIndex]
    if (IsObject(action)) {
        deleted := ShortcutDeleteRecord(action.index)
        if (deleted = 1) {
            MainRenderSearchSection(mainCurrentSection, mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch")
            ogcTextMainFooterHint.Value := "Удалено: " shortcutDeletedAlias
        } else if (deleted = -1)
            MsgBox("Не удалось обновить файл Shortcuts.tsv.", "Сокращения", 16)
    }
    return
}
MainSectionScrollClick(*) {
    global
    MainScrollSectionToMouse()
    return
}
Info(*) {
    global
    MainOpenSection("info", "Общая информация", 1)
    return
}
Commandlist(*) {
    global
    MainOpenSection("commands", "Команды", 2)
    return
}
Answers(*) {
    global
    MainOpenSection("answers", "Ответы", 3)
    return
}
MainAnswersSearchChanged(*) {
    global
    if (mainCurrentSection = "answers")
        SetTimer(MainSearchApply, -180)
    return
}
MainAnswersSearchClear(*) {
    global
    SetTimer(MainSearchApply, 0)
    ogcEditMainAnswersSearch.Value := ""
    ogcEditMainAnswersSearch.Focus()
    if (mainCurrentSection = "answers")
        MainSearchChanged("answers", "MainAnswersSearch")
    return
}
MainChapterChoose(control, *) {
    global
    chapterIndex := Integer(RegExReplace(control.Name, "\D"))
    MainShowChapter(mainCurrentSection = "answers" ? answerChapters[chapterIndex] : mainCurrentSection = "punishments" ? punishmentChapters[chapterIndex] : usefulChapters[chapterIndex])
    return
}
MainChaptersBack(*) {
    global
    MainShowChapters()
    return
}
Punish(*) {
    global
    MainOpenSection("punishments", "Наказания", 4)
    return
}
Usefull(*) {
    global
    MainOpenSection("useful", "Полезное", 5)
    return
}
MainUsefulSearchChanged(*) {
    global
    if (mainCurrentSection = "useful" || mainCurrentSection = "punishments")
        SetTimer(MainSearchApply, -180)
    return
}
MainUsefulSearchClear(*) {
    global
    SetTimer(MainSearchApply, 0)
    ogcEditMainUsefulSearch.Value := ""
    ogcEditMainUsefulSearch.Focus()
    if (mainCurrentSection = "useful" || mainCurrentSection = "punishments")
        MainSearchChanged(mainCurrentSection, "MainUsefulSearch")
    return
}
MainSearchApply() {
    global
    if (mainCurrentSection = "answers")
        MainSearchChanged("answers", "MainAnswersSearch")
    else if (mainCurrentSection = "useful" || mainCurrentSection = "punishments")
        MainSearchChanged(mainCurrentSection, "MainUsefulSearch")
    return
}
SaveData1(*) {
    global settingsPath
    IniWrite(Main["Dinamic"].Value, settingsPath, "ID", "Dinamic")
}
SaveData(*) {
    global
    oSaved := Main.Submit(0)
    clickerIntervalValue := oSaved.ClickerInterval
    if !RegExMatch(clickerIntervalValue, "^\d+$") || clickerIntervalValue < 10 || clickerIntervalValue > 10000 {
        MsgBox("Укажите интервал от 10 до 10000 мс.", "Кликер", 48)
        return
    }
    try LoginAdvToggle := oSaved.LoginAdvToggle
    try Radio10 := oSaved.Radio10
    try Radio11 := oSaved.Radio11
    try Radio12 := oSaved.Radio12
    try Radio13 := oSaved.Radio13
    try Radio14 := oSaved.Radio14
    try Radio15 := oSaved.Radio15
    try Radio16 := oSaved.Radio16
    try Radio8 := oSaved.Radio8
    try Radio9 := oSaved.Radio9
    try Dinamic := oSaved.Dinamic
    try Fraction := oSaved.Fraction
    try dis := oSaved.dis
    try gadis := oSaved.gadis
    try zgadis := oSaved.zgadis
    try GreetingHotkey := oSaved.GreetingHotkey
    try Radio1 := oSaved.Radio1
    try Radio17 := oSaved.Radio17
    try Radio2 := oSaved.Radio2
    try Radio3 := oSaved.Radio3
    try Radio4 := oSaved.Radio4
    try Radio5 := oSaved.Radio5
    try Radio6 := oSaved.Radio6
    try Radio7 := oSaved.Radio7
    try GenderFemale := oSaved.GenderFemale
    try GenderMale := oSaved.GenderMale
    if (GenderMale = GenderFemale) {
        MsgBox("Выберите один вариант: мужской или женский.", "Пол администратора", 48)
        return
    }
    GreetingHotkey := NormalizeBinderHotkey(GreetingHotkey)
    if (GreetingHotkey = "") {
        MsgBox("Выберите клавишу приветствия в настройках.", "Клавиша приветствия", 48)
        return
    }
    Hot1 := NormalizeBinderHotkey(Main["Hot1"].Value)
    Hot2 := NormalizeBinderHotkey(Main["Hot2"].Value)
    Hot3 := NormalizeBinderHotkey(Main["Hot3"].Value)
    Hot4 := NormalizeBinderHotkey(Main["Hot4"].Value)
    Hot5 := NormalizeBinderHotkey(Main["Hot5"].Value)
    Hot6 := NormalizeBinderHotkey(Main["Hot6"].Value)
    Hot7 := NormalizeBinderHotkey(Main["Hot7"].Value)
    Hot8 := NormalizeBinderHotkey(Main["Hot8"].Value)
    Hot9 := NormalizeBinderHotkey(Main["Hot9"].Value)
    Hot10 := NormalizeBinderHotkey(Main["Hot10"].Value)
    Hot11 := NormalizeBinderHotkey(Main["Hot11"].Value)
    Hot12 := NormalizeBinderHotkey(Main["Hot12"].Value)
    Hot13 := NormalizeBinderHotkey(Main["Hot13"].Value)
    Hot14 := NormalizeBinderHotkey(Main["Hot14"].Value)
    Hot15 := NormalizeBinderHotkey(Main["Hot15"].Value)
    Hot16 := NormalizeBinderHotkey(Main["Hot16"].Value)
    Hot17 := NormalizeBinderHotkey(Main["Hot17"].Value)
    Hot18 := NormalizeBinderHotkey(Main["Hot18"].Value)
    Hot19 := NormalizeBinderHotkey(Main["Hot19"].Value)
    Hot20 := NormalizeBinderHotkey(Main["Hot20"].Value)
    greetingConflict := GreetingConflictIndex(GreetingHotkey, [Hot1, Hot2, Hot3, Hot4, Hot5
        , Hot6, Hot7, Hot8, Hot9, Hot10, Hot11, Hot12, Hot13, Hot14, Hot15
        , Hot16, Hot17, Hot18, Hot19, Hot20])
    if (greetingConflict < 0) {
        MsgBox("Ctrl+F9 и Ctrl+F10 заняты перезапуском и закрытием биндера. Выберите другое сочетание.", "Клавиша приветствия", 48)
        return
    }
    if (greetingConflict > 0) {
        MsgBox("Выбранная клавиша уже назначена на бинд №" greetingConflict ". Выберите другое сочетание.", "Клавиша приветствия", 48)
        return
    }
    if clickerEnabledDraft {
        for _, bindKey in [Hot1, Hot2, Hot3, Hot4, Hot5, Hot6, Hot7, Hot8, Hot9, Hot10
            , Hot11, Hot12, Hot13, Hot14, Hot15, Hot16, Hot17, Hot18, Hot19, Hot20, GreetingHotkey] {
            if (bindKey != "" && GetKeyVK(PhysicalBinderHotkey(bindKey)) = GetKeyVK(clickerPendingKey)) {
                MsgBox("Кнопка кликера уже назначена на другое действие. Выберите другую.", "Кликер", 48)
                return
            }
        }
    }
    if (Hot13 != "") {
        punishmentKey := PhysicalBinderHotkey(Hot13)
        allHotkeys := [Hot1, Hot2, Hot3, Hot4, Hot5, Hot6, Hot7, Hot8, Hot9, Hot10
            , Hot11, Hot12, Hot13, Hot14, Hot15, Hot16, Hot17, Hot18, Hot19, Hot20]
        for otherIndex, otherHotkey in allHotkeys {
            if (otherIndex != 13 && otherHotkey != "" && PhysicalBinderHotkey(otherHotkey) = punishmentKey) {
                MsgBox("Клавиша наказаний уже назначена на бинд №" otherIndex ". Выберите разные клавиши.", "Совпадающие клавиши", 48)
                return
            }
        }
    }
    AdminGender := GenderFemale ? "female" : "male"
    IniWrite(Radio1, A_ScriptDir "\res\Settings.ini", "Resolution", "1920x1080")
    IniWrite(Radio3, A_ScriptDir "\res\Settings.ini", "Resolution", "1680x1050")
    IniWrite(Radio2, A_ScriptDir "\res\Settings.ini", "Resolution", "1600x900")
    IniWrite(Radio4, A_ScriptDir "\res\Settings.ini", "Resolution", "1366x768")
    IniWrite(Radio5, A_ScriptDir "\res\Settings.ini", "Resolution", "1280x960")
    IniWrite(Radio6, A_ScriptDir "\res\Settings.ini", "Resolution", "1920x10802")
    IniWrite(Radio7, A_ScriptDir "\res\Settings.ini", "Resolution", "1280х1024")
    IniWrite(Radio17, A_ScriptDir "\res\Settings.ini", "Resolution", "2560x1440")

    IniWrite(Radio8, A_ScriptDir "\res\Settings.ini", "Login Commands", "/hidecheatinfo")
    IniWrite(Radio9, A_ScriptDir "\res\Settings.ini", "Login Commands", "/showcheats")
    IniWrite(Radio10, A_ScriptDir "\res\Settings.ini", "Login Commands", "/dl")
    IniWrite(Radio11, A_ScriptDir "\res\Settings.ini", "Login Commands", "/esp 3")
    IniWrite(Radio12, A_ScriptDir "\res\Settings.ini", "Login Commands", "/templeader")
    IniWrite(Radio13, A_ScriptDir "\res\Settings.ini", "Login Commands", "/chide")
    IniWrite(Radio14, A_ScriptDir "\res\Settings.ini", "Login Commands", "/zzdebug")
    IniWrite(Radio15, A_ScriptDir "\res\Settings.ini", "Login Commands", "/objdl")
    IniWrite(Radio16, A_ScriptDir "\res\Settings.ini", "Login Commands", "/netstat")
    IniWrite(LoginAdvToggle, A_ScriptDir "\res\Settings.ini", "Login Commands", "/advtoggle 0")

    IniWrite(Hot1, A_ScriptDir "\res\Settings.ini", "Binds", "KEY1")
    IniWrite(Hot2, A_ScriptDir "\res\Settings.ini", "Binds", "KEY2")
    IniWrite(Hot3, A_ScriptDir "\res\Settings.ini", "Binds", "KEY3")
    IniWrite(Hot4, A_ScriptDir "\res\Settings.ini", "Binds", "KEY4")
    IniWrite(Hot5, A_ScriptDir "\res\Settings.ini", "Binds", "KEY5")
    IniWrite(Hot6, A_ScriptDir "\res\Settings.ini", "Binds", "KEY6")
    IniWrite(Hot7, A_ScriptDir "\res\Settings.ini", "Binds", "KEY7")
    IniWrite(Hot8, A_ScriptDir "\res\Settings.ini", "Binds", "KEY8")
    IniWrite(Hot9, A_ScriptDir "\res\Settings.ini", "Binds", "KEY9")
    IniWrite(Hot10, A_ScriptDir "\res\Settings.ini", "Binds", "KEY10")
    IniWrite(Hot11, A_ScriptDir "\res\Settings.ini", "Binds", "KEY11")
    IniWrite(Hot12, A_ScriptDir "\res\Settings.ini", "Binds", "KEY12")
    IniWrite(Hot13, A_ScriptDir "\res\Settings.ini", "Binds", "KEY13")
    IniWrite(Hot14, A_ScriptDir "\res\Settings.ini", "Binds", "KEY14")
    IniWrite(Hot15, A_ScriptDir "\res\Settings.ini", "Binds", "KEY15")
    IniWrite(Hot16, A_ScriptDir "\res\Settings.ini", "Binds", "KEY16")
    IniWrite(Hot17, A_ScriptDir "\res\Settings.ini", "Binds", "KEY17")
    IniWrite(Hot18, A_ScriptDir "\res\Settings.ini", "Binds", "KEY18")
    IniWrite(Hot19, A_ScriptDir "\res\Settings.ini", "Binds", "KEY19")
    IniWrite(Hot20, A_ScriptDir "\res\Settings.ini", "Binds", "KEY20")

    IniWrite(X, A_ScriptDir "\res\Settings.ini", "Coords", "X")
    IniWrite(Y, A_ScriptDir "\res\Settings.ini", "Coords", "Y")
    IniWrite(Fraction, A_ScriptDir "\res\Settings.ini", "Fraction", "Fraction")

    IniWrite(dis, A_ScriptDir "\res\Settings.ini", "Discord", "dis")
    IniWrite(gadis, A_ScriptDir "\res\Settings.ini", "Discord", "gadis")
    IniWrite(zgadis, A_ScriptDir "\res\Settings.ini", "Discord", "zgadis")
    IniWrite(GreetingHotkey, A_ScriptDir "\res\Settings.ini", "Greeting", "Hotkey")
    IniWrite(AdminGender, A_ScriptDir "\res\Settings.ini", "Admin", "Gender")
    IniWrite(clickerEnabledDraft, settingsPath, "Clicker", "Enabled")
    IniWrite(clickerPendingKey, settingsPath, "Clicker", "Key")
    IniWrite(clickerIntervalValue, settingsPath, "Clicker", "Interval")
    Reload()
}
ClickerStart(*) {
    global ClickerEnabled, ClickerKey, ClickerInterval, clickerRunning
    if (!ClickerEnabled || clickerRunning || !GetKeyState(ClickerKey, "P"))
        return
    clickerRunning := true
    ClickerTick()
    if clickerRunning
        SetTimer(ClickerTick, ClickerInterval)
}
ClickerTick() {
    global ClickerKey, clickerRunning
    if (!GetKeyState(ClickerKey, "P") || !(WinActive("ahk_exe GTA5.exe") || WinActive("ahk_exe ragemp_v.exe"))) {
        SetTimer(ClickerTick, 0)
        clickerRunning := false
        return
    }
    SendEvent("{Click}")
}
mess(ThisHotkey := "") {
    global
    labelgo()
}
labelgo() {
    global
    if (Radio17 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(253, 56, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  ) | ( Var1 = 0xB01544 )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    else if (radio1 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(190, 42, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  ) | ( Var1 = 0xB01544 )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    else if (Radio2 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(152, 45, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    else if (Radio3 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(178, 54, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    else if (Radio6 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(183, 55, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    else if (Radio4 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(130, 40, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    else if (Radio7 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(174, 51, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    else if (Radio5 == 1)
    {
    SendInput("{Enter}")
    Sleep(1000)
    color := PixelGetColor(163, 51, "Alt")
    Var1 := color
    if ( Var1 = 0xE81C5A  ) | ( Var1 = 0xFB1259  ) | ( Var1 = 0xFF1383  ) | ( Var1 = 0xE91966  )
    {

    UpdateCounter()
    A_Clipboard :=""
    }
    }
    return
}
UpdateCounter1() {
    global
    IniWrite(DayANS, A_ScriptDir "\res\Settings.ini", "ANS", "DayANS")
    DayANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "DayANS", 0)
    IniWrite(WeekANS, A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS")
    WeekANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS", 0)
    ogcMyText.Value := "День: " DayANS
    ogcTextMyTotalR.Value := "Неделя: " WeekANS
    return
}
UpdateCounter2() {
    global
    DayANS-=1
    WeekANS-=1
    IniWrite(DayANS, A_ScriptDir "\res\Settings.ini", "ANS", "DayANS")
    DayANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "DayANS", 0)
    IniWrite(WeekANS, A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS")
    WeekANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS", 0)
    ogcMyText.Value := "День: " DayANS
    ogcTextMyTotalR.Value := "Неделя: " WeekANS
    return
}
UpdateCounter() {
    global
    DayANS+=1
    WeekANS+=1
    IniWrite(DayANS, A_ScriptDir "\res\Settings.ini", "ANS", "DayANS")
    DayANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "DayANS", 0)
    IniWrite(WeekANS, A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS")
    WeekANS := IniRead(A_ScriptDir "\res\Settings.ini", "ANS", "WeekANS", 0)
    ogcMyText.Value := "День: " DayANS
    ogcTextMyTotalR.Value := "Неделя: " WeekANS
    return
}
Reports(ThisHotkey := "") {
    global
    SendInput("{F11}")
    Sleep(50)
    MouseMove(494, 161)
    return
}
f5(ThisHotkey := "") {
    global
    SendInput("{F5}")
    return
}
Cheatsheet(ThisHotkey := "") {
    global
    if (Cheatsheet1 && WinActive(cheatsheetGuiHwnd)) {
        focusedControl := ""
        try focusedControl := ControlGetClassNN(ControlGetFocus(cheatsheetGuiHwnd))
        if RegExMatch(focusedControl, "i)^Edit")
            return
    }
    if (Cheatsheet1) {
        CheatsheetClose()
        return
    }
    Cheatsheet1 := true
    CheatsheetPage := 1
    CheatsheetSearchActive := false
    cheatsheetRules := CheatsheetBuildRules()
    cheatsheetFiltered := cheatsheetRules
    try SheetGui.Destroy()
    SheetGui := Gui("-Caption +Border +AlwaysOnTop +ToolWindow")
    SheetGui.OnEvent("Close", CheatsheetGuiEscape)
    SheetGui.OnEvent("Escape", CheatsheetGuiEscape)
    SheetGui.BackColor := "12131A"
    SheetGui.Add("Progress", "x0 y0 w1020 h78 c1B1D27 Background1B1D27 Disabled", "100")
    ogcText := SheetGui.Add("Text", "x260 y0 w344 h76 +BackgroundTrans")
    ogcText.OnEvent("Click", CheatsheetDrag)
    SheetGui.SetFont("s17 w700 cFFFFFF", "Segoe UI")
    ogcTextMAJESTIC := SheetGui.Add("Text", "x24 y15 w230 h30 +BackgroundTrans", "MAJESTIC")
    ogcTextMAJESTIC.OnEvent("Click", CheatsheetDrag)
    SheetGui.SetFont("s9 w600 cEA3479", "Segoe UI")
    ogcTextADMINBINDER := SheetGui.Add("Text", "x26 y47 w230 h18 +BackgroundTrans", "ADMIN  /  BINDER")
    ogcTextADMINBINDER.OnEvent("Click", CheatsheetDrag)
    SheetGui.SetFont("s10 w600 cD9DCE8", "Segoe UI")
    ogcText := SheetGui.Add("Text", "x612 y27 w142 h28 +0x200 +0x100 Center Background292C38", "ПОИСК")
    ogcText.OnEvent("Click", CheatsheetSearchToggle)
    ogcText := SheetGui.Add("Text", "x772 y27 w174 h28 +0x200 +0x100 Center Background292C38", "ПАМЯТКА")
    ogcText.OnEvent("Click", CheatsheetDrag)
    SheetGui.Add("Progress", "x772 y57 w174 h3 cEA3479 BackgroundEA3479 Disabled", "100")
    SheetGui.SetFont("s15 w400 cAEB1BF", "Segoe UI")
    ogcText := SheetGui.Add("Text", "x972 y25 w30 h30 +0x200 +0x100 Center +BackgroundTrans", "×")
    ogcText.OnEvent("Click", CheatsheetClose)
    SheetGui.Add("Progress", "x0 y77 w1020 h2 cEA3479 BackgroundEA3479 Disabled", "100")

    SheetGui.SetFont("s12 w700 cFFFFFF", "Segoe UI")
    SheetGui.Add("Text", "x24 y99 w460 h28 +BackgroundTrans", "Фракции")
    SheetGui.SetFont("s9 c989DAD", "Segoe UI")
    SheetGui.Add("Text", "x696 y105 w300 h19 Right +BackgroundTrans", "ID фракций для команд")
    fractions := CheatsheetReadRows("fractions.txt", 12)
    for fractionSlot, fraction in fractions {
        fractionId := fraction[1]
        fractionName := fraction[2]
        chipX := 24 + Mod(fractionSlot - 1, 6) * 162
        chipY := 137 + Floor((fractionSlot - 1) / 6) * 31
        SheetGui.Add("Progress", "x" chipX " y" chipY " w154 h26 c272A36 Background272A36 Disabled", "100")
        SheetGui.SetFont("s9 w700 cEA3479", "Segoe UI")
        SheetGui.Add("Text", "x" (chipX + 12) " y" chipY " w26 h26 +0x200 +BackgroundTrans", fractionId)
        SheetGui.SetFont("s9 w600 cFFFFFF", "Segoe UI")
        SheetGui.Add("Text", "x" (chipX + 43) " y" chipY " w105 h26 +0x200 +BackgroundTrans", fractionName)
    }
    SheetGui.Add("Progress", "x24 y205 w972 h1 c343746 Background343746 Disabled", "100")
    SheetGui.SetFont("s12 w700 cFFFFFF", "Segoe UI")
    SheetGui.Add("Text", "x24 y215 w280 h28 +BackgroundTrans", "Наказания")
    SheetGui.SetFont("s9 c989DAD", "Segoe UI")
    ogcTextCheatsheetRulesHint := SheetGui.Add("Text", "x537 y220 w459 h20 Right +BackgroundTrans vCheatsheetRulesHint", "Сроки из вашей памятки — сверяйте с форумом")
    ogcProgressCheatsheetSearchBg := SheetGui.Add("Progress", "x537 y215 w390 h29 c272A36 Background272A36 Disabled Hidden vCheatsheetSearchBg", "100")
    SheetGui.SetFont("s9 cFFFFFF", "Segoe UI")
    ogcEditCheatsheetSearchInput := SheetGui.Add("Edit", "x546 y219 w372 h21 vCheatsheetSearchInput Background272A36 -Border -E0x200 Hidden"), CheatsheetSearchHwnd := ogcEditCheatsheetSearchInput.hwnd
    ogcEditCheatsheetSearchInput.OnEvent("Change", CheatsheetSearchChanged)
    DllCall("SendMessage", "Ptr", CheatsheetSearchHwnd, "UInt", 0x1501, "Ptr", 1, "WStr", "Название или санкция")
    ogcProgressCheatsheetClearBg := SheetGui.Add("Progress", "x934 y215 w62 h29 c292C38 Background292C38 Disabled Hidden vCheatsheetClearBg", "100")
    SheetGui.SetFont("s9 w700 cFFFFFF", "Segoe UI")
    ogcTextCheatsheetClearButton := SheetGui.Add("Text", "x934 y215 w62 h29 +0x200 +0x100 Center +BackgroundTrans Hidden vCheatsheetClearButton", "×")
    ogcTextCheatsheetClearButton.OnEvent("Click", CheatsheetSearchClear)

    Loop 10 {
        slot := A_Index
        cardX := slot > 5 ? 518 : 24
        cardY := 253 + Mod(slot - 1, 5) * 78
        ogcProgressCheatsheetCardBgslot := SheetGui.Add("Progress", "x" cardX " y" cardY " w478 h72 c272A36 Background272A36 Disabled vCheatsheetCardBg" slot, "100")
        SheetGui.SetFont("s10 w700 cFFFFFF", "Segoe UI")
        ogcTextCheatsheetCardTitleslot := SheetGui.Add("Text", "x" (cardX + 12) " y" (cardY + 8) " w454 h22 +BackgroundTrans vCheatsheetCardTitle" slot)
        SheetGui.SetFont("s9 w400 cD4D5E0", "Segoe UI")
        ogcTextCheatsheetCardPenaltyslot := SheetGui.Add("Text", "x" (cardX + 12) " y" (cardY + 32) " w454 h37 +BackgroundTrans vCheatsheetCardPenalty" slot)
    }
    SheetGui.Add("Progress", "x24 y648 w972 h1 c343746 Background343746 Disabled", "100")
    SheetGui.Add("Progress", "x24 y660 w150 h29 c292C38 Background292C38 Disabled", "100")
    SheetGui.SetFont("s9 w700 cFFFFFF", "Segoe UI")
    ogcText := SheetGui.Add("Text", "x24 y660 w150 h29 +0x200 +0x100 Center +BackgroundTrans", "← НАЗАД")
    ogcText.OnEvent("Click", CheatsheetPrev)
    SheetGui.SetFont("s9 w700 cEA3479", "Segoe UI")
    ogcTextCheatsheetPageNumber := SheetGui.Add("Text", "x445 y660 w130 h29 +0x200 +0x100 Center +BackgroundTrans vCheatsheetPageNumber")
    SheetGui.Add("Progress", "x846 y660 w150 h29 cEA3479 BackgroundEA3479 Disabled", "100")
    SheetGui.SetFont("s9 w700 cFFFFFF", "Segoe UI")
    ogcText := SheetGui.Add("Text", "x846 y660 w150 h29 +0x200 +0x100 Center +BackgroundTrans", "ДАЛЕЕ →")
    ogcText.OnEvent("Click", CheatsheetNext)
    SheetGui.SetFont("s12 w600 c989DAD", "Segoe UI")
    ogcTextCheatsheetNoResults := SheetGui.Add("Text", "x195 y400 w630 h50 +0x200 Center +BackgroundTrans Hidden vCheatsheetNoResults", "По вашему запросу ничего не найдено")
    CheatsheetRenderPage()
    sheetX := Max(0, Min(X2 + 0, A_ScreenWidth - 1020))
    sheetY := Max(0, Min(Y2 + 0, A_ScreenHeight - 704))
    SheetGui.Title := "Памятка администрации"
    SheetGui.Show("NoActivate x" sheetX " y" sheetY " w1020 h704")
    SheetGui.Opt("+LastFound")
    cheatsheetGuiHwnd := WinExist()
    WinSetTransparent(245, cheatsheetGuiHwnd)
    if (KEY14 != "") {
        HotIfWinActive(cheatsheetGuiHwnd)
        try Hotkey("~" PhysicalBinderHotkey(KEY14), Cheatsheet, "On")
        HotIfWinActive("ahk_exe GTA5.exe")
    }
    return
}
CheatsheetPrev(*) {
    global
    CheatsheetPage := CheatsheetPage = 1 ? CheatsheetPageCount : CheatsheetPage - 1
    CheatsheetRenderPage()
    return
}
CheatsheetNext(*) {
    global
    CheatsheetPage := CheatsheetPage = CheatsheetPageCount ? 1 : CheatsheetPage + 1
    CheatsheetRenderPage()
    return
}
CheatsheetSearchToggle(*) {
    global
    CheatsheetSearchActive := !CheatsheetSearchActive
    if (CheatsheetSearchActive) {
        ogcTextCheatsheetRulesHint.Visible := false
        ogcProgressCheatsheetSearchBg.Visible := true
        ogcEditCheatsheetSearchInput.Visible := true
        ogcProgressCheatsheetClearBg.Visible := true
        ogcTextCheatsheetClearButton.Visible := true
        WinActivate(cheatsheetGuiHwnd)
        ogcEditCheatsheetSearchInput.Focus()
    } else {
        ogcProgressCheatsheetSearchBg.Visible := false
        ogcEditCheatsheetSearchInput.Visible := false
        ogcProgressCheatsheetClearBg.Visible := false
        ogcTextCheatsheetClearButton.Visible := false
        ogcTextCheatsheetRulesHint.Visible := true
        ogcEditCheatsheetSearchInput.Value := ""
        CheatsheetApplySearch()
    }
    return
}
CheatsheetSearchChanged(*) {
    global
    CheatsheetApplySearch()
    return
}
CheatsheetSearchClear(*) {
    global
    ogcEditCheatsheetSearchInput.Value := ""
    ogcEditCheatsheetSearchInput.Focus()
    return
}
CheatsheetDrag(*) {
    global
    DllCall("ReleaseCapture")
    PostMessage(0xA1, 2, , , cheatsheetGuiHwnd)
    return
}
CheatsheetClose(*) {
    global
    CheatsheetGuiEscape()
}
CheatsheetGuiEscape(*) {
    global
    if (cheatsheetGuiHwnd && WinExist(cheatsheetGuiHwnd)) {
        WinGetPos(&sheetSavedX, &sheetSavedY, , , cheatsheetGuiHwnd)
        if (sheetSavedX != "" && sheetSavedY != "") {
            X2 := sheetSavedX
            Y2 := sheetSavedY
            IniWrite(X2, A_ScriptDir "\res\Settings.ini", "Coords", "X2")
            IniWrite(Y2, A_ScriptDir "\res\Settings.ini", "Coords", "Y2")
        }
    }
    if (KEY14 != "" && cheatsheetGuiHwnd) {
        HotIfWinActive(cheatsheetGuiHwnd)
        try Hotkey("~" PhysicalBinderHotkey(KEY14), "Off")
        HotIfWinActive("ahk_exe GTA5.exe")
    }
    Cheatsheet1 := false
    try SheetGui.Destroy()
    cheatsheetGuiHwnd := 0
    return
}
vac(ThisHotkey := "") {
    global
    SendMessage(0x50, , 0x4190419, , "A")
    SendInput("{t}")
    Sleep(200)
    SendInput("/ainfect  0{left 2}")
    return
}
repm(ThisHotkey := "") {
    global

    UpdateCounter2()
    A_Clipboard :=""
    return
}
dimcar(ThisHotkey := "") {
    global
    SendMessage(0x50, , 0x4190419, , "A")
    SendInput("{T}")
    ihcar := InputHook("V","{ctrl}{Enter}"), ihcar.Start(), ihcar.Wait(), car := ihcar.Input
    Sleep(750)
    SendInput("{T}")
    Sleep(200)
    SendInput("/getcar " car "{Enter}")
    Sleep(750)
    SendInput("{T}")
    Sleep(200)
    SendInput("/repair{Enter}")
    Sleep(750)
    SendInput("{T}")
    Sleep(200)
    SendInput("/setcardim " car " 5{Enter}")
    Sleep(1200)
    SendInput("{T}")
    Sleep(200)
    SendInput("/setcardim " car " 0{Enter}")
    Return
}
reshp(ThisHotkey := "") {
    global
    SendInput("{T}")
    ihhId := InputHook("V","{ctrl} {Enter}"), ihhId.Start(), ihhId.Wait(), hId := ihhId.Input
    Sleep(750)
    SendInput("{T}")
    Sleep(200)
    SendInput("/hp " hId " 0{Enter}")
    Sleep(750)
    SendInput("{T}")
    Sleep(200)
    SendInput("/rescue " hId "{Enter}")
    Return
}
delv(ThisHotkey := "") {
    global
    BlockInput("SendAndMouse")
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/delveh{Enter}")
    return
}
killplayer(ThisHotkey := "") {
    global
    BlockInput("SendAndMouse")
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/hp  0{left 2}")
    return
}
PunishmentOpenFromGui(*) {
    global
    punishmentFromGui := true
    PunishmentHandler()
    return
}
PunishmentHandler(ThisHotkey := "") {
    global
    if (!punishmentFromGui && WinActive("ahk_id " mainGuiHwnd)) {
        focusedControl := ""
        try focusedControl := ControlGetClassNN(ControlGetFocus("ahk_id " mainGuiHwnd))
        if RegExMatch(focusedControl, "i)^Edit")
            return
        if RegExMatch(focusedControl, "i)^msctls_hotkey32") {
            focusedHwnd := ControlGetHwnd(focusedControl, "ahk_id " mainGuiHwnd)
            if (focusedHwnd != mainPunishmentHotkeyHwnd)
                return
        }
    }
    punishmentFromGui := false
    punishmentGameHwnd := WinActive("ahk_exe GTA5.exe")
    if (!punishmentGameHwnd)
        punishmentGameHwnd := WinActive("ahk_exe ragemp_v.exe")
    punishmentPath := A_ScriptDir . "\Punishment.txt"
    try punishmentSavedText := FileRead(punishmentPath)
    catch Error
        punishmentSavedText := ""
    try Punishment.Destroy()
    Punishment := Gui("-Caption +Border +AlwaysOnTop +OwnDialogs")
    Punishment.OnEvent("Close", PunishmentGuiEscape)
    Punishment.OnEvent("Escape", PunishmentGuiEscape)
    Punishment.BackColor := "12131A"
    Punishment.Add("Progress", "x0 y0 w620 h78 c1B1D27 Background1B1D27 Disabled", "100")
    ogcText := Punishment.Add("Text", "x260 y0 w130 h76 +BackgroundTrans")
    ogcText.OnEvent("Click", PunishmentDrag)
    Punishment.SetFont("s17 w700 cFFFFFF", "Segoe UI")
    ogcTextMAJESTIC := Punishment.Add("Text", "x24 y15 w230 h30 +BackgroundTrans", "MAJESTIC")
    ogcTextMAJESTIC.OnEvent("Click", PunishmentDrag)
    Punishment.SetFont("s9 w600 cEA3479", "Segoe UI")
    ogcTextADMINBINDER := Punishment.Add("Text", "x26 y47 w230 h18 +BackgroundTrans", "ADMIN  /  BINDER")
    ogcTextADMINBINDER.OnEvent("Click", PunishmentDrag)
    Punishment.SetFont("s10 w600 cD9DCE8", "Segoe UI")
    ogcText := Punishment.Add("Text", "x399 y27 w160 h28 +0x200 +0x100 Center Background292C38", "НАКАЗАНИЯ")
    ogcText.OnEvent("Click", PunishmentDrag)
    Punishment.Add("Progress", "x399 y57 w160 h3 cEA3479 BackgroundEA3479 Disabled", "100")
    Punishment.SetFont("s15 w400 cAEB1BF", "Segoe UI")
    ogcText := Punishment.Add("Text", "x575 y25 w30 h30 +0x200 +0x100 Center +BackgroundTrans", "×")
    ogcText.OnEvent("Click", PunishmentCancel)
    Punishment.Add("Progress", "x0 y77 w620 h2 cEA3479 BackgroundEA3479 Disabled", "100")
    Punishment.SetFont("s15 w700 cFFFFFF", "Segoe UI")
    Punishment.Add("Text", "x24 y103 w560 h32 +BackgroundTrans", "Выдача наказаний")
    Punishment.SetFont("s9 c989DAD", "Segoe UI")
    Punishment.Add("Text", "x24 y138 w560 h38 +BackgroundTrans", "Вставьте команды: по одной в строке. Каждая строка должна начинаться с /.`nПосле отправки список останется в Punishment.txt.")
    Punishment.Add("Progress", "x24 y188 w572 h236 c1B1D27 Background1B1D27 Disabled", "100")
    Punishment.SetFont("s10 cFFFFFF", "Segoe UI")
    ogcEditPunishmentCommands := Punishment.Add("Edit", "x32 y196 w556 h220 vPunishmentCommands +VScroll -Border -E0x200 Background1B1D27", punishmentSavedText), PunishmentEditHwnd := ogcEditPunishmentCommands.hwnd
    DllCall("SendMessage", "Ptr", PunishmentEditHwnd, "UInt", 0xD3, "Ptr", 3, "Ptr", 8 | (8 << 16))
    Punishment.SetFont("s9 c989DAD", "Segoe UI")
    Punishment.Add("Text", "x24 y434 w560 h20 +BackgroundTrans", "Проверьте ID и срок наказания перед отправкой.")
    Punishment.SetFont("s10 w700 cFFFFFF", "Segoe UI")
    Punishment.Add("Progress", "x24 y468 w130 h36 c292C38 Background292C38 Disabled", "100")
    ogcText := Punishment.Add("Text", "x24 y468 w130 h36 +0x200 +0x100 Center +BackgroundTrans", "ЗАКРЫТЬ")
    ogcText.OnEvent("Click", PunishmentCancel)
    Punishment.Add("Progress", "x350 y468 w246 h36 cEA3479 BackgroundEA3479 Disabled", "100")
    ogcText := Punishment.Add("Text", "x350 y468 w246 h36 +0x200 +0x100 Center +BackgroundTrans", "СОХРАНИТЬ И ОТПРАВИТЬ")
    ogcText.OnEvent("Click", PunishmentSaveAndSend)
    Punishment.Title := "Выдача наказаний"
    Punishment.Show("w620 h522")
    Punishment.Opt("+LastFound")
    punishmentGuiHwnd := WinExist()
    return
}
PunishmentDrag(*) {
    global
    DllCall("ReleaseCapture")
    PostMessage(0xA1, 2, , , "ahk_id " punishmentGuiHwnd)
    return
}
PunishmentSaveAndSend(*) {
    global
    PunishmentCommands := Punishment["PunishmentCommands"].Value
    punishmentLines := []
    normalizedPunishment := StrReplace(StrReplace(PunishmentCommands, "`r`n", "`n"), "`r", "`n")
    for lineNumber, rawPunishmentLine in StrSplit(normalizedPunishment, "`n") {
        punishmentLine := Trim(rawPunishmentLine, " `t")
        if (punishmentLine = "")
            continue
        if (SubStr(punishmentLine, 1, 1) != "/") {
            MsgBox("Строка " lineNumber " не начинается с /. Исправьте её и повторите отправку.", "Выдача наказаний", 48)
            return
        }
        punishmentLines.Push(punishmentLine)
    }
    if (!punishmentLines.Length) {
        MsgBox("Вставьте хотя бы одну команду.", "Выдача наказаний", 48)
        return
    }
    punishmentTextToSave := ""
    for _, punishmentLine in punishmentLines
        punishmentTextToSave .= punishmentLine . "`r`n"
    try {
        punishmentFile := FileOpen(punishmentPath ".tmp", "w", "UTF-8")
        try written := punishmentFile.Write(punishmentTextToSave)
        finally punishmentFile.Close()
        if (written != StrPut(punishmentTextToSave, "UTF-8") - 1)
            throw Error("Incomplete write")
        FileMove(punishmentPath ".tmp", punishmentPath, true)
    } catch Error {
        MsgBox("Не удалось сохранить Punishment.txt.", "Выдача наказаний", 16)
        return
    }
    gameHwnd := punishmentGameHwnd
    if (!gameHwnd || !WinExist("ahk_id " gameHwnd))
        gameHwnd := WinExist("ahk_exe GTA5.exe")
    if (!gameHwnd)
        gameHwnd := WinExist("ahk_exe ragemp_v.exe")
    if (!gameHwnd) {
        MsgBox("Команды сохранены. Откройте игру и нажмите «Сохранить и отправить» ещё раз.", "Выдача наказаний", 48)
        return
    }
    Punishment.Hide()
    WinActivate("ahk_id " gameHwnd)
    if !WinWaitActive("ahk_id " gameHwnd, , 3) {
        Punishment.Show()
        MsgBox("Команды сохранены, но не удалось переключиться на окно игры.", "Выдача наказаний", 48)
        return
    }
    sentPunishmentCount := 0
    totalPunishmentCount := punishmentLines.Length
    PunishmentProgressShow()
    for _, punishmentLine in punishmentLines {
        if (!WinActive("ahk_id " gameHwnd)) {
            PunishmentProgressHide()
            Punishment.Show()
            MsgBox("Отправка остановлена: фокус ушёл из игры. Отправлено " sentPunishmentCount " команд.", "Выдача наказаний", 48)
            return
        }
        SendInput("{t}")
        Sleep(350)
        if (!WinActive("ahk_id " gameHwnd)) {
            PunishmentProgressHide()
            Punishment.Show()
            MsgBox("Отправка остановлена: фокус ушёл из игры. Отправлено " sentPunishmentCount " команд.", "Выдача наказаний", 48)
            return
        }
        SendInput("{Raw}" punishmentLine)
        Sleep(200)
        if (!WinActive("ahk_id " gameHwnd)) {
            PunishmentProgressHide()
            Punishment.Show()
            MsgBox("Отправка остановлена: фокус ушёл из игры. Отправлено " sentPunishmentCount " команд.", "Выдача наказаний", 48)
            return
        }
        SendInput("{Enter}")
        sentPunishmentCount++
        ogcPunishmentProgressText.Value := "Выдано " sentPunishmentCount "/" totalPunishmentCount
        Sleep(500)
    }
    try Punishment.Destroy()
    SetTimer(PunishmentProgressHide, -2500)
    return
}
PunishmentProgressShow() {
    global
    SetTimer(PunishmentProgressHide, 0)
    try PunishmentProgress.Destroy()
    PunishmentProgress := Gui("+AlwaysOnTop -Caption +ToolWindow +E0x20")
    PunishmentProgress.BackColor := "1B1D27"
    PunishmentProgress.Add("Progress", "x0 y0 w240 h3 cEA3479 BackgroundEA3479 Disabled", "100")
    PunishmentProgress.SetFont("s11 w700 cFFFFFF", "Segoe UI")
    ogcPunishmentProgressText := PunishmentProgress.Add("Text", "x8 y5 w224 h34 Center +0x200 +BackgroundTrans vPunishmentProgressText", "Выдано 0/" totalPunishmentCount)
    punishmentProgressX := (A_ScreenWidth - 240) // 2
    PunishmentProgress.Title := "Отправка наказаний"
    PunishmentProgress.Show("NoActivate x" punishmentProgressX " y20 w240 h44")
    PunishmentProgress.Opt("+LastFound")
    punishmentProgressHwnd := WinExist()
    WinSetTransparent(170, "ahk_id " punishmentProgressHwnd)
    return
}
PunishmentProgressHide() {
    global
    try PunishmentProgress.Destroy()
    return
}
PunishmentCancel(*) {
    global
    PunishmentGuiEscape()
}
PunishmentGuiEscape(*) {
    global
    try Punishment.Destroy()
    return
}
gcar(ThisHotkey := "") {
    global
    BlockInput("SendAndMouse")
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/getcar{Space}")
    return
}
gm(ThisHotkey := "") {
    global
    BlockInput("SendAndMouse")
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/gm{Enter}")
    return
}
resc(ThisHotkey := "") {
    global
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/rescue{Space}")
    return
}
gh(ThisHotkey := "") {
    global
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/gh{Space}")
    return
}
chide(ThisHotkey := "") {
    global
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/chide{Enter}")
    return
}
zzdebug(ThisHotkey := "") {
    global
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/zzdebug{Enter}")
    return
}
mtp(ThisHotkey := "") {
    global
    BlockInput("SendAndMouse")
    SendInput("{sc14}")
    Sleep(50)
    SendInput("/mtp{Enter}")
    return
}
vhod(ThisHotkey := "") {
    global
    SendMessage(0x50, , 0x4090409)
    SendInput("{T}")
    Sleep(300)
    SendInput("/gm{Enter}")
    Sleep(300)
    if (Radio11==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/esp 3{Enter}")
    Sleep(300)
    }
    if (Radio13==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/chide{Enter}")
    Sleep(300)
    }
    if (Radio9==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/showcheats{Enter}")
    Sleep(300)
    }
    if (Radio8==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/hidecheatinfo{Enter}")
    Sleep(300)
    }
    if (Radio10==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/dl{Enter}")
    Sleep(300)
    }
    if (Radio14==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/zzdebug{Enter}")
    Sleep(300)
    }
    if (Radio15==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/objdl{Enter}")
    Sleep(300)
    }
    if (Radio16==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/netstat{Enter}")
    Sleep(300)
    }
    if (LoginAdvToggle == 1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/advtoggle 0{Enter}")
    Sleep(300)
    }
    if (Radio12==1)
    {
    SendInput("{T}")
    Sleep(300)
    SendInput("/templeader " Fraction "{Enter}")
    }
    return
}
rep(ThisHotkey := "") {
    global

    UpdateCounter()
    A_Clipboard :=""
    return
}
ShortcutEditorOpen(*) {
    global
    SetTimer(ShortcutEditorDeferredSelection, 0)
    try Shortcuts.Destroy()
    shortcutLastAliasInput := ""
    shortcutPaintRow := 0
    shortcutPaintRect := 0
    shortcutListVisibleRows := 0
    shortcutPreviousAction := 0
    shortcutOtherTextManual := false
    Shortcuts := Gui("+Owner" Main.Hwnd " -Caption +Border")
    Shortcuts.OnEvent("Close", ShortcutsGuiEscape)
    Shortcuts.OnEvent("Escape", ShortcutsGuiEscape)
    shortcutEditorHwnd := Shortcuts.Hwnd
    Shortcuts.BackColor := "12131A"
    Shortcuts.Add("Progress", "x0 y0 w980 h78 c1B1D27 Background1B1D27 Disabled", "100")
    ogcText := Shortcuts.Add("Text", "x250 y0 w446 h76 +BackgroundTrans")
    ogcText.OnEvent("Click", ShortcutEditorDrag)
    Shortcuts.SetFont("s17 w700 cFFFFFF", "Segoe UI")
    ogcTextMAJESTIC := Shortcuts.Add("Text", "x24 y15 w230 h30 +BackgroundTrans", "MAJESTIC")
    ogcTextMAJESTIC.OnEvent("Click", ShortcutEditorDrag)
    Shortcuts.SetFont("s9 w600 c989DAD", "Segoe UI")
    ogcTextADMINBINDER := Shortcuts.Add("Text", "x26 y47 w230 h18 +BackgroundTrans", "ADMIN  /  BINDER")
    ogcTextADMINBINDER.OnEvent("Click", ShortcutEditorDrag)
    Shortcuts.SetFont("s10 w700 cFFFFFF", "Segoe UI")
    ogcText := Shortcuts.Add("Text", "x696 y27 w224 h28 +0x200 +0x100 Center Background292C38", "РЕДАКТОР СОКРАЩЕНИЙ")
    ogcText.OnEvent("Click", ShortcutEditorDrag)
    Shortcuts.Add("Progress", "x696 y57 w224 h3 cEA3479 BackgroundEA3479 Disabled", "100")
    Shortcuts.SetFont("s15 w400 cAEB1BF", "Segoe UI")
    ogcText := Shortcuts.Add("Text", "x934 y25 w30 h30 +0x200 +0x100 Center +BackgroundTrans", "×")
    ogcText.OnEvent("Click", ShortcutEditorClose)
    Shortcuts.Add("Progress", "x0 y77 w980 h2 cEA3479 BackgroundEA3479 Disabled", "100")

    Shortcuts.Add("Progress", "x16 y96 w948 h508 c1B1D27 Background1B1D27 Disabled", "100")
    Shortcuts.SetFont("s9 w600 cEA3479", "Segoe UI")
    Shortcuts.Add("Text", "x30 y112 w200 +BackgroundTrans", "ДЕЙСТВИЕ")
    Shortcuts.Add("Text", "x250 y112 w230 +BackgroundTrans", "РАЗДЕЛ")
    Shortcuts.Add("Text", "x500 y112 w450 +BackgroundTrans", "ГЛАВА")
    Shortcuts.SetFont("s10 w400 cE9EAF0", "Segoe UI")
    OnMessage(0x2B, ShortcutDrawComboItem)
    ; Owner draw с CBS_HASSTRINGS сохраняет стандартный выбор и навигацию клавиатурой.
    ogcDropDownListShortcutAction := Shortcuts.Add("DropDownList", "x30 y136 w200 r12 +0x210 Choose1 vShortcutAction", ["Добавить", "Удалить", "Изменить"]), shortcutActionHwnd := ogcDropDownListShortcutAction.hwnd
    ogcDropDownListShortcutAction.OnEvent("Change", ShortcutEditorRefresh)
    ogcDropDownListShortcutSection := Shortcuts.Add("DropDownList", "x250 y136 w230 r12 +0x210 Choose1 vShortcutSection", ["Ответы", "Полезное", "Наказания"]), shortcutSectionHwnd := ogcDropDownListShortcutSection.hwnd
    ogcDropDownListShortcutSection.OnEvent("Change", ShortcutEditorSection)
    ogcDropDownListShortcutChapter := Shortcuts.Add("DropDownList", "x500 y136 w450 r12 +0x210 vShortcutChapter"), shortcutChapterHwnd := ogcDropDownListShortcutChapter.hwnd
    ogcDropDownListShortcutChapter.OnEvent("Change", ShortcutEditorRefresh)
    for _, comboHwnd in [shortcutActionHwnd, shortcutSectionHwnd, shortcutChapterHwnd]
        ShortcutStyleCombo(comboHwnd)
    Shortcuts.SetFont("s10 w400 cE9EAF0", "Segoe UI")
    ogcTextShortcutAliasLabel := Shortcuts.Add("Text", "x30 y184 w920 +BackgroundTrans vShortcutAliasLabel", "Сокращение (например, .ку)")
    ogcEditShortcutAlias := Shortcuts.Add("Edit", "x30 y210 w330 h30 -Border Background343746 Limit40 vShortcutAlias"), shortcutAliasHwnd := ogcEditShortcutAlias.hwnd
    ogcEditShortcutAlias.OnEvent("Change", ShortcutEditorAliasChanged)
    ogcTextShortcutTranslit := Shortcuts.Add("Text", "x380 y215 w570 vShortcutTranslit"), shortcutTranslitHwnd := ogcTextShortcutTranslit.hwnd
    Shortcuts.Add("Text", "x30 y260 w450 +BackgroundTrans vShortcutTextLabel", AdminGender = "female" ? "Основной текст (женский род)" : "Основной текст (мужской род)")
    Shortcuts.Add("Text", "x500 y260 w450 +BackgroundTrans vShortcutOtherTextLabel", AdminGender = "female" ? "Текст в мужском роде" : "Текст в женском роде")
    ogcEditShortcutText := Shortcuts.Add("Edit", "x30 y286 w450 h303 +Multi +Wrap +VScroll -Border Background343746 Limit2000 vShortcutText"), shortcutTextHwnd := ogcEditShortcutText.hwnd
    ogcEditShortcutText.OnEvent("Change", ShortcutEditorTextChanged)
    ogcEditShortcutOtherText := Shortcuts.Add("Edit", "x500 y286 w450 h303 +Multi +Wrap +VScroll -Border Background343746 Limit2000 vShortcutOtherText"), shortcutOtherTextHwnd := ogcEditShortcutOtherText.hwnd
    ogcEditShortcutOtherText.OnEvent("Change", ShortcutEditorOtherTextChanged)
    ogcProgressShortcutListHeaderBg := Shortcuts.Add("Progress", "x30 y183 w920 h26 c292C38 Background292C38 Disabled vShortcutListHeaderBg", "100")
    ogcTextShortcutListHeaderAlias := Shortcuts.Add("Text", "x38 y183 w157 h26 +0x200 +BackgroundTrans vShortcutListHeaderAlias", "Сокращение")
    ogcShortcutListHeaderText := Shortcuts.Add("Text", "x203 y183 w729 h26 +0x200 +BackgroundTrans vShortcutListHeaderText", "Текст")
    ogcShortcutList := Shortcuts.Add("ListView", "x30 y209 w920 h252 -Multi -Hdr NoSortHdr -Border Background292C38 vShortcutList", ["Сокращение", "Текст"]), shortcutListHwnd := ogcShortcutList.hwnd
    ogcShortcutList.OnEvent("ItemSelect", ShortcutEditorSelect)
    ShortcutHookListPainting(shortcutEditorHwnd, shortcutListHwnd)
    shortcutListFont := DllCall("SendMessageW", "Ptr", shortcutListHwnd, "UInt", 0x31, "Ptr", 0, "Ptr", 0, "Ptr")
    ; LVS_EX_DOUBLEBUFFER: список перерисовывается без промежуточных кадров.
    SendMessage(0x1036, 0x10000, 0x10000, , "ahk_id " shortcutListHwnd)
    ogcEditShortcutPreview := Shortcuts.Add("Edit", "x30 y474 w920 h115 ReadOnly -Border Background292C38 vShortcutPreview"), shortcutPreviewHwnd := ogcEditShortcutPreview.hwnd
    shortcutScrollTracks := Map()
    shortcutScrollAreas := [{hwnd: shortcutTextHwnd, x: 462, y: 286, h: 303, type: "edit"}
        , {hwnd: shortcutOtherTextHwnd, x: 932, y: 286, h: 303, type: "edit"}
        , {hwnd: shortcutListHwnd, x: 932, y: 209, h: 252, type: "list"}
        , {hwnd: shortcutPreviewHwnd, x: 932, y: 474, h: 115, type: "edit"}]
    for index, area in shortcutScrollAreas {
        ogcTextShortcutScrollTrackindex := Shortcuts.Add("Text", "x" area.x " y" area.y " w18 h" area.h " +0x100 Background292C38 vShortcutScrollTrack" index, Chr(160)), trackHwnd := ogcTextShortcutScrollTrackindex.hwnd
        ogcProgressShortcutScrollThumbindex := Shortcuts.Add("Progress", "x" (area.x + 5) " y" (area.y + 2) " w8 h30 cEA3479 BackgroundEA3479 Disabled Hidden vShortcutScrollThumb" index, "100")
        shortcutScrollTracks[trackHwnd] := index
        area.track := trackHwnd
        ShortcutClipScrollControl(area.hwnd, index <= 2 ? 450 : 920, area.h)
    }
    Shortcuts.SetFont("s9 cE9EAF0", "Segoe UI")
    ogcTextShortcutStatus := Shortcuts.Add("Text", "x152 y621 w520 h38 Background12131A vShortcutStatus")
    Shortcuts.SetFont("s10 w700 q0 cFFFFFF", "Segoe UI")
    ogcText := Shortcuts.Add("Text", "x16 y621 w116 h36 +0x200 +0x100 Center Background292C38", "ЗАКРЫТЬ")
    ogcText.OnEvent("Click", ShortcutEditorClose)
    ogcTextShortcutConfirm := Shortcuts.Add("Text", "x700 y621 w264 h36 +0x200 +0x100 Center vShortcutConfirm", "ПОДТВЕРДИТЬ ДОБАВЛЕНИЕ"), shortcutConfirmHwnd := ogcTextShortcutConfirm.hwnd
    ogcTextShortcutConfirm.OnEvent("Click", ShortcutEditorConfirm)
    Shortcuts.SetFont("s10 w700 q0 cAEB1BF", "Segoe UI")
    ogcTextShortcutConfirmInactive := Shortcuts.Add("Text", "x700 y621 w264 h36 +0x200 Center vShortcutConfirmInactive Hidden"), shortcutConfirmInactiveHwnd := ogcTextShortcutConfirmInactive.hwnd
    ShortcutEditorSection()
    if (shortcutOpenRecord) {
        for _, ref in shortcutRecords[shortcutOpenRecord].refs {
            if (ref.section != "answers" && ref.section != "useful" && ref.section != "punishments")
                continue
            if (shortcutOpenSection != "" && (ref.section != shortcutOpenSection || ref.chapter != shortcutOpenChapter))
                continue
            ogcDropDownListShortcutSection.Choose(ref.section = "answers" ? 1 : ref.section = "useful" ? 2 : 3)
            ShortcutEditorSection()
            ogcDropDownListShortcutChapter.Choose(ref.chapter)
            ogcDropDownListShortcutAction.Choose(3)
            ShortcutEditorRefresh()
            for rowIndex, row in shortcutRows {
                if (row.index = shortcutOpenRecord) {
                    ogcShortcutList.Modify(rowIndex, "Select Focus Vis")
                    ShortcutEditorUpdatePreview()
                    break
                }
            }
            break
        }
        shortcutOpenRecord := 0
        shortcutOpenSection := ""
        shortcutOpenChapter := ""
    }
    Shortcuts.Title := "Редактор сокращений"
    Shortcuts.Show("w980 h674")
    SetTimer(ShortcutRefreshScroll, 100)
    return
}
ShortcutEditorDrag(*) {
    global
    DllCall("ReleaseCapture")
    PostMessage(0xA1, 2, DllCall("GetMessagePos", "UInt"), , "ahk_id " shortcutEditorHwnd)
    return
}
ShortcutEditorClose(*) {
    global
    ShortcutsGuiEscape()
}
ShortcutsGuiEscape(*) {
    global
    SetTimer(ShortcutEditorDeferredSelection, 0)
    SetTimer(ShortcutRefreshScroll, 0)
    try Shortcuts.Destroy()
    shortcutEditorHwnd := 0
    shortcutScrollTracks := Map()
    shortcutScrollDragging := 0
    return
}
ShortcutRefreshScroll() {
    global
    ShortcutUpdateScroll()
    return
}
ShortcutEditorSection(*) {
    global
    ShortcutSection := ogcDropDownListShortcutSection.Value
    ogcDropDownListShortcutChapter.Delete()
    ogcDropDownListShortcutChapter.Add(ShortcutSectionChapters(shortcutSections[ShortcutSection]))
    ogcDropDownListShortcutChapter.Choose(1)
    ShortcutEditorRefresh()
    return
}
ShortcutEditorRefresh(*) {
    global
    ShortcutAction := Shortcuts["ShortcutAction"].Value
    ShortcutChapter := ogcDropDownListShortcutChapter.Text
    ShortcutSection := Shortcuts["ShortcutSection"].Value

    SetTimer(ShortcutEditorDeferredSelection, 0)
    deleting := ShortcutAction = 2
    editing := ShortcutAction = 3
    shortcutFormControls := ["ShortcutAlias", "ShortcutText", "ShortcutOtherText", "ShortcutAliasLabel", "ShortcutTextLabel", "ShortcutOtherTextLabel", "ShortcutTranslit"]
    formPositions := editing ? [377, 444, 444, 354, 420, 420, 382] : [210, 286, 286, 184, 260, 260, 215]
    for i, control in shortcutFormControls {
        Shortcuts[control].Move(, formPositions[i], , (i = 2 || i = 3) ? (editing ? 145 : 303) : unset)
        Shortcuts[control].Visible := !(deleting)
    }
    ogcShortcutList.Move(, , , editing ? 132 : 252)
    for _, control in ["ShortcutListHeaderBg", "ShortcutListHeaderAlias", "ShortcutListHeaderText"]
        Shortcuts[control].Visible := !(ShortcutAction = 1)
    for index, area in shortcutScrollAreas {
        area.y := index <= 2 ? (editing ? 444 : 286) : index = 3 ? 209 : 474
        area.h := index <= 2 ? (editing ? 145 : 303) : index = 3 ? (editing ? 132 : 252) : 115
        visible := index <= 2 ? !deleting : index = 3 ? ShortcutAction != 1 : deleting
        track := "ShortcutScrollTrack" index
        Shortcuts[track].Move(area.x, area.y, 18, area.h)
        ShortcutClipScrollControl(area.hwnd, index <= 2 ? 450 : 920, area.h)
        Shortcuts[track].Visible := (visible)
        Shortcuts["ShortcutScrollThumb" index].Visible := false
    }
    ogcShortcutList.Visible := !(ShortcutAction = 1)
    ogcEditShortcutPreview.Visible := (deleting)
    ogcTextShortcutStatus.Value := ""
    confirmText := deleting ? "ПОДТВЕРДИТЬ УДАЛЕНИЕ" : editing ? "СОХРАНИТЬ ИЗМЕНЕНИЯ" : "ПОДТВЕРДИТЬ ДОБАВЛЕНИЕ"
    ogcTextShortcutConfirm.Value := confirmText
    ogcTextShortcutConfirmInactive.Value := confirmText
    if (ShortcutAction = 1) {
        if (shortcutPreviousAction != 1) {
            shortcutOtherTextManual := false
            ogcEditShortcutAlias.Value := ""
            ogcEditShortcutText.Value := ""
            ogcEditShortcutOtherText.Value := ""
        }
        shortcutPreviousAction := ShortcutAction
        ogcEditShortcutAlias.Enabled := true
        ogcEditShortcutText.Enabled := true
        ogcEditShortcutOtherText.Enabled := true
        ShortcutEditorAliasChanged()
        return
    }
    shortcutPreviousAction := ShortcutAction
    ogcShortcutList.Opt("-Redraw")
    shortcutPaintRow := 0
    ogcShortcutList.Delete()
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
            ogcShortcutList.Add("", ref.alias, listText)
            break
        }
    }
    ogcShortcutList.ModifyCol(1, 165)
    ogcShortcutList.ModifyCol(2, 730)
    shortcutListFirstColWidth := DllCall("SendMessageW", "Ptr", shortcutListHwnd, "UInt", 0x101D, "Ptr", 0, "Ptr", 0, "Int")
    shortcutListVisibleRows := DllCall("SendMessageW", "Ptr", shortcutListHwnd, "UInt", 0x1028, "Ptr", 0, "Ptr", 0, "Int")
    ogcShortcutList.Opt("+Redraw")
    ShortcutUpdateScroll()
    shortcutPreviewRow := -1
    ShortcutEditorUpdatePreview()
    if (!shortcutRows.Length)
        ogcTextShortcutStatus.Value := "В этой главе нет сокращений."
    return
}
ShortcutEditorAliasChanged(*) {
    global
    ShortcutAlias := ogcEditShortcutAlias.Value
    if (ShortcutAlias != "" && !RegExMatch(ShortcutAlias, "^[./]")) {
        ShortcutAlias := shortcutLastAliasInput
        ogcEditShortcutAlias.Value := ShortcutAlias
        shortcutCaret := StrLen(ShortcutAlias)
        SendMessage(0xB1, shortcutCaret, shortcutCaret, , "ahk_id " shortcutAliasHwnd)
    } else
        shortcutLastAliasInput := ShortcutAlias
    pair := ShortcutLayoutPair(Trim(ShortcutAlias))
    ogcTextShortcutTranslit.Value := pair = "" ? "" : "Другая раскладка: " pair
    ShortcutEditorUpdateFormConfirm()
    return
}
ShortcutEditorTextChanged(*) {
    global
    if (!shortcutOtherTextManual && ShortcutAction != 2) {
        currentText := ogcEditShortcutText.Value
        currentText := ShortcutEditorBody(currentText)
        if (ShortcutAction = 3 && IsObject(shortcutSelected) && ShortcutEditorSameBody(currentText, shortcutSelected.body))
            otherText := AdminGender = "female" ? shortcutSelected.male : shortcutSelected.female
        else
            otherText := ShortcutSuggestGender(currentText, AdminGender := "male")
        ogcEditShortcutOtherText.Value := otherText
    }
    ShortcutEditorUpdateFormConfirm()
    ShortcutUpdateScroll()
    return
}
ShortcutEditorOtherTextChanged(*) {
    global
    shortcutOtherTextManual := true
    ShortcutEditorUpdateFormConfirm()
    ShortcutUpdateScroll()
    return
}
ShortcutEditorSelect(control, row, selected) {
    if (selected)
        SetTimer(ShortcutEditorDeferredSelection, -15)
    return
}
ShortcutEditorDeferredSelection() {
    global
    if (shortcutListHwnd && DllCall("IsWindowVisible", "Ptr", shortcutListHwnd))
        ShortcutEditorUpdatePreview()
    return
}
ShortcutEditorUpdatePreview() {
    global
    shortcutSelectedRow := ogcShortcutList.GetNext()
    shortcutPaintRow := shortcutSelectedRow
    if (shortcutSelectedRow = shortcutPreviewRow)
        return
    shortcutPreviewRow := shortcutSelectedRow
    shortcutSelected := (shortcutRows.Has(shortcutSelectedRow) ? shortcutRows[shortcutSelectedRow] : "")
    hasSelection := IsObject(shortcutSelected)
    if (ShortcutAction = 3) {
        shortcutOtherTextManual := false
        ogcEditShortcutAlias.Value := hasSelection ? shortcutSelected.alias : ""
        ogcEditShortcutText.Value := hasSelection ? shortcutSelected.body : ""
        ogcEditShortcutOtherText.Value := hasSelection ? (AdminGender = "female" ? shortcutSelected.male : shortcutSelected.female) : ""
        ogcEditShortcutAlias.Enabled := (hasSelection)
        ogcEditShortcutText.Enabled := (hasSelection)
        ogcEditShortcutOtherText.Enabled := (hasSelection)
        ShortcutEditorAliasChanged()
        return
    }
    ogcEditShortcutPreview.Value := hasSelection ? shortcutSelected.alias " — " shortcutSelected.body : ""
    ShortcutEditorSetConfirm(hasSelection)
    return
}
ShortcutEditorConfirm(*) {
    global
    ShortcutAction := Shortcuts["ShortcutAction"].Value
    ShortcutChapter := ogcDropDownListShortcutChapter.Text
    ShortcutSection := Shortcuts["ShortcutSection"].Value
    ShortcutAlias := Shortcuts["ShortcutAlias"].Value
    ShortcutOtherText := Shortcuts["ShortcutOtherText"].Value
    ShortcutText := Shortcuts["ShortcutText"].Value
    section := shortcutSections[ShortcutSection]
    if (section = "")
        return
    oldAlias := "", oldIndex := 0
    if (ShortcutAction != 1) {
        row := ogcShortcutList.GetNext()
        selected := shortcutRows.Has(row) ? shortcutRows[row] : ""
        if (!IsObject(selected) || (ShortcutAction = 3 && ogcShortcutList.GetNext() != shortcutPreviewRow))
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
            ogcTextShortcutStatus.Value := "Введите сокращение с точки и заполните обе формы текста."
            return
        }
        pair := ShortcutLayoutPair(alias)
        if (ShortcutAliasTaken(alias, oldIndex) || (pair != "" && ShortcutAliasTaken(pair, oldIndex))) {
            ogcTextShortcutStatus.Value := "Сокращение " alias " или " pair " уже занято."
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
                ogcTextShortcutStatus.Value := "Не удалось обновить файл Shortcuts.tsv."
            return
        }
        result := "Удалено: " oldAlias
        ShortcutEditorClose()
        ShortcutEditorRefreshMain()
        ogcTextMainFooterHint.Value := result
        return
    }
    newRecords := shortcutRecords.Clone()
    replacement := ShortcutEditedRecord(oldIndex ? shortcutRecords[oldIndex] : "", section, ShortcutChapter, alias
        , maleBody, femaleBody, keepMale, keepFemale)
    if (oldIndex)
        newRecords[oldIndex] := replacement
    else
        newRecords.Push(replacement)
    if !ShortcutEditorSave(newRecords) {
        ogcTextShortcutStatus.Value := "Не удалось обновить файл Shortcuts.tsv."
        return
    }
    if (oldIndex)
        ShortcutApplyRecord(shortcutRecords[oldIndex], "Off")
    shortcutRecords := newRecords
    ShortcutApplyRecord(replacement, "On")
    result := (ShortcutAction = 3 ? "Изменено: " : "Добавлено: ") alias (pair = "" ? "" : " и " pair)
    ShortcutEditorClose()
    ShortcutEditorRefreshMain()
    ogcTextMainFooterHint.Value := result
    return
}
ShortcutEditorRefreshMain() {
    global
    visibleTab := ogcTab2MainTabs.Value
    if (visibleTab = "Справочник" || visibleTab = 3) {
        if (mainCurrentSection = "commands")
            Commandlist()
        else if (!mainChaptersVisible && (mainCurrentSection = "answers" || mainCurrentSection = "punishments" || mainCurrentSection = "useful"))
            MainRenderSearchSection(mainCurrentSection, mainCurrentSection = "answers" ? "MainAnswersSearch" : "MainUsefulSearch")
    }
    return
}
ShortcutDeleteDrag(*) {
    global
    DllCall("ReleaseCapture")
    PostMessage(0xA1, 2, , , "ahk_id " shortcutDeleteGuiHwnd)
    return
}
ShortcutDeleteAccept(*) {
    global
    shortcutDeleteConfirmed := true
    ShortcutDeleteDismiss()
    return
}
ShortcutDeleteDismiss() {
    global
    if (shortcutEditorHwnd)
        Shortcuts.Opt("-Disabled")
    else
        Main.Opt("-Disabled")
    try ShortcutDelete.Destroy()
    return
}
ShortcutDeleteCancel(*) {
    global
    ShortcutDeleteGuiEscape()
}
ShortcutDeleteGuiEscape(*) {
    global
    shortcutDeleteConfirmed := false
    ShortcutDeleteDismiss()
    return
}
GreetingHandler(ThisHotkey := "") {
    global
    if (GreetingText != "") {
        GreetingSendText(GreetingText)
        SendInput("{Enter}")

        UpdateCounter()
    }
    return
}
ReloadBinder(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *) {
    global
    Reload()
}
UpdateBinderDialog(current := false) {
    global Main
    accepted := false
    dialog := Gui("+Owner" Main.Hwnd " -Caption +Border")
    dialog.Title := "Обновление"
    dialog.OnEvent("Close", (*) => dialog.Destroy())
    dialog.OnEvent("Escape", (*) => dialog.Destroy())
    dialog.BackColor := "12131A"
    dialog.Add("Progress", "x0 y0 w500 h78 c1B1D27 Background1B1D27 Disabled", "100")
    dialog.SetFont("s16 w700 cFFFFFF", "Segoe UI")
    dialog.Add("Text", "x24 y17 w300 h30 +BackgroundTrans", "MAJESTIC")
    dialog.SetFont("s9 w600 cEA3479", "Segoe UI")
    dialog.Add("Text", "x26 y47 w300 h18 +BackgroundTrans", "ADMIN  /  BINDER")
    dialog.SetFont("s15 w400 cAEB1BF", "Segoe UI")
    dialog.Add("Text", "x459 y22 w27 h30 +0x200 +0x100 Center +BackgroundTrans", "×").OnEvent("Click", (*) => dialog.Destroy())
    dialog.Add("Progress", "x0 y77 w500 h2 cEA3479 BackgroundEA3479 Disabled", "100")
    dialog.Add("Progress", "x16 y96 w468 h111 c1B1D27 Background1B1D27 Disabled", "100")
    dialog.SetFont("s14 w700 cFFFFFF", "Segoe UI")
    dialog.Add("Text", "x32 y111 w436 h30 +BackgroundTrans", current ? "У вас последняя версия" : "Доступно обновление")
    dialog.SetFont("s10 cE9EAF0", "Segoe UI")
    dialog.Add("Text", "x32 y153 w436 h42 +BackgroundTrans", current ? "Новых обновлений пока нет." : "Установить новую версию и перезапустить биндер?")
    dialog.SetFont("s10 w700 cFFFFFF", "Segoe UI")
    if !current {
        dialog.Add("Text", "x16 y221 w160 h36 +0x200 +0x100 Center Background292C38", "ПОЗЖЕ").OnEvent("Click", (*) => dialog.Destroy())
    }
    dialog.Add("Progress", "x324 y221 w160 h36 cEA3479 BackgroundEA3479 Disabled", "100")
    dialog.Add("Text", "x324 y221 w160 h36 +0x200 +0x100 Center +BackgroundTrans", current ? "ПОНЯТНО" : "ОБНОВИТЬ").OnEvent("Click", (*) => (accepted := true, dialog.Destroy()))
    dialog.Add("Button", "Hidden Default", current ? "Понятно" : "Обновить").OnEvent("Click", (*) => (accepted := true, dialog.Destroy()))
    Main.Opt("+Disabled")
    try {
        dialog.Show("w500 h273")
        WinWaitClose("ahk_id " dialog.Hwnd)
    } finally {
        Main.Opt("-Disabled")
    }
    return accepted
}
UpdateBinder(*) {
    if A_IsCompiled {
        MsgBox("Обновление доступно только для binder.ahk.", "Обновление", 16)
        return
    }
    tempPath := A_ScriptFullPath ".download"
    backupPath := A_ScriptFullPath ".bak"
    try {
        Download("https://github.com/StickyEwoks/AdminBinder/releases/latest/download/binder.ahk", tempPath)
        downloaded := FileRead(tempPath, "UTF-8")
        if !InStr(downloaded, "#Requires AutoHotkey v2.0", true, 1, 1)
            throw Error("В релизе нет корректного binder.ahk.")
        if (downloaded = FileRead(A_ScriptFullPath, "UTF-8")) {
            UpdateBinderDialog(true)
            return
        }
        if !UpdateBinderDialog()
            return
        FileCopy(A_ScriptFullPath, backupPath, true)
        FileMove(tempPath, A_ScriptFullPath, true)
        Reload()
    } catch Error as err {
        MsgBox("Не удалось обновить биндер: " err.Message "`nПри необходимости восстановите версию из " backupPath, "Обновление", 16)
    } finally {
        try FileDelete(tempPath)
    }
}
Close(*) {
    global
    ExitApp()
}
Hide(*) {
    global
    Main.Hide()
    return
}
Show(A_ThisMenuItem := "", A_ThisMenuItemPos := "", MyMenu := "", *) {
    global
    Main.Show()
    return
}
guiclose2(*) {
    global
    Main.Hide()
    return
}
BinderRegisterHotkey(key, action, options := "On") {
    if (key = "")
        return true
    try {
        Hotkey(key, action, options)
        return true
    } catch Error {
        return false
    }
}
