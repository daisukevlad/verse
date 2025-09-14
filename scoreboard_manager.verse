using { /Verse.org/Simulation }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors/NamedColors }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/Characters }
using { /Fortnite.com/UI }
using { /Verse.org/Colors }
using { /Fortnite.com/Game }

StrToMsg<localizes>(String : string): message = "{String}"

IdxToPadding(i : int): margin=
    case(i):
        1 => return margin{Right := 10.0, Top := 8.0, Left := 10.0}
        _ => return margin{Right := 10.0, Left := 10.0}

(String : string).StrToTxt(): text_block=

    return text_block{DefaultText := StrToMsg(String), DefaultJustification := text_justification.Center, DefaultTextSize := 25.0, DefaultTextColor := White}

(Message : message).MessageToTxt(): text_block=
    return text_block{DefaultText := Message, DefaultJustification := text_justification.Center, DefaultTextSize := 25.0, DefaultTextColor := White}

GetMainStackBox(Placement : []string, PlayerNames : []message, Rebirths : []string, Steals : []string, Cash : []string, PlayerIdx : int): stack_box=
    MainStackBox := stack_box{Orientation := orientation.Horizontal}
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(Placement)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxNames(PlayerNames, PlayerIdx)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(Rebirths)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(Steals)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(Cash)})

    return MainStackBox
    
GetStackBoxColumn(Information :[]string): stack_box=
    var TextBlockWidgets : []text_block = array{}
    StackBox := stack_box{Orientation := orientation.Vertical}

    for (Idx -> Info : Information):
        NewTextBlock := Info.StrToTxt()
        set TextBlockWidgets += array{NewTextBlock}
        StackBox.AddWidget(stack_box_slot{Widget := NewTextBlock, Padding := IdxToPadding(Idx)})
    
    return StackBox

GetStackBoxNames(Information :[]message, i : int): stack_box=
    var TextBlockWidgets : []text_block = array{}
    StackBox := stack_box{Orientation := orientation.Vertical}

    for (Idx -> Info : Information):
        NewTextBlock := Info.MessageToTxt()
        if (i = Idx):
            NewTextBlock.SetTextColor(Blue)
        
        set TextBlockWidgets += array{NewTextBlock}
        StackBox.AddWidget(stack_box_slot{Widget := NewTextBlock, Padding := IdxToPadding(Idx)})
    
    return StackBox

GetPersistentData(Player : player): saved_player_data=
    if (Data := SavedPlayerDataMap[Player]):
        return Data
    return saved_player_data{}

AgentToMsg<localizes>(Agent : agent): message= "{Agent}"

scoreboard_manager := class(creative_device):
    var PlayersMap :[player]canvas = map{}
    @editable CashHudMessage : hud_message_device = hud_message_device{}
    OnAdded(Player : player): void=
        if (not PlayersMap[Player], PlayerUI := GetPlayerUI[Player]):
            option {set PlayersMap[Player] = canvas{}}

    OnRemoved(Player : player): void=
        var NewMap :[player]canvas = map{}
        for (Idx -> Player1 : PlayersMap, Idx <> Player):
            set NewMap = ConcatenateMaps(NewMap, map{ Idx => Player1})
        set PlayersMap = NewMap

    GetCanvas(MainStackBox : stack_box): canvas=

        return canvas{Slots := array:
            canvas_slot{Alignment := vector2{X := 0.5, Y := 0.0}, SizeToContent := true, Widget := color_block{DefaultColor := Black, DefaultDesiredSize := vector2{X := 700.0, Y := PlayersMap.Length * 37.0+ 90.0}, DefaultOpacity := 0.7}, Offsets := margin{Top := -0.0, Left := -250.0}, Anchors := anchors{Minimum := vector2{X := 1.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}}
            canvas_slot{Alignment := vector2{X := 0.5, Y := 0.0}, SizeToContent := true, Widget := MainStackBox, Offsets := margin{Top := -0.0, Left := -320.0}, Anchors := anchors{Minimum := vector2{X := 1.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}}
        }
    (Players : []player).GetPlayerIdx(Player : player): int=
        for (i -> Playr : Players, Player = Playr):
            return i
        return -1

    PlayerNamesMessage<localizes>: message = {"Player Name"}
    MainLoop()<suspends>: void=
        loop:
            var Placements : []string = array{""}
            var PlayerNames : []message = array{PlayerNamesMessage}
            var Rebirths : []string = array{"Rebirths"}
            var Steals : []string = array{"Steals"}
            var Cash : []string = array{"Cash"}
            SortedPlayers := GetSortedPlayerRankings(GetPlayspace())
            for (Idx -> Player : SortedPlayers, Player.IsActive[]):
                Data := GetPersistentData(Player)
                set Placements += array{"#{Idx + 1}"}
                set PlayerNames += array{AgentToMsg(Player)}
                set Rebirths += array{"{Data.Rebirths}"}
                set Steals += array{"{Data.Steals}"}
                set Cash += array{"{baggas_utils.Format(Data.Cash)}"}
                CashHudMessage.Show(Player, StrToMsg("$ {baggas_utils.Format(Data.Cash)}"))

            
            for (Player -> Canvas : PlayersMap, PlayerUI := GetPlayerUI[Player]):
                PlayerIdx := SortedPlayers.GetPlayerIdx(Player)
                MainStackBox := GetMainStackBox(Placements, PlayerNames, Rebirths, Steals, Cash, PlayerIdx+1)
                
                PlayerUI.RemoveWidget(Canvas)
                MainCanvas := GetCanvas(MainStackBox)
                option {set PlayersMap[Player] = MainCanvas}
                PlayerUI.AddWidget(MainCanvas)

            Sleep(0.2)

    OnBegin<override>()<suspends>: void=
        spawn. MainLoop()
        GetPlayspace().PlayerRemovedEvent().Subscribe(OnRemoved)
        GetPlayspace().PlayerAddedEvent().Subscribe(OnAdded)
        for (Player : GetPlayspace().GetPlayers()):
            OnAdded(Player)



