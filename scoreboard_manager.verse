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
using { /Fortnite.com/Playspaces }

player_ranking_data := struct:
    Player : player
    BestTime : float
    Complete : int
    Score : int
    
saved_player_data := class<persistable><final>:
    BestTime : float = 36000.0
    Complete : int = 0
    Score : int = 0
    Version : int = 0
   
var SavedPlayerDataMap:weak_map(player, saved_player_data) = map{}

StrToMessage<localizes>(String : string): message = "{String}"

IdxToPadding(i : int): margin=
    case(i):
        1 => return margin{Right := 10.0, Top := 5.0, Left := 10.0}
        _ => return margin{Right := 10.0, Left := 10.0}

(String : string).StrToTxt(): text_block=

    return text_block{DefaultText := StrToMessage(String), DefaultJustification := text_justification.Center, DefaultTextSize := 25.0, DefaultTextColor := White}

(Message : message).MessageToTxt(): text_block=
    return text_block{DefaultText := Message, DefaultJustification := text_justification.Center, DefaultTextSize := 25.0, DefaultTextColor := White}



# CreateHeaderWithLine(HeaderText : string) : stack_box =
#     # Create the header text block
#     HeaderTextBlock := text_block{
#         DefaultText := StrToMessage(HeaderText),
#         DefaultTextColor := NamedColors.White,
#         DefaultJustification := text_justification.Center
#     }
#     HorizontalDividingLine := color_block{
#         DefaultColor := NamedColors.White,
#         DefaultDesiredSize := vector2{X := 600.0, Y := 2.0}
#     }
    

 
#     # Stack the header and line vertically
#     stack_box{
#         Orientation := orientation.Vertical,
#         Slots := array{
#             stack_box_slot{
#                 Widget := HeaderTextBlock,
#                 HorizontalAlignment := horizontal_alignment.Center
#             },
#             stack_box_slot{
#                 Widget := HorizontalDividingLine,
#                 HorizontalAlignment := horizontal_alignment.Fill
#             }
#         }
#     }

GetMainStackBox(Placement : []string, PlayerNames : []message, Complete : []string, BestTime : []string, Score : []string, PlayerIdx : int): stack_box=
    MainStackBox := stack_box{Orientation := orientation.Horizontal}
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(Placement)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxVerticalDividingline(),VerticalAlignment:=vertical_alignment.Fill})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxNames(PlayerNames, PlayerIdx)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxVerticalDividingline(),VerticalAlignment:=vertical_alignment.Fill})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(Complete)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxVerticalDividingline(),VerticalAlignment:=vertical_alignment.Fill})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(BestTime)})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxVerticalDividingline(),VerticalAlignment:=vertical_alignment.Fill})
    MainStackBox.AddWidget(stack_box_slot{Widget := GetStackBoxColumn(Score)})
    # return MainStackBox
    
    #-------------------------
    # HeaderWidget := CreateHeaderWithLine("Leaderboard")

    return stack_box{
        Orientation := orientation.Vertical,
        Slots := array{
            # stack_box_slot{Widget := HeaderWidget},
            
            stack_box_slot{Widget := MainStackBox}
        }
    }
    
GetStackBoxColumn(Information :[]string): stack_box=
    var TextBlockWidgets : []text_block = array{}
    StackBox := stack_box{Orientation := orientation.Vertical}
    

    for (Idx -> Info : Information):
        NewTextBlock := Info.StrToTxt()
        set TextBlockWidgets += array{NewTextBlock}
        StackBox.AddWidget(stack_box_slot{Widget := NewTextBlock, Padding := IdxToPadding(Idx)})
        if(Idx = 0):
            StackBox.AddWidget(stack_box_slot{Widget := GetStackBoxHorisontalDividingLine(),HorizontalAlignment:=horizontal_alignment.Fill})
    
    return StackBox

GetStackBoxNames(Information :[]message, i : int): stack_box=
    var TextBlockWidgets : []text_block = array{}
    StackBox := stack_box{Orientation := orientation.Vertical}

    for (Idx -> Info : Information):
        NewTextBlock := Info.MessageToTxt()
        if (i = Idx):
            NewTextBlock.SetTextColor(White)
        
        set TextBlockWidgets += array{NewTextBlock}
        StackBox.AddWidget(stack_box_slot{Widget := NewTextBlock, Padding := IdxToPadding(Idx)})
        if(Idx = 0):
            StackBox.AddWidget(stack_box_slot{Widget := GetStackBoxHorisontalDividingLine(),HorizontalAlignment:=horizontal_alignment.Fill})
    
    return StackBox

GetStackBoxVerticalDividingline(): color_block=
    VerticalDividingLine := color_block{
        DefaultColor := NamedColors.White,
        DefaultDesiredSize := vector2{X := 2.0, Y := 70.0} 
    }
    
    return VerticalDividingLine

GetStackBoxHorisontalDividingLine():color_block=
    
    HorizontalDividingLine := color_block{
        DefaultColor := NamedColors.White,
        DefaultDesiredSize := vector2{X := 20.0, Y := 2.0} 
    }
     
    return HorizontalDividingLine

GetPersistentData(Player : player): saved_player_data=
    if (Data := SavedPlayerDataMap[Player]):
        return Data
    return saved_player_data{}

AgentToMsg<localizes>(Agent : agent): message= "{Agent}"

scoreboard_manager := class(creative_device):
    @editable
    Timer : timer_device = timer_device{}
    @editable
    GoalTeleporter : teleporter_device = teleporter_device{}
    
    @editable
    NiceTrigger :trigger_device = trigger_device{}
    @editable
    GreatTrigger :trigger_device = trigger_device{}
    @editable
    PerfectTrigger :trigger_device = trigger_device{}
    
    var PlayersMap :[player]canvas = map{}
    
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
            canvas_slot{Alignment := vector2{X := 0.5, Y := 0.0}, SizeToContent := true, Widget := color_block{DefaultColor := Black, DefaultDesiredSize := vector2{X := 700.0, Y := PlayersMap.Length * 37.0+ 90.0}, DefaultOpacity := 0.7}, Offsets := margin{Top := 60.0, Left := -400.0}, Anchors := anchors{Minimum := vector2{X := 1.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}}
            canvas_slot{Alignment := vector2{X := 0.5, Y := 0.0}, SizeToContent := true, Widget := MainStackBox, Offsets := margin{Top := 85.0, Left := -400.0}, Anchors := anchors{Minimum := vector2{X := 1.0, Y := 0.0}, Maximum := vector2{X := 1.0, Y := 0.0}}}
        }
    (Players : []player).GetPlayerIdx(Player : player): int=
        for (i -> Play : Players, Player = Play):
            return i
        return -1

    PlayerNamesMessage<localizes>: message = {"Player Name"}

    MainLoop()<suspends>: void=
        loop:
            var Placements : []string = array{""}
            var PlayerNames : []message = array{PlayerNamesMessage}
            var Complete : []string = array{"Complete"}
            var BestTime : []string = array{"BestTime"}
            var Score : []string = array{"Score"}
            SortedPlayers := GetSortedPlayerRankings(GetPlayspace())
            for (Idx -> Player : SortedPlayers, Player.IsActive[]):
                Data := GetPersistentData(Player)
                set Placements += array{"{Idx + 1}"}
                set PlayerNames += array{AgentToMsg(Player)}
                set Complete += array{"{Data.Complete}"}
                set Score += array{"{Data.Score}"}
                if (Data.BestTime = 36000.0):
                    set BestTime += array{"{ConvertTimeToString(36000.0)}"}
                else:
                    set BestTime += array{"{ConvertTimeToString(Data.BestTime)}"} 
        
            for (Player -> Canvas : PlayersMap, PlayerUI := GetPlayerUI[Player]):
                PlayerIdx := SortedPlayers.GetPlayerIdx(Player)
                MainStackBox := GetMainStackBox(Placements, PlayerNames, Complete, BestTime, Score, PlayerIdx+1)
                
                PlayerUI.RemoveWidget(Canvas)
                MainCanvas := GetCanvas(MainStackBox)
                option {set PlayersMap[Player] = MainCanvas}
                PlayerUI.AddWidget(MainCanvas)

            Sleep(0.2)

    GetSortedPlayerRankings(Playspace : fort_playspace) : []player =
        var PlayerData : []player_ranking_data = array{}
    
        
        for (Player : Playspace.GetPlayers()):
            Data1 := GetPersistentData(Player)
            Data := player_ranking_data{
                Player := Player,
                BestTime := Data1.BestTime,
                Complete := Data1.Complete,
                Score := Data1.Score
            }
            set PlayerData += array{Data}
    
        
        SortedData := MergeSortPlayerRankings(PlayerData)
        var SortedPlayers : []player = array{}
        for (Data : SortedData):
            set SortedPlayers += array{Data.Player}
    
        
        var Players : []player = array{}
        for (Idx := 0..SortedPlayers.Length - 1):
            if (Player1 := SortedPlayers[SortedPlayers.Length - 1 - Idx]):
                set Players += array{Player1}
    
        return Players

    MergeSortPlayerRankings(Data : []player_ranking_data) : []player_ranking_data =
        if (Data.Length <= 1):
            Data
        else:
            var Middle : int = 0
            if (FloorResult := Floor[Data.Length * 1.0 / 2.0]):
                set Middle = FloorResult
            var Left : []player_ranking_data = array{}
            var Right : []player_ranking_data = array{}
            if (LeftSlice := Data.Slice[0, Middle]):
                set Left = LeftSlice
            if (RightSlice := Data.Slice[Middle, Data.Length]):
                set Right = RightSlice
            SortedLeft := MergeSortPlayerRankings(Left)
            SortedRight := MergeSortPlayerRankings(Right)
            MergePlayerRankings(SortedLeft, SortedRight)

    MergePlayerRankings(Left : []player_ranking_data, Right : []player_ranking_data) : []player_ranking_data =
        var Result : []player_ranking_data = array{}
        var LeftIndex : int = 0
        var RightIndex : int = 0
    
        loop:
            if (LeftIndex >= Left.Length and RightIndex >= Right.Length):
                break
    
            if (LeftIndex < Left.Length and RightIndex < Right.Length):
                if (ComparePlayerRankings(Left[LeftIndex], Right[RightIndex]) = true):
                    if (LeftElement := Left[LeftIndex]):
                        set Result += array{LeftElement}
                    set LeftIndex += 1
                else:
                    if (RightElement := Right[RightIndex]):
                        set Result += array{RightElement}
                    set RightIndex += 1
            else if (LeftIndex < Left.Length):
                if (LeftElement := Left[LeftIndex]):
                    set Result += array{LeftElement}
                set LeftIndex += 1
            else if (RightElement := Right[RightIndex]):
                set Result += array{RightElement}
                set RightIndex += 1
    
        Result

    ComparePlayerRankings(A : player_ranking_data, B : player_ranking_data)<transacts> : logic =
        if (A.Score < B.Score):
            true
        else:
            false
        

    OnBegin<override>()<suspends>: void=
        if (Player := GetPlayspace().GetPlayers()[0], PlayerUI := GetPlayerUI[Player]):
            # HeaderWidget := CreateHeaderWithLine("Leaderboard")
        spawn. MainLoop()
        GetPlayspace().PlayerRemovedEvent().Subscribe(OnRemoved)
        GetPlayspace().PlayerAddedEvent().Subscribe(OnAdded)
        for (Player : GetPlayspace().GetPlayers()):
            OnAdded(Player)
