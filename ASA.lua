script_name('License Center Assistant')
script_author('banan4eg')

----    Libraries    ----
require 'lib.moonloader'
require 'lib.sampfuncs'
-----------------------
local dlstatus = require 'moonloader'.download_status
local rkeys = require 'rkeys'
local imgui = require 'imgui'
local ev = require 'lib.samp.events'
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local inicfg = require 'inicfg'
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
imgui.ToggleButton = require 'imgui_addons'.ToggleButton
imgui.HotKey = require 'imgui_addons'.HotKey
require 'imgui_addons'._SETTINGS.noKeysMessage = u8('�� ������')
----    Libraries    ----

----     IniCFG      ----
if not doesDirectoryExist('moonloader/ASA config') then
	createDirectory('moonloader/ASA config')
end

local JsonPath = getWorkingDirectory()..'\\ASA config\\ASA.json'
local JsonPathL = getWorkingDirectory()..'\\ASA config\\ASALections.json'
local JsonPathG = getWorkingDirectory()..'\\ASA config\\ASAGNews.json'
local JsonPathB = getWorkingDirectory()..'\\ASA config\\ASABinder.json'
local JsonPathS = getWorkingDirectory()..'\\ASA config\\ASANotepad.json'

local GNews = {}
if doesFileExist(JsonPathG) then
	local f = io.open(JsonPathG, 'r')
	if f then
		GNews = decodeJson(f:read('a*'))
		f:close()
	end
else
    local f = io.open(JsonPathG, 'w')
	GNews = {
        [1] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        },
        [2] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        },
        [3] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        },
        [4] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        },
        [5] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        },
        [6] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        },
        [7] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        },
        [8] = {
            text3 = u8'',
            text1 = u8'',
            delay = ''
        }
    }
    f:write(encodeJson(GNews))
    f:close()
end

local config = {}
if doesFileExist(JsonPath) then
	local f = io.open(JsonPath, 'r')
	if f then
		config = decodeJson(f:read('a*'))
		f:close()
	end
else
    local f = io.open(JsonPath, 'w')
	config = {
        ['Settings'] = {
            ASRang = 0,
            Tag = '',
            TagCi = '',
            AutoScreen = false,
            LecF = false,
            TagF = false,
            TagC = false,
            TScreen = true,
            AutoUpdate = false,
            Gender = 1
        },
        ['HotKeys'] = {
            MainMenu = '[18,50]',
            Exam = '[18,107]',
            Time = '[18,106]',
            Hello = '[17,49]',
            R = '[18,111]',
            RN = '[17,104]',
            Binder = '[]'
        }
    }
    f:write(encodeJson(config))
    f:close()
end

if config.HF070920 == nil then
    config.HF070920 = {
        DokladF = true,
        ----------------
        NeedAgeCar = true,
        NeedMedCar = false,
        NeedLvlCar = false,
        AgeCar = '18',
        LvlCar = '',
        ----------------
        NeedAgeMoto = true,
        NeedMedMoto = true,
        NeedLvlMoto = true,
        AgeMoto = '18',
        LvlMoto = '2',
        ----------------
        NeedAgeAir = true,
        NeedMedAir = true,
        NeedLvlAir = true,
        AgeAir = '18',
        LvlAir = '2',
        ----------------
        NeedAgeBigCar = true,
        NeedMedBigCar = true,
        NeedLvlBigCar = true,
        AgeBigCar = '18',
        LvlBigCar = '4',
        ----------------
        NeedAgeGun = true,
        NeedMedGun = true,
        NeedLvlGun = false,
        GunPriceSend = true,
        AgeGun = '18',
        LvlGun = '',
        GunPrice = '50000',
        ----------------
        NeedAgeWater = true,
        NeedMedWater = true,
        NeedLvlWater = false,
        WaterPriceSend = true,
        AgeWater = '18',
        LvlWater = '',
        WaterPrice = '22000',
        ----------------
        NeedAgeInsur = true,
        NeedMedInsur = true,
        NeedLvlInsur = false,
        AgeInsur = '18',
        LvlInsur = '',
        ----------------
        NeedZakon = true,
        NeedMedInv = true,
        NeedLvlInv = true,
        Zakon = '15',
        LvlInv = '3'
    }
end

if config.HF031020 == nil then
    config.HF031020 = {
        ExamTime = false
    }
end

if config.HF041020 == nil then
    config.HF041020 = {
        Theme = 9,
        Style = 2,
        ReloadState = false,
        Shpora = '[]'
    }
end

if config.HF061020 == nil then
    config.HF061020 = {
        Checkpoints_st = false
    }
end

if config.HF141020 == nil then
    config.HF141020 = {
        BlipState = false
    }
end

local Lections = {}
if doesFileExist(JsonPathL) then
	local f = io.open(JsonPathL, 'r')
	if f then
		Lections = decodeJson(f:read('a*'))
		f:close()
	end
else
    local f = io.open(JsonPathL, 'w')
	Lections = {
        [1] = {
            text = u8'����� ��������, ������ � ��� ������� ������.\n�� ����: "�������� ����������� ����������� ������������� ������".\n������� - ������������:\n���� �������� ������ ��� �������� ������ � ������� ��������.\n����� �������� ������ � ������� ��������, �� ������ ���������� � ������.\n� ������: ��������� �������� �� �������� � ��������� ���������,\n� ����� ��������� �������� �� ���� � �������� ���������.\n������������:\n������ �� ��� ������ ��������� �������� �� ������ � ������ �/c.\n����� �� ������� ������� �� �������� � �������� ��.\n��.����������� - �����������:\n���� �������� ������ ����������� � ������ ��.������� � ������ ���������.\n�� ��� �� �� �� ������ �������� � ���������� ���������.\n���������:\n�������� ������ ��������� - ������ ����� ������� ���� ��� �� ���������.\n������ �� ������ ��������� ������ ��� ��������� �� ����������� ���������.\n����������� � ���������� �������� ����� ���� ������ ������.\n�� ���������, ���� ���������� �������, �� �� ������ ��������, �����: ������� � ����.\n���� ������� �� ��������!',
            caption = u8'�������� ����������� ����������� ������������� ������',
            delay = '2000'
        },
        [2] = {
            text = u8'��������� ����������, ��������� ��������!\n������ � ������ ��� ������ �� ���� "������� �������� ������������� ������".\n������������ ������������� ��� ����������� ����� 1.000$.\n������������ ������������� ��� ����������� ����� 5.000$.\n��������� ��� ��������� ���� ��������� ��������� 2 ���� � ���������� � � ���� ���� ���.������.\n������������ ������������� ��� ��������� �/� ����� 25.000$.\n��������� ��� ��������� ���� ��������� ��������� 4 ���� � ���������� � � ���� ���� ���.������.\n������������ ������������� ��� ���������� �/c ����� 10.000$.\n��������� ��� ��������� ���� ��������� ��������� 2 ���� � ���������� � � ���� ���� ���.������.\n�������� �� ������ ����� 50.000$, �� ������ �/� 20.000$.\n��� ��������� ������ �������� ��������� ���. ������.\n������� �� ��������!',
            caption = u8'������� �������� ������������� ������',
            delay = '2000'
        },
        [3] = {
            text = u8'������������, ������ � ������� ������ �� ���� "��������� ������������� ������".\n��������� ������������� ������ - ��� ������������� �����������.\n������ ������ ������������ ��� � ������ �����, � ������ � ������� �����.\n��������� ������� ������� - �������, ���� ����������.\n���� ��� ���� ����-�� � �� ������ ����� ��������� �.�. � ������� �����..\n�������� � �����! ����� ������ ��������.\n��������� ������������� ������ ��������� ����� � ������ ����� � ��� ����������...\n... ������ ����� �������� ��� ��� � �������� ����.\n���� ������� �� ��������.',
            caption = u8'��������� ������������� ������',
            delay = '2000'
        },
        [4] = {
            text = u8'��������, ������ � ������� ��� ������..\n..�� ���� "������� ��������� � ����������".\n�������� - ��� �� �������, �� ������, �� ������������ � ����� ���� ��������.\n�������, ��� �� �� �� ����, ������� ��� ���������� - �� ���� ������������� ������..\n.. � ������ �������� � � ������ �������.\n���������� ��������� ���������� � ������������� ������..\n..���������, ������, ������� � �������..\n��� ������������ - �������.\n�������� ����������� � ������� � ���.�����, ���..\n..���������� ��������� ��� ������� ��������\n� ��������� ������ - ����������, �������.\n���� ������� �� ��������.',
            caption = u8'������� ��������� � ����������',
            delay = '2000'
        },
        [5] = {
            text = u8'������������, ������� ����������.\n������ � ������� ��� ������ � ������� ������ � ������� �������.\n� ������������ �� ������� ������������...\n...������� ���� ���������� � 11:00 � ������������� � 20:00.\n������� � ����������� - �������� ����.\n������ � ���������:\n������� ������ (( 1-2 )): � 13:30 �� 14:30 ������� ������ (( 3-5 )): � 12:30 �� 13:30\n������� � ����������� ������ (( 6-8 )): � 14:00 �� 15:00\n��������� �������� � �������� �� ������� � ��� ��� ���������!',
            caption = u8'����� ������ � ������� ������',
            delay = '2000'
        },
        [6] = {
            text = u8'��������� ����������, ����� ������� ������ ������ ��������.\n������ � ������ ��� ��� ������ �� ����: "�������� ������ ������"\n��������� ������������ ������� � ����������� ������!\n������� �������� �������� ��������, ����������� - ���.���������.\n��� �� ��������� ���������� � ����� ��������� ���������� ��� ����������.\n����������� ��������� ����� ������, ��������� ��� �������� � �������.\n��� �� ��������� ������, �������, ���������, ���������� � ������������� ������.\n�� ������� ��������� �����-��� � ������������.\n�������� ��������� ��������� ������������� �� �������.\n�� ��������� ������������ ������ �� ������ ��������.\n�� ���������, ������� �� ��������!',
            caption = u8'�������� ������ ������',
            delay = '2000'
        },
        [7] = {
            text = u8'��������� ����������, ����� �������� ���� ��������!\n������ � ������� ��� ������ �� ����: "������ ������������� ������"\n�������� ������� ������������� ������ � 22.06.2020 �������� ��� - ������� � �����������.\n������� ���� ������ � 11:00 �� 20:00.\n������������� ������ �������� � ������� ������ � 11:00 �� 19:59.\n������������� ������ �������� � ������ ������ � 20:00 �� 10:59.\n��������� ������� �������� �������: � 13:30 �� 14:30.\n��������� ������� �������� �������: � 12:30 �� 13:30.\n��������� ������� �������� � ������������ ��������: � 14:00 �� 15:00.\n������� � ������������ ���������� � ����� �����.\n��������� ���������� ���������� ������������� �� ��������.\n�������� � �����������, ����� � �������, � 18:00!\n������� �� ��������!',
            caption = u8'������ ������������� ������',
            delay = '2000'
        },
        [8] = {
            text = u8'��������� ����������, ����� ���� ����������� ���������!\n������ � ������ ��� ������ �� ����: "�������� ��������"\n���� �� �������� ����� � �������� �������, ��� ����� �������!\n��� ����� ����� �������� ��������� �� �������� ��������.\n����� ���� ��� ���� ��������� ����� ��������...\n...����������� ������������� ������ ������ ��� �������.\n� ���� ����� ������� ���� 1 ������� �� ������� ����.\n�������� ������ ������� ������� �� ������� ���� ��� ������������ ������.\n�� ���������, ������� �� ��������.',
            caption = u8'�������� �������� �� ������� ����',
            delay = '2000'
        },
        [9] = {
            text = u8'��������� ����������, ����� ������ ������ ��������.\n������ � ������ ��� ������ �� ����: "�����-���"\n���������� ������������� ������ ������� ��������� �����-���.\n� ���� �������� ������� ���� ������ �����.\n� ��������� ����� �� ������ ����������� � ����� ������.\n��������� ������ ����� ����������.\n����������:\n���������� ����������� ������� ����� ����.\n����-������� ����\n��������� ���� �� ��������. ����������� ������!',
            caption = u8'�����-���',
            delay = '2000'
        },
        [10] = {
            text = u8'��������, ������ � ������ ������ ��� ����� �����������!\n������ ����� �� ������ ������� ����� ������������� ������ � ����.\n����� ������������� ������ � ���� �������� �� �������.\n����� ����� �� ������ ������� �������� ����������...\n...����� ���� ������ �������� ������ ��� ���������.\n�� ��������� � ���, ��� �� ���� ����������...\n...������ �������������� �������� �������.\n���������� ���� ������ �����������.\n�� ���������, ���� ��� ���-�� �� �������...\n...�� ������ ������ �������� � ������� �� ���������.\n������� �� ��������!',
            caption = u8'������ ��� ����� �����������',
            delay = '2000'
        },
        [11] = {
            text = u8'',
            caption = u8'������ �11',
            delay = ''
        },
        [12] = {
            text = u8'',
            caption = u8'������ �12',
            delay = ''
        },
        [13] = {
            text = u8'',
            caption = u8'������ �13',
            delay = ''
        },
        [14] = {
            text = u8'',
            caption = u8'������ �14',
            delay = ''
        },
        [15] = {
            text = u8'',
            caption = u8'������ �15',
            delay = ''
        }
    }
    f:write(encodeJson(Lections))
    f:close()
end

local Binder = {}
if doesFileExist(JsonPathB) then
	local f = io.open(JsonPathB, "r")
	if f then
		Binder = decodeJson(f:read("a*"))
		f:close()
	end
else
    local f = io.open(JsonPathB, 'w')
	Binder = {
        
    }
    f:write(encodeJson(Binder))
    f:close()
end

local Notepad = {}
if doesFileExist(JsonPathS) then
	local f = io.open(JsonPathS, "r")
	if f then
		Notepad = decodeJson(f:read("a*"))
		f:close()
	end
else
    local f = io.open(JsonPathS, 'w')
	Notepad = {
        
    }
    f:write(encodeJson(Notepad))
    f:close()
end


----     IniCFG      ----
local ActiveMainMenu = {
	v = decodeJson(config.HotKeys.MainMenu)
}
local ActiveExam = {
	v = decodeJson(config.HotKeys.Exam)
}
local ActiveTime = {
	v = decodeJson(config.HotKeys.Time)
}
local ActiveHello = {
	v = decodeJson(config.HotKeys.Hello)
}
local ActiveR = {
	v = decodeJson(config.HotKeys.R)
}
local ActiveRN = {
	v = decodeJson(config.HotKeys.RN)
}
local ActiveBinder = {
	v = decodeJson(config.HotKeys.Binder)
}
local ActiveShpora = {
	v = decodeJson(config.HF041020.Shpora)
}


-------------------------
if doesFileExist(getGameDirectory() .. '\\moonloader\\ASA config\\ASAlogo.png') then
    os.remove(getGameDirectory() .. '\\moonloader\\ASA config\\ASAlogo.png')
end
if not doesFileExist(getGameDirectory() .. '\\moonloader\\ASA config\\ASAlogot.png') then
    lua_thread.create(function()
        print("�������� ����")
        if downloadUrlToFile('https://i.imgur.com/XMhmEFO.png', getWorkingDirectory() .. '/ASA config/ASAlogot.png') then
            print("���� ���������. ������ ����� ������������.")
            wait(1000)
            thisScript():reload()
        end
    end)
end
---- Local variables ----
local sw, sh = getScreenResolution()
-------------------------
local ExamTime = imgui.ImBool(config.HF031020.ExamTime)
local Theme = imgui.ImInt(config.HF041020.Theme)
local Style = imgui.ImInt(config.HF041020.Style)
local ASRang = imgui.ImInt(config.Settings.ASRang)
local SelLection = imgui.ImInt(0)
local SelGnews = imgui.ImInt(0)
local SelKrit = imgui.ImInt(0)
local coled = imgui.ImFloat3(1.0, 1.0, 1.0)
local ExampleNote = imgui.ImBuffer(u8'������ ����� ��������������� �� ������ ����/n\n@Center:�� ����� ����������� � �� ������\n/n\n@Right:����� � �� ������� ����\n[/cStart]\n���� �� ������� �� ������ � �������,\n�� ��� ����������� � ������ ������.\n���� ��������, ���� ����� �� ������.\n� ��� ���� ����� ���� {FF00FF}�������.\n[/cEnd]\n[/rStart]\n�� ��� � ������������� ������ ����\n����� �� ������.\n[/rEnd]',4096)
local RunCarExamSt, RunAirExamSt, RunMotoExamSt, RunBigCarExamSt = false, false, false, false
local RunCarExam, RunMotoExam, RunBigCarExam = false, false, false
local NextStepCar, NextStepBigCar, NextStepMoto = 0, 0, 0
local ExamTimer, ExamTimerPlay = -1, false
local SellState, SellIns = false, false
BinderInfo = true
LecPlay = false
exam_tr = false
TextCentr = false
TextRight = false
ReloadAccept = false


clrBindEmpty_st = {}

local BinderType = imgui.ImInt(0)

themeitems = {u8'�����', u8'�������', u8'����������', u8'����', u8'׸����', u8'����������', u8'�����-���������', u8'������-������', u8'�����', u8'��������', u8'������-�������', u8'�����-�������', u8'��������', u8'����-�����', u8'�����', u8'���������', u8'�����-�������'}
styleitems = {u8'�������', u8'������'}

arr_rang = {u8'������', u8'�����������', u8'�����������', u8'��. ����������', u8'����������', u8'��������', u8'���. ���������', u8'��������'}
myrang = u8:decode(arr_rang[ASRang.v + 1])

arr_gnews = {u8'�������� �������', u8'������������ �����', u8'�������', u8'���. �������', u8'��������', u8'���', u8'�������������', u8'�����������'}

arr_krit = {u8'�������� �����', u8'�������� �������', u8'���� �������', u8'��������� �������', u8'�������� �������', u8'�������� �� ������', u8'�������� �� ������ ���������', u8'���������', u8'�������� ��� �������'}

local SelectBind = {}
for i = 1, #Binder do
    SelectBind[i] = false
end

local SelectNote = {}
for i = 1, #Notepad do
    SelectNote[i] = false
end

logo = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\ASA config\\ASAlogot.png')

-------------------------
local tag_text, tag_clr = '{58ACFA}LCA{FFFFFF} �', 0xFF58ACFA
-------------------------

---- Local variables ----

----   GUI Windows   ----
local Window = {
    Main = imgui.ImBool(false),
    Target = imgui.ImBool(false),
    Binder = imgui.ImBool(false),
    Latest_Update = imgui.ImBool(false),
    FAQ = imgui.ImBool(false)
}
local Child = {
    SettingsMain = false,
    SettingsKrit = false,
    Lekcii = false,
    Leader = false,
    InterviewM = false,
    Support = false,
    Visual = false,
    --------------
    Exam = false,
    Work = false
}
local Toggle = {
    AutoScreen = imgui.ImBool(config.Settings.AutoScreen),
    DokladF = imgui.ImBool(config.HF070920.DokladF),
    LecF = imgui.ImBool(config.Settings.LecF),
    TagF = imgui.ImBool(config.Settings.TagF),
    TagC = imgui.ImBool(config.Settings.TagC),
    TScreen = imgui.ImBool(config.Settings.TScreen),
    AutoUpdate = imgui.ImBool(config.Settings.AutoUpdate),
    Checkpoints_st = imgui.ImBool(config.HF061020.Checkpoints_st),
    BlipState = imgui.ImBool(config.HF141020.BlipState)
}
local Radio = {
    Gender = imgui.ImInt(config.Settings.Gender)
}
local Input = {
    Tag = imgui.ImBuffer(''..config.Settings.Tag, 256),
    TagCi = imgui.ImBuffer(''..config.Settings.TagCi, 256)
}
local Krit = {
    NeedAgeCar = imgui.ImBool(config.HF070920.NeedAgeCar),
    NeedMedCar = imgui.ImBool(config.HF070920.NeedMedCar),
    NeedLvlCar = imgui.ImBool(config.HF070920.NeedLvlCar),
    AgeCar = imgui.ImBuffer(''..config.HF070920.AgeCar, 3),
    LvlCar = imgui.ImBuffer(''..config.HF070920.LvlCar, 3),
    ------------------------------------------------------
    NeedAgeMoto = imgui.ImBool(config.HF070920.NeedAgeMoto),
    NeedMedMoto = imgui.ImBool(config.HF070920.NeedMedMoto),
    NeedLvlMoto = imgui.ImBool(config.HF070920.NeedLvlMoto),
    AgeMoto = imgui.ImBuffer(''..config.HF070920.AgeMoto, 3),
    LvlMoto = imgui.ImBuffer(''..config.HF070920.LvlMoto, 3),
    ------------------------------------------------------
    NeedAgeAir = imgui.ImBool(config.HF070920.NeedAgeAir),
    NeedMedAir = imgui.ImBool(config.HF070920.NeedMedAir),
    NeedLvlAir = imgui.ImBool(config.HF070920.NeedLvlAir),
    AgeAir = imgui.ImBuffer(''..config.HF070920.AgeAir, 3),
    LvlAir = imgui.ImBuffer(''..config.HF070920.LvlAir, 3),
    ------------------------------------------------------
    NeedAgeBigCar = imgui.ImBool(config.HF070920.NeedAgeBigCar),
    NeedMedBigCar = imgui.ImBool(config.HF070920.NeedMedBigCar),
    NeedLvlBigCar = imgui.ImBool(config.HF070920.NeedLvlBigCar),
    AgeBigCar = imgui.ImBuffer(''..config.HF070920.AgeBigCar, 3),
    LvlBigCar = imgui.ImBuffer(''..config.HF070920.LvlBigCar, 3),
    ------------------------------------------------------
    NeedAgeGun = imgui.ImBool(config.HF070920.NeedAgeGun),
    NeedMedGun = imgui.ImBool(config.HF070920.NeedMedGun),
    NeedLvlGun = imgui.ImBool(config.HF070920.NeedLvlGun),
    GunPriceSend = imgui.ImBool(config.HF070920.GunPriceSend),
    AgeGun = imgui.ImBuffer(''..config.HF070920.AgeGun, 3),
    LvlGun = imgui.ImBuffer(''..config.HF070920.LvlGun, 3),
    GunPrice = imgui.ImBuffer(''..config.HF070920.GunPrice, 7),
    ------------------------------------------------------
    NeedAgeWater = imgui.ImBool(config.HF070920.NeedAgeWater),
    NeedMedWater = imgui.ImBool(config.HF070920.NeedMedWater),
    NeedLvlWater = imgui.ImBool(config.HF070920.NeedLvlWater),
    WaterPriceSend = imgui.ImBool(config.HF070920.WaterPriceSend),
    AgeWater = imgui.ImBuffer(''..config.HF070920.AgeWater, 3),
    LvlWater = imgui.ImBuffer(''..config.HF070920.LvlWater, 3),
    WaterPrice = imgui.ImBuffer(''..config.HF070920.WaterPrice, 7),
    ------------------------------------------------------
    NeedAgeInsur = imgui.ImBool(config.HF070920.NeedAgeInsur),
    NeedMedInsur = imgui.ImBool(config.HF070920.NeedMedInsur),
    NeedLvlInsur = imgui.ImBool(config.HF070920.NeedLvlInsur),
    AgeInsur = imgui.ImBuffer(''..config.HF070920.AgeInsur, 3),
    LvlInsur = imgui.ImBuffer(''..config.HF070920.LvlInsur, 3),
    ------------------------------------------------------
    NeedZakon = imgui.ImBool(config.HF070920.NeedZakon),
    NeedMedInv = imgui.ImBool(config.HF070920.NeedMedInv),
    NeedLvlInv = imgui.ImBool(config.HF070920.NeedLvlInv),
    Zakon = imgui.ImBuffer(''..config.HF070920.Zakon, 3),
    LvlInv = imgui.ImBuffer(''..config.HF070920.LvlInv, 3)
}
----   GUI Windows   ----

----    AutoUpdate   ----
update_state = false
update_btn = false
autoupdate_state = false

local script_vers = 11
local script_vers_text = '1.11'

local update_url = 'https://raw.githubusercontent.com/banan4eg/scripts/master/ASAupdate.ini'
local update_path = getWorkingDirectory() .. '/ASA config/ASAupdate.ini'

local script_url = 'https://github.com/banan4eg/scripts/blob/master/ASA.luac?raw=true'
local script_path = thisScript().path
----    AutoUpdate   ----





----    Main Block   ----
function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end

---- Variables after SAMPon ----
	local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
	nrpnick = sampGetPlayerNickname(id)
	Name, Surname = string.match(nrpnick, '(.+)_(.+)')
	rpnick = string.gsub(sampGetPlayerNickname(id), "_", " ")

    if config.HF041020.ReloadState then sampAddChatMessage(tag_text..' ������ {58ACFA}������� {FFFFFF}������������.', tag_clr) config.HF041020.ReloadState = false saveJson() end

    sampRegisterChatCommand('fail', function()
        if RunCarExam or RunMotoExam or RunAirExam or RunBigCarExam then
            lua_thread.create(function()
                sampSendChat('�� ��������� ������� ����� ������, ������������� �� ���������.')
                wait(2200)
                if Toggle['DokladF'].v then
                    if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                        sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', �� ���� �������.')
                    else
                        sampSendChat('/f ������������ �'..tid..' '..targrpnick..', �� ���� �������.')
                    end
                end
                ExamEnd(2)
                wait(2200)
                sampSendChat('/exam')
                thisScript():reload()
            end)
        else
            sampAddChatMessage(tag_text..' �� {58ACFA}�� ���������{FFFFFF} �������', tag_clr)
        end
    end)

    sampRegisterChatCommand('f', function(text) 
        if Toggle['TagF'].v then sampSendChat('/f '..u8:decode(Input['Tag'].v)..' '..text) else sampSendChat('/f '..text) end
    end)


    ----  Hotkeys  Func  ----
    bindMainMenu = rkeys.registerHotKey(ActiveMainMenu.v, true, MainMenuFunc)
    bindExam = rkeys.registerHotKey(ActiveExam.v, true, ExamFunc)
    bindTime = rkeys.registerHotKey(ActiveTime.v, true, TimeFunc)
    bindHello = rkeys.registerHotKey(ActiveHello.v, true, HelloFunc)
    bindR = rkeys.registerHotKey(ActiveR.v, true, RFunc)
    bindRN = rkeys.registerHotKey(ActiveRN.v, true, RNFunc)
    bindBinder = rkeys.registerHotKey(ActiveBinder.v, true, BinderFunc)
    bindShpora = rkeys.registerHotKey(ActiveShpora.v, true, ShporaFunc)
    ----  Hotkeys  Func  ----

    for k, v in pairs(Binder) do
		rkeys.registerHotKey(v.v, true, onHotKey)
	end


----    AutoUpdate   ----
if Toggle['AutoUpdate'].v then
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            if doesFileExist(getWorkingDirectory() .. '/ASA config/ASAupdate.ini') then
                updateini = inicfg.load(nil, update_path)
                if tonumber(updateini.script.version) > script_vers and Toggle['AutoUpdate'].v then
                    sampAddChatMessage(tag_text..' ������� {58ACFA}����� ������ {FFFFFF}�������', tag_clr)
                    sampAddChatMessage(tag_text..' ���������� {58ACFA}����������{FFFFFF}', tag_clr)
                    autoupdate_state = true
                end
                os.remove(update_path)
            end
        end
    end)
end
----    AutoUpdate   ----
    


    --repeat	wait(0)	until sampIsLocalPlayerSpawned()
    while true do wait(0)

NotepadST = {}
for i = 1, #Notepad do
    NotepadST[i] = imgui.ImBool(Notepad[i].state)
end

 -- Dincamic variables --
    _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    nrpnick1 = sampGetPlayerNickname(id)
    if Radio['Gender'].v == 1 then Sex = '' SexL = '' else Sex = '�' SexL = '��' end
    date = os.date("%d.%m.%Y")
    timehm = os.date('%H:%M')
-- Dincamic variables --

----    AutoUpdate   ----
if autoupdate_state and Toggle['AutoUpdate'].v then
    downloadUrlToFile(script_url, script_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            sampAddChatMessage(tag_text..' ������ {58ACFA}������� {FFFFFF}��������', tag_clr)
            thisScript():reload()
        end
    end)
    break
end
----    AutoUpdate   ----

if ExamTimer >= os.time() and ExamTimerPlay then
    local timeInSeconds = ExamTimer - os.time()
    SecondsExam = math.floor(timeInSeconds)
    if ExamTime.v then
        sampTextdrawCreate(35, SecondsExam, 623, 80.500)
        sampTextdrawSetLetterSizeAndColor(35, 0.3, 1.3, -1)
        sampTextdrawSetStyle(35, 2)
        sampTextdrawSetOutlineColor(35, 1, 4278190080)
        if SecondsExam == 0 then 
            sampTextdrawDelete(35)
            ExamTimerPlay = false
            ExamTimer = 0
        end
    else 
        if seconds == 0 then 
            ExamTimerPlay = false
            ExamTimer = 0
        end
    end
end

if ExamTimer ~= -1 and not ExamTimerPlay then
    if ExamTime.v then
        sampTextdrawCreate(36, 'OK', 618, 80.500)
        sampTextdrawSetLetterSizeAndColor(36, 0.3, 1.3, 0xFF00BE21)
        sampTextdrawSetStyle(36, 2)
        sampTextdrawSetOutlineColor(36, 1, 4278190080)
        wait(2000)
        sampTextdrawDelete(36)
        ExamTimerPlay = true
        ExamTimer = -1
    else
        ExamTimerPlay = true
        ExamTimer = -1
    end
end

if RunCarExam then
    local ax, ay, az = getCharCoordinates(1)
    local bx, by, bz = -2054.0480957031, -173.13999938965, 35.063426971436 -- 1
    local ex, ey, ez = -2052.2875976563, -200.17088317871, 35.070415496826 -- 2
    local qx, qy, qz = -2051.7846679688, -241.173828125, 35.066963195801 -- 3
    local wx, wy, wz = -2065.1159667969, -245.57873535156, 35.063671112061 -- 4
    local ux, uy, uz = -2034.9053955078, -261.35479736328, 35.063709259033 -- 5
    local ox, oy, oz = -2027.5394287109, -249.63632202148, 35.06315612793 -- 6
    local px, py, pz = -2027.4201660156, -216.39141845703, 35.063369750977 -- 7
    if IsPlayerInRangeOfPoint(bx, by, bz, 4) and NextStepCar == 1 then 
    wait(500)
        sampSendChat("�������� �� ������� ����������� �� �������. ����� ������� ������ �������.")
        if Toggle['Checkpoints_st'].v then setMarker(2, ex, ey, ez, 3, 0xFF0000FF) end
        NextStepCar = 2
    elseif IsPlayerInRangeOfPoint(ex, ey, ez, 3) and NextStepCar == 2 then 
    wait(500)
        sampSendChat("���������� �������� ������� �� �������� � ���������� ������ �������.")
        if Toggle['Checkpoints_st'].v then setMarker(2, qx, qy, qz, 3, 0xFF0000FF) end
        NextStepCar = 3
    elseif IsPlayerInRangeOfPoint(qx, qy, qz, 3) and NextStepCar == 3 then 
    wait(500)
        sampSendChat("������ ��������� ������ � ������������ �������.")
        if Toggle['Checkpoints_st'].v then setMarker(2, wx, wy, wz, 3, 0xFF0000FF) end
        NextStepCar = 4
    elseif IsPlayerInRangeOfPoint(wx, wy, wz, 3) and NextStepCar == 4 then
    wait(500)
        sampSendChat("������ ������� �� �������� ������ ������� � ������� ��������.")
        if Toggle['Checkpoints_st'].v then setMarker(2, ux, uy, uz, 4, 0xFF0000FF) end
        NextStepCar = 5
    elseif IsPlayerInRangeOfPoint(ux, uy, uz, 4) and NextStepCar == 5 then 
    wait(500)
        sampSendChat("����������� � �������� � ������������ ����� ������.")
        if Toggle['Checkpoints_st'].v then setMarker(2, ox, oy, oz, 3, 0xFF0000FF) end
        NextStepCar = 6
    elseif IsPlayerInRangeOfPoint(ox, oy, oz, 3) and NextStepCar == 6 then
    wait(1000)
        sampSendChat("������ ��������� ���������� �� �����, ����� ����� ������� ���� ������������.")
        if Toggle['Checkpoints_st'].v then setMarker(2, px, py, pz, 3, 0xFF0000FF) end
        NextStepCar = 7
    elseif IsPlayerInRangeOfPoint(px, py, pz, 3) and NextStepCar == 7 then
    wait(500)
    sampSendChat("�������, ������ ��������� ���������� �� ��������!")
    NextStepCar = 8
    end
end

if RunMotoExam then
    local ax, ay, az = getCharCoordinates(1)
    local bx, by, bz = -2112.3962402344, -101.9630279541, 34.89965057373 -- 1
    local ex, ey, ez = -2113.443359375, -144.38008117676, 34.887550354004 -- 2
    local qx, qy, qz = -2125.4226074219, -117.89943695068, 34.889862060547 -- 3
    local wx, wy, wz = -2148.3720703125, -119.83048248291, 34.893516540527 -- 4
    local ux, uy, uz = -2147.0822753906, -130.81153869629, 34.888622283936 -- 5
    local ox, oy, oz = -2134.7041015625, -140.8558807373, 34.890331268311 -- 6
    local px, py, pz = -2124.1689453125, -139.82873535156, 34.888557434082 -- 7
    local cx, cy, cz = -2144.6499023438, -149.48649597168, 34.886878967285 -- 8
    local sx, sy, sz = -2114.3820800781, -154.32595825195, 34.890197753906 -- 9 
    local vx, vy, vz = -2105.7290039063, -103.55418395996, 34.899787902832 -- 10
    if IsPlayerInRangeOfPoint(bx, by, bz, 3) and NextStepMoto == 1 then
    wait(500)
        sampSendChat('���������� �������� ������� �� �������� � ���������� ������ �������.')
        if Toggle['Checkpoints_st'].v then setMarker(2, ex, ey, ez, 5, 0xFF0000FF) end
        NextStepMoto = 2
    elseif IsPlayerInRangeOfPoint(ex, ey, ez, 5) and NextStepMoto == 2 then
    wait(500)
        sampSendChat('������ �� ��������, ���������� � ������� ��������.')
        if Toggle['Checkpoints_st'].v then setMarker(2, qx, qy, qz, 3, 0xFF0000FF) end
        NextStepMoto = 3
    elseif IsPlayerInRangeOfPoint(qx, qy, qz, 3) and NextStepMoto == 3 then
    wait(500)
        sampSendChat('������ ��������� ���������� �� ��������.')
        if Toggle['Checkpoints_st'].v then setMarker(2, wx, wy, wz, 3, 0xFF0000FF) end
        NextStepMoto = 4
    elseif IsPlayerInRangeOfPoint(wx, wy, wz, 3) and NextStepMoto == 4 then
    wait(500)
        sampSendChat('������ ��������, �������� ��������� ������ ������')
        if Toggle['Checkpoints_st'].v then setMarker(2, ux, uy, uz, 3, 0xFF0000FF) end
        NextStepMoto = 5
    elseif IsPlayerInRangeOfPoint(ux, uy, uz, 3) and NextStepMoto == 5 then
    wait(500)
        sampSendChat('� ������ ����������� �������� � ������������ �������.')
        if Toggle['Checkpoints_st'].v then setMarker(2, ox, oy, oz, 1, 0xFF0000FF) end
        NextStepMoto = 6
    elseif IsPlayerInRangeOfPoint(ox, oy, oz, 1) and NextStepMoto == 6 then
    wait(500)
        sampSendChat('����������� ��������, ������� �� ����������� ��������.')
        if Toggle['Checkpoints_st'].v then setMarker(2, px, py, pz, 3, 0xFF0000FF) end
        NextStepMoto = 7
    elseif IsPlayerInRangeOfPoint(px, py, pz, 3) and NextStepMoto == 7 then
    wait(500)
        sampSendChat('����������� �����������, ������� ����� ��������.')
        if Toggle['Checkpoints_st'].v then setMarker(2, cx, cy, cz, 3, 0xFF0000FF) end
        NextStepMoto = 8
    elseif IsPlayerInRangeOfPoint(cx, cy, cz, 3) and NextStepMoto == 8 then
    wait(500)
        sampSendChat('����������� ������������� ����������')
        if Toggle['Checkpoints_st'].v then setMarker(2, sx, sy, sz, 3, 0xFF0000FF) end
        NextStepMoto = 9
    elseif IsPlayerInRangeOfPoint(sx, sy, sz, 3) and NextStepMoto == 9 then
    wait(500)
        sampSendChat('��� ����� �������� ������ ������� �� ���������� ��������.')
        if Toggle['Checkpoints_st'].v then setMarker(2, vx, vy, vz, 3, 0xFF0000FF) end
        NextStepMoto = 10
    elseif IsPlayerInRangeOfPoint(vx, vy, vz, 3) and NextStepMoto == 10 then
    wait(500)
        sampSendChat('������ ����������� �������� � ��� �����, ��� ��� �����.')
    NextStepMoto = 11
    end
end

if RunBigCarExam then
    local ax, ay, az = getCharCoordinates(1)  
    local bx, by, bz = -2129.3610839844, -86.953735351563, 34.8903465271 -- 1
    if IsPlayerInRangeOfPoint(bx, by, bz, 6) and NextStepBigCar == 1 then
        wait(100)
        sampSendChat('��������� ������, ����� ���� �������� ���� ������ ������������� ������')
        wait(2200)
        sampSendChat('������������� �� ��������� ������ ������.')
    NextStepBigCar = 2
    end
end



    end
end
----    Main Block   ----
function ev.onSendChat(text)
    if Toggle['TagC'].v then return {u8:decode(Input['TagCi'].v)..' '..text} else return {text} end
end

function ev.onServerMessage(color, text)
    if string.find(text, '�� ������� (.*) �� ����������� ��������%. %[(.*)%]') and color == 647747839 then
        ExamTimer = os.time() + 31
        ExamTimerPlay = true
    end

    if string.find(text, nrpnick..' ������ �������� �� .* .*_.*') and color == -577699841 then
        SellState = true
    end

    if string.find(text, nrpnick..' ����������� ���������� .*_.* �� %d+ ����') and color == -577699841 then
        SellIns = true
    end
--[[
(.*) ������� ������ �� ������������ ������� �� ���������� (.*) COL: 647747839

�� ������� (.*) �� ����������� ��������. %[(.*)%] COL: 647747839

��������� ������� ����� �� ����� 1 ���� �� 30 ������. COL: -1347440726

������� �������� %(�������%) COL: 866792362
]]
end

-------------------------
function MainMenuFunc()
    if not Window['Target'].v then
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
            if valid and doesCharExist(ped) then
                targ_tr, tid = sampGetPlayerIdByCharHandle(ped)
                    if targ_tr then
                        if Toggle['BlipState'].v then
                            targ_bl = addBlipForChar(ped)
                        end
                        Window['Target'].v = true
                        imgui.Process = Window['Target'].v or Window['Binder'].v or Window['Latest_Update'].v or Window['FAQ'].v
                    end
            else
                Window['Main'].v = not Window['Main'].v
                imgui.Process = Window['Main'].v or Window['Binder'].v or Window['Latest_Update'].v or Window['FAQ'].v
            end
    elseif Window['Target'].v then
        Window['Target'].v = false
        if not RunCarExamSt and not RunAirExamSt and not RunMotoExamSt and not RunBigCarExamSt and Toggle['BlipState'].v then
            removeBlip(targ_bl)
        end
    end
end

function ExamFunc()
    sampSendChat('/exam')
end

function TimeFunc()
    carExam()
    --sampSendChat('/time')
end

function HelloFunc()
    sampSendChat('������������, � '..myrang..', '..rpnick..', ��� ���� ���� �������?')
end

function RFunc()
    sampSetChatInputEnabled(true)
    sampSetChatInputText('/f ')
end

function RNFunc()
    sampSetChatInputEnabled(true)
    sampSetChatInputText('/fn ') 
end

function BinderFunc()
    BinderType.v = 0
    Window['Binder'].v = not Window['Binder'].v
    imgui.Process = Window['Binder'].v or Window['Main'].v or Window['Target'].v or Window['Latest_Update'].v or Window['FAQ'].v
end

function ShporaFunc()
    BinderType.v = 1
    Window['Binder'].v = not Window['Binder'].v
    imgui.Process = Window['Binder'].v or Window['Main'].v or Window['Target'].v or Window['Latest_Update'].v or Window['FAQ'].v
end
-------------------------


----   ImGui Block   ----
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/lib/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end
-------------------------
function imgui.OnDrawFrame()
    setstyleandtheme()
    imgui.Process = Window['Main'].v or Window['Target'].v or Window['Binder'].v or Window['Latest_Update'].v or Window['FAQ'].v

local tLastKeys = {}

local ListenText = {}
for i = 1, 15 do 
    ListenTextPath = Lections[i].text
    ListenText[i] = imgui.ImBuffer(u8''..ListenTextPath, 2048)
end
local ListenCaption = {}
for i = 1, 15 do 
    ListenCaptionPath = Lections[i].caption
    ListenCaption[i] = imgui.ImBuffer(u8''..ListenCaptionPath, 128)
end
local ListenDelay = {}
for i = 1, 15 do 
    ListenDelayPath = Lections[i].delay
    ListenDelay[i] = imgui.ImBuffer(u8''..ListenDelayPath, 6)
end
arr_Lections = {u8'�������� ������', Lections[1].caption, Lections[2].caption, Lections[3].caption, Lections[4].caption, Lections[5].caption, Lections[6].caption, Lections[7].caption, Lections[8].caption, Lections[9].caption, Lections[10].caption, Lections[11].caption, Lections[12].caption, Lections[13].caption, Lections[14].caption, Lections[15].caption}
---------------------------------
local GnewsText3 = {}
for i = 1, 8 do 
    GnewsText3Path = GNews[i].text3
    GnewsText3[i] = imgui.ImBuffer(u8''..GnewsText3Path, 2048)
end
local GnewsText1 = {}
for i = 1, 8 do 
    GnewsText1Path = GNews[i].text1
    GnewsText1[i] = imgui.ImBuffer(u8''..GnewsText1Path, 256)
end
local GnewsDelay = {}
for i = 1, 8 do 
    GnewsDelayPath = GNews[i].delay
    GnewsDelay[i] = imgui.ImBuffer(u8''..GnewsDelayPath, 5)
end
---------------------------------
local BindText = {}
for i = 1, #Binder do 
    BindTextPath = Binder[i].text
    if BindTextPath == nil then BindTextPath = '' end
    BindText[i] = imgui.ImBuffer(u8''..BindTextPath, 8192)
end
local BindCaption = {}
for i = 1, #Binder do 
    BindCaptionPath = Binder[i].caption
    if BindCaptionPath == nil then BindCaptionPath = '' end
    BindCaption[i] = imgui.ImBuffer(u8''..BindCaptionPath, 256)
end
local BindCommand = {}
for i = 1, #Binder do 
    BindCommandPath = Binder[i].command
    if BindCommandPath == nil then BindCommandPath = '' end
    BindCommand[i] = imgui.ImBuffer(u8''..BindCommandPath, 256)
end
---------------------------------
local NotepadTitle = {}
for i = 1, #Notepad do
    NotepadTitlePath = Notepad[i].title
    if NotepadTitlePath == nil then NotepadTitlePath = '' end
    NotepadTitle[i] = imgui.ImBuffer(u8''..NotepadTitlePath, 256)
end
local NotepadText = {}
for i = 1, #Notepad do 
    NotepadTextPath = Notepad[i].text
    if NotepadTextPath == nil then NotepadTextPath = '' end
    NotepadText[i] = imgui.ImBuffer(u8''..NotepadTextPath, 99999)
end 
---------------------------------


---------------------------------
    if Window['Main'].v then
		imgui.SetNextWindowSize(imgui.ImVec2(391, 383), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2+450, sh/2+190), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin('License Center Assistant ##1', Window['Main'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.MenuBar + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
            imgui.BeginMenuBar()
            if imgui.BeginMenu(fa.ICON_BARS..u8' ����', true) then
                if imgui.MenuItem(u8'�������������') then
                    Child['InterviewM'] = not Child['InterviewM']
                    Child['SettingsMain'], Child['Leader'], Child['Lekcii'], Child['Support'], Child['SettingsKrit'], Child['Visual'] = false, false, false, false, false, false
                end
                if imgui.MenuItem(u8'���. �������') then
                    Child['Leader'] = not Child['Leader']
                    SelGnews.v = 0
                    Child['InterviewM'], Child['SettingsMain'], Child['Lekcii'], Child['Support'], Child['SettingsKrit'], Child['Visual'] = false, false, false, false, false, false
                end
                if imgui.MenuItem(u8'������') then
                    Child['Lekcii'] = not Child['Lekcii']
                    SelLection.v = 0
                    Child['InterviewM'], Child['Leader'], Child['SettingsMain'], Child['Support'], Child['SettingsKrit'], Child['Visual'] = false, false, false, false, false, false
                end
            imgui.EndMenu()
            end
            if imgui.MenuItem(fa.ICON_LIST_ALT..u8' ������') then
                Window['Binder'].v = not Window['Binder'].v
                imgui.Process = Window['Binder'].v or Window['Main'].v or Window['Target'].v or Window['Latest_Update'].v or Window['FAQ'].v
            end
            if imgui.BeginMenu(fa.ICON_COGS..u8' ���������', true) then
                if imgui.MenuItem(u8'��������') then
                Child['SettingsMain'] = not Child['SettingsMain']
                Child['InterviewM'], Child['Leader'], Child['Lekcii'], Child['Support'], Child['SettingsKrit'], Child['Visual'] = false, false, false, false, false, false
                end
                if imgui.MenuItem(u8'��������') then
                    Child['SettingsKrit'] = not Child['SettingsKrit']
                    Child['InterviewM'], Child['Leader'], Child['Lekcii'], Child['Support'], Child['SettingsMain'], Child['Visual'] = false, false, false, false, false, false
                end
                if imgui.MenuItem(u8'���������� ����������') then
                    Child['Visual'] = not Child['Visual']
                    Child['InterviewM'], Child['Leader'], Child['Lekcii'], Child['Support'], Child['SettingsMain'], Child['SettingsKrit'] = false, false, false, false, false, false
                end
                imgui.EndMenu()
            end
            if imgui.MenuItem(fa.ICON_INFO_CIRCLE..u8' � �������') then
                Child['Support'] = not Child['Support']
                Child['InterviewM'], Child['Leader'], Child['Lekcii'], Child['SettingsMain'], Child['SettingsKrit'], Child['Visual'] = false, false, false, false, false, false
            end 
            --[[
            if imgui.MenuItem(fa.ICON_QUESTION_CIRCLE..' F.A.Q') then
                Window['FAQ'].v = not Window['FAQ'].v
                imgui.Process = Window['FAQ'].v or Window['Main'].v or Window['Target'].v or Window['Binder'].v or Window['Latest_Update'].v
            end 
            imgui.MenuItem('', false, false, false)
            ]]
            imgui.MenuItem('               ', false, false, false)
            if imgui.MenuItem(fa.ICON_REFRESH) then
                imgui.OpenPopup('ReloadScript')
            end 
            if imgui.BeginPopup('ReloadScript') then
                imgui.TextRGB('�� ������ �������������\n������?', 2) imgui.SetCursorPosX(35)
                if imgui.Button(u8'���', imgui.ImVec2(40,20)) then imgui.CloseCurrentPopup() end imgui.SameLine()
                if imgui.Button(u8'��', imgui.ImVec2(40,20)) then lua_thread.create(function()
                    imgui.CloseCurrentPopup() Window['Main'].v = false sampAddChatMessage(tag_text..' ������ {58ACFA}���������������{FFFFFF}...', tag_clr)
                    wait(1000) config.HF041020.ReloadState = true saveJson() thisScript():reload() end) end
            imgui.EndPopup()
            end
            imgui.EndMenuBar()

            imgui.SetCursorPos(imgui.ImVec2(3, 38))
            imgui.BeginChild('MainChild', imgui.ImVec2(385, 347), true, imgui.WindowFlags.NoScrollWithMouse)
            if Child['InterviewM'] then
                local Xbi, Ybi, Xbi2, Ybi2, lef = 181, 25, 368, 25, 9
                imgui.SetCursorPos(imgui.ImVec2(lef, 12))
                if imgui.Button(u8'����������� [1]', imgui.ImVec2(Xbi, 30)) then
                    lua_thread.create(function()
                        sampSendChat("������������, �� �� �������������?")
                        wait(200)
                        sampAddChatMessage(tag_text..' ����� ������ ������� - {58ACFA}1{FFFFFF}. ������ - {58ACFA}2{FFFFFF}.', tag_clr)
                        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
                        if isKeyJustPressed(0x31) then
                            sampSendChat('������, �������� ��� �������, �������� � ����������� �����.')
                            wait(2200)
                            sampSendChat('/n �������� ������� - /pass '..myid..' , ���. ����� - /med '..myid..', �������� - /lic '..myid..'.')
                        elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                        end
                    end)
                end imgui.SameLine()
                if imgui.Button(u8'������� [5]', imgui.ImVec2(Xbi, 30)) then
                    inviteFunc(1)
                end
                imgui.SetCursorPosY(55) imgui.Separator() imgui.SetCursorPosY(60)
                imgui.TextRGB('              �� ������� [2]', 1) imgui.SameLine()
                imgui.TextRGB('OOC ������� [3]            ', 3) imgui.SetCursorPosX(lef)
                if imgui.Button(u8'��� � ���� ��� �������?', imgui.ImVec2(Xbi, Ybi)) then
                    sampSendChat('������, ��� � ���� ��� �������?')
                end imgui.SameLine()
                if imgui.Button(u8'������ [IC]', imgui.ImVec2(Xbi, Ybi)) then
                    sampSendChat('������.')
                end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'��� ����� ��?', imgui.ImVec2(Xbi, Ybi)) then
                    sampSendChat('������, ��� ����� ��?')
                end imgui.SameLine()
                if imgui.Button(u8'��������� [OOC]', imgui.ImVec2(Xbi, Ybi)) then
                    sampSendChat('/n ���������.')
                end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'��� ����� ��?', imgui.ImVec2(Xbi, Ybi)) then
                    sampSendChat('������, ��� ����� ��?')
                end imgui.SameLine()
                if imgui.Button(u8'��������� [IC]', imgui.ImVec2(Xbi, Ybi)) then
                    sampSendChat('���������.')
                end imgui.SetCursorPosX(100)
                if imgui.Button(u8'������ ������ ��? [4]', imgui.ImVec2(Xbi, Ybi)) then
                    lua_thread.create(function()
                        sampSendChat('������, �������� ��� ����� ������� ��������')
                        wait(2200)
                        sampSendChat('� ������ �� ������ �������� ������ � ���?')
                    end)
                end
                imgui.SetCursorPosY(195) imgui.Separator() imgui.SetCursorPos(imgui.ImVec2(lef, 202))
                imgui.TextRGB('����� �� �������', 2) imgui.SameLine() 
                if Krit['NeedZakon'].v and not Krit['NeedMedInv'].v and not Krit['NeedLvlInv'].v then
                    imgui.TextQuestion(u8'���� ���������������. (( ����������������� '..Krit['Zakon'].v..u8'+ ))\n�� ���', 0.4)
                elseif Krit['NeedZakon'].v and Krit['NeedMedInv'].v and not Krit['NeedLvlInv'].v then
                    imgui.TextQuestion(u8'���� ���������������. (( ����������������� '..Krit['Zakon'].v..u8'+ ))\n����� ���������� ����������� ������.\n�� ���', 0.4)
                elseif Krit['NeedZakon'].v and Krit['NeedMedInv'].v and Krit['NeedLvlInv'].v then
                    imgui.TextQuestion(u8'���� ���������������. (( ����������������� '..Krit['Zakon'].v..u8'+ ))\n��������� � ���������� '..Krit['LvlInv'].v..u8' ���� (( ����� '..Krit['LvlInv'].v..u8' LvL ))\n����� ���������� ����������� ������.\n�� ���', 0.4)
                elseif Krit['NeedZakon'].v and not Krit['NeedMedInv'].v and Krit['NeedLvlInv'].v then
                    imgui.TextQuestion(u8'���� ���������������. (( ����������������� '..Krit['Zakon'].v..u8'+ ))\n��������� � ���������� '..Krit['LvlInv'].v..u8' ���� (( ����� '..Krit['LvlInv'].v..u8' LvL ))\n�� ���', 0.4)
                elseif not Krit['NeedZakon'].v and Krit['NeedMedInv'].v and not Krit['NeedLvlInv'].v then
                    imgui.TextQuestion(u8'����� ���������� ����������� ������.\n�� ���', 0.4)
                elseif not Krit['NeedZakon'].v and not Krit['NeedMedInv'].v and Krit['NeedLvlInv'].v then
                    imgui.TextQuestion(u8'��������� � ���������� '..Krit['LvlInv'].v..u8' ���� (( ����� '..Krit['LvlInv'].v..u8' LvL ))\n�� ���', 0.4)
                elseif not Krit['NeedZakon'].v and Krit['NeedMedInv'].v and Krit['NeedLvlInv'].v then
                    imgui.TextQuestion(u8'��������� � ���������� '..Krit['LvlInv'].v..u8' ���� (( ����� '..Krit['LvlInv'].v..u8' LvL ))\n����� ���������� ����������� ������.\n�� ���', 0.4)
                end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'������������ �����������������', imgui.ImVec2(Xbi2, Ybi2)) then
                    lua_thread.create(function()
                        sampSendChat('��������, �� �� �����������������. ��������.')
                        wait(1500)
                        sampSendChat('/n ���������� '..Krit['Zakon'].v..'+ �����������������.')
                    end)
                end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'����� ���', imgui.ImVec2(Xbi2, Ybi2)) then
                    lua_thread.create(function()
                        sampSendChat('� ��� �������� � ��������, �� �� �������.')
                        wait(2200)
                        sampSendChat('/n ������� /mn - ����� ����� ����.')
                    end)
                end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'������������� �������', imgui.ImVec2(Xbi2, Ybi2)) then
                    lua_thread.create(function()
                        sampSendChat('� ��� ������������� ���� ����������.')
                        wait(2200)
                        sampSendChat('/n ��������� '..Krit['LvlInv'].v..' �������.') 
                    end)
                end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'������� �����', imgui.ImVec2(Xbi2, Ybi2)) then
                    sampSendChat('��������, �� ��� �� ���������.')
                end
            elseif Child['Leader'] then
                local lef = 10
                imgui.SetCursorPos(imgui.ImVec2(lef-3, 8))
                imgui.Text(u8'���. ������� ���:') imgui.SameLine()
                imgui.PushItemWidth(153) imgui.SetCursorPosY(7)
                imgui.Combo('##SelGnews', SelGnews, arr_gnews, #arr_gnews)
                for i = 1, 8 do
                    if SelGnews.v == i then
                        imgui.SetCursorPosY(30) imgui.Separator() imgui.SetCursorPos(imgui.ImVec2(lef-3, 38))
                        imgui.Text(u8'3-� �������� /gnews') imgui.SameLine() imgui.SetCursorPosY(34)
                        if imgui.Button(u8'��������� 3 ������') then
                            lua_thread.create(function()
                                    sampSendChat('/l �����.')
                                    wait(2200)
                                for str in u8:decode(GNews[i].text3):gmatch('[^\n\r]+') do
                                    sampSendChat('/gnews '..str)
                                    wait(GNews[i].delay)
                                end
                                    wait(200)
                                    sampSendChat('/time')
                            end)
                        end imgui.SameLine()
                        imgui.SetCursorPos(imgui.ImVec2(268, 34)) imgui.Text(u8'��������:') imgui.SameLine() imgui.PushItemWidth(40)
                        imgui.SetCursorPos(imgui.ImVec2(337, 35))
                        if imgui.InputText(u8'##DelayGnews'..i, GnewsDelay[i]) then
                            GNews[i].delay = GnewsDelay[i].v
                            saveJsonG()
                        end imgui.SetCursorPos(imgui.ImVec2(lef-3, 60))
                        if imgui.InputTextMultiline(u8'##MuiltiGnews'..i, GnewsText3[i], imgui.ImVec2(371, 59)) then
                            GNews[i].text3 = GnewsText3[i].v
                            saveJsonG()
                        end imgui.SetCursorPosY(120)
                        imgui.TextRGB('�����������', 2)
                        imgui.PushItemWidth(371) imgui.SetCursorPosX(lef-3)
                        if imgui.InputText(u8'##OneGnews'..i, GnewsText1[i]) then
                            GNews[i].text1 = GnewsText1[i].v
                            saveJsonG()
                        end imgui.SetCursorPosX(lef)
                        if imgui.Button(u8'����� (�� ����������)') then
                            lua_thread.create(function()
                                sampSendChat('/l �����, �� ����������.')
                                wait(2200)
                                sampSendChat('/gnews '..u8:decode(GnewsText1[i].v))
                                wait(200)
                                sampSendChat('/time')
                            end)
                        end imgui.SameLine() imgui.Text('                   ') imgui.SameLine()
                        if imgui.Button(u8'����� (����������)') then
                            lua_thread.create(function()
                                sampSendChat('/l �����, ����������.')
                                wait(2200)
                                sampSendChat('/gnews '..u8:decode(GnewsText1[i].v))
                                wait(200)
                                sampSendChat('/time')
                            end)
                        end
                    end
                end
                imgui.SetCursorPosY(188) imgui.Separator()
                local Xbl2, Ybl2 = 180, 21
                imgui.SetCursorPosY(191) imgui.SetCursorPosX(lef)
                if imgui.Button(u8'���������', imgui.ImVec2(Xbl2, Ybl2)) then rangup(2) end imgui.SameLine()
                if imgui.Button(u8'����������', imgui.ImVec2(Xbl2, Ybl2)) then uninvite(2) end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'������ ����', imgui.ImVec2(Xbl2, Ybl2)) then giveskin(2) end imgui.SameLine()
                if imgui.Button(u8'���������� � ��������', imgui.ImVec2(Xbl2, Ybl2)) then uninviteoff(2) end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'�������', imgui.ImVec2(Xbl2, Ybl2)) then givewarn(2) end imgui.SameLine()
                if imgui.Button(u8'��������� � ��', imgui.ImVec2(Xbl2, Ybl2)) then gobl(2) end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'������� � ��������', imgui.ImVec2(Xbl2, Ybl2)) then givewarnoff(2) end imgui.SameLine()
                if imgui.Button(u8'��������� � �� � ��������', imgui.ImVec2(Xbl2, Ybl2)) then gobloff(2) end imgui.SetCursorPosX(lef)
                if imgui.Button(u8'������ ��������', imgui.ImVec2(Xbl2, Ybl2)) then takeoffwarn(2) end imgui.SameLine() 
                if imgui.Button(u8'��������� �� ��', imgui.ImVec2(Xbl2, Ybl2)) then backbl(2) end imgui.SetCursorPosX(100)
                if imgui.Button(u8'������� �������� (/invite)', imgui.ImVec2(Xbl2, Ybl2)) then inviteFunc(2) end
            elseif Child['Lekcii'] then
                imgui.SetCursorPos(imgui.ImVec2(18, 6)) imgui.PushItemWidth(350)
                imgui.Combo('##SelLection', SelLection, arr_Lections, #arr_Lections)
                if SelLection.v == 0 then
                    imgui.SetCursorPosY(60)
                    imgui.TextRGB('� ������ ������� ������������ �������� ����� {58ACFA}@tscreen')
                    imgui.Text('')
                    imgui.TextRGB('{58ACFA}@tscreen{FFFFFF} - ������� ����� �����, ��� ��� ���������� �������\n                 �������� � ������. (/time)\n                 ���������� ��� ���� ���-�� �����')
                    imgui.Text('')
                    imgui.TextRGB('��� �� ��� ������� {58ACFA}����� ���������{FFFFFF} �� ������ ������ ���\n�� ������')
                end
                for i = 1, 15 do
                    if SelLection.v == i then
                        imgui.SetCursorPosY(29) imgui.Separator()
                        imgui.SetCursorPosY(34) imgui.Text(u8'��������:') imgui.SameLine() imgui.PushItemWidth(175) imgui.SetCursorPosY(32)
                        if imgui.InputText(u8'##CaptionLec'..i, ListenCaption[i]) then Lections[i].caption = ListenCaption[i].v saveJsonL() end 
                        if not LecPlay then
                            imgui.SameLine() imgui.SetCursorPos(imgui.ImVec2(253,32)) imgui.Text(u8'��������:') imgui.SameLine() imgui.PushItemWidth(40) imgui.SetCursorPosY(32)
                            if imgui.InputText(u8'##DelayLec'..i, ListenDelay[i], imgui.InputTextFlags.CharsDecimal) then
                                if not LecPlay then  
                                    Lections[i].delay = ListenDelay[i].v saveJsonL()
                                end
                            end imgui.SameLine()
                            if tonumber(ListenDelay[i].v) ~= nil then
                                if tonumber(ListenDelay[i].v) < 2000 then imgui.TextWarning(u8'���������� ������������� �������� - 2000') end
                            else
                                imgui.TextWarning(u8'�� �� ����� ��������')
                            end
                        end
                        imgui.SetCursorPos(imgui.ImVec2(5, 55))
                        if imgui.InputTextMultiline(u8'##MultilineText'..i, ListenText[i], imgui.ImVec2(377, 262)) then
                            Lections[i].text = ListenText[i].v
                            saveJsonL()
                        end imgui.SetCursorPosY(321)
                        if not LecPlay then
                            if imgui.Button(u8'��������� ������') then
                                LecPlay = true
                                lua_thread.create(function()
                                        for str in u8:decode(Lections[i].text):gmatch('[^\n\r]+') do
                                            if LecPlay and Toggle['TScreen'].v then
                                                if string.find(str, '@tscreen') then
                                                    local str2tscreen = string.gsub(str, '@tscreen', '')
                                                    Window['Main'].v = false
                                                    imgui.Process = false
                                                    sampSendChat('/time')
                                                    wait(500)
                                                    makeScreen()
                                                    wait(Lections[i].delay+500)
                                                    Window['Main'].v = true
                                                    imgui.Process = Window['Main'].v
                                                else
                                                    if Toggle['LecF'].v then
                                                        if Toggle['TagF'].v then
                                                            sampSendChat('/f '..u8:decode(Input['Tag'].v)..' '..str)
                                                            wait(Lections[i].delay)
                                                        else
                                                            sampSendChat('/f '..str)
                                                            wait(Lections[i].delay)
                                                        end
                                                    else
                                                        sampSendChat(str)
                                                        wait(Lections[i].delay)
                                                    end
                                                end
                                            elseif LecPlay and not Toggle['TScreen'].v then
                                                if not string.find(str, '@tscreen') then
                                                    if Toggle['LecF'].v then
                                                        if Toggle['TagF'].v then
                                                            sampSendChat('/f '..u8:decode(Input['Tag'].v)..' '..str)
                                                            wait(Lections[i].delay)
                                                        else
                                                            sampSendChat('/f '..str)
                                                            wait(Lections[i].delay)
                                                        end
                                                    else
                                                        sampSendChat(str)
                                                        wait(Lections[i].delay)
                                                    end
                                                end
                                            end
                                        end
                                    LecPlay = false
                                end)
                            end
                        elseif LecPlay then
                            if imgui.Button(u8'����������  '..fa.ICON_STOP) then
                                sampAddChatMessage(tag_text..' ������ ������ {58ACFA}�����������', tag_clr)
                                LecPlay = false 
                            end
                        end
                        if not LecPlay then
                            imgui.SameLine() imgui.Text('          ') imgui.SameLine()
                            if imgui.ToggleButton(u8'������ � �����', Toggle['LecF']) then
                                config.Settings.LecF = Toggle['LecF'].v saveJson()
                            end imgui.SameLine()
                            if imgui.ToggleButton('@tscreen', Toggle['TScreen']) then
                                config.Settings.TScreen = Toggle['TScreen'].v saveJson()
                            end
                        end
                    end
                end
            elseif Child['SettingsMain'] then
                imgui.SetCursorPos(imgui.ImVec2(0, 0))
                imgui.BeginChild('LeftChild', imgui.ImVec2(192, 345), true)
                local XposEl = 161
                    imgui.TextRGB('�������� ���������', 2) imgui.Separator()
                    imgui.SetCursorPosY(28)
                    imgui.Text(u8'��� ����:') imgui.SameLine() imgui.PushItemWidth(122) imgui.SetCursorPosY(27)
                    if imgui.Combo('##ASRang', ASRang, arr_rang, #arr_rang)  then config.Settings.ASRang = ASRang.v saveJson() end
                    imgui.Text(u8'��� ���:') imgui.SameLine() imgui.SetCursorPosX(85)
                    if imgui.RadioButton(u8'���', Radio['Gender'], 1) then config.Settings.Gender = Radio['Gender'].v saveJson() end
                    imgui.SameLine()
                    if imgui.RadioButton(u8'���', Radio['Gender'], 2) then config.Settings.Gender = Radio['Gender'].v saveJson() end
                    imgui.Text(u8'������ � ���:') imgui.SameLine() imgui.SetCursorPosX(XposEl)
                    if imgui.ToggleButton(' TagC', Toggle['TagC']) then config.Settings.TagC = Toggle['TagC'].v saveJson() end if Toggle['TagC'].v then
                    if imgui.InputText('##InputTagC', Input['TagCi']) then config.Settings.TagCi = Input['TagCi'].v saveJson() end end
                    imgui.Text(u8'������ � �����:') imgui.SameLine() imgui.SetCursorPosX(XposEl)
                    if imgui.ToggleButton(' TagF', Toggle['TagF']) then config.Settings.TagF = Toggle['TagF'].v saveJson() end if Toggle['TagF'].v then
                    if imgui.InputText('##InputTag', Input['Tag']) then config.Settings.Tag = Input['Tag'].v saveJson() end end
                    imgui.Text(u8'����-�����:') imgui.SameLine() 
                    imgui.TextQuestion(u8'��� ���������� ����-������, ���������:\n����� �������� ���������, ������� ��������, ��������� ����.', 0.4) imgui.SameLine() imgui.SetCursorPosX(XposEl)
                    if imgui.ToggleButton(' AutoScreen', Toggle['AutoScreen']) then config.Settings.AutoScreen = Toggle['AutoScreen'].v saveJson() end
                    imgui.Text(u8'������ � �����:') imgui.SameLine()
                    imgui.TextQuestion(u8'����������/��������� ������� � ����� ��� �������� ��������', 0.4) imgui.SameLine() imgui.SetCursorPosX(XposEl)
                    if imgui.ToggleButton(' DokladF', Toggle['DokladF']) then config.HF070920.DokladF = Toggle['DokladF'].v saveJson() end
                    imgui.Text(u8'����� KD ��������') imgui.SameLine()
                    imgui.TextQuestion(u8'����� �� ������ ��������� �������\n�� 30 ������ ����� �������� /exam', 0.4) imgui.SameLine() imgui.SetCursorPosX(XposEl)
                    if imgui.ToggleButton('##ExamTime', ExamTime) then config.HF031020.ExamTime = ExamTime.v saveJson() end
                    imgui.Text(u8'���������') imgui.SameLine()
                    imgui.TextQuestion(u8'���������� ��������� ��������� �� ��������\n�� ����� ���������� ��������', 0.4) imgui.SameLine() imgui.SetCursorPosX(XposEl)
                    if imgui.ToggleButton('##ExamCheckpoints', Toggle['Checkpoints_st']) then config.HF061020.Checkpoints_st = Toggle['Checkpoints_st'].v saveJson() end
                    imgui.Text(u8'������') imgui.SameLine()
                    imgui.TextQuestion(u8'���������� ������ ��� ��������� � �������� �� ���������� �������.') imgui.SameLine() imgui.SetCursorPosX(XposEl)
                    if imgui.ToggleButton('    BlipState', Toggle['BlipState']) then config.HF141020.BlipState = Toggle['BlipState'].v saveJson() end
                imgui.EndChild() imgui.SetCursorPos(imgui.ImVec2(192, 0)) 
                imgui.BeginChild('RightChild', imgui.ImVec2(192, 345), true)
                local XposBinds = 89
                    imgui.TextRGB('��������� ������', 2) imgui.Separator()
                    imgui.Text(u8'����:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##1', ActiveMainMenu, tLastKeys, 100) then
                        rkeys.changeHotKey(bindMainMenu, ActiveMainMenu.v)
                        config.HotKeys.MainMenu = encodeJson(ActiveMainMenu.v) saveJson()
                    end
                    imgui.Text(u8'/exam:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##2', ActiveExam, tLastKeys, 100) then
                        rkeys.changeHotKey(bindExam, ActiveExam.v)
                        config.HotKeys.Exam = encodeJson(ActiveExam.v) saveJson()
                    end
                    imgui.Text(u8'/time:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##3', ActiveTime, tLastKeys, 100) then
                        rkeys.changeHotKey(bindTime, ActiveTime.v)
                        config.HotKeys.Time = encodeJson(ActiveTime.v) saveJson()
                    end
                    imgui.Text(u8'�����������:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##4', ActiveHello, tLastKeys, 100) then
                        rkeys.changeHotKey(bindHello, ActiveHello.v)
                        config.HotKeys.Hello = encodeJson(ActiveHello.v) saveJson()
                    end
                    imgui.Text(u8'�����:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##5', ActiveR, tLastKeys, 100) then
                        rkeys.changeHotKey(bindR, ActiveR.v)
                        config.HotKeys.R = encodeJson(ActiveR.v) saveJson()
                    end
                    imgui.Text(u8'��� �����:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##6', ActiveRN, tLastKeys, 100) then
                        rkeys.changeHotKey(bindRN, ActiveRN.v)
                        config.HotKeys.RN = encodeJson(ActiveRN.v) saveJson()
                    end
                    imgui.Text(u8'������:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##7', ActiveBinder, tLastKeys, 100) then
                        rkeys.changeHotKey(bindBinder, ActiveBinder.v)
                        config.HotKeys.Binder = encodeJson(ActiveBinder.v) saveJson()
                    end
                    imgui.Text(u8'�������:')
                    imgui.SameLine() imgui.SetCursorPosX(XposBinds)
                    if imgui.HotKey('##8', ActiveShpora, tLastKeys, 100) then
                        rkeys.changeHotKey(bindShpora, ActiveShpora.v)
                        config.HF041020.Shpora = encodeJson(ActiveShpora.v) saveJson()
                    end
                imgui.EndChild()
            elseif Child['SettingsKrit'] then
                local XposCB, YposFE = 95, 87
                imgui.SetCursorPosX(65)
                imgui.Combo('##SelKrit', SelKrit, arr_krit, #arr_krit)
                if SelKrit.v == 0 then
                    imgui.Text('')
                    imgui.TextRGB('� ������ ������� �� ������� �������� ��������\n������� ����� ������������ � ������������\n�� ����� ������-���� ��������', 2)
                elseif SelKrit.v == 1 then -- ��������
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedAgeCar', Krit['NeedAgeCar']) then config.HF070920.NeedAgeCar = Krit['NeedAgeCar'].v saveJson() end 
                    if Krit['NeedAgeCar'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##AgeCar', Krit['AgeCar'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.AgeCar = Krit['AgeCar'].v saveJson() end
                        if Krit['AgeCar'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedMedCar', Krit['NeedMedCar']) then config.HF070920.NeedMedCar = Krit['NeedMedCar'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedLvlCar', Krit['NeedLvlCar']) then config.HF070920.NeedLvlCar = Krit['NeedLvlCar'].v saveJson() end 
                    if Krit['NeedLvlCar'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlCar', Krit['LvlCar'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlCar = Krit['LvlCar'].v saveJson() end
                        if Krit['LvlCar'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                elseif SelKrit.v == 2 then -- ����
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedAgeMoto', Krit['NeedAgeMoto']) then config.HF070920.NeedAgeMoto = Krit['NeedAgeMoto'].v saveJson() end 
                    if Krit['NeedAgeMoto'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##AgeMoto', Krit['AgeMoto'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.AgeMoto = Krit['AgeMoto'].v saveJson() end
                        if Krit['AgeMoto'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedMedMoto', Krit['NeedMedMoto']) then config.HF070920.NeedMedMoto = Krit['NeedMedMoto'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedLvlMoto', Krit['NeedLvlMoto']) then config.HF070920.NeedLvlMoto = Krit['NeedLvlMoto'].v saveJson() end 
                    if Krit['NeedLvlMoto'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlMoto', Krit['LvlMoto'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlMoto = Krit['LvlMoto'].v saveJson() end
                        if Krit['LvlMoto'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                elseif SelKrit.v == 3 then -- ������
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedAgeAir', Krit['NeedAgeAir']) then config.HF070920.NeedAgeAir = Krit['NeedAgeAir'].v saveJson() end 
                    if Krit['NeedAgeAir'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##AgeAir', Krit['AgeAir'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.AgeAir = Krit['AgeAir'].v saveJson() end
                        if Krit['AgeAir'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedMedAir', Krit['NeedMedAir']) then config.HF070920.NeedMedAir = Krit['NeedMedAir'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedLvlAir', Krit['NeedLvlAir']) then config.HF070920.NeedLvlAir = Krit['NeedLvlAir'].v saveJson() end 
                    if Krit['NeedLvlAir'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlAir', Krit['LvlAir'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlAir = Krit['LvlAir'].v saveJson() end
                        if Krit['LvlAir'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                elseif SelKrit.v == 4 then -- ��������
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedAgeBigCar', Krit['NeedAgeBigCar']) then config.HF070920.NeedAgeBigCar = Krit['NeedAgeBigCar'].v saveJson() end 
                    if Krit['NeedAgeBigCar'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##AgeBigCar', Krit['AgeBigCar'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.AgeBigCar = Krit['AgeBigCar'].v saveJson() end
                        if Krit['AgeBigCar'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedMedBigCar', Krit['NeedMedBigCar']) then config.HF070920.NeedMedBigCar = Krit['NeedMedBigCar'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedLvlBigCar', Krit['NeedLvlBigCar']) then config.HF070920.NeedLvlBigCar = Krit['NeedLvlBigCar'].v saveJson() end 
                    if Krit['NeedLvlBigCar'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlBigCar', Krit['LvlBigCar'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlBigCar = Krit['LvlBigCar'].v saveJson() end
                        if Krit['LvlBigCar'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                elseif SelKrit.v == 5 then -- ������
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedAgeGun', Krit['NeedAgeGun']) then config.HF070920.NeedAgeGun = Krit['NeedAgeGun'].v saveJson() end 
                    if Krit['NeedAgeGun'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##AgeGun', Krit['AgeGun'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.AgeGun = Krit['AgeGun'].v saveJson() end
                        if Krit['AgeGun'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedMedGun', Krit['NeedMedGun']) then config.HF070920.NeedMedGun = Krit['NeedMedGun'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedLvlGun', Krit['NeedLvlGun']) then config.HF070920.NeedLvlGun = Krit['NeedLvlGun'].v saveJson() end 
                    if Krit['NeedLvlGun'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlGun', Krit['LvlGun'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlGun = Krit['LvlGun'].v saveJson() end
                        if Krit['LvlGun'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end imgui.Text('')
                    imgui.Text(u8'��������� ��������:') imgui.SameLine() imgui.SetCursorPosX(XposCB+68) imgui.PushItemWidth(55)
                    if imgui.InputText('', Krit['GunPrice'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.GunPrice = Krit['GunPrice'].v saveJson() end
                    imgui.Text(u8'���������� ���� ��� �������:') imgui.SameLine()
                    if imgui.Checkbox('##GunPriceSend', Krit['GunPriceSend']) then config.HF070920.GunPriceSend = Krit['GunPriceSend'].v saveJson() end
                    if Krit['GunPrice'].v == '' and Krit['GunPriceSend'].v then
                        imgui.SameLine()
                        imgui.TextWarning(u8'�� �� ��������� ����� � �����')
                    end
                elseif SelKrit.v == 6 then -- ������
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedAgeWater', Krit['NeedAgeWater']) then config.HF070920.NeedAgeWater = Krit['NeedAgeWater'].v saveJson() end 
                    if Krit['NeedAgeWater'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##AgeWater', Krit['AgeWater'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.AgeWater = Krit['AgeWater'].v saveJson() end
                        if Krit['AgeWater'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedMedWater', Krit['NeedMedWater']) then config.HF070920.NeedMedWater = Krit['NeedMedWater'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedLvlWater', Krit['NeedLvlWater']) then config.HF070920.NeedLvlWater = Krit['NeedLvlWater'].v saveJson() end 
                    if Krit['NeedLvlWater'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlWater', Krit['LvlWater'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlWater = Krit['LvlWater'].v saveJson() end
                        if Krit['LvlWater'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end imgui.Text('')
                    imgui.Text(u8'��������� ��������:') imgui.SameLine() imgui.SetCursorPosX(XposCB+68) imgui.PushItemWidth(55)
                    if imgui.InputText('', Krit['WaterPrice'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.WaterPrice = Krit['WaterPrice'].v saveJson() end
                    imgui.Text(u8'���������� ���� ��� �������:') imgui.SameLine()
                    if imgui.Checkbox('##WaterPriceSend', Krit['WaterPriceSend']) then config.HF070920.WaterPriceSend = Krit['WaterPriceSend'].v saveJson() end
                    if Krit['WaterPrice'].v == '' and Krit['WaterPriceSend'].v then
                        imgui.SameLine()
                        imgui.TextWarning(u8'�� �� ��������� ����� � �����')
                    end
                elseif SelKrit.v == 7 then -- ���������
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedAgeInsur', Krit['NeedAgeInsur']) then config.HF070920.NeedAgeInsur = Krit['NeedAgeInsur'].v saveJson() end 
                    if Krit['NeedAgeInsur'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##AgeInsur', Krit['AgeInsur'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.AgeInsur = Krit['AgeInsur'].v saveJson() end
                        if Krit['AgeInsur'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedMedInsur', Krit['NeedMedInsur']) then config.HF070920.NeedMedInsur = Krit['NeedMedInsur'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB)
                    if imgui.Checkbox('##NeedLvlInsur', Krit['NeedLvlInsur']) then config.HF070920.NeedLvl = Krit['NeedLvlInsur'].v saveJson() end 
                    if Krit['NeedLvlInsur'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlInsur', Krit['LvlInsur'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlInsur = Krit['LvlInsur'].v saveJson() end
                        if Krit['LvlInsur'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                elseif SelKrit.v == 8 then -- ������
                    imgui.Text('')
                    imgui.TextRGB('�������� ����������� ��������:', 2)
                    imgui.SetCursorPosY(YposFE)
                    imgui.Text(u8'�����������������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB+40)
                    if imgui.Checkbox('##NeedZakon', Krit['NeedZakon']) then config.HF070920.NeedZakon = Krit['NeedZakon'].v saveJson() end 
                    if Krit['NeedZakon'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##Zakon', Krit['Zakon'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.Zakon = Krit['Zakon'].v saveJson() end
                        if Krit['Zakon'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                    imgui.Text('')
                    imgui.Text(u8'���. ������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB+40)
                    if imgui.Checkbox('##NeedMedInv', Krit['NeedMedInv']) then config.HF070920.NeedMedInv = Krit['NeedMedInv'].v saveJson() end 
                    imgui.Text('')
                    imgui.Text(u8'�������: ') imgui.SameLine() imgui.SetCursorPosX(XposCB+40)
                    if imgui.Checkbox('##NeedLvlInv', Krit['NeedLvlInv']) then config.HF070920.NeedLvlInv = Krit['NeedLvlInv'].v saveJson() end 
                    if Krit['NeedLvlInv'].v then
                        imgui.SameLine()
                        imgui.PushItemWidth(30)
                        if imgui.InputText(u8'##LvlInv', Krit['LvlInv'], imgui.InputTextFlags.CharsDecimal) then config.HF070920.LvlInv = Krit['LvlInv'].v saveJson() end
                        if Krit['LvlInv'].v == '' then
                            imgui.SameLine()
                            imgui.TextWarning(u8'�� �� ��������� ������ �����')
                        end
                    end
                end
            elseif Child['Support'] then
                imgui.TextRGB('����� ������� - {FFFF00}Banana Blackstone', 2)
                imgui.TextRGB('������� �� ������ - {FF8000}Lance Connors', 2)
                imgui.TextRGB('                                       {00FF40}Curtis Blackstone', 2)
                imgui.Text('') imgui.Text('')
                imgui.TextRGB('������ {01DF01}Emerald', 2)

                if update_state then
                    imgui.SetCursorPos(imgui.ImVec2(128, 130))
                    imgui.TextRGB('�������� ����� ������ ������� - '..updateini.script.version_text, 2)
                end 
                imgui.SetCursorPos(imgui.ImVec2(98, 150))
                if imgui.Button(u8'��������� ������� ����������', imgui.ImVec2(200, 25)) then
                    downloadUrlToFile(update_url, update_path, function(id, status)
                        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                            if doesFileExist(getWorkingDirectory() .. '/ASA config/ASAupdate.ini') then
                                updateini = inicfg.load(nil, update_path)
                                if tonumber(updateini.script.version) > script_vers and not Toggle['AutoUpdate'].v then
                                    sampAddChatMessage(tag_text..' �������� {58ACFA}����� ������ {FFFFFF}�������', tag_clr)
                                    sampAddChatMessage(tag_text..' ����� �������� ������, {58ACFA}������� �� ������{FFFFFF} � ������� ��������', tag_clr)
                                    update_btn = true
                                    update_state = true
                                else
                                    sampAddChatMessage(tag_text..' ���������� {58ACFA}�� �������', tag_clr)
                                end
                                os.remove(update_path)
                            end
                        end
                    end)
                end
                if update_btn then
                    imgui.SameLine()
                    if imgui.Button(fa.ICON_DOWNLOAD, imgui.ImVec2(25, 25)) then
                        downloadUrlToFile(script_url, script_path, function(id, status)
                            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                sampAddChatMessage(tag_text..' ������ {58ACFA}������� {FFFFFF}��������', tag_clr)
                                thisScript():reload()
                            end
                        end)
                    end
                end imgui.SetCursorPosX(128)
                if imgui.Button(u8'��������� ���������', imgui.ImVec2(140, 25)) then Window['Latest_Update'].v = not Window['Latest_Update'].v imgui.Process = Window['Latest_Update'].v or Window['Main'].v or Window['Target'].v or Window['Binder'].v or Window['FAQ'].v end imgui.SetCursorPosX(105)
                if imgui.ToggleButton(u8'��������� �������������', Toggle['AutoUpdate']) then
                    config.Settings.AutoUpdate = Toggle['AutoUpdate'].v saveJson()
                end
                imgui.SetCursorPosY(327)
                imgui.TextRGB('������ ������� - {58ACFA}'..script_vers_text, 3)
                imgui.SetCursorPosY(300)
                imgui.TextRGB('����� � �������:') imgui.SetCursorPosX(11)
                if imgui.ButtonHint(u8'����������� ������ �� ������', fa.ICON_VK..'##SayVK', 0.2) then setClipboardText('vk.com/id241807403') 
                    clipcompil = true
                end imgui.SameLine()
                if imgui.ButtonHint(u8'����������� ������ �������� ������', fa.ICON_SIMPLYBUILT..'##SayDS', 0.2) then setClipboardText('banan4eg#5464') 
                    clipcompil = true
                end imgui.SameLine()
                if imgui.ButtonHint(u8'����������� ������ �� ����', fa.ICON_DIAMOND..'##SayDF', 0.2) then setClipboardText('forum.diamondrp.ru/threads/lua-autoschool-assist-pomoschnik-dlja-sotrudnikov-lc.1029624/') 
                    clipcompil = true
                end
                if clipcompil then imgui.SetCursorPos(imgui.ImVec2(106, 319)) lua_thread.create(function()
                imgui.TextRGB('������ �����������!') wait(1000) clipcompil = false end) end
            elseif Child['Visual'] then
                imgui.TextRGB('���� �������', 2)
                for i, value in pairs(themeitems) do
                    if i == 1 or i == 3 or i == 5 or i == 7 or i == 9 or i == 11 or i == 13 or i == 15 then
                        imgui.SetCursorPosX(80)
                        if imgui.RadioButton(value, Theme, i) then 
                            config.HF041020.Theme = Theme.v saveJson()
                        end
                    elseif i == 17 then
                        imgui.SetCursorPosX(130)
                        if imgui.RadioButton(value, Theme, i) then 
                            config.HF041020.Theme = Theme.v saveJson()
                        end
                    else
                        imgui.SameLine() imgui.SetCursorPosX(210)
                        if imgui.RadioButton(value, Theme, i) then 
                            config.HF041020.Theme = Theme.v saveJson()
                        end
                    end
                end imgui.Text('') imgui.Separator()
                imgui.TextRGB('����� ���������', 2) imgui.SetCursorPosX(115)
                if imgui.RadioButton(u8'�������', Style, 1) then config.HF041020.Style = Style.v saveJson() end imgui.SameLine()
                if imgui.RadioButton(u8'������', Style, 2) then config.HF041020.Style = Style.v saveJson() end
                --imgui.SetCursorPosX(100) imgui.VerticalSeparator()
            elseif not Child['InterviewM'] and not Child['Leader'] and not Child['Lekcii'] and not Child['SettingsMain'] and not Child['Support'] and not Child['SettingsKrit'] and not Child['Visual'] then
                imgui.SetCursorPos(imgui.ImVec2(-30,30))
                imgui.Image(logo, imgui.ImVec2(450, 240), imgui.ImVec2(0,0), imgui.ImVec2(1,1), imgui.ImVec4(1, 1, 1, 1))
            end
            


            imgui.EndChild()


        imgui.End()
    end

    if Window['Target'].v then
        local targNick = sampGetPlayerNickname(tid)
        targrpnick = string.gsub(sampGetPlayerNickname(tid), "_", " ")
		imgui.SetNextWindowSize(imgui.ImVec2(271, 339), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2+300, sh/2+110), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8'�������� � '..targNick..'['..tid..']##2', Window['Target'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
            local Xbm, Ybm, Xleft = 123, 25, 10 --X 120
            imgui.SetCursorPos(imgui.ImVec2(Xleft, 25))
            if imgui.Button(u8'�������', imgui.ImVec2(Xbm, Ybm)) then Child['Exam'] = not Child['Exam'] Child['Work'] = false end
            imgui.SameLine()
            if imgui.Button(u8'���������', imgui.ImVec2(Xbm, Ybm)) then Child['Work'] = not Child['Work'] Child['Exam'] = false end

                imgui.SetCursorPosY(55)
                imgui.BeginChild('Settings2', imgui.ImVec2(261,275), true)
                if Child['Exam'] then
                    imgui.Text(u8'�������� ��������:') imgui.Separator()
                    local Xsb, Ysb, Xleft2 = 240, 25, 12
                    imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'�������� ���������', imgui.ImVec2(Xsb,Ysb)) then
                        carExam()
                    end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'��������� ���������', imgui.ImVec2(Xsb,Ysb)) then
                        airExam()
                    end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'�������������', imgui.ImVec2(Xsb,Ysb)) then
                        motoExam()
                    end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'�������� �������', imgui.ImVec2(Xsb,Ysb)) then
                        bigcarExam()
                    end 
                    imgui.Text('') imgui.Separator() imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'�������� �� ������', imgui.ImVec2(Xsb,Ysb)) then
                        SellLic(2)
                    end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'�������� �� ������ ���������', imgui.ImVec2(Xsb,Ysb)) then
                        SellLic(1)
                    end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'���������', imgui.ImVec2(Xsb,Ysb)) then
                        sellinsurance()
                    end
                elseif Child['Work'] then
                    local Xbl2, Ybl2, Xleft2 = 240, 25, 12
                    imgui.SetCursorPos(imgui.ImVec2(Xleft2, 10))
                    if imgui.Button(u8'���������', imgui.ImVec2(Xbl2, Ybl2)) then rangup(1) end  imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'������ ����', imgui.ImVec2(Xbl2, Ybl2)) then giveskin(1) end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'�������', imgui.ImVec2(Xbl2, Ybl2)) then givewarn(1) end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'������ ��������', imgui.ImVec2(Xbl2, Ybl2)) then takeoffwarn(1) end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'����������', imgui.ImVec2(Xbl2, Ybl2)) then uninvite(1) end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'��������� � ��', imgui.ImVec2(Xbl2, Ybl2)) then gobl(1) end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'��������� �� ��', imgui.ImVec2(Xbl2, Ybl2)) then backbl(1) end imgui.SetCursorPosX(Xleft2)
                    if imgui.Button(u8'������� �������� (/invite)', imgui.ImVec2(Xbl2, Ybl2)) then inviteFunc(3) end
                    --imgui.Separator()
                    --if imgui.Button(u8'������ �������������', imgui.ImVec2(Xbl2, Ybl2)) then Interview() end
                elseif not Child['Exam'] and not Child['Work'] then
                    Child['Exam'] = true
                end
                imgui.EndChild()
        imgui.End()
    else
        if not RunCarExamSt and not RunAirExamSt and not RunMotoExamSt and not RunBigCarExamSt and Toggle['BlipState'].v then
            removeBlip(targ_bl)
        end
    end

    if Window['Binder'].v then
		imgui.SetNextWindowSize(imgui.ImVec2(609, 502), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2-70, sh/2+131), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8'License Center Assistant | ������##3', Window['Binder'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
        imgui.SetCursorPos(imgui.ImVec2(3, 18))
            imgui.BeginChild('Binder', imgui.ImVec2(603, 485), true, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
                imgui.SetCursorPos(imgui.ImVec2(0,0))
                imgui.BeginChild('LeftBinderType', imgui.ImVec2(130, 68), true)
                    imgui.SetCursorPosY(4) imgui.TextRGB('���', 2) imgui.SetCursorPosX(7) imgui.PushItemWidth(118)
                    if imgui.Combo('##BinderType', BinderType, u8'������\0�������\0\0', 2) then end
                imgui.EndChild()
                imgui.SetCursorPos(imgui.ImVec2(0,45))
                imgui.BeginChild('LeftBinderUp', imgui.ImVec2(130, 23), true)
                    imgui.SetCursorPosY(4) imgui.TextRGB(' � |        ����')
                imgui.EndChild() imgui.SetCursorPos(imgui.ImVec2(0,67))

                imgui.BeginChild('LeftBinderMiddle', imgui.ImVec2(130, 405), true)
                if BinderType.v == 0 then
                    for i = 1, #Binder do
                        if i <= 9 then imgui.Text(' '..i..'  |') imgui.SameLine() else imgui.Text(i..' |') imgui.SameLine() end
                        if (Binder[i].caption == '' or Binder[i].caption == nil) and Binder[i].command == '' and Binder[i].text == '' then 
                            BindCapt = u8'       �����' 
                        elseif Binder[i].caption == '' or Binder[i].caption == nil and (Binder[i].command ~= '' or Binder[i].text ~= '') then
                            BindCapt = u8'     �� ������' 
                        elseif Binder[i].caption ~= '' or Binder[i].caption ~= nil then
                            BindCapt = Binder[i].caption 
                        end
                        if imgui.Selectable(BindCapt..'##bind'..i, false, imgui.SelectableFlags.AllowDoubleClick) then
                            if (imgui.IsMouseDoubleClicked(0)) then
                                for z = 1, #Binder do
                                    SelectBind[z] = false
                                end
                                SelectBind[i] = true
                                BinderInfo = false
                            end
                        end
                    end
                elseif BinderType.v == 1 then
                    for i = 1, #Notepad do
                        if i <= 9 then imgui.Text(' '..i..'  |') imgui.SameLine() else imgui.Text(i..' |') imgui.SameLine() end
                        if (Notepad[i].title == '' or Notepad[i].title == nil) and Notepad[i].text == '' then 
                            NoteCapt = u8'       �����' 
                        elseif Notepad[i].title == '' or Notepad[i].title == nil and Notepad[i].text ~= '' then
                            NoteCapt = u8'     �� ������' 
                        elseif Notepad[i].title ~= '' or Notepad[i].title ~= nil then
                            NoteCapt = Notepad[i].title 
                        end
                        if imgui.Selectable(NoteCapt..'##shpora'..i, false, imgui.SelectableFlags.AllowDoubleClick) then
                            if (imgui.IsMouseDoubleClicked(0)) then
                                for z = 1, #Notepad do
                                    SelectNote[z] = false
                                end
                                SelectNote[i] = true
                                BinderInfo = false
                            end
                        end
                    end
                end
                imgui.EndChild() imgui.SetCursorPos(imgui.ImVec2(0,449))

                imgui.BeginChild('LeftBinderDown', imgui.ImVec2(130, 36), true)
                imgui.SetCursorPos(imgui.ImVec2(8, 6))
                if BinderType.v == 0 then
                    if imgui.Button(fa.ICON_PLUS_CIRCLE..'##AddBinder', imgui.ImVec2(56,25)) then
                        for i = 1, #Binder do 
                            if SelectBind[i] then SelectBind[i] = false end
                        end
                        table.insert(Binder, {caption = '', command = '', text = '', v = {}}) saveJsonB()
                        BinderInfo = true
                    end imgui.SameLine()
                    if imgui.Button(fa.ICON_MINUS_CIRCLE..'##SubBinder', imgui.ImVec2(56,25)) then 
                        for i = 1, #Binder do 
                            if SelectBind[i] then SelectBind[i] = false end
                        end
                        table.remove(Binder, #Binder) saveJsonB()
                        BinderInfo = true
                    end
                elseif BinderType.v == 1 then
                    if imgui.Button(fa.ICON_PLUS_CIRCLE..'##AddShpora', imgui.ImVec2(56,25)) then
                        for i = 1, #Notepad do 
                            if SelectNote[i] then SelectNote[i] = false end
                        end
                        table.insert(Notepad, {title = '', text = '', state = true}) saveJsonS()
                        BinderInfo = true
                    end imgui.SameLine()
                    if imgui.Button(fa.ICON_MINUS_CIRCLE..'##SubShpora', imgui.ImVec2(56,25)) then 
                        for i = 1, #Notepad do 
                            if SelectNote[i] then SelectNote[i] = false end
                        end
                        table.remove(Notepad, #Notepad) saveJsonS()
                        BinderInfo = true
                    end
                end
                imgui.EndChild() imgui.SetCursorPos(imgui.ImVec2(129,0))

                imgui.BeginChild('RightBinder', imgui.ImVec2(473, 485), true, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
                    if BinderType.v == 0 then
                        for k, v in pairs(Binder) do
                            if SelectBind[k] then
                                for i = 1, #Notepad do 
                                    if SelectNote[i] then SelectNote[i] = false end
                                end
                                imgui.SetCursorPosY(4)
                                imgui.TextRGB('�������������� ����� �'..k, 2) imgui.SetCursorPosY(23)
                                imgui.Separator() imgui.SetCursorPos(imgui.ImVec2(447,2))
                                if imgui.Button(fa.ICON_TIMES..'##'..k) then SelectBind[k] = false BinderInfo = true end imgui.SetCursorPos(imgui.ImVec2(379,30))
                                if imgui.Button(u8'������� ����') then
                                    imgui.OpenPopup('DeleteSure'..k)
                                end
                                if imgui.BeginPopup('DeleteSure'..k) then
                                    imgui.TextRGB('�� ������� ��� ������ ������� ������ ����', 2)
                                    if imgui.Button(u8'  ������  ') then
                                        imgui.CloseCurrentPopup()
                                    end imgui.SameLine() imgui.Text('                                ') imgui.SameLine()
                                    if imgui.Button(u8'��, ������##'..k) then
                                        for i = 1, #Binder do 
                                            if SelectBind[i] then SelectBind[i] = false end
                                        end
                                        table.remove(Binder, k) saveJsonB()
                                        BinderInfo = true
                                        imgui.CloseCurrentPopup()
                                    end 
                                imgui.EndPopup()
                                end imgui.SetCursorPosY(30)
                                imgui.Text(u8'���������:') imgui.SameLine() imgui.PushItemWidth(130) imgui.SetCursorPosX(135)
                                if imgui.InputText(u8'##Title'..k, BindCaption[k]) then
                                    Binder[k].caption = BindCaption[k].v saveJsonB()
                                end
                                imgui.Text(u8'������� ���������:') imgui.SameLine() imgui.PushItemWidth(130) imgui.SetCursorPosX(135)
                                if imgui.InputText(u8'##Command'..k, BindCommand[k], imgui.InputTextFlags.EnterReturnsTrue) then
                                    if isCommandDouble(BindCommand[k].v) then
                                        sampAddChatMessage(tag_text..' ������� ��������� {58ACFA}��� ������{FFFFFF}, ���������� ������', tag_clr)
                                    elseif not isCommandDouble(BindCommand[k].v) and BindCommand[k].v == '' then
                                        sampAddChatMessage(tag_text..' ������� {58ACFA}�������{FFFFFF} �������', tag_clr)
                                        Binder[k].command = BindCommand[k].v saveJsonB()
                                    else
                                        sampAddChatMessage(tag_text..' ������� {58ACFA}�������{FFFFFF} ���������', tag_clr)
                                        Binder[k].command = BindCommand[k].v saveJsonB()
                                    end
                                end imgui.SameLine()
                                imgui.TextQuestion(u8'����� ��������� �������, ������� Enter.', 0.4)
                                imgui.Text(u8'������� ���������:') imgui.SameLine() imgui.SetCursorPosX(135)
                                if imgui.HotKey("##BindKey"..k, v, tLastKeys, 130) then
                                    if not rkeys.isHotKeyDefined(v.v) then
                                        if rkeys.isHotKeyDefined(tLastKeys.v) then
                                            rkeys.unRegisterHotKey(tLastKeys.v)
                                        end
                                        rkeys.registerHotKey(v.v, true, onHotKey)
                                        saveJsonB()
                                    end
                                end imgui.SetCursorPosY(103)
                                if imgui.InputTextMultiline(u8'##BindText'..k, BindText[k], imgui.ImVec2(467, 378)) then
                                    Binder[k].text = BindText[k].v saveJsonB()
                                end
                                imgui.SetCursorPos(imgui.ImVec2(368,83))
                                imgui.Text(u8'HTML �����')
                                imgui.SameLine() imgui.SetCursorPos(imgui.ImVec2(441,73))
                                if imgui.Button(fa.ICON_TINT, imgui.ImVec2(25,25)) then
                                    imgui.OpenPopup('HTML colors')
                                end
                                if imgui.BeginPopup('HTML colors') then
                                    imgui.ColorPicker3('HTML CE3', coled, imgui.ColorEditFlags.NoSidePreview + imgui.ColorEditFlags.NoLabel + imgui.ColorEditFlags.NoSmallPreview + imgui.ColorEditFlags.HEX)
                                    if imgui.Button(u8'����������� � ������', imgui.ImVec2(223,23)) then 
                                        colorM = join_argb(0, coled.v[1] * 255, coled.v[2] * 255, coled.v[3] * 255)
                                        if colorM ~= nil then
                                            local r1, r2, g1, g2, b1, b2 = string.match(('%X'):format(colorM), '(.)(.)(.)(.)(.)(.)')
                                            if r1 == nil then r1 = '0' end if r2 == nil then r2 = '0' end
                                            if g1 == nil then g1 = '0' end if g2 == nil then g2 = '0' end
                                            if b1 == nil then b1 = '0' end if b2 == nil then b2 = '0' end
                                            setClipboardText('{'..r1..r2..g1..g2..b1..b2..'}')
                                        end
                                    end
                                imgui.EndPopup()
                                end
                            end
                        end
                    elseif BinderType.v == 1 then
                        for k, v in pairs(Notepad) do
                            if SelectNote[k] then
                                for i = 1, #Binder do 
                                    if SelectBind[i] then SelectBind[i] = false end
                                end
                                imgui.SetCursorPosY(4)
                                imgui.TextRGB('�������������� ����� �'..k, 2) imgui.SetCursorPosY(23)
                                imgui.Separator() imgui.SetCursorPos(imgui.ImVec2(447,2))
                                if imgui.Button(fa.ICON_TIMES..'##'..k) then SelectNote[k] = false BinderInfo = true end imgui.SetCursorPos(imgui.ImVec2(379,30))
                                if NotepadST[k].v then
                                if imgui.Button(u8'������� ����') then
                                    imgui.OpenPopup('DeleteSure'..k)
                                end
                                if imgui.BeginPopup('DeleteSure'..k) then
                                    imgui.TextRGB('�� ������� ��� ������ ������� ������ ����', 2)
                                    if imgui.Button(u8'  ������  ') then
                                        imgui.CloseCurrentPopup()
                                    end imgui.SameLine() imgui.Text('                                ') imgui.SameLine()
                                    if imgui.Button(u8'��, ������##'..k) then
                                        for i = 1, #Notepad do 
                                            if SelectNote[i] then SelectNote[i] = false end
                                        end
                                        table.remove(Notepad, k) saveJsonS()
                                        BinderInfo = true
                                        imgui.CloseCurrentPopup()
                                    end 
                                imgui.EndPopup()
                                end end imgui.SetCursorPos(imgui.ImVec2(5,30))
                                imgui.Text(u8'������:') imgui.SameLine() imgui.SetCursorPosX(80) imgui.Text(u8'��������') imgui.SameLine()
                                if imgui.ToggleButton(u8'�������������', NotepadST[k]) then Notepad[k].state = NotepadST[k].v saveJsonS() end
                                if NotepadST[k].v then 
                                    imgui.SetCursorPosY(58) imgui.Text(u8'���������:') imgui.SameLine() imgui.PushItemWidth(130) imgui.SetCursorPosX(80)
                                    if imgui.InputText(u8'##Title'..k, NotepadTitle[k]) then
                                        Notepad[k].title = NotepadTitle[k].v saveJsonS()
                                    end
                                    imgui.SetCursorPosY(81)
                                    if imgui.InputTextMultiline('##NotepadTextText'..k, NotepadText[k], imgui.ImVec2(467, 400)) then
                                        Notepad[k].text = NotepadText[k].v saveJsonB()
                                    end
                                    imgui.SetCursorPos(imgui.ImVec2(368,61))
                                    imgui.Text(u8'HTML �����')
                                    imgui.SameLine() imgui.SetCursorPos(imgui.ImVec2(441,53))
                                    if imgui.Button(fa.ICON_TINT, imgui.ImVec2(25,25)) then
                                        imgui.OpenPopup('HTML colors')
                                    end
                                    if imgui.BeginPopup('HTML colors') then
                                        imgui.ColorPicker3('HTML CE3', coled, imgui.ColorEditFlags.NoSidePreview + imgui.ColorEditFlags.NoLabel + imgui.ColorEditFlags.NoSmallPreview + imgui.ColorEditFlags.HEX)
                                        if imgui.Button(u8'����������� � ������', imgui.ImVec2(223,23)) then 
                                            colorM = join_argb(0, coled.v[1] * 255, coled.v[2] * 255, coled.v[3] * 255)
                                            if colorM ~= nil then
                                                local r1, r2, g1, g2, b1, b2 = string.match(('%X'):format(colorM), '(.)(.)(.)(.)(.)(.)')
                                                if r1 == nil then r1 = '0' end if r2 == nil then r2 = '0' end
                                                if g1 == nil then g1 = '0' end if g2 == nil then g2 = '0' end
                                                if b1 == nil then b1 = '0' end if b2 == nil then b2 = '0' end
                                                setClipboardText('{'..r1..r2..g1..g2..b1..b2..'}')
                                            end
                                        end
                                    imgui.EndPopup()
                                end
                                end
                                if not NotepadST[k].v then
                                    imgui.SetCursorPos(imgui.ImVec2(0,48))
                                    imgui.BeginChild('SeeShpora'..k, imgui.ImVec2(472, 436), true)
                                        for str in u8:decode(Notepad[k].text):gmatch('[^\n\r]+') do
                                            if str:find('^/n') then
                                                imgui.Text('')
                                            elseif str:find('@Center:(.*)%/n') then
                                                local str1 = str:match('@Center:(.*)%/n')
                                                imgui.TextRGBcopy(str1, 2)
                                                imgui.Text('')
                                            elseif str:find('@Right:(.*)%/n') then
                                                local str1 = str:match('@Right:(.*)%/n')
                                                imgui.TextRGBcopy(str1, 3)
                                                imgui.Text('')
                                            elseif str:find('.*/n') then
                                                if not TextCentr and not TextRight then
                                                    local str1 = str:match('(.*)/n')
                                                    imgui.TextRGBcopy(str1)
                                                    imgui.Text('')
                                                elseif TextCentr then
                                                    local str1 = str:match('(.*)/n')
                                                    imgui.TextRGBcopy(str1, 2)
                                                    imgui.Text('')
                                                elseif TextRight then
                                                    local str1 = str:match('(.*)/n')
                                                    imgui.TextRGBcopy(str1, 3)
                                                    imgui.Text('')
                                                end
                                            elseif str:find('@Right:.*') then
                                                local str1 = str:match('@Right:(.*)')
                                                imgui.TextRGBcopy(str1, 3)
                                            elseif str:find('@Center:.*') then
                                                local str1 = str:match('@Center:(.*)')
                                                imgui.TextRGBcopy(str1, 2)
                                            elseif str:find('%[/cStart%]') then
                                                TextCentr = true
                                            elseif str:find('%[/cEnd%]') then
                                                TextCentr = false
                                            elseif str:find('%[/rStart%]') then
                                                TextRight = true
                                            elseif str:find('%[/rEnd%]') then
                                                TextRight = false
                                            elseif TextCentr then
                                                imgui.TextRGBcopy(str, 2)
                                            elseif TextRight then
                                                imgui.TextRGBcopy(str, 3)
                                            else
                                                imgui.TextRGBcopy(str)
                                            end --
                                        end
                                    imgui.EndChild()
                                end
                            end
                        end
                    end
                if BinderInfo and BinderType.v == 0 then
                    imgui.SetCursorPos(imgui.ImVec2(7, 7))
                    imgui.TextRGB('������ ������ ������� �� �������� ������\n�� �������� � ������� �������� ����:', 2) imgui.Text('')
                    imgui.TextRGB('{58ACFA}@wait{FFFFFF} - ������� �����, ��� ������� ����� ����� ��� ���������� �����\n             {FF8000}������: {58ACFA}@wait1000{FFFFFF} (1000 - 1 ���)')
                    imgui.Separator()
                    imgui.TextRGB('{58ACFA}@local:{FFFFFF} - ������ �������, ���������� ��������� � ��������� ��� � �����\n             ������ ��� (������������ HTML �����)\n             {FF8000}������: {58ACFA}@local:') imgui.SameLine() imgui.SetCursorPosX(150) imgui.Text(u8'���� ����� ������� {FF0000}������ ��')
                    imgui.Separator()
                    imgui.TextRGB('{58ACFA}@nsent{FFFFFF} - ������ ������� ������� � ����� ��������� � ��������� ��\n             ���������� ��� ����� � ���\n{FF8000}����������:{FFFFFF} ��� ������� ��������� {58ACFA}��������{FFFFFF} �� ������� � ������ ������\n             {FF8000}������:{FFFFFF} /pass {58ACFA}@nsent')
                    imgui.Separator()
                    imgui.TextRGB('{58ACFA}@screen{FFFFFF} - ������ ������� ������ �������� ���� � ������� ����� �����\n             {FF8000}������: {58ACFA}@screen')
                    imgui.Separator()
                    imgui.TextRGB('{58ACFA}{my_id}{FFFFFF} - ����� ��� id � ���������\n             {FF8000}������:{FFFFFF} ��� id - {58ACFA}{my_id}')
                    imgui.Separator()
                    imgui.TextRGB('{58ACFA}{my_nick}{FFFFFF} - ����� ��� Nick Name (��� "_") � ���������\n             {FF8000}������:{FFFFFF} ��� ��� - {58ACFA}{my_nick}')
                    imgui.Separator()
                    imgui.Text('')
                    imgui.TextRGB('�� {58ACFA}������ ������{FFFFFF} ��� ��� ������� ������� ������������ ���� ������.', 2)
                    imgui.Text('')
                    imgui.TextRGB('��������� ����� ����� ���� ��������� ��� {58ACFA}�� �������{FFFFFF}\n��� � �� {58ACFA}�������{FFFFFF} ��� {58ACFA}��������� ������', 2)
                elseif BinderInfo and BinderType.v == 1 then
                    imgui.SetCursorPos(imgui.ImVec2(7, 7))
                    imgui.TextRGB('�� ������� ��������� {58ACFA}������������ {FFFFFF}� {58ACFA}���� ������.', 2) imgui.Text('')
                    imgui.TextRGB('��� ��������� ����� ������ ������������ HTML/HEX ����.\n             {FF8000}������:') imgui.SameLine()
                    imgui.Text(u8'���� ����� ����� {FF0000}') imgui.SameLine() imgui.TextRGB('{FF0000}�����������') imgui.Separator()
                    imgui.TextRGB('{58ACFA}/n {FFFFFF}- ������ ������� ������� ������ ������, ������� �� ������ ������ ������\n���� � ����� ������, ����� ������� ����� ������ ������.') imgui.Separator()
                    imgui.TextRGB('{58ACFA}[/cStart] {FFFFFF}� {58ACFA}[/cEnd] {FFFFFF}- ������������ � ����, � ������ ��� ������������\n ���������� ����� ������ �� ������. {FF8000}������:')
                    imgui.Text('[/cStart]') imgui.TextRGB('���� �����\n������������� �� ������', 2) imgui.Text('[/cEnd]') imgui.Separator()
                    imgui.TextRGB('{58ACFA}@Center:{FFFFFF} - ������ ������� ����������� ���� ������ �� ������\n             {FF8000}������: {58ACFA}@Center:{FFFFFF}����� �� ������') imgui.Separator()
                    imgui.TextRGB('{58ACFA}[/rStart] {FFFFFF}� {58ACFA}[/rEnd] {FFFFFF}- ������������ � ����, � ������ ��� ������������\n ���������� ����� ������ �� ������� ����. {FF8000}������:')
                    imgui.Text('[/rStart]') imgui.TextRGB('���� �����\n������������� �� ������� ����', 3) imgui.Text('[/rEnd]') imgui.Separator()
                    imgui.TextRGB('{58ACFA}@Right:{FFFFFF} - ������ ������� ����������� ���� ������ �� ������� ����\n             {FF8000}������: {58ACFA}@Right:{FFFFFF}����� �� ������� ����') imgui.Separator()
                    imgui.TextRGB('��� �� ����������� {58ACFA}����������� {FFFFFF}������, {58ACFA}������ �� ����\n{FFFFFF}������ ������� �� ������ � ����� ����� � ������� ������.', 2) imgui.SetCursorPosX(150)
                    if imgui.Button(u8'������ ��������������') then imgui.OpenPopup('ExampleNote') end
                    if imgui.BeginPopup('ExampleNote') then
                        imgui.TextRGB('��������������', 2)
                        imgui.InputTextMultiline('##ExampleNote', ExampleNote, imgui.ImVec2(467, 200)) imgui.Separator()
                        imgui.TextRGB('��������', 2)
                        imgui.BeginChild('ExampleNote', imgui.ImVec2(467, 200), true)
                            for str in u8:decode(ExampleNote.v):gmatch('[^\n\r]+') do
                                if str:find('^/n') then
                                    imgui.Text('')
                                elseif str:find('@Center:(.*)%/n') then
                                    local str1 = str:match('@Center:(.*)%/n')
                                    imgui.TextRGBcopy(str1, 2)
                                    imgui.Text('')
                                elseif str:find('@Right:(.*)%/n') then
                                    local str1 = str:match('@Right:(.*)%/n')
                                    imgui.TextRGBcopy(str1, 3)
                                    imgui.Text('')
                                elseif str:find('.*/n') then
                                    if not TextCentr and not TextRight then
                                        local str1 = str:match('(.*)/n')
                                        imgui.TextRGBcopy(str1)
                                        imgui.Text('')
                                    elseif TextCentr then
                                        local str1 = str:match('(.*)/n')
                                        imgui.TextRGBcopy(str1, 2)
                                        imgui.Text('')
                                    elseif TextRight then
                                        local str1 = str:match('(.*)/n')
                                        imgui.TextRGBcopy(str1, 3)
                                        imgui.Text('')
                                    end
                                elseif str:find('@Right:.*') then
                                    local str1 = str:match('@Right:(.*)')
                                    imgui.TextRGBcopy(str1, 3)
                                elseif str:find('@Center:.*') then
                                    local str1 = str:match('@Center:(.*)')
                                    imgui.TextRGBcopy(str1, 2)
                                elseif str:find('%[/cStart%]') then
                                    TextCentr = true
                                elseif str:find('%[/cEnd%]') then
                                    TextCentr = false
                                elseif str:find('%[/rStart%]') then
                                    TextRight = true
                                elseif str:find('%[/rEnd%]') then
                                    TextRight = false
                                elseif TextCentr then
                                    imgui.TextRGBcopy(str, 2)
                                elseif TextRight then
                                    imgui.TextRGBcopy(str, 3)
                                else
                                    imgui.TextRGBcopy(str)
                                end --
                            end
                        imgui.EndChild()
                        imgui.EndPopup()
                    end
                end
                imgui.EndChild()
            imgui.EndChild()
        imgui.End()
    end

    if Window['Latest_Update'].v then
        imgui.SetNextWindowSize(imgui.ImVec2(617, 523), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2-70, sh/2+131), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8'License Center Assistant: ��������� ���������##4', Window['Latest_Update'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
            imgui.BeginChild('Latest Update', imgui.ImVec2(609,500), true)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}06.09.2020 (1.03)\n{FF8000}[1]{FFFFFF} ���������� ������� ����-����������.\n� ��� ����������� ����-���������� �� ������ ���� ������ �������.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}07.09.2020 (1.04)\n{FF8000}[1]{FFFFFF} ������ ��� ���������� "���������".\n{FF8000}[2]{FFFFFF} � "����������", �������� ����� ���������/���������� ������� � ����� �� ����� ��������\n{FF8000}[3]{FFFFFF} ��������� ������� - {58ACFA}/fail{FFFFFF}, �������� �� ����� ��������.\n{FF8000}[4] {FFFFFF}�� ������� "���������" �������� �������� "��������"\n� � ������ ��������� �� ������ ��������� ��� �������� ��� ������ ��.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}03.10.2020 (1.05)\n{FF8000}[1]{FFFFFF} ������� ��������� ������.\n� ������ ���������� ������ ������������ � ���������� ��������� ���� �������.\n{FF8000}[2]{FFFFFF} �� ������� "� �������" ���������� ������, ��� ����� � �������.\n{FF8000}[3]{FFFFFF} ���������� ��������� ����.\n� ������ �������� ��� ������ ������� �������.\n{FF8000}[4]{FFFFFF} ��������� ����������� �������� 30 ��������� ������ � ������ ��������.\n{FF8000}[5]{FFFFFF} ��������� �����������, ������� ������� ������ ��������.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}04.10.2020 (1.06)\n{FF8000}[1]{FFFFFF} ��������� ����������� ����� ���� ����������� ����������.\n{FF8000}[2]{FFFFFF} ��������� ������ ������������ �������.\n{FF8000}[3]{FFFFFF} ������� ��� ������� "�������� > ��������".\n{FF8000}[4]{FFFFFF} � ������ ��������� ����������� ������ �������.\n� ��� �� � ���� "��������� > ��������" ��� �������, ����� ���������� ���������.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}06.10.2020 (1.07)\n{FF8000}[1]{FFFFFF} ���������� �������� � ���� ��������������.\n{FF8000}[2]{FFFFFF} ��������� ����������� �������� ���������� ����������� ����������� ����� �� ��������.\n{FF8000}[3]{FFFFFF} ��������� ������/��� � �����.\n{FF8000}[4]{FFFFFF} ��������� �����.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}12.10.2020 (1.08)\n{FF8000}[1]{FFFFFF} �������� �������� �������.\n{FF8000}[2]{FFFFFF} ���������� �������.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}14.10.2020 (1.09)\n{FF8000}[1]{FFFFFF} �����, �����, �����...\n� ��������� ����-����� �� ���� ������, ������ �������� ���������.\n� ��������� ����� � ������� /fail.\n� �������� ������ �������� � ��������.\n� ���������� ����������� ������� ��� �������.\n� ����� ��� ��������� �������� ����-������� ��� ���������� ����-����������.\n� ���������� ����� ������� ����� ������� ��������/���������.\n{FF8000}[2]{FFFFFF} ��������� ����������� ���/���� ������ ��� �������.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}15.10.2020 (1.10)\n{FF8000}[1]{FFFFFF} ��������.', 2)
                imgui.Separator()
                imgui.TextRGB('{58ACFA}16.10.2020 (1.11)\n{FF8000}[1]{FFFFFF} ���� "�����������" ��������� ��������.', 2)
                imgui.Separator()
            imgui.EndChild()
        imgui.End()
    end

--[[
    if Window['FAQ'].v then
        imgui.SetNextWindowSize(imgui.ImVec2(617, 523), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2-70, sh/2+131), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))

        imgui.Begin(u8'License Center Assistant: F.A.Q ��� ��������##4', Window['FAQ'], imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
            imgui.BeginChild('Latest Update', imgui.ImVec2(609,500), true)
                imgui.TextRGB('����������� ���� '..rpnick..', � ������ ������� �� ������� ������������ � �����.\n���� �� ������ ��� ��������� � ������������ �����, ���� � ���� ���� �����-�� �������\n�� ����� �������� �� ������� �����.', 2)
                imgui.Text('') 
                if imgui.CollapsingHeader(u8'��� ������� ������������� ������.') then
                    imgui.SetCursorPos(imgui.ImVec2(360,120))
                    imgui.TextRGB('{FFFF00}/exam -{FFFFFF} ������� �������') 
                    imgui.SetCursorPos(imgui.ImVec2(339,140))
                    imgui.TextRGB('��������� ��� �������������[3+]')
                    imgui.SetCursorPos(imgui.ImVec2(360,160))
                    imgui.TextRGB('{FFFF00}/selllic -{FFFFFF} ������� ��������')
                    imgui.SetCursorPos(imgui.ImVec2(339,180))
                    imgui.TextRGB('��������� ��� ��.�������������[4+]')
                    imgui.SetCursorPos(imgui.ImVec2(360,200))
                    imgui.TextRGB('{FFFF00}/insurance -{FFFFFF} ������������ ���������')
                    imgui.SetCursorPos(imgui.ImVec2(0,100))
                    imgui.Text(u8'                 ��������� ��� ����') imgui.SameLine() imgui.TextRGB('��������� ��� �������������[2+]                 ', 3)
                    imgui.TextRGB('{FFFF00}/f -{FFFFFF} �����\n{FFFF00}/fn -{FFFFFF} ��� �����\n{FFFF00}/find -{FFFFFF} ���������� ������ �����������\n{FFFF00}/setspawn -{FFFFFF} �������� ����� ���������\n{FFFF00}/topinstructors -{FFFFFF} ������ ����������\n{FFFF00}/mystats -{FFFFFF} ������ ����������\n{FFFF00}/sobject -{FFFFFF} ��������� ��������')
                end --{FFFF00}/ -{FFFFFF} \n
                if imgui.CollapsingHeader(u8'��� ������ � ��������� �������.') then
                    local xPos = 25
                    imgui.TextRGB('��� ���� ����� ������ ��������� ������� � ���������, �� ������ �')
                    imgui.SetCursorPosX(xPos)
                    if imgui.CollapsingHeader(u8'������� �� �������� ����.') then imgui.SetCursorPosX(xPos)
                        imgui.TextRGB('test') 
                    end imgui.SetCursorPosX(xPos)
                    if imgui.CollapsingHeader(u8'������� �� ��������� ���������.') then imgui.SetCursorPosX(xPos)
                        imgui.TextRGB('test')
                    end imgui.SetCursorPosX(xPos)
                    if imgui.CollapsingHeader(u8'������� �� �������������.') then imgui.SetCursorPosX(xPos)
                        imgui.TextRGB('test')
                    end imgui.SetCursorPosX(xPos)
                    if imgui.CollapsingHeader(u8'������� �� �������� ���������.') then imgui.SetCursorPosX(xPos)
                        imgui.TextRGB('test')
                    end
                end
                if imgui.CollapsingHeader(u8'������� ��������.') then
                    imgui.TextRGB('test')
                end
                if imgui.CollapsingHeader(u8'���������� ���������.') then
                    imgui.TextRGB('test')  
                end
            imgui.EndChild()
        imgui.End()
    end
]]




end











function ev.onSendCommand(command)
    for i = 1, #Binder do
        if command == Binder[i].command then
            lua_thread.create(function()
                for str in u8:decode(Binder[i].text):gmatch('[^\n\r]+') do
                    if string.find(str, '^@wait(%d+)') then
                        local strWait = string.match(str, '^@wait(%d+)')
                        wait(strWait)
                    else
                        if string.find(str, '(.*)@nsent') then
                            local strNsent = string.match(str, '(.*)@nsent')
                            if string.find(strNsent, '{my_id}') then
                                local str2 = string.gsub(strNsent, '{my_id}', myid)
                                if string.find(str2, '{my_nick}') then
                                    local str3 = string.gsub(str2, '{my_nick}', rpnick)
                                    sampSetChatInputEnabled(true)
                                    sampSetChatInputText(str3)
                                    repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                                else
                                    sampSetChatInputEnabled(true)
                                    sampSetChatInputText(str2)
                                    repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                                end
                            elseif string.find(strNsent, '{my_nick}') then
                                local strMyNick = string.gsub(strNsent, '{my_nick}', rpnick)
                                sampSetChatInputEnabled(true)
                                sampSetChatInputText(str2)
                                repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                            else
                                sampSetChatInputEnabled(true)
                                sampSetChatInputText(strNsent)
                                repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                            end
                        else
                            if string.find(str, '{my_id}') then
                                local strMyid = string.gsub(str, '{my_id}', myid)
                                if string.find(strMyid, '{my_nick}') then
                                    local str2 = string.gsub(strMyid, '{my_nick}', rpnick)
                                    sampSendChat(str2)
                                else
                                    sampSendChat(strMyid)
                                end
                            elseif string.find(str, '{my_nick}') then
                                local strMyNick = string.gsub(str, '{my_nick}', rpnick)
                                sampSendChat(strMyNick)
                            elseif string.find(str, '@screen') then
                                makeScreen()
                            elseif string.find(str, '@local:(.*)') then
                                local strLocal = string.match(str, '@local:(.*)')
                                sampAddChatMessage(strLocal, -1)
                            else
                                sampSendChat(str)
                            end
                        end
                    end
                end
            end)
            return false
        end
    end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(Binder) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			lua_thread.create(function()
                for str in u8:decode(Binder[k].text):gmatch('[^\n\r]+') do
                    if string.find(str, '^@wait(%d+)') then
                        local strWait = string.match(str, '^@wait(%d+)')
                        wait(strWait)
                    else
                        if string.find(str, '(.*)@nsent') then
                            local strNsent = string.match(str, '(.*)@nsent')
                            if string.find(strNsent, '{my_id}') then
                                local str2 = string.gsub(strNsent, '{my_id}', myid)
                                if string.find(str2, '{my_nick}') then
                                    local str3 = string.gsub(str2, '{my_nick}', rpnick)
                                    sampSetChatInputEnabled(true)
                                    sampSetChatInputText(str3)
                                    repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                                else
                                    sampSetChatInputEnabled(true)
                                    sampSetChatInputText(str2)
                                    repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                                end
                            elseif string.find(strNsent, '{my_nick}') then
                                local strMyNick = string.gsub(strNsent, '{my_nick}', rpnick)
                                sampSetChatInputEnabled(true)
                                sampSetChatInputText(str2)
                                repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                            else
                                sampSetChatInputEnabled(true)
                                sampSetChatInputText(strNsent)
                                repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x75) or isKeyJustPressed(0x1B)
                            end
                        else
                            if string.find(str, '{my_id}') then
                                local strMyid = string.gsub(str, '{my_id}', myid)
                                if string.find(strMyid, '{my_nick}') then
                                    local str2 = string.gsub(strMyid, '{my_nick}', rpnick)
                                    sampSendChat(str2)
                                else
                                    sampSendChat(strMyid)
                                end
                            elseif string.find(str, '{my_nick}') then
                                local strMyNick = string.gsub(str, '{my_nick}', rpnick)
                                sampSendChat(strMyNick)
                            elseif string.find(str, '@screen') then
                                makeScreen()
                            elseif string.find(str, '@local:(.*)') then
                                local strLocal = string.match(str, '@local:(.*)')
                                sampAddChatMessage(strLocal, -1)
                            else
                                sampSendChat(str)
                            end
                        end
                    end
                end
            end)
		end
	end
end
--------------------------------------------------
function carExam()
    lua_thread.create(function()
        RunCarExamSt = true
        sampSendChat('������������, ���� ����� '..rpnick..', � ���� ��������� � ��� �������.')
        wait(2200)
        sampSendChat('���������� ��� �������.')
        wait(2200)
        sampSendChat('/n ������� �������: /pass '..myid)
        wait(1000)
        if Krit['NeedAgeCar'].v and not Krit['NeedMedCar'].v and not Krit['NeedLvlCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeCar'].v..'+ ���{FFFFFF}.', tag_clr) wait(1)
        elseif Krit['NeedAgeCar'].v and Krit['NeedMedCar'].v and not Krit['NeedLvlCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeCar'].v..'+ ���{FFFFFF} � ��������� ���. ������.', tag_clr) wait(1)
        elseif Krit['NeedAgeCar'].v and Krit['NeedMedCar'].v and Krit['NeedLvlCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeCar'].v..'+ ���{FFFFFF} � ��������� ���. ������ � {58ACFA}'..Krit['LvlCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif Krit['NeedAgeCar'].v and not Krit['NeedMedCar'].v and Krit['NeedLvlCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeCar'].v..'+ ���{FFFFFF} � {58ACFA}'..Krit['LvlCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeCar'].v and Krit['NeedMedCar'].v and not Krit['NeedLvlCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������', tag_clr) wait(1)
        elseif not Krit['NeedAgeCar'].v and not Krit['NeedMedCar'].v and Krit['NeedLvlCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['LvlCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeCar'].v and Krit['NeedMedCar'].v and Krit['NeedLvlCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������ {FFFFFF}� {58ACFA}'..Krit['LvlCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        end
        sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ���� �� �������, �� ������� - {58ACFA}2{FFFFFF}. ������ - {58ACFA}3{FFFFFF}.', tag_clr)
        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
        if isKeyJustPressed(0x31) then
            sampSendChat('/me ������'..Sex..' ����� � ����� �� ������� ������')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ��� � ������� �������������, ����� ���� �������'..Sex..' ����� ���')
            wait(2200)
            sampSendChat('�������� �� ���� �� ��������, ��� ����� ������������ ����� ��������.')
            if Toggle['DokladF'].v then
                wait(2200)
                if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                    sampSendChat('/f '..u8:decode(Input['Tag'].v)..' �����'..Sex..' ��������� ������� �� �������� ����, � '..targrpnick..'.')
                else
                    sampSendChat('/f �����'..Sex..' ��������� ������� �� �������� ����, � '..targrpnick..'.')
                end
            end
            wait(1000)
            sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ������ - {58ACFA}2{FFFFFF}.', tag_clr)
                repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
                if isKeyJustPressed(0x31) then
                    sampSendChat('�������������� �� ����� �������� � �������� ���� ���������� ��������.')
                    wait(2200)
                    sampSendChat('��� ������ ����������� ������ ������������.')
                    wait(2200)
                    sampSendChat('/n /me ����������(�) ������ ������������')
                    wait(2200)
                    sampSendChat('/me ����������'..Sex..' ������ ������������')
                    wait(2200)
                    sampSendChat('�������� ���������, ��������� ���� � ���������� � ����� "�����" � ������ ��������.')
                    if Toggle['Checkpoints_st'].v then setMarker(2, -2054.0480957031, -173.13999938965, 35.063426971436, 4, 0xFF0000FF) end
                    wait(2200)
                    sampSendChat('/n ������� ��������� ����� ����� �� ������� [Ctrl], �������� ���� [Alt].')
                    wait(1000)
                    sampAddChatMessage(tag_text..' ���� ������������ �������� {58ACFA}������� ����� ������{FFFFFF} ������� ������� - {58ACFA}/fail', tag_clr)
                    RunCarExam = true
                    NextStepCar = 1
                    repeat wait(0) until NextStepCar == 8
                        if NextStepCar == 8 then
                            wait(1500)
                            sampAddChatMessage(tag_text..' ����� ���� ��� ��������������, �������:', tag_clr) wait(1)
                            sampAddChatMessage(tag_text..' ���� - {58ACFA}1{FFFFFF}, �� ���� - {58ACFA}2{FFFFFF}, ������ - {58ACFA}3{FFFFFF}.', tag_clr)
                            repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
                            if isKeyJustPressed(0x31) then
                                sampSendChat('/me ���������'..Sex..' ����, ����� ���� ������'..Sex..' ������ � �����'..Sex..' ��������� ��')
                                wait(2200)
                                sampSendChat('/me ������'..Sex..' ��� � ������� �������')
                                wait(2200)
                                sampSendChat('/me ������'..Sex..' ������ ����� ������������ �������������, ����� ���� �������'..Sex..' �������')
                                wait(2200)
                                sampSendChat('/me ����� ���������� ����������, ��������� ������'..Sex..' �� � ������'..Sex..' ����')
                                wait(2200)
                                if Toggle['DokladF'].v then
                                    if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                        sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� �������� ����. '..timehm..' '..date..'.')
                                    else
                                        sampSendChat('/f ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� �������� ����. '..timehm..' '..date..'.')
                                    end
                                end
                                ExamEnd(1)
                                wait(2200)
                                sampSendChat('/exam')
                                wait(1000)
                                if not sampIsDialogActive() then
                                    if Toggle['AutoScreen'].v then TimeScreen() end
                                else
                                    while sampIsDialogActive() do wait(0)
                                        if sampIsDialogActive() then
                                            if Toggle['AutoScreen'].v then TimeScreen() end
                                        end
                                    end
                                end
                                wait(2200)
                                sampSendChat('����������!')
                                if ReloadAccept then
                                    thisScript():reload()
                                else
                                    while not ReloadAccept do wait(0)
                                        if ReloadAccept then
                                            thisScript():reload()
                                        end
                                    end
                                end
                            elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                                sampSendChat('�� ��������� ������� ����� ������, ������������� �� ���������.')
                                wait(2200)
                                if Toggle['DokladF'].v then
                                    if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                        sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� �������� ����.')
                                    else
                                        sampSendChat('/f ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� �������� ����.')
                                    end
                                end
                                ExamEnd(2)
                                wait(2200)
                                sampSendChat('/exam')
                                thisScript():reload()
                            elseif isKeyJustPressed(0x33) then
                                thisScript():reload()
                            end
                        end
                elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                    thisScript():reload()
                end
        elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
            Otkaz()
        elseif isKeyJustPressed(0x33) then
            thisScript():reload()
        end
    end)
end

function airExam()
    lua_thread.create(function()
        RunAirExamSt = true
        sampSendChat('������������, ���� ����� '..rpnick..', � ���� ��������� � ��� �������.')
        wait(2200)
        sampSendChat('���������� ��� ������� � ����������� �����.')
        wait(2200)
        sampSendChat('/n ������� �������: /pass '..myid..', ���. �����: /med '..myid)
        wait(200)
        if Krit['NeedAgeAir'].v and not Krit['NeedMedAir'].v and not Krit['NeedLvlAir'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeAir'].v..'+ ���{FFFFFF}.', tag_clr) wait(1)
        elseif Krit['NeedAgeAir'].v and Krit['NeedMedAir'].v and not Krit['NeedLvlAir'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeAir'].v..'+ ���{FFFFFF} � ��������� ���. ������.', tag_clr) wait(1)
        elseif Krit['NeedAgeAir'].v and Krit['NeedMedAir'].v and Krit['NeedLvlAir'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeAir'].v..'+ ���{FFFFFF} � ��������� ���. ������ � {58ACFA}'..Krit['LvlAir'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif Krit['NeedAgeAir'].v and not Krit['NeedMedAir'].v and Krit['NeedLvlAir'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeAir'].v..'+ ���{FFFFFF} � {58ACFA}'..Krit['LvlAir'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeAir'].v and Krit['NeedMedAir'].v and not Krit['NeedLvlAir'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������', tag_clr) wait(1)
        elseif not Krit['NeedAgeAir'].v and not Krit['NeedMedAir'].v and Krit['NeedLvlAir'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['LvlAir'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeAir'].v and Krit['NeedMedAir'].v and Krit['NeedLvlAir'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������ {FFFFFF}� {58ACFA}'..Krit['LvlAir'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        end
        sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ���� �� �������, �� ������� - {58ACFA}2{FFFFFF}. ������ - {58ACFA}3{FFFFFF}.', tag_clr)
        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
        if isKeyJustPressed(0x31) then
            sampSendChat('/me ������'..Sex..' ����� � ����� �� ������� ����')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ��� � ������� �������������, ����� ���� �������'..Sex..' ���')
            wait(2200)
            sampSendChat('�������� �� ���� ��� ����� ������������ ����� ��������.')
            if Toggle['DokladF'].v then
                wait(2200)
                if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                    sampSendChat('/f '..u8:decode(Input['Tag'].v)..' �����'..Sex..' ��������� ������� �� ��������� ���������, � '..targrpnick..'.')
                else
                    sampSendChat('/f �����'..Sex..' ��������� ������� �� ��������� ���������, � '..targrpnick..'.') 
                end
            end
            wait(1000)
            sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ������ - {58ACFA}2{FFFFFF}.', tag_clr)
                repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
                if isKeyJustPressed(0x31) then
                    sampSendChat('�������� �� ����� ������, ����� ���� ����� ���� ��������.')
                    wait(2200)
                    sampSendChat('��� ������ �������� ��������, ����������� ������ ������������.')
                    wait(2200)
                    sampSendChat('/n /me �����(�) �������� � ����������(�) ������ ������������')
                    wait(2200)
                    sampSendChat('/me �����'..Sex..' �������� � ����������'..Sex..' ������ ������������')
                    wait(2200)
                    sampSendChat('������ �������� ��������� � ��������.')
                    wait(2200)
                    sampSendChat('��������� ������ ���������� ������������� ������.')
                    wait(2200)
                    sampSendChat('����� ����, ��� �������� ���� - ������������� � �� �����, ������ ����� �������.')
                    wait(2200)
                    sampSendChat('/n ��� ��������� � ������� ����������� ������� "Q" � "E".')
                    wait(1500)
                    sampAddChatMessage(tag_text..' ����� ���� ��� ������������, �������:', tag_clr) wait(1)
                    sampAddChatMessage(tag_text..' ���� - {58ACFA}1{FFFFFF}, �� ���� - {58ACFA}2{FFFFFF}, ������ - {58ACFA}3{FFFFFF}.', tag_clr) RunAirExam = true wait(1000)
                    sampAddChatMessage(tag_text..' ���� ������������ �������� {58ACFA}������� ����� ������{FFFFFF} ������� ������� - {58ACFA}/fail', tag_clr)
                    repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
                    if isKeyJustPressed(0x31) then
                        sampSendChat('/me ���������'..Sex..' ����, ����� ���� ������'..Sex..' ������ � �����'..Sex..' ��������� ��')
                        wait(2200)
                        sampSendChat('/me ������'..Sex..' ��� � ������� �������')
                        wait(2200)
                        sampSendChat('/me ������'..Sex..' ������ ����� ������������ �������������, ����� ���� �������'..Sex..' �������')
                        wait(2200)
                        sampSendChat('/me ����� ���������� ����������, ��������� ������'..Sex..' �� � ������'..Sex..' ����')
                        wait(2200)
                        if Toggle['DokladF'].v then
                            if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� ��������� ���������. '..timehm..' '..date..'.')
                            else
                                sampSendChat('/f ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� ��������� ���������. '..timehm..' '..date..'.') 
                            end
                        end
                        ExamEnd(1)
                        wait(2200)
                        sampSendChat('/exam')
                        wait(1000)
                        if not sampIsDialogActive() then
                            if Toggle['AutoScreen'].v then TimeScreen() end
                        else
                            while sampIsDialogActive() do wait(0)
                                if sampIsDialogActive() then
                                    if Toggle['AutoScreen'].v then TimeScreen() end
                                end
                            end
                        end
                        wait(2200)
                        sampSendChat('����������!')
                        if ReloadAccept then
                            thisScript():reload()
                        else
                            while not ReloadAccept do wait(0)
                                if ReloadAccept then
                                    thisScript():reload()
                                end
                            end
                        end
                    elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                        sampSendChat('�� ��������� ������� ����� ������, ������������� �� ���������.')
                        wait(2200)
                        if Toggle['DokladF'].v then
                            if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� ��������� ���������.')
                            else
                                sampSendChat('/f ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� ��������� ���������.') 
                            end
                        end
                        ExamEnd(2)
                        wait(2200)
                        sampSendChat('/exam')
                        thisScript():reload()
                    elseif isKeyJustPressed(0x33) then
                        thisScript():reload()
                    end
                elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                    thisScript():reload()
                end
        elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
            Otkaz()
        elseif isKeyJustPressed(0x33) then
            thisScript():reload()
        end
    end)
end

function motoExam()
    lua_thread.create(function()
    RunMotoExamSt = true
        sampSendChat('������������, ���� ����� '..rpnick..', � ���� ��������� � ��� �������.')
        wait(2200)
        sampSendChat('���������� ��� ������� � ���.�����')
        wait(2200)
        sampSendChat('/n ������� �������: /pass '..myid..', ���. �����: /med '..myid)
        wait(1000)
        if Krit['NeedAgeMoto'].v and not Krit['NeedMedMoto'].v and not Krit['NeedLvlMoto'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeMoto'].v..'+ ���{FFFFFF}.', tag_clr) wait(1)
        elseif Krit['NeedAgeMoto'].v and Krit['NeedMedMoto'].v and not Krit['NeedLvlMoto'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeMoto'].v..'+ ���{FFFFFF} � ��������� ���. ������.', tag_clr) wait(1)
        elseif Krit['NeedAgeMoto'].v and Krit['NeedMedMoto'].v and Krit['NeedLvlMoto'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeMoto'].v..'+ ���{FFFFFF} � ��������� ���. ������ � {58ACFA}'..Krit['LvlMoto'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif Krit['NeedAgeMoto'].v and not Krit['NeedMedMoto'].v and Krit['NeedLvlMoto'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeMoto'].v..'+ ���{FFFFFF} � {58ACFA}'..Krit['LvlMoto'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeMoto'].v and Krit['NeedMedMoto'].v and not Krit['NeedLvlMoto'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������', tag_clr) wait(1)
        elseif not Krit['NeedAgeMoto'].v and not Krit['NeedMedMoto'].v and Krit['NeedLvlMoto'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['LvlMoto'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeMoto'].v and Krit['NeedMedMoto'].v and Krit['NeedLvlMoto'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������ {FFFFFF}� {58ACFA}'..Krit['LvlMoto'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        end
        sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ���� �� �������, �� ������� - {58ACFA}2{FFFFFF}. ������ - {58ACFA}3{FFFFFF}.', tag_clr)
        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
        if isKeyJustPressed(0x31) then
            sampSendChat('/me ������'..Sex..' ����� � ����� �� ������� ����')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ��� � ������� �������������, ����� ���� �������'..Sex..' ���')
            wait(2200)
            sampSendChat('�������� �� ���� ��� ����� ������������ ����� ��������.')
            if Toggle['DokladF'].v then
                wait(2200)
                if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                    sampSendChat('/f '..u8:decode(Input['Tag'].v)..' �����'..Sex..' ��������� ������� �� �������������, � '..targrpnick..'.')
                else
                    sampSendChat('/f �����'..Sex..' ��������� ������� �� �������������, � '..targrpnick..'.')  
                end
            end
            wait(1000)
            sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ������ - {58ACFA}2{FFFFFF}.', tag_clr)
                repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
                if isKeyJustPressed(0x31) then
                    sampSendChat('�������� �� ��������, ����� ���� �������� ���������� ��������.')
                    wait(2200)
                    sampSendChat('��� ������ �������� ����.')
                    wait(2200)
                    sampSendChat('/n /me ����(�) ���� � ���������, ����� ���� �����(�) ���')
                    wait(2200)
                    sampSendChat('/me ����'..Sex..' ���� � ���������, ����� ���� �����'..Sex..' ���')
                    wait(2200)
                    sampSendChat('�������� ���������, ��������� ���� � ���������� � ����� "�����".')
                    if Toggle['Checkpoints_st'].v then setMarker(2, -2112.3962402344, -101.9630279541, 34.89965057373, 3, 0xFF0000FF) end
                    wait(2200)
                    sampSendChat('/n ������� ��������� ����� ����� �� ������� [Ctrl], �������� ���� [Alt].')
                    wait(1000)
                    sampAddChatMessage(tag_text..' ���� ������������ �������� {58ACFA}������� ����� ������{FFFFFF} ������� ������� - {58ACFA}/fail', tag_clr)
                    RunMotoExam = true
                    NextStepMoto = 1
                    repeat wait(0) until NextStepMoto == 11
                        if NextStepMoto == 11 then
                            wait(1500)
                            sampAddChatMessage(tag_text..' ����� ���� ��� ��������������, �������:', tag_clr) wait(1)
                            sampAddChatMessage(tag_text..' ���� - {58ACFA}1{FFFFFF}, �� ���� - {58ACFA}2{FFFFFF}, ������ - {58ACFA}3{FFFFFF}.', tag_clr)
                            repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
                            if isKeyJustPressed(0x31) then
                                sampSendChat('/me ���������'..Sex..' ����, ����� ���� ������'..Sex..' ������ � �����'..Sex..' ��������� ��')
                                wait(2200)
                                sampSendChat('/me ������'..Sex..' ��� � ������� �������')
                                wait(2200)
                                sampSendChat('/me ������'..Sex..' ������ ����� ������������ �������������, ����� ���� �������'..Sex..' �������')
                                wait(2200)
                                sampSendChat('/me ����� ���������� ����������, ��������� ������'..Sex..' �� � ������'..Sex..' ����')
                                wait(2200)
                                if Toggle['DokladF'].v then
                                    if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                        sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� �������������. '..timehm..' '..date..'.')
                                    else
                                        sampSendChat('/f ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� �������������. '..timehm..' '..date..'.') 
                                    end
                                end
                                ExamEnd(1)
                                wait(2200)
                                sampSendChat('/exam')
                                wait(1000)
                                if not sampIsDialogActive() then
                                    if Toggle['AutoScreen'].v then TimeScreen() end
                                else
                                    while sampIsDialogActive() do wait(0)
                                        if sampIsDialogActive() then
                                            if Toggle['AutoScreen'].v then TimeScreen() end
                                        end
                                    end
                                end
                                wait(2200)
                                sampSendChat('����������!')
                                if ReloadAccept then
                                    thisScript():reload()
                                else
                                    while not ReloadAccept do wait(0)
                                        if ReloadAccept then
                                            thisScript():reload()
                                        end
                                    end
                                end
                            elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                                sampSendChat('�� ��������� ������� ����� ������, ������������� �� ���������.')
                                wait(2200)
                                if Toggle['DokladF'].v then
                                    if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                        sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� �������������.')
                                    else
                                        sampSendChat('/f ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� �������������.') 
                                    end
                                end
                                ExamEnd(2)
                                wait(2200)
                                sampSendChat('/exam')
                                thisScript():reload()
                            elseif isKeyJustPressed(0x33) then
                                
                            end
                        end
                elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                    thisScript():reload()
                end
        elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
            Otkaz()
        elseif isKeyJustPressed(0x33) then
            thisScript():reload()
        end
	end)
end

function bigcarExam()
    lua_thread.create(function()
    RunBigCarExamSt = true
        sampSendChat('������������, ���� ����� '..rpnick..', � ���� ��������� � ��� �������.')
        wait(2200)
        sampSendChat('���������� ��� ������� � ���.�����')
        wait(2200)
        sampSendChat('/n ������� �������: /pass '..myid..', ���. �����: /med '..myid)
        wait(1000)
        if Krit['NeedAgeBigCar'].v and not Krit['NeedMedBigCar'].v and not Krit['NeedLvlBigCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeBigCar'].v..'+ ���{FFFFFF}.', tag_clr) wait(1)
        elseif Krit['NeedAgeBigCar'].v and Krit['NeedMedBigCar'].v and not Krit['NeedLvlBigCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeBigCar'].v..'+ ���{FFFFFF} � ��������� ���. ������.', tag_clr) wait(1)
        elseif Krit['NeedAgeBigCar'].v and Krit['NeedMedBigCar'].v and Krit['NeedLvlBigCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeBigCar'].v..'+ ���{FFFFFF} � ��������� ���. ������ � {58ACFA}'..Krit['LvlBigCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif Krit['NeedAgeBigCar'].v and not Krit['NeedMedBigCar'].v and Krit['NeedLvlBigCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeBigCar'].v..'+ ���{FFFFFF} � {58ACFA}'..Krit['LvlBigCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeBigCar'].v and Krit['NeedMedBigCar'].v and not Krit['NeedLvlBigCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������', tag_clr) wait(1)
        elseif not Krit['NeedAgeBigCar'].v and not Krit['NeedMedBigCar'].v and Krit['NeedLvlBigCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['LvlBigCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        elseif not Krit['NeedAgeBigCar'].v and Krit['NeedMedBigCar'].v and Krit['NeedLvlBigCar'].v then
            sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������ {FFFFFF}� {58ACFA}'..Krit['LvlBigCar'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
        end
        sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ���� �� �������, �� ������� - {58ACFA}2{FFFFFF}. ������ - {58ACFA}3{FFFFFF}.', tag_clr)
        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
        if isKeyJustPressed(0x31) then
            sampSendChat('/me ������'..Sex..' ����� � ����� �� ������� ����')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ��� � ������� �������������, ����� ���� �������'..Sex..' ���')
            wait(2200)
            sampSendChat('�������� �� ���� ��� ����� ������������ ����� ��������.')
            if Toggle['DokladF'].v then
                wait(2200)
                if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                    sampSendChat('/f '..u8:decode(Input['Tag'].v)..' �����'..Sex..' ��������� ������� �� �������� ���������, � '..targrpnick..'.')
                else
                    sampSendChat('/f �����'..Sex..' ��������� ������� �� �������� ���������, � '..targrpnick..'.') 
                end
            end
            wait(1000)
            sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ������ - {58ACFA}2{FFFFFF}.', tag_clr)
                repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
                if isKeyJustPressed(0x31) then
                    sampSendChat('�������������� �� ����� �������� � �������� ���� ���������� ��������.')
                    wait(2200)
                    sampSendChat('��� ������ ����������� ������ ������������.')
                    wait(2200)
                    sampSendChat('/n /me ����������(�) ������ ������������')
                    wait(2200)
                    sampSendChat('/me ����������'..Sex..' ������ ������������')
                    wait(2200)
                    sampSendChat('�������� ���������, ��������� �� �������� ����� � �������� ���������� ��������.')
                    if Toggle['Checkpoints_st'].v then setMarker(2, -2129.3610839844, -86.953735351563, 34.8903465271, 6, 0xFF0000FF) end
                    wait(2200)
                    sampSendChat('/n ������� ��������� ����� ����� �� ������� [Ctrl], �������� ���� [Alt].')
                    wait(1000)
                    sampAddChatMessage(tag_text..' ���� ������������ �������� {58ACFA}������� ����� ������{FFFFFF} ������� ������� - {58ACFA}/fail', tag_clr)
                    RunBigCarExam = true
                    NextStepBigCar = 1
                    repeat wait(0) until NextStepBigCar == 2
                        if NextStepBigCar == 2 then
                            sampAddChatMessage(tag_text..' ����� ��������� ����� ������� - {58ACFA}1{FFFFFF}. ������ - {58ACFA}2{FFFFFF}.', tag_clr)
                            repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
                            if isKeyJustPressed(0x31) then
                                sampSendChat('������ ����������� ���� �� �����, ������ �� �����.')
                                wait(1500)
                                sampAddChatMessage(tag_text..' ����� ���� ��� ��������������, �������:', tag_clr) wait(1)
                                sampAddChatMessage(tag_text..' ���� - {58ACFA}1{FFFFFF}, �� ���� - {58ACFA}2{FFFFFF}, ������ - {58ACFA}3{FFFFFF}.', tag_clr)
                                repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
                                if isKeyJustPressed(0x31) then
                                    sampSendChat('/me ���������'..Sex..' ����, ����� ���� ������'..Sex..' ������ � �����'..Sex..' ��������� ��')
                                    wait(2200)
                                    sampSendChat('/me ������'..Sex..' ��� � ������� �������')
                                    wait(2200)
                                    sampSendChat('/me ������'..Sex..' ������ ����� ������������ �������������, ����� ���� �������'..Sex..' �������')
                                    wait(2200)
                                    sampSendChat('/me ����� ���������� ����������, ��������� ������'..Sex..' �� � ������'..Sex..' ����')
                                    wait(2200)
                                    if Toggle['DokladF'].v then
                                        if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                            sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� �������� ���������. '..timehm..' '..date..'.')
                                        else
                                            sampSendChat('/f ������������ �'..tid..' '..targrpnick..', ������� �������� ������� �� �������� ���������. '..timehm..' '..date..'.') 
                                        end
                                    end
                                    ExamEnd(1)
                                    wait(2200)
                                    sampSendChat('/exam')
                                    wait(1000)
                                    if not sampIsDialogActive() then
                                        if Toggle['AutoScreen'].v then TimeScreen() end
                                    else
                                        while sampIsDialogActive() do wait(0)
                                            if sampIsDialogActive() then
                                                if Toggle['AutoScreen'].v then TimeScreen() end
                                            end
                                        end
                                    end
                                    wait(2200)
                                    sampSendChat('����������!')
                                    if ReloadAccept then
                                        thisScript():reload()
                                    else
                                        while not ReloadAccept do wait(0)
                                            if ReloadAccept then
                                                thisScript():reload()
                                            end
                                        end
                                    end
                                elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                                    sampSendChat('�� ��������� ������� ����� ������, ������������� �� ���������.')
                                    wait(2200)
                                    if Toggle['DokladF'].v then
                                        if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                                            sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� �������� ���������. '..timehm..' '..date..'.')
                                        else
                                            sampSendChat('/f ������������ �'..tid..' '..targrpnick..', �� ���� ������� �� �������� ���������. '..timehm..' '..date..'.') 
                                        end
                                    end
                                    ExamEnd(2)
                                    wait(2200)
                                    sampSendChat('/exam')
                                    thisScript():reload()
                                elseif isKeyJustPressed(0x33) then
                                    thisScript():reload()
                                end
                            elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                                thisScript():reload()
                            end
                        end
                elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                    thisScript():reload()
                end
        elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
            Otkaz()
        elseif isKeyJustPressed(0x33) then
            thisScript():reload()
        end
	end)
end

function Otkaz()
    lua_thread.create(function()
        wait(1)
        sampAddChatMessage(tag_text..' ������� ����� - {58ACFA}1', tag_clr)
        sampAddChatMessage(tag_text..' ����� ������� � �������� ������� ������ ������� - {58ACFA}2', tag_clr)
        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
        if isKeyJustPressed(0x31) then
            sampSendChat('� ��� �������� � �����������, � �� ���� ������� � ��� �������.') wait(1)
            if SecondsExam > 0 then sampAddChatMessage(tag_text..' ��� ������ ������� 30 ��� ����� ������, ������� ����� ��������.', tag_clr) end
        elseif isKeyJustPressed(0x32) and not isKeyDown(0x12) then
            sampAddChatMessage(tag_text..' �������: ������� - {58ACFA}1{FFFFFF}, NRPNick - {58ACFA}2{FFFFFF}, ������� - {58ACFA}3{FFFFFF}, ���. ������ - {58ACFA}4', tag_clr)
            repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33) or isKeyJustPressed(0x34)
            if isKeyJustPressed(0x31) then
                sampSendChat('��� ��� 18 ���, ���������, ����� ���������� ���������������.')
                if SecondsExam > 0 then sampAddChatMessage(tag_text..' ��� ������ ������� 30 ��� ����� ������, ������� ����� ��������.', tag_clr) end
                repeat wait(0) until SecondsExam == 0 or SecondsExam < 0
                ExamEnd(2)
                wait(2200)
                sampSendChat('/exam')
                wait(1500)
                thisScript():reload()
            elseif isKeyJustPressed(0x32) and not isKeyDown(0x12) then
                sampSendChat('� ��� �������� � ��������, ����� ���������.')
                wait(2200)
                sampSendChat('/n � ��� ����� ���, ������ ����� �������� "/mn >> 8. ����� ����� ����".')
                if SecondsExam > 0 then sampAddChatMessage(tag_text..' ��� ������ ������� 30 ��� ����� ������, ������� ����� ��������.', tag_clr) end
                repeat wait(0) until SecondsExam == 0 or SecondsExam < 0
                ExamEnd(2)
                wait(2200)
                sampSendChat('/exam')
                wait(1500)
                thisScript():reload()
            elseif isKeyJustPressed(0x33) then
                sampSendChat('�� ������������ ���������� �����.')
                wait(2200)
                sampSendChat('/n � ��� ������������ �������.')
                if SecondsExam > 0 then sampAddChatMessage(tag_text..' ��� ������ ������� 30 ��� ����� ������, ������� ����� ��������.', tag_clr) end
                repeat wait(0) until SecondsExam == 0 or SecondsExam < 0
                ExamEnd(2)
                wait(2200)
                sampSendChat('/exam')
                wait(1500)
                thisScript():reload()
            elseif isKeyJustPressed(0x34) then
                sampSendChat('� ��� �� ������� ���. ������, ���������� � �������� � �������� ���.')
                if SecondsExam > 0 then sampAddChatMessage(tag_text..' ��� ������ ������� 30 ��� ����� ������, ������� ����� ��������.', tag_clr) end
                repeat wait(0) until SecondsExam == 0 or SecondsExam < 0
                ExamEnd(2)
                wait(2200)
                sampSendChat('/exam')
                wait(1500)
                thisScript():reload()
            end
        end
        repeat wait(0) until SecondsExam == 0 or SecondsExam < 0
        ExamEnd(2)
        wait(2200)
        sampSendChat('/exam')
        wait(1500)
        thisScript():reload()
    end)
end

function SellLic(type)
    lua_thread.create(function()
        sampSendChat('������������, ���� ����� '..rpnick..', � �������� ��������.')
        if type == 1 and Krit['WaterPriceSend'].v then
            local WaterPice = Round(Krit['WaterPrice'].v)
            wait(2200)
            sampSendChat('���� �������� �� ������ ��������� - '..WaterPice..'$.')
        elseif type == 2 and Krit['GunPriceSend'].v then
            local GunPice = Round(Krit['GunPrice'].v)
            wait(2200)
            sampSendChat('���� �������� �� ������ - '..GunPice..'$.')
        end
        wait(2200)
        sampSendChat('���������� ��� ��� ������� � ���. �����.')
        wait(2200)
        sampSendChat('/n ������� �������: /pass '..myid..', ���. �����: /med '..myid)
        wait(1000)
        if type == 1 then
            if Krit['NeedAgeWater'].v and not Krit['NeedMedWater'].v and not Krit['NeedLvlWater'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeWater'].v..'+ ���{FFFFFF}.', tag_clr) wait(1)
            elseif Krit['NeedAgeWater'].v and Krit['NeedMedWater'].v and not Krit['NeedLvlWater'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeWater'].v..'+ ���{FFFFFF} � ��������� ���. ������.', tag_clr) wait(1)
            elseif Krit['NeedAgeWater'].v and Krit['NeedMedWater'].v and Krit['NeedLvlWater'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeWater'].v..'+ ���{FFFFFF} � ��������� ���. ������ � {58ACFA}'..Krit['LvlWater'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif Krit['NeedAgeWater'].v and not Krit['NeedMedWater'].v and Krit['NeedLvlWater'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeWater'].v..'+ ���{FFFFFF} � {58ACFA}'..Krit['LvlWater'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif not Krit['NeedAgeWater'].v and Krit['NeedMedWater'].v and not Krit['NeedLvlWater'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������', tag_clr) wait(1)
            elseif not Krit['NeedAgeWater'].v and not Krit['NeedMedWater'].v and Krit['NeedLvlWater'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['LvlWater'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif not Krit['NeedAgeWater'].v and Krit['NeedMedWater'].v and Krit['NeedLvlWater'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������ {FFFFFF}� {58ACFA}'..Krit['LvlWater'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            end
        elseif type == 2 then
            if Krit['NeedAgeGun'].v and not Krit['NeedMedGun'].v and not Krit['NeedLvlGun'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeGun'].v..'+ ���{FFFFFF}.', tag_clr) wait(1)
            elseif Krit['NeedAgeGun'].v and Krit['NeedMedGun'].v and not Krit['NeedLvlGun'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeGun'].v..'+ ���{FFFFFF} � ��������� ���. ������.', tag_clr) wait(1)
            elseif Krit['NeedAgeGun'].v and Krit['NeedMedGun'].v and Krit['NeedLvlGun'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeGun'].v..'+ ���{FFFFFF} � ��������� ���. ������ � {58ACFA}'..Krit['LvlGun'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif Krit['NeedAgeGun'].v and not Krit['NeedMedGun'].v and Krit['NeedLvlGun'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeGun'].v..'+ ���{FFFFFF} � {58ACFA}'..Krit['LvlGun'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif not Krit['NeedAgeGun'].v and Krit['NeedMedGun'].v and not Krit['NeedLvlGun'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������', tag_clr) wait(1)
            elseif not Krit['NeedAgeGun'].v and not Krit['NeedMedGun'].v and Krit['NeedLvlGun'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['LvlGun'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif not Krit['NeedAgeGun'].v and Krit['NeedMedGun'].v and Krit['NeedLvlGun'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������ {FFFFFF}� {58ACFA}'..Krit['LvlGun'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            end
        end
        sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ���� �� �������, �� ������� - {58ACFA}2{FFFFFF}. ������ - {58ACFA}3{FFFFFF}.', tag_clr)
        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
        if isKeyJustPressed(0x31) then
            sampSendChat('/do � ����� ���� ��������� �������� � ����������.')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ���� � �������'..Sex..' �� ���� ������ ��������')
            wait(2200)
            sampSendChat('/me ����'..Sex..' � ���� �����, ����� ���� ��������'..Sex..' ��������')
            wait(2200)
            sampSendChat('/todo ��� ���� ��������*����� ���� �������'..Sex..' �������� �������� ��������')
            wait(2200)
            sampSendChat('/selllic '..tid..' '..type)
            if Toggle['AutoScreen'].v then
                while not SellState do wait(0)
                    if SellState then
                        wait(1000)
                        TimeScreen() 
                        while not ReloadAccept do wait(0)
                            if ReloadAccept then
                                thisScript():reload()
                            end
                        end
                    end
                end
            else
                thisScript():reload()
            end
        elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
            sampSendChat('� ��� �������� � �����������, � �� ���� ������� ��� ��������.')
            thisScript():reload()
        elseif isKeyJustPressed(0x33) then
            thisScript():reload()
        end
	end)
end

function sellinsurance()
    lua_thread.create(function()
        sampSendChat('������������, � '..rpnick..'. �� ����� ���� ������-�� ������������ ���� ���������?') wait(100)
        sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ������ - {58ACFA}2{FFFFFF}.', tag_clr)
        repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
        if isKeyJustPressed(0x31) then
            sampSendChat('������, ������������ ��� ��� �������, ���. ����� � ���.') 
            wait(2200)
            sampSendChat('/n ������� �������: /pass '..myid..', ���. �����: /med '..myid)
            wait(1000)
            if Krit['NeedAgeInsur'].v and not Krit['NeedMedInsur'].v and not Krit['NeedLvlInsur'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeInsur'].v..'+ ���{FFFFFF}.', tag_clr) wait(1)
            elseif Krit['NeedAgeInsur'].v and Krit['NeedMedInsur'].v and not Krit['NeedLvlInsur'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeInsur'].v..'+ ���{FFFFFF} � ��������� ���. ������.', tag_clr) wait(1)
            elseif Krit['NeedAgeInsur'].v and Krit['NeedMedInsur'].v and Krit['NeedLvlInsur'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeInsur'].v..'+ ���{FFFFFF} � ��������� ���. ������ � {58ACFA}'..Krit['LvlInsur'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif Krit['NeedAgeInsur'].v and not Krit['NeedMedInsur'].v and Krit['NeedLvlInsur'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['AgeInsur'].v..'+ ���{FFFFFF} � {58ACFA}'..Krit['LvlInsur'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif not Krit['NeedAgeInsur'].v and Krit['NeedMedInsur'].v and not Krit['NeedLvlInsur'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������', tag_clr) wait(1)
            elseif not Krit['NeedAgeInsur'].v and not Krit['NeedMedInsur'].v and Krit['NeedLvlInsur'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}'..Krit['LvlInsur'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            elseif not Krit['NeedAgeInsur'].v and Krit['NeedMedInsur'].v and Krit['NeedLvlInsur'].v then
                sampAddChatMessage(tag_text..' ��������: {58ACFA}��������� ���. ������ {FFFFFF}� {58ACFA}'..Krit['LvlInsur'].v..'+ LvL{FFFFFF}', tag_clr) wait(1)
            end
                sampAddChatMessage(tag_text..' ��� ����������� ������� - {58ACFA}1{FFFFFF}. ���� �� �������, �� ������� - {58ACFA}2{FFFFFF}. ������ - {58ACFA}3{FFFFFF}.', tag_clr)
                repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12)) or isKeyJustPressed(0x33)
                if isKeyJustPressed(0x31) then
                    sampSendChat('/do ���� � �������� � �����������, �������� � ���������� � ������ ����.')
                    wait(2200)
                    sampSendChat('/me ������'..Sex..' ����, ������'..Sex..' ���������, ����� ���� �����'..Sex..' ��������� ��')
                    wait(2200)
                    sampSendChat('/me ���� ��������'..Sex..' ������ "License center at", ���� � �������')
                    wait(2200)
                    sampSendChat('/me ����� ������� ���������, �� ��������� ������'..Sex..' ����')
                    wait(2200)
                    sampSendChat('/me �������'..Sex..' ��������� �������� ��������')
                    wait(200)
                    sampAddChatMessage(tag_text..' ������� ����: 10 ���� - {58ACFA}1{FFFFFF}, 30 ���� - {58ACFA}2{FFFFFF}, 60 ���� - {58ACFA}3', tag_clr)
                    sampSetChatInputEnabled(true)
                    sampSetChatInputText('/insurance '..tid..' ')
                    repeat wait(0) until isKeyJustPressed(0x0D)
                    if Toggle['AutoScreen'].v then
                        while not SellIns do wait(0)
                            if SellIns then
                                wait(1000)
                                TimeScreen() 
                                while not ReloadAccept do wait(0)
                                    if ReloadAccept then
                                        thisScript():reload()
                                    end
                                end
                            end
                        end
                    else
                        thisScript():reload()
                    end
                elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
                    sampSendChat('� ��� �������� � �����������, � �� ���� ������� ��� ���������.')
                    thisScript():reload()
                elseif isKeyJustPressed(0x33) then
                    thisScript():reload()
                end
        elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
            thisScript():reload()
        end
	end)
end
--------------------------------------------------
function rangup(arg)
    lua_thread.create(function()
        if arg == 2 then
            sampSendChat('/do � ������� ����� �������.')
            wait(2200)
            sampSendChat('/me ������'..Sex..' �������')
            wait(2200)
            sampSendChat('/do �� ��������� ������� "������ �����������".')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ����������, ����� �����'..Sex..' ������ "��������� � ���������"')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ����������', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/rang ')
        elseif arg == 1 then
            sampSendChat('/do � ������� ����� �������.')
            wait(2200)
            sampSendChat('/me ������'..Sex..' �������')
            wait(2200)
            sampSendChat('/do �� ��������� ������� "������ �����������".')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ����������, ����� �����'..Sex..' ������ "��������� � ���������"')
            wait(2200)
            sampSendChat('/rang '..tid)
        end
	end)
end

function giveskin(arg)
    lua_thread.create(function()
        if arg == 2 then
            sampSendChat('/do �� ����� ����� �����.')
            wait(2200)
            sampSendChat('/me �������'..Sex..' � ����� �����, ��������'..Sex..' �� �����')
            wait(2200)
            sampSendChat('/me ������'..Sex..' �������� ������� ������, ����� ���� �������'..Sex..' �������� ��������')
            wait(2200)
            sampSendChat('/todo ��� ���*�������� �����')
            wait(2200)
            sampSendChat('/me �������'..Sex..' ����� �� �����')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ����������', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/setskin ')
        elseif arg == 1 then
            sampSendChat('/do �� ����� ����� �����.')
            wait(2200)
            sampSendChat('/me �������'..Sex..' � ����� �����, ��������'..Sex..' �� �����')
            wait(2200)
            sampSendChat('/me ������'..Sex..' �������� ������� ������, ����� ���� �������'..Sex..' �������� ��������')
            wait(2200)
            sampSendChat('/todo ��� ���*�������� �����')
            wait(2200)
            sampSendChat('/me �������'..Sex..' ����� �� �����')
            wait(2200)
            sampSendChat('/setskin '..tid)
        end
	end)
end

function givewarn(arg)
	lua_thread.create(function()
        if arg == 2 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "�������"')
            else
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "�������"')
            end
            wait(2200)
            sampSendChat('/do ������� ������ �������� � ������ ���� ����������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ���������� � {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
            sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/fwarn [ID] �� | ������ ['..date..']', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/fwarn  ['..date..']')            
        elseif arg == 1 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "�������"')
            else
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "�������"')
            end
            wait(2200)
            sampSendChat('/do ������� ������ �������� � ������ ���� ����������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
            sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/fwarn '..tid..' �� | ������ ['..date..']', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/fwarn '..tid..'  ['..date..']')
        end
	end)
end

function givewarnoff()
	lua_thread.create(function()
        sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
        wait(2200)
        if Radio['Gender'].v == 1 then
            sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "�������"')
        else
            sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "�������"')
        end
        wait(2200)
        sampSendChat('/do ������� ������ �������� � ������ ���� ����������.')
        wait(2200)
        sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
        wait(500)
        sampAddChatMessage(tag_text..' ������� {58ACFA}Nick_Name{FFFFFF} ���������� � {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
        sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/fwarnoff Banana_Blackstone �� | ������ ['..date..']', tag_clr)
        sampSetChatInputEnabled(true)
        sampSetChatInputText('/fwarnoff  ['..date..']') 
	end)
end

function takeoffwarn(arg)
	lua_thread.create(function()
        if arg == 2 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "������ ��������"')
            else
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "������ ��������"')
            end
            wait(2200)
            sampSendChat('/do ������� ������ �������� � ������ ���� ����������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ���������� � {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
            sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/unfwarn [ID] �� | ��������� ['..date..']', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/unfwarn  ['..date..']') 
        elseif arg == 1 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "������ ��������"')
            else
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "������ ��������"')
            end
            wait(2200)
            sampSendChat('/do ������� ������ �������� � ������ ���� ����������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
            sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/unfwarn '..tid..' �� | ��������� ['..date..']', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/unfwarn '..tid..'  ['..date..']') 
        end
	end)
end

function uninvite(arg)
	lua_thread.create(function()
        if arg == 2 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "����������"')
            else
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "����������"')
            end
            wait(2200)
            sampSendChat('/do ������� ������������ ������ ���� ����������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ���������� � {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
            sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/uninvite [ID] �� | ����.���������� ['..date..']', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/uninvite  ['..date..']') 
        elseif arg == 1 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "����������"')
            else
                sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "����������"')
            end
            wait(2200)
            sampSendChat('/do ������� ������������ ������ ���� ����������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
            sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/uninvite '..tid..' �� | ����.���������� ['..date..']', tag_clr)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/uninvite '..tid..'  ['..date..']')
        end
	end)
end

function uninviteoff()
	lua_thread.create(function()
        sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
        wait(2200)
        if Radio['Gender'].v == 1 then
            sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� �������� ������� "����������"')
        else
            sampSendChat('/me ����� � ������ �����������, ����� ������� ����������, �������� ���� ��������� ������� "����������"')
        end
        wait(2200)
        sampSendChat('/do ������� ������������ ������ ���� ����������.')
        wait(2200)
        sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
        wait(500)
        sampAddChatMessage(tag_text..' ������� {58ACFA}Nick_Name{FFFFFF} ���������� � {58ACFA}�������{FFFFFF}', tag_clr) wait(1)
        sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/uninviteoff Banana_Blackstone �� | ����.���������� ['..date..']', tag_clr)
        sampSetChatInputEnabled(true)
        sampSetChatInputText('/uninviteoff  ['..date..']') 
	end)
end

function gobl(arg)
	lua_thread.create(function()
        if arg == 2 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ���� ������ ������������� ������, ����� ���� ����� �� ������� "������ ������"')
            else
                sampSendChat('/me ����� � ���� ������ ������������� ������, ����� ���� ������ �� ������� "������ ������"')
            end
            wait(2200)
            sampSendChat('/me ������'..Sex..' ������ �� ����������, ����� ���� �����'..Sex..' ������ "��������"')
            wait(2200)
            sampSendChat('/do ���� ��������...')
            wait(2200)
            sampSendChat('/do ������� �������� � ������ ������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(500)
            sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ����������', tag_clr) wait(1)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/black ') 
        elseif arg == 1 then
            sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
            wait(2200)
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ����� � ���� ������ ������������� ������, ����� ���� ����� �� ������� "������ ������"')
            else
                sampSendChat('/me ����� � ���� ������ ������������� ������, ����� ���� ������ �� ������� "������ ������"')
            end
            wait(2200)
            sampSendChat('/me ������'..Sex..' ������ �� ����������, ����� ���� �����'..Sex..' ������ "��������"')
            wait(2200)
            sampSendChat('/do ���� ��������...')
            wait(2200)
            sampSendChat('/do ������� �������� � ������ ������.')
            wait(2200)
            sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
            wait(2200)
            sampSendChat('/black '..tid) 
        end
	end)
end

function gobloff(arg)
	lua_thread.create(function()
        sampSendChat('/me ������'..Sex..' �� ������ ������� ���, �������'..Sex..' ���')
        wait(2200)
        if Radio['Gender'].v == 1 then
            sampSendChat('/me ����� � ���� ������ ������������� ������, ����� ���� ����� �� ������� "������ ������"')
        else
            sampSendChat('/me ����� � ���� ������ ������������� ������, ����� ���� ������ �� ������� "������ ������"')
        end
        wait(2200)
        sampSendChat('/me ������'..Sex..' ������ �� ����������, ����� ���� �����'..Sex..' ������ "��������"')
        wait(2200)
        sampSendChat('/do ���� ��������...')
        wait(2200)
        sampSendChat('/do ������� �������� � ������ ������.')
        wait(2200)
        sampSendChat('/me ��������'..Sex..' ���, �����'..Sex..' ��� � ������')
        wait(500)
        sampAddChatMessage(tag_text..' ������� {58ACFA}Nick_Name{FFFFFF} ����������', tag_clr) wait(1)
        --sampAddChatMessage(tag_text..' ������ �������������: {58ACFA}/uninviteoff Banana_Blackstone �� | ����.���������� ['..date..']', tag_clr)
        sampSetChatInputEnabled(true)
        sampSetChatInputText('/offblack ') 
	end)
end

function backbl(arg)
    lua_thread.create(function()
        if arg == 2 then
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ������ �������, ����� ���� ����� � ������ "׸���� ������ ������������� ������"')
            else
                sampSendChat('/me ������� �������, ����� ���� ����� � ������ "׸���� ������ ������������� ������"')
            end        
            wait(2200)
            sampSendChat('/me �����'..Sex..' �� ������ "�����", ����� ���� ����'..Sex..' ��� � ������� �������� � ����������� ����, ����� �����'..Sex..' "�����"')
            wait(2200)
            sampSendChat('/do ������� ������ ������ ������� ��������.')
            wait(2200)
            sampSendChat('/do ������ ���� ������ �� ������ �������� ������� ������: "��� �������" ������. � ���� �� ���� ���� ������ ��������: "�������" � "�������".')
            wait(2200)
            sampSendChat('/me �����'..Sex..' �� ������ "�������" , ����� �����'..Sex..' ������� � ������')
            wait(2200)
            sampSendChat('/do �� ������ �������� ������� �����������: "��� �������" ������� �� ������� ������ ������������� ������.')
            wait(500)
            sampAddChatMessage(tag_text..' ������� �������: {58ACFA}/offblack {FFFFFF}��� {58ACFA}/black', tag_clr) wait(1)
            sampSetChatInputEnabled(true) 
        elseif arg == 1 then
            if Radio['Gender'].v == 1 then
                sampSendChat('/me ������ �������, ����� ���� ����� � ������ "׸���� ������ ������������� ������"')
            else
                sampSendChat('/me ������� �������, ����� ���� ����� � ������ "׸���� ������ ������������� ������"')
            end        
            wait(2200)
            sampSendChat('/me �����'..Sex..' �� ������ "�����", ����� ���� ����'..Sex..' ��� � ������� �������� � ����������� ����, ����� �����'..Sex..' "�����"')
            wait(2200)
            sampSendChat('/do ������� ������ ������ ������� ��������.')
            wait(2200)
            sampSendChat('/do ������ ���� ������ �� ������ �������� ������� ������: "'..targrpnick..'" ������. � ���� �� ���� ���� ������ ��������: "�������" � "�������".')
            wait(2200)
            sampSendChat('/me �����'..Sex..' �� ������ "�������" , ����� �����'..Sex..' ������� � ������')
            wait(2200)
            sampSendChat('/do �� ������ �������� ������� �����������: "'..targrpnick..'" ������� �� ������� ������ ������������� ������.')
            wait(2200)
            sampSendChat('/black '..tid)
        end
	end)
end

function inviteFunc(st)
    lua_thread.create(function()
        if st == 1 then
            sampSendChat('������, �� ��� ���������! �������� ������ ����� � ��������.')
            wait(2200)
            if Toggle['TagF'].v then -- '..u8:decode(Input['Tag'].v)..'
                sampSendChat('/f '..u8:decode(Input['Tag'].v)..' ������� ����� ��������� �������� �� ����������.')
            else
                sampSendChat('/f ������� ����� ��������� �������� �� ����������.')
            end
            sampAddChatMessage(tag_text..' ���� �� ����� ��� �����������, ������� - {58ACFA}1{FFFFFF}. ���� ��� - {58ACFA}2{FFFFFF}.', tag_clr)
            repeat wait(0) until isKeyJustPressed(0x31) or (isKeyJustPressed(0x32) and not isKeyDown(0x12))
            if isKeyJustPressed(0x31) then
                sampSendChat('/do �� ����� ����� �����.')
                wait(2200)
                sampSendChat('/do �� ��������� ������� "������ �����������"')
                wait(2200)
                sampSendChat('/me ������'..Sex..' ����������, ����� �����'..Sex..' ������ "��������� � ���������"')
                wait(200)
                sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ������', tag_clr) wait(1)
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/invite ')
                congr()
            elseif (isKeyJustPressed(0x32) and not isKeyDown(0x12)) then
            end
        elseif st == 2 then
            sampSendChat('/do �� ����� ����� �����.')
            wait(2200)
            sampSendChat('/do �� ��������� ������� "������ �����������"')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ����������, ����� �����'..Sex..' ������ "��������� � ���������"')
            wait(200)
            sampAddChatMessage(tag_text..' ������� {58ACFA}id{FFFFFF} ������', tag_clr) wait(1)
            sampSetChatInputEnabled(true)
            sampSetChatInputText('/invite ')
            congr()
        elseif st == 3 then
            sampSendChat('/do �� ����� ����� �����.')
            wait(2200)
            sampSendChat('/do �� ��������� ������� "������ �����������"')
            wait(2200)
            sampSendChat('/me ������'..Sex..' ����������, ����� �����'..Sex..' ������ "��������� � ���������"')
            wait(2200)
            sampSendChat('/invite '..tid)
        end
    end)
end

-------------------------------------------------------------------------
function congr()
    lua_thread.create(function()
        repeat wait(0) until isKeyJustPressed(0x0D) or isKeyJustPressed(0x1B) or isKeyJustPressed(0x75)
            if isKeyJustPressed(0x0D) then
                sampSendChat('����������!')
            elseif isKeyJustPressed(0x1B) or isKeyJustPressed(0x75) then
            end
    end)
end

function ExamEnd(Result)
    lua_thread.create(function()
        repeat wait(0) until sampIsDialogActive() and sampGetDialogCaption() == '{FFFF7A}�������'
        sampSetCurrentDialogListItem(Result)
        setVirtualKeyDown(0x0D, true)
        wait(50)
        setVirtualKeyDown(0x0D, false)
    end)
end

function TimeScreen()
    lua_thread.create(function()
        if sampIsDialogActive() then
            while sampIsDialogActive() do wait(0)
                if not sampIsDialogActive() then
                    wait(1000)
                    sampSendChat('/time')
                    wait(1000)
                    makeScreen()
                    ReloadAccept = true
                end
            end
        else
            sampSendChat('/time')
            wait(1000)
            makeScreen()
            ReloadAccept = true
        end
    end)
end

function onScriptTerminate(scriptt)
    if scriptt == thisScript() then
        sampTextdrawDelete(35)
        for i = 1, #Notepad do
            Notepad[i].WindowSt = false saveJsonS()
        end
        deleteCheckpoint(marker)
        removeBlip(checkpoint)
        removeBlip(targ_bl)
    end
end

function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end

--------------------------------------------------------------------------   

function saveJson()
    if doesFileExist(JsonPath) then
      local f = io.open(JsonPath, 'w+')
      if f then
        f:write(encodeJson(config)):close()
      end
    end
end

function saveJsonL()
    if doesFileExist(JsonPathL) then
      local f = io.open(JsonPathL, 'w+')
      if f then
        f:write(encodeJson(Lections)):close()
      end
    end
end

function saveJsonG()
    if doesFileExist(JsonPathG) then
      local f = io.open(JsonPathG, 'w+')
      if f then
        f:write(encodeJson(GNews)):close()
      end
    end
end

function saveJsonB()
    if doesFileExist(JsonPathB) then
      local f = io.open(JsonPathB, 'w+')
      if f then
        f:write(encodeJson(Binder)):close()
      end
    end
end

function saveJsonS()
    if doesFileExist(JsonPathS) then
      local f = io.open(JsonPathS, 'w+')
      if f then
        f:write(encodeJson(Notepad)):close()
      end
    end
end

function imgui.ButtonHint(hint, text, delay)
    if imgui.Button(text) then return true end
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5 -- �������� ���������
        if os.clock() >= go_hint then
            imgui.PushStyleVar(imgui.StyleVar.Alpha, (alpha <= 1.0 and alpha or 1.0))
                --imgui.PushStyleColor(imgui.Col.PopupBg, imgui.GetStyle().Colors[imgui.Col.ButtonHovered])
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(hint)
                    if not imgui.IsItemVisible() and imgui.GetStyle().Alpha == 1.0 then go_hint = nil end
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                --imgui.PopStyleColor()
            imgui.PopStyleVar()
        end
    end
end

function Round(n)
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1.'):reverse())..right
end

function IsPlayerInRangeOfPoint(tposX, tposY, tposZ, Radius)
	local myX, myY, myZ = getCharCoordinates(1)
	local Xm, Ym, Zm = myX-tposX, myY-tposY, myZ-tposZ
	if (((Xm < Radius) and (Xm >-Radius)) and ((Ym < Radius) and (Ym >-Radius)) and ((Zm < Radius) and (Zm >-Radius))) then 
		return true 
	end
	return false
end

function isCommandDouble(command)
	for i = 1, #Binder do
		if command == Binder[i].command and command ~= '' then
			return true
		end
    end
    for i = 1, #Notepad do
		if command == Notepad[i].command and command ~= '' then
			return true
		end
	end
	return false
end

function isKeyDouble(key)
    for i = 1, #Binder do
		if key == Binder[i].v then
			return true
		end
    end
    for i = 1, #Notepad do
		if key == Notepad[i].v then
			return true
		end
	end
	return false
end

function imgui.TextRGB(text, render_text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
            local a = bit.band(bit.rshift(argb, 24), 0xFF)
            local r = bit.band(bit.rshift(argb, 16), 0xFF)
            local g = bit.band(bit.rshift(argb, 8), 0xFF)
            local b = bit.band(argb, 0xFF)
            return a, r, g, b
    end

    local getcolor = function(color)
            if color:sub(1, 6):upper() == 'SSSSSS' then
                    local r, g, b = colors[1].x, colors[1].y, colors[1].z
                    local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
                    return ImVec4(r, g, b, a / 255)
            end
            local color = type(color) == 'string' and tonumber(color, 16) or color
            if type(color) ~= 'number' then return end
            local r, g, b, a = explode_argb(color)
            return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text)
            for w in text:gmatch('[^\r\n]+') do
                local textsize = w:gsub('{.-}', '')
                local text_width = imgui.CalcTextSize(u8(textsize))
                    local text, colors_, m = {}, {}, 1
                    w = w:gsub('{(......)}', '{%1FF}')
                    while w:find('{........}') do
                            local n, k = w:find('{........}')
                            local color = getcolor(w:sub(n + 1, k - 1))
                            if color then
                                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                                    colors_[#colors_ + 1] = color
                                    m = n
                            end
                            w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
                    end
                    local length = imgui.CalcTextSize(u8(w))
                    if render_text == 2 then
                            imgui.NewLine()
                            imgui.SameLine(width / 2 - ( length.x / 2 ))
                    elseif render_text == 3 then
                            imgui.NewLine()
                            imgui.SameLine(width - length.x - 5 )
                    end
                    if text[0] then
                            for i, k in pairs(text) do
                                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                                    imgui.SameLine(nil, 0)
                            end
                            imgui.NewLine()
                    else imgui.Text(u8(w)) end
            end
    end

    render_text(text)
end

function imgui.TextRGBcopy(text, render_text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
            local a = bit.band(bit.rshift(argb, 24), 0xFF)
            local r = bit.band(bit.rshift(argb, 16), 0xFF)
            local g = bit.band(bit.rshift(argb, 8), 0xFF)
            local b = bit.band(argb, 0xFF)
            return a, r, g, b
    end

    local getcolor = function(color)
            if color:sub(1, 6):upper() == 'SSSSSS' then
                    local r, g, b = colors[1].x, colors[1].y, colors[1].z
                    local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
                    return ImVec4(r, g, b, a / 255)
            end
            local color = type(color) == 'string' and tonumber(color, 16) or color
            if type(color) ~= 'number' then return end
            local r, g, b, a = explode_argb(color)
            return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text)
            for w in text:gmatch('[^\r\n]+') do
                local textsize = w:gsub('{.-}', '')
                local text_width = imgui.CalcTextSize(u8(textsize))
                    local text, colors_, m = {}, {}, 1
                    w = w:gsub('{(......)}', '{%1FF}')
                    while w:find('{........}') do
                            local n, k = w:find('{........}')
                            local color = getcolor(w:sub(n + 1, k - 1))
                            if color then
                                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                                    colors_[#colors_ + 1] = color
                                    m = n
                            end
                            w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
                    end
                    local length = imgui.CalcTextSize(u8(w))
                    if render_text == 2 then
                            imgui.NewLine()
                            imgui.SameLine(width / 2 - ( length.x / 2 ))
                    elseif render_text == 3 then
                            imgui.NewLine()
                            imgui.SameLine(width - length.x - 5 )
                    end
                    if text[0] then
                            for i, k in pairs(text) do
                                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                                    if imgui.IsItemClicked() then
                                        imgui.LogToClipboard()
                                        imgui.LogText(u8(w))
                                        imgui.LogFinish()
                                    end
                                    imgui.SameLine(nil, 0)
                            end
                            imgui.NewLine()
                    else imgui.Text(u8(w)) 
                        if imgui.IsItemClicked() then
                            imgui.LogToClipboard()
                            imgui.LogText(u8(w))
                            imgui.LogFinish()
                        end
                    end
            end
    end

    render_text(text)
end

function makeScreen(disable) -- ���� �������� true, ��������� � ��� ����� ������
    if disable then displayHud(false) sampSetChatDisplayMode(0) end
    require('memory').setuint8(sampGetBase() + 0x119CBC, 1)
    if disable then displayHud(true) sampSetChatDisplayMode(2) end
end

function imgui.TextQuestion(hint, delay) -- ������� ��� ��������� ���������
    imgui.TextDisabled(fa.ICON_QUESTION_CIRCLE) -- ������ ��� ����������� ���������
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5 -- �������� ���������
        if os.clock() >= go_hint then
            imgui.PushStyleVar(imgui.StyleVar.Alpha, (alpha <= 1.0 and alpha or 1.0))
                --imgui.PushStyleColor(imgui.Col.PopupBg, imgui.GetStyle().Colors[imgui.Col.ButtonHovered])
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(hint)
                    if not imgui.IsItemVisible() and imgui.GetStyle().Alpha == 1.0 then go_hint = nil end
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                --imgui.PopStyleColor()
            imgui.PopStyleVar()
        end
    end
end

function imgui.TextWarning(hint)
    imgui.Text(fa.ICON_EXCLAMATION_TRIANGLE) 
    if imgui.IsItemHovered() then
        if go_hint == nil then go_hint = os.clock() + (delay and delay or 0.0) end
        local alpha = (os.clock() - go_hint) * 5 -- �������� ���������
        if os.clock() >= go_hint then
            imgui.PushStyleVar(imgui.StyleVar.Alpha, (alpha <= 1.0 and alpha or 1.0))
                --imgui.PushStyleColor(imgui.Col.PopupBg, imgui.GetStyle().Colors[imgui.Col.ButtonHovered])
                    imgui.BeginTooltip()
                    imgui.PushTextWrapPos(450)
                    imgui.TextUnformatted(hint)
                    if not imgui.IsItemVisible() and imgui.GetStyle().Alpha == 1.0 then go_hint = nil end
                    imgui.PopTextWrapPos()
                    imgui.EndTooltip()
                --imgui.PopStyleColor()
            imgui.PopStyleVar()
        end
    end
end

function imgui.VerticalSeparator()
    local p = imgui.GetCursorScreenPos()
    imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x, p.y + imgui.GetContentRegionMax().y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Separator]))
end

function sampGetPlayerIdByNickname(nick)
    local _, myid = sampGetPlayerIdByCharHandle(playerPed)
    if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
    for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end

function setMarker(type, x, y, z, radius, color)
    deleteCheckpoint(marker)
    removeBlip(checkpoint)
    checkpoint = addBlipForCoord(x, y, z)
    marker = createCheckpoint(type, x, y, z, 1, 1, 1, radius)
    changeBlipColour(checkpoint, color)
    lua_thread.create(function()
    repeat
        wait(0)
        local x1, y1, z1 = getCharCoordinates(PLAYER_PED)
        until getDistanceBetweenCoords3d(x, y, z, x1, y1, z1) < radius or not doesBlipExist(checkpoint)
        deleteCheckpoint(marker)
        removeBlip(checkpoint)
        addOneOffSound(0, 0, 0, 1149)
    end)
end

function theme1()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function theme2()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
        colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function theme3()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.48, 0.23, 0.16, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.98, 0.43, 0.26, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.88, 0.39, 0.24, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.43, 0.26, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.98, 0.43, 0.26, 1.00)
        colors[clr.Header]                 = ImVec4(0.98, 0.43, 0.26, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.98, 0.43, 0.26, 0.80)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.FrameBg]                = ImVec4(0.48, 0.23, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.43, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.43, 0.26, 0.67)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.Button]                 = ImVec4(0.98, 0.43, 0.26, 0.40)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.28, 0.06, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.43, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.25, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.25, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.43, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.43, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.43, 0.26, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.50, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.43, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function theme4()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
        colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 0.40)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function theme5()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
        colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
        colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
    colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
    colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

function theme6()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
        colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
        colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
        colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
        colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
        colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
        colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
        colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
        colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
    colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
    colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
    colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
    colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
    colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
    colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
    colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
    colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
    colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
    colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
    colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
    colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
    colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
    colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
    colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
    colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
    colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
    colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end

function theme7()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
        colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
        colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
        colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
        colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
        colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
    colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
    colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

function theme8()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.46, 0.46, 0.46, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.99, 0.99, 0.99, 0.52)
        colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.42)
        colors[clr.SliderGrabActive]       = ImVec4(0.76, 0.76, 0.76, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.68, 0.68, 0.68, 1.00)
        colors[clr.Header]                 = ImVec4(0.72, 0.72, 0.72, 0.54)
        colors[clr.HeaderHovered]          = ImVec4(0.92, 0.92, 0.95, 0.77)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(1.00, 1.00, 1.00, 0.79)
    colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
    colors[clr.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.PopupBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.Border]                 = ImVec4(0.82, 0.77, 0.78, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.35, 0.35, 0.35, 0.66)
    colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 0.28)
    colors[clr.FrameBgHovered]         = ImVec4(0.68, 0.68, 0.68, 0.67)
    colors[clr.FrameBgActive]          = ImVec4(0.79, 0.73, 0.73, 0.62)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.MenuBarBg]              = ImVec4(0.00, 0.00, 0.00, 0.80)
    colors[clr.ScrollbarBg]            = ImVec4(0.00, 0.00, 0.00, 0.60)
    colors[clr.ScrollbarGrab]          = ImVec4(1.00, 1.00, 1.00, 0.87)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.80, 0.50, 0.50, 0.40)
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 0.99)
    colors[clr.Button]                 = ImVec4(0.51, 0.51, 0.51, 0.60)
    colors[clr.ButtonActive]           = ImVec4(0.67, 0.67, 0.67, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.82, 0.82, 0.82, 0.80)
    colors[clr.Separator]              = ImVec4(0.73, 0.73, 0.73, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.81, 0.81, 0.81, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.74, 0.74, 0.74, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.80, 0.80, 0.80, 0.30)
    colors[clr.ResizeGripHovered]      = ImVec4(0.95, 0.95, 0.95, 0.60)
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90)
    colors[clr.CloseButton]            = ImVec4(0.45, 0.45, 0.45, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.70, 0.70, 0.90, 0.60)
    colors[clr.CloseButtonActive]      = ImVec4(0.70, 0.70, 0.70, 1.00)
    colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 1.00, 1.00, 0.35)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.88, 0.88, 0.88, 0.35)
end

function theme9()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg] = ImVec4(0.08, 0.10, 0.12, 1.00)
        colors[clr.TitleBgActive] = ImVec4(0.20, 0.25, 0.30, 1.00)
        colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
        colors[clr.Header] = ImVec4(0.26, 0.59, 0.98, 0.80)
        colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.70)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
    colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
    colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
    colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
    colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
    colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.20, 0.20, 0.20, 0.35);
end

function theme10()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg] = ImVec4(0.232, 0.201, 0.271, 1.00)
        colors[clr.TitleBgActive] = ImVec4(0.502, 0.075, 0.256, 1.00)
        colors[clr.CheckMark] = ImVec4(0.71, 0.22, 0.27, 1.00)
        colors[clr.SliderGrab] = ImVec4(0.47, 0.77, 0.83, 0.14)
        colors[clr.SliderGrabActive] = ImVec4(0.71, 0.22, 0.27, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.455, 0.198, 0.301, 0.86)
        colors[clr.Header] = ImVec4(0.455, 0.198, 0.301, 0.76)
        colors[clr.HeaderHovered] = ImVec4(0.455, 0.198, 0.301, 0.86)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.455, 0.198, 0.301, 0.78)
    colors[clr.Text] = ImVec4(0.860, 0.930, 0.890, 0.78)
    colors[clr.TextDisabled] = ImVec4(0.860, 0.930, 0.890, 0.28)
    colors[clr.WindowBg] = ImVec4(0.13, 0.14, 0.17, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.200, 0.220, 0.270, 0.58)
    colors[clr.PopupBg] = ImVec4(0.200, 0.220, 0.270, 0.9)
    colors[clr.Border] = ImVec4(0.31, 0.31, 1.00, 0.00)
    colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg] = ImVec4(0.200, 0.220, 0.270, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.455, 0.198, 0.301, 0.78)
    colors[clr.FrameBgActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(0.200, 0.220, 0.270, 0.75)
    colors[clr.MenuBarBg] = ImVec4(0.200, 0.220, 0.270, 0.47)
    colors[clr.ScrollbarBg] = ImVec4(0.200, 0.220, 0.270, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.09, 0.15, 0.1, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
    colors[clr.Button] = ImVec4(0.47, 0.77, 0.83, 0.14)
    colors[clr.ButtonActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.502, 0.075, 0.256, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.47, 0.77, 0.83, 0.04)
    colors[clr.ResizeGripHovered] = ImVec4(0.455, 0.198, 0.301, 0.78)
    colors[clr.ResizeGripActive] = ImVec4(0.455, 0.198, 0.301, 1.00)
    colors[clr.PlotLines] = ImVec4(0.860, 0.930, 0.890, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.455, 0.198, 0.301, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.860, 0.930, 0.890, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.455, 0.198, 0.301, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.455, 0.198, 0.301, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(0.200, 0.220, 0.270, 0.73)
end

function theme11()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]              = ImVec4(0.47, 0.22, 0.22, 0.67)
        colors[clr.TitleBgActive]        = ImVec4(0.47, 0.22, 0.22, 1.00)
        colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
        colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
        colors[clr.SliderGrabActive]     = ImVec4(0.84, 0.66, 0.66, 1.00)
        colors[clr.ButtonHovered]        = ImVec4(0.71, 0.39, 0.39, 0.65)
        colors[clr.Header]               = ImVec4(0.71, 0.39, 0.39, 0.54)
        colors[clr.HeaderHovered]        = ImVec4(0.84, 0.66, 0.66, 0.65)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)
    colors[clr.WindowBg]             = ImVec4(0.09, 0.09, 0.09, 0.94)
    colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(0.84, 0.66, 0.66, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(0.84, 0.66, 0.66, 0.67)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.47, 0.22, 0.22, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(0.34, 0.16, 0.16, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.Button]               = ImVec4(0.47, 0.22, 0.22, 0.65)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.HeaderActive]         = ImVec4(0.84, 0.66, 0.66, 0.00)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.ResizeGrip]           = ImVec4(0.71, 0.39, 0.39, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.84, 0.66, 0.66, 0.66)
    colors[clr.ResizeGripActive]     = ImVec4(0.84, 0.66, 0.66, 0.66)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function theme12()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 0.81);
        colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
        colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
        colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
        colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
        colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
        colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
        colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end

function theme13()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg] = ImVec4(0.14, 0.18, 0.21, 0.73)
        colors[clr.TitleBgActive] = ImVec4(0.00, 1.00, 1.00, 0.27)
        colors[clr.CheckMark] = ImVec4(0.00, 1.00, 1.00, 0.68)
        colors[clr.SliderGrab] = ImVec4(0.00, 1.00, 1.00, 0.36)
        colors[clr.SliderGrabActive] = ImVec4(0.00, 1.00, 1.00, 0.76)
        colors[clr.ButtonHovered] = ImVec4(0.01, 1.00, 1.00, 0.43)
        colors[clr.Header] = ImVec4(0.00, 1.00, 1.00, 0.33)
        colors[clr.HeaderHovered] = ImVec4(0.00, 1.00, 1.00, 0.42)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
    colors[clr.Text] = ImVec4(0.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.00, 0.40, 0.41, 1.00)
    colors[clr.WindowBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.Border] = ImVec4(0.00, 1.00, 1.00, 0.65)
    colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg] = ImVec4(0.44, 0.80, 0.80, 0.18)
    colors[clr.FrameBgHovered] = ImVec4(0.44, 0.80, 0.80, 0.27)
    colors[clr.FrameBgActive] = ImVec4(0.44, 0.81, 0.86, 0.66)
    colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.54)
    colors[clr.MenuBarBg] = ImVec4(0.00, 0.00, 0.00, 0.20)
    colors[clr.ScrollbarBg] = ImVec4(0.22, 0.29, 0.30, 0.71)
    colors[clr.ScrollbarGrab] = ImVec4(0.00, 1.00, 1.00, 0.44)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
    colors[clr.ComboBg] = ImVec4(0.16, 0.24, 0.22, 0.60)
    colors[clr.Button] = ImVec4(0.00, 0.65, 0.65, 0.46)
    colors[clr.ButtonActive] = ImVec4(0.00, 1.00, 1.00, 0.62)
    colors[clr.HeaderActive] = ImVec4(0.00, 1.00, 1.00, 0.54)
    colors[clr.ResizeGrip] = ImVec4(0.00, 1.00, 1.00, 0.54)
    colors[clr.ResizeGripHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
    colors[clr.ResizeGripActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
    colors[clr.CloseButton] = ImVec4(0.00, 0.78, 0.78, 0.35)
    colors[clr.CloseButtonHovered] = ImVec4(0.00, 0.78, 0.78, 0.47)
    colors[clr.CloseButtonActive] = ImVec4(0.00, 0.78, 0.78, 1.00)
    colors[clr.PlotLines] = ImVec4(0.00, 1.00, 1.00, 1.00)
    colors[clr.PlotLinesHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.00, 1.00, 1.00, 0.22)
    colors[clr.ModalWindowDarkening] = ImVec4(0.04, 0.10, 0.09, 0.51)
end

function theme14()

    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]               = ImVec4(0.00, 0.45, 1.00, 0.82)
        colors[clr.TitleBgActive]         = ImVec4(0.00, 0.45, 1.00, 0.82)
        colors[clr.CheckMark]             = ImVec4(0.00, 0.49, 1.00, 0.59)
        colors[clr.SliderGrab]            = ImVec4(0.00, 0.49, 1.00, 0.59)
        colors[clr.SliderGrabActive]      = ImVec4(0.00, 0.39, 1.00, 0.71)
        colors[clr.ButtonHovered]         = ImVec4(0.00, 0.49, 1.00, 0.71)
        colors[clr.Header]                = ImVec4(0.00, 0.49, 1.00, 0.78)
        colors[clr.HeaderHovered]         = ImVec4(0.00, 0.49, 1.00, 0.71)
        colors[clr.ScrollbarGrabHovered]  = ImVec4(0.00, 0.33, 1.00, 0.84)
    colors[clr.Text]                  = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.TextDisabled]          = ImVec4(0.24, 0.24, 0.24, 1.00)
    colors[clr.WindowBg]              = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.ChildWindowBg]         = ImVec4(0.96, 0.96, 0.96, 1.00)
    colors[clr.PopupBg]               = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.Border]                = ImVec4(0.86, 0.86, 0.86, 1.00)
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]               = ImVec4(0.88, 0.88, 0.88, 1.00)
    colors[clr.FrameBgHovered]        = ImVec4(0.82, 0.82, 0.82, 1.00)
    colors[clr.FrameBgActive]         = ImVec4(0.76, 0.76, 0.76, 1.00)
    colors[clr.TitleBgCollapsed]      = ImVec4(0.00, 0.45, 1.00, 0.82)
    colors[clr.MenuBarBg]             = ImVec4(0.00, 0.37, 0.78, 1.00)
    colors[clr.ScrollbarBg]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ScrollbarGrab]         = ImVec4(0.00, 0.35, 1.00, 0.78)
    colors[clr.ScrollbarGrabActive]   = ImVec4(0.00, 0.31, 1.00, 0.88)
    colors[clr.ComboBg]               = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.Button]                = ImVec4(0.00, 0.49, 1.00, 0.59)
    colors[clr.ButtonActive]          = ImVec4(0.00, 0.49, 1.00, 0.78)
    colors[clr.HeaderActive]          = ImVec4(0.00, 0.49, 1.00, 0.78)
    colors[clr.ResizeGrip]            = ImVec4(0.00, 0.39, 1.00, 0.59)
    colors[clr.ResizeGripHovered]     = ImVec4(0.00, 0.27, 1.00, 0.59)
    colors[clr.ResizeGripActive]      = ImVec4(0.00, 0.25, 1.00, 0.63)
    colors[clr.CloseButton]           = ImVec4(0.00, 0.35, 0.96, 0.71)
    colors[clr.CloseButtonHovered]    = ImVec4(0.00, 0.31, 0.88, 0.69)
    colors[clr.CloseButtonActive]     = ImVec4(0.00, 0.25, 0.88, 0.67)
    colors[clr.PlotLines]             = ImVec4(0.00, 0.39, 1.00, 0.75)
    colors[clr.PlotLinesHovered]      = ImVec4(0.00, 0.39, 1.00, 0.75)
    colors[clr.PlotHistogram]         = ImVec4(0.00, 0.39, 1.00, 0.75)
    colors[clr.PlotHistogramHovered]  = ImVec4(0.00, 0.35, 0.92, 0.78)
    colors[clr.TextSelectedBg]        = ImVec4(0.00, 0.47, 1.00, 0.59)
    colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35)
end

function theme15()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg] = ImVec4(0.96, 0.96, 0.96, 1.00)
        colors[clr.TitleBgActive] = ImVec4(0.82, 0.82, 0.82, 1.00)
        colors[clr.CheckMark] = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.SliderGrab] = ImVec4(0.24, 0.52, 0.88, 1.00)
        colors[clr.SliderGrabActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.ButtonHovered] = ImVec4(0.26, 0.59, 0.98, 1.00)
        colors[clr.Header]= ImVec4(0.26, 0.59, 0.98, 0.31)
        colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
        colors[clr.ScrollbarGrabHovered] = ImVec4(0.59, 0.59, 0.59, 1.00)
    colors[clr.Text] = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.60, 0.60, 0.60, 1.00)
    colors[clr.WindowBg] = ImVec4(0.94, 0.94, 0.94, 0.94)
    colors[clr.ChildWindowBg] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.PopupBg] = ImVec4(1.00, 1.00, 1.00, 0.94)
    colors[clr.Border]= ImVec4(0.00, 0.00, 0.00, 0.39)
    colors[clr.BorderShadow] = ImVec4(1.00, 1.00, 1.00, 0.10)
    colors[clr.FrameBg] = ImVec4(1.00, 1.00, 1.00, 0.94)
    colors[clr.FrameBgHovered]= ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive] = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBgCollapsed] = ImVec4(1.00, 1.00, 1.00, 0.51)
    colors[clr.MenuBarBg] = ImVec4(0.86, 0.86, 0.86, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.98, 0.98, 0.98, 0.53)
    colors[clr.ScrollbarGrab] = ImVec4(0.69, 0.69, 0.69, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.49, 0.49, 0.49, 1.00)
    colors[clr.ComboBg] = ImVec4(0.86, 0.86, 0.86, 0.99)
    colors[clr.Button]= ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip] = ImVec4(1.00, 1.00, 1.00, 0.50)
    colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive] = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.CloseButton] = ImVec4(0.59, 0.59, 0.59, 0.50)
    colors[clr.CloseButtonHovered] = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive] = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines] = ImVec4(0.39, 0.39, 0.39, 1.00)
    colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]= ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.20, 0.20, 0.20, 0.35)
end

function theme16()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
        colors[clr.TitleBgActive]          = ImVec4(0.42, 0.48, 0.16, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.85, 0.98, 0.26, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.77, 0.88, 0.24, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.85, 0.98, 0.26, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.85, 0.98, 0.26, 1.00)
        colors[clr.Header]                 = ImVec4(0.85, 0.98, 0.26, 0.31)
        colors[clr.HeaderHovered]          = ImVec4(0.85, 0.98, 0.26, 0.80)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.FrameBg]                = ImVec4(0.42, 0.48, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.Button]                 = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.ButtonActive]           = ImVec4(0.82, 0.98, 0.06, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.63, 0.75, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.63, 0.75, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.85, 0.98, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.85, 0.98, 0.26, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.85, 0.98, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function theme17()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

        colors[clr.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 0.80)
        colors[clr.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
        colors[clr.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
        colors[clr.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
        colors[clr.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
        colors[clr.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
    colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.10, 0.10, 0.10, 1.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
    colors[clr.Border]                 = ImVec4(0.70, 0.70, 0.70, 0.40)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
    colors[clr.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
    colors[clr.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
    colors[clr.ComboBg]                = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
    colors[clr.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
    colors[clr.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
    colors[clr.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
    colors[clr.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
    colors[clr.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.00, 0.82, 0.39, 1.00)
    colors[clr.CloseButtonHovered]     = ImVec4(0.00, 0.88, 0.42, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.00, 1.00, 0.48, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.17, 0.17, 0.17, 0.48)
end

function strongstyle()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    style.WindowPadding = imgui.ImVec2(4, 4)
    style.WindowRounding = 0
    style.ChildWindowRounding = 0
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 13
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8
    style.GrabRounding = 0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end

function easystyle()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    style.WindowPadding = imgui.ImVec2(4, 4)
    style.WindowRounding = 7
    style.ChildWindowRounding = 0
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 4
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 13
    style.ScrollbarRounding = 10
    style.GrabMinSize = 8
    style.GrabRounding = 10
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end

function setstyleandtheme()
    if Style.v == 1 then strongstyle() end
    if Style.v == 2 then easystyle() end
    if Theme.v == 1 then theme1() end
    if Theme.v == 2 then theme2() end
    if Theme.v == 3 then theme3() end
    if Theme.v == 4 then theme4() end
    if Theme.v == 5 then theme5() end
    if Theme.v == 6 then theme6() end
    if Theme.v == 7 then theme7() end
    if Theme.v == 8 then theme8() end
    if Theme.v == 9 then theme9() end
    if Theme.v == 10 then theme10() end	
    if Theme.v == 11 then theme11() end
    if Theme.v == 12 then theme12() end
    if Theme.v == 13 then theme13() end
    if Theme.v == 14 then theme14() end
    if Theme.v == 15 then theme15() end
    if Theme.v == 16 then theme16() end
    if Theme.v == 17 then theme17() end
end