using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /Verse.org/Assets }
using { /Verse.org/Random }
using { /Fortnite.com/Characters }
using { /UnrealEngine.com/Temporary/SpatialMath }
using {/Verse.org/Colors}
using { TX }

#Verseコードの一番上にカテゴリの設定を書く
UISettingCategory<public><localizes>:message := "UI Setting"
TipsMessageCategory<public><localizes>:message := "Tips Message Settings"
RouletteCategory<public><localizes>:message := "Roulette Settings"


moneySystem_device<public> := class(creative_device):

    #editableを下記のように書く
    @editable:
        Categories := array{UISettingCategory}
    ItemButton : conditional_button_device = conditional_button_device{}
    @editable:
        Categories := array{UISettingCategory}
    Parts1Button : conditional_button_device = conditional_button_device{}
    @editable:
        Categories := array{UISettingCategory}
    Parts2Button : conditional_button_device = conditional_button_device{}
    @editable:
        Categories := array{UISettingCategory}
    Parts3Button : conditional_button_device = conditional_button_device{}
    @editable:
        Categories := array{UISettingCategory}
    Parts4Button : conditional_button_device = conditional_button_device{}
    @editable:
        Categories := array{UISettingCategory}
    Parts5Button : conditional_button_device = conditional_button_device{}
    @editable:
        Categories := array{UISettingCategory}
    Parts6Button : conditional_button_device = conditional_button_device{}
    @editable:
        Categories := array{UISettingCategory}
    NitroButton : conditional_button_device = conditional_button_device{}

    

    @editable:
        Categories := array{UISettingCategory}
    UpdateInterval : float = 0.5 # How often to update the display (in seconds)

    @editable:
        Categories := array{UISettingCategory}
    PartoffsetX : float = 0.0
    @editable:
        Categories := array{UISettingCategory}
    PartoffsetY : float = 0.0
    @editable:
        Categories := array{UISettingCategory}
    StatOffsetX : float = 0.0
    @editable:
        Categories := array{UISettingCategory}
    StatOffsetY : float = 0.0



    @editable:
        Categories := array{UISettingCategory}
    TextColor : color = color{R:=1.0,G:=1.0,B:=1.0}

    
    @editable:
        Categories := array{RouletteCategory}
    TextureBlock : texture_block = texture_block{DefaultImage := Noimg,DefaultDesiredSize := vector2{X := 320.0, Y := 240.0}}
    @editable:
        Categories := array{UISettingCategory}
    Textures : []texture = array{Shadeget, Partget,miss, nitroget,WeaponGet, miss,ChugGet,miss}
    @editable:
        Categories := array{UISettingCategory}
    RouletteTracker : tracker_device = tracker_device{}
    @editable :
        Categories := array{RouletteCategory}
    RouletteLoopAudio : []audio_player_device = array{}

    @editable :
        Categories := array{RouletteCategory}
    RouletteLoopEndAudio : audio_player_device = audio_player_device{}

    @editable
    HUDGetPart : hud_message_device = hud_message_device{}


    @editable:
        Categories := array{RouletteCategory}
    ChugGranter : item_granter_device = item_granter_device{}
    @editable:
        Categories := array{RouletteCategory}
    NitroGranter : item_granter_device = item_granter_device{}
    @editable:
        Categories := array{RouletteCategory}
    WeaponRNG : rng_device = rng_device{}

    @editable:
        Categories := array{RouletteCategory}
    ShadeGrantSwitch : switch_device = switch_device{}
    @editable:
        Categories := array{RouletteCategory}
    PartGranter : item_granter_device = item_granter_device{}

    @editable:
        Categories := array{UISettingCategory}
    MoneyBlockImage : texture = money_bag
    @editable:
        Categories := array{UISettingCategory}
    MoneyNameText : string = "Money"
    var MoneyCountText : text_block = text_block{}

    @editable:
        Categories := array{UISettingCategory}
    Parts1BlockImage : texture = money_bag
    var Parts1CountText : text_block = text_block{}

    @editable:
        Categories := array{UISettingCategory}
    Parts2BlockImage : texture = money_bag
    var Parts2CountText : text_block = text_block{}

    @editable:
        Categories := array{UISettingCategory}
    Parts3BlockImage : texture = money_bag
    var Parts3CountText : text_block = text_block{}

    @editable:
        Categories := array{UISettingCategory}
    Parts4BlockImage : texture = money_bag
    var Parts4CountText : text_block = text_block{}

    @editable:
        Categories := array{UISettingCategory}
    Parts5BlockImage : texture = money_bag
    var Parts5CountText : text_block = text_block{}

    @editable:
        Categories := array{UISettingCategory}
    Parts6BlockImage : texture = money_bag
    var Parts6CountText : text_block = text_block{}

    # @editable
    # NitroBlockImage : texture = money_bag


    @editable:
        Categories := array{UISettingCategory}
    KillcountDev : stat_creator_device = stat_creator_device{}
    @editable:
        Categories := array{UISettingCategory}
    KillcountBlockImage : texture = money_bag
    @editable:
        Categories := array{UISettingCategory}
    KillcountNameText : string = "KillCount"
    var KillCountText : text_block = text_block{}


    @editable:
        Categories := array{UISettingCategory}
    ATKcountDev : stat_creator_device = stat_creator_device{}
    @editable:
        Categories := array{UISettingCategory}
    ATKBlockImage : texture = money_bag
    @editable:
        Categories := array{UISettingCategory}
    ATKcountNameText : string = "ATKLV."
    var ATKCountText : text_block = text_block{}
    
    @editable:
        Categories := array{UISettingCategory}
    HPcountDev : stat_creator_device = stat_creator_device{}
    @editable:
        Categories := array{UISettingCategory}
    HPBlockImage : texture = money_bag
    @editable:
        Categories := array{UISettingCategory}
    HPcountNameText : string = "HPLV."
    var HPCountText : text_block = text_block{}
    
    @editable:
        Categories := array{UISettingCategory}
    EXPcountDev : stat_creator_device = stat_creator_device{}
    @editable:
        Categories := array{UISettingCategory}
    EXPBlockImage : texture = money_bag
    @editable:
        Categories := array{UISettingCategory}
    EXPcountNameText : string = "EXPLV."
    var EXPCountText : text_block = text_block{}
    
    @editable
    removeButton : button_device = button_device{}
    var MyWidget : ?widget = false

    
    var CurrentCount : string = ""
    var Parts1count : string = ""
    var Parts2count : string = ""
    var Parts3count : string = ""
    var Parts4count : string = ""
    var Parts5count : string = ""
    var Parts6count : string = ""
    
    @editable:
        Categories := array{TipsMessageCategory}
    TipsHuds:[]hud_message_device = array{}

    @editable
    StartMutator<public> : mutator_zone_device = mutator_zone_device{}

    StringToMessage<localizes>(InString : string) : message = "{InString}"

    
    FormatWithCommas(Number : int) : string =
        # Handle zero case
        if (Number = 0):
            return "0"
        
        # Convert number to string and get its length
        NumberStr := ToString(Number)
        Len := NumberStr.Length
        
        # Handle negative numbers
        var StartIndex : int = 0
        var IsNegative : logic = false
        if (Number < 0):
            set StartIndex = 1
            set IsNegative = true
        
        # Calculate first group length (1-3 digits before first comma)
        var FirstGroupLength : int = 0
        if (QuotientResult := Quotient[Len - StartIndex, 3]):
            set FirstGroupLength = Len - StartIndex - (QuotientResult * 3)
        if (FirstGroupLength = 0):
            set FirstGroupLength = 3
        
        # Build the formatted string
        var FormattedStr : string = ""
        var CurrentIndex : int = StartIndex
        
        # Add first group of digits
        if (FirstGroup := NumberStr.Slice[CurrentIndex, CurrentIndex + FirstGroupLength]):
            set FormattedStr = FirstGroup
            set CurrentIndex += FirstGroupLength
            
            # Add remaining groups with commas
            loop:
                if (CurrentIndex >= Len):
                    break
                if (NextGroup := NumberStr.Slice[CurrentIndex, CurrentIndex + 3]):
                    set FormattedStr = "{FormattedStr},{NextGroup}"
                    set CurrentIndex += 3
        
        # Add negative sign if needed
        if (IsNegative = true):
            set FormattedStr = "-{FormattedStr}"
        
        return FormattedStr


    CreateItemDisplayWidget() : canvas =
        
        
        set MoneyCountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set KillCountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set ATKCountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set HPCountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set EXPCountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        
        set Parts1CountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set Parts2CountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set Parts3CountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set Parts4CountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set Parts5CountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        set Parts6CountText = text_block{DefaultText := StringToMessage("0"),DefaultTextColor := TextColor,DefaultJustification := text_justification.Left}
        
        canvas:
            Slots := array:
                canvas_slot:
                    
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                    Offsets := margin{Top := PartoffsetY, Left := PartoffsetX, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    Widget := overlay:
                        Slots:=array:
                            overlay_slot:

                                #stack1
                                HorizontalAlignment:=horizontal_alignment.Center
                                VerticalAlignment:=vertical_alignment.Center
                                Widget:=stack_box:
                                    Orientation := orientation.Vertical
                                    Slots:=array:
                                        #Roulette box
                                        stack_box_slot:
                                            HorizontalAlignment:=horizontal_alignment.Center
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget := TextureBlock
                                                  

                                        stack_box_slot:

                                            #Shade
                                            HorizontalAlignment:=horizontal_alignment.Center
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget := stack_box:
                                                Orientation := orientation.Horizontal
                                                Slots:=array:
                                                    stack_box_slot:

                                                        #Shadeinfo
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Widget:=stack_box:
                                                            Orientation := orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:

                                                                    #shadeimage
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=texture_block:
                                                                        DefaultImage := MoneyBlockImage
                                                                        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                                
                                                                # stack_box_slot:

                                                                #     #ShadeText1
                                                                #     Padding:=margin{Left:=10.0,Right:=10.0}
                                                                #     HorizontalAlignment:=horizontal_alignment.Center
                                                                #     VerticalAlignment:=vertical_alignment.Center
                                                                #     Widget:=text_block:
                                                                        
                                                                #         DefaultText:=StringToMessage("Shades")
                                                                #         DefaultTextColor := TextColor
                                                                
                                                                stack_box_slot:

                                                                    #ShadeText1
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget := MoneyCountText




                                        
                                        
                                        
                                        stack_box_slot:
                                            #Parts LIne1
                                            HorizontalAlignment:=horizontal_alignment.Fill
                                            VerticalAlignment:=vertical_alignment.Fill
                                            Padding:= margin{Top:=10.0}
                                            Widget := stack_box:
                                                Orientation := orientation.Horizontal
                                                Slots:=array:
                                                    stack_box_slot:

                                                        #partLine1-1
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget:=stack_box:
                                                            Orientation := orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    
                                                                    #partA image
                                                                    HorizontalAlignment:=horizontal_alignment.Center
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget := texture_block:
                                                                        DefaultImage := Parts1BlockImage
                                                                        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                                
                                                                stack_box_slot:
                                                                    #partA Text
                                                                    Padding:=margin{Left:=10.0,Right:=10.0}
                                                                    Widget := Parts1CountText

                                                           
                                                    stack_box_slot:
                                                        #partLine1-2 
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget:=stack_box:
                                                            Orientation := orientation.Horizontal
                                                            Slots:=array:
                                                                
                                                                stack_box_slot:
                                                                    #partB image
                                                                    
                                                                    Widget := texture_block:

                                                                        DefaultImage := Parts2BlockImage
                                                                        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                                
                                                                stack_box_slot:
                                                                    #partB Text
                                                                    Padding:=margin{Left:=10.0,Right:=10.0}
                                                                    Widget := Parts2CountText


                                                    #partLine1-3        
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget:=stack_box:
                                                            Orientation := orientation.Horizontal
                                                            Slots:=array:
                                                                #partC image
                                                                stack_box_slot:
                                                                    
                                                                    Widget := texture_block:
                                                                        DefaultImage := Parts3BlockImage
                                                                        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                                #partC Text
                                                                stack_box_slot:
                                                                    Padding:=margin{Left:=10.0,Right:=10.0}
                                                                    Widget := Parts3CountText




                                        #Parts LIne2
                                        stack_box_slot:
                                            HorizontalAlignment:=horizontal_alignment.Fill
                                            VerticalAlignment:=vertical_alignment.Fill
                                            Padding:= margin{Top:=10.0}
                                            Widget := stack_box:
                                                Orientation := orientation.Horizontal
                                                Slots:=array:
                                                    #partLine2-1
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget:=stack_box:
                                                            Orientation := orientation.Horizontal
                                                            Slots:=array:
                                                                #partA image
                                                                stack_box_slot:
                                                                    Widget := texture_block:
                                                                        DefaultImage := Parts4BlockImage
                                                                        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                                #partA Text
                                                                stack_box_slot:
                                                                    Padding:=margin{Left:=10.0,Right:=10.0}
                                                                    Widget := Parts4CountText

                                                    #partLine2-2        
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget:=stack_box:
                                                            Orientation := orientation.Horizontal
                                                            Slots:=array:
                                                                #partB image
                                                                stack_box_slot:
                                                                    
                                                                    Widget := texture_block:
                                                                        DefaultImage := Parts5BlockImage
                                                                        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                                #partB Text
                                                                stack_box_slot:
                                                                    Padding:=margin{Left:=10.0,Right:=10.0}
                                                                    Widget := Parts5CountText


                                                    #partLine2-3        
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget:=stack_box:
                                                            Orientation := orientation.Horizontal
                                                            Slots:=array:
                                                                #partC image
                                                                stack_box_slot:
                                                                    
                                                                    Widget := texture_block:
                                                                        DefaultImage := Parts6BlockImage
                                                                        DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                                #partC Text
                                                                stack_box_slot:
                                                                    Padding:=margin{Left:=10.0,Right:=10.0}
                                                                    Widget := Parts6CountText
                    
                canvas_slot:                                                    
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                    Offsets := margin{Top := StatOffsetY, Left := StatOffsetX, Right := 0.0, Bottom := 0.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    Widget := overlay:
                        Slots:=array:
                            overlay_slot:
                                HorizontalAlignment:=horizontal_alignment.Left
                                VerticalAlignment:=vertical_alignment.Center
                                Widget:=stack_box:
                                    Orientation := orientation.Vertical
                                    Slots:=array:
                                #KillCount
                                        stack_box_slot:
                                            HorizontalAlignment:=horizontal_alignment.Left
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget := stack_box:
                                                Orientation := orientation.Horizontal
                                                Slots:=array:
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        
                                                        Widget := texture_block:
                                                            DefaultImage := KillcountBlockImage
                                                            DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                            
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Padding:=margin{Top:=10.0,Bottom:=10.0,Left:=10.0,Right:=10.0}
                                                        Widget := text_block:
                                                            DefaultText := StringToMessage(KillcountNameText)
                                                            DefaultTextColor := TextColor 

                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget := KillCountText

                                        #ATKCount
                                        stack_box_slot:
                                            HorizontalAlignment:=horizontal_alignment.Left
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget := stack_box:
                                                Orientation := orientation.Horizontal
                                                Slots:=array:
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget := texture_block:
                                                            
                                                            DefaultImage := ATKBlockImage
                                                            DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                            
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Padding:=margin{Top:=10.0,Bottom:=10.0,Left:=10.0,Right:=10.0}
                                                        Widget := text_block:
                                                            DefaultText := StringToMessage(ATKcountNameText)
                                                            DefaultTextColor := TextColor 

                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget := ATKCountText

                                        #HPCount
                                        stack_box_slot:
                                            HorizontalAlignment:=horizontal_alignment.Left
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget := stack_box:
                                                Orientation := orientation.Horizontal
                                                Slots:=array:
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget := texture_block:
                                                            
                                                            DefaultImage := HPBlockImage
                                                            DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                            
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Padding:=margin{Top:=10.0,Bottom:=10.0,Left:=10.0,Right:=10.0}
                                                        Widget := text_block:
                                                            DefaultText := StringToMessage(HPcountNameText)
                                                            DefaultTextColor := TextColor 

                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget := HPCountText

                                        #EXPCount
                                        stack_box_slot:
                                            HorizontalAlignment:=horizontal_alignment.Left
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget := stack_box:
                                                Orientation := orientation.Horizontal
                                                Slots:=array:
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget := texture_block:
                                                            
                                                            DefaultImage := EXPBlockImage
                                                            DefaultDesiredSize := vector2{X := 64.0, Y := 64.0}
                                                            
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Padding:=margin{Top:=10.0,Bottom:=10.0,Left:=10.0,Right:=10.0}
                                                        Widget := text_block:
                                                            DefaultText := StringToMessage(EXPcountNameText)
                                                            DefaultTextColor := TextColor 

                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                                        Widget := EXPCountText

                
                                
            

    OnBegin<override>()<suspends>:void=
        

        Widget := CreateItemDisplayWidget()
        for (Player : GetPlayspace().GetPlayers()):
            if (PlayerUI := GetPlayerUI[Player]):
                PlayerUI.AddWidget(Widget)
        spawn{ UpdateDisplay() }

        removeButton.InteractedWithEvent.Subscribe(OnButtonPressed)
        RouletteTracker.CompleteEvent.Subscribe(RouletteSpawn)

    RouletteSpawn(Agent:agent):void=
        spawn{RouletteStart(Agent)}

    RouletteStart(Agent:agent)<suspends> : void =
        Print("Rourette Start")
        # Get random number of spins between 5 and 10
        SpinCount := GetRandomInt(20, 40)
        var k :int=0
        var SleepTime :float= 0.1
        # Perform the spins
        for (i := 0..SpinCount):
            if (Textures.Length > 0):
                set k=i
                loop:
                    if(k > Textures.Length-1):
                        set k = k - Textures.Length

                    else:
                        break
                Print("{k}")    
        # Get random index for texture array
            
                
                # for(j:=0..Textures.Length-1):
                
            # RandomIndex := GetRandomInt(0, Textures.Length - 1)
                if (NewTexture := Textures[k]):
            #     # Set the new texture
                    # Print("Set LoopImage")
                    TextureBlock.SetImage(NewTexture)
                    # if (i <= 5 and RouletteLoopAudio.Length > 0):
                    #     # Use modulo to cycle through audio indices
                    #     AudioIndex := (i - 1)
                    #     if (AudioIndex >= 0 and AudioIndex < RouletteLoopAudio.Length):
                    if (Audio := RouletteLoopAudio[k]):
                        Audio.Play(Agent)
                        
                        
                                
                                
            
            # Add delay between spins
            if(SpinCount - i < 5):
                set SleepTime = 0.2
            Sleep(SleepTime)
            Print("SleepTime={SleepTime}")
            if(Audio:=RouletteLoopAudio[k]):
                Audio.Stop(Agent)
            

        Randomprizenum := GetRandomInt(1,100)
        if(Randomprizenum <= 5):
            Print("Set NitroImage")
            TextureBlock.SetImage(nitroget)
            NitroGranter.GrantItem(Agent)
            
        else if(Randomprizenum<=30):
            Print("Set ShadeImage")
            TextureBlock.SetImage(Shadeget)
            for(i:=1..GetRandomInt(10,30)):
                ShadeGrantSwitch.CheckState(Agent)


        else if(Randomprizenum<=55):
            Print("Set PartImage")
            TextureBlock.SetImage(Partget)
            for(i:=1..GetRandomInt(10,30)):
                PartGranter.CycleToRandomItem(Agent)
                HUDGetPart.Show(Agent)

        
                

        else if(Randomprizenum<=65):
            Print("Set WeaponImage")
            TextureBlock.SetImage(WeaponGet)
            WeaponRNG.Activate(Agent)

        else if(Randomprizenum<=75):
            Print("Set ChugImage")
            TextureBlock.SetImage(ChugGet)
            ChugGranter.GrantItem(Agent)
                
        else:
            Print("Set MissImage")
            TextureBlock.SetImage(miss)
        RouletteLoopEndAudio.Play(Agent)
        Sleep(5.0)
        TextureBlock.SetImage(Noimg)

        
        
            





    OnButtonPressed(Agent : agent) : void =
        if (Player := player[Agent]):
            RemoveWidgetFromPlayer(Player)

    UpdateDisplay()<suspends> : void =
        loop:
            if (Players := GetPlayspace().GetPlayers(), FirstPlayer := Players[0]):
                if (Character := FirstPlayer.GetFortCharacter[]):

                    set CurrentCount = FormatWithCommas(GetItemCount(FirstPlayer))
                    
                    MoneyCountText.SetText(StringToMessage(CurrentCount))

                    set Parts1count = FormatWithCommas(GetParts1Count(FirstPlayer))
                    Parts1CountText.SetText(StringToMessage("{Parts1count}"))
                    set Parts2count = FormatWithCommas(GetParts2Count(FirstPlayer))
                    Parts2CountText.SetText(StringToMessage("{Parts2count}"))
                    set Parts3count = FormatWithCommas(GetParts3Count(FirstPlayer))
                    Parts3CountText.SetText(StringToMessage("{Parts3count}"))
                    set Parts4count = FormatWithCommas(GetParts4Count(FirstPlayer))
                    Parts4CountText.SetText(StringToMessage("{Parts4count}"))
                    set Parts5count = FormatWithCommas(GetParts5Count(FirstPlayer))
                    Parts5CountText.SetText(StringToMessage("{Parts5count}"))
                    set Parts6count = FormatWithCommas(GetParts6Count(FirstPlayer))
                    Parts6CountText.SetText(StringToMessage("{Parts6count}"))
                    
                    if (KillCount := KillcountDev.GetValue[FirstPlayer]):
                        KillCountText.SetText(StringToMessage("{KillCount}"))
                    
                    if (ATKCount := ATKcountDev.GetLevel[FirstPlayer]):
                        ATKCountText.SetText(StringToMessage("{ATKCount}"))

                    if (HPCount := HPcountDev.GetLevel[FirstPlayer]):
                        HPCountText.SetText(StringToMessage("{HPCount}"))

                    if (EXPCount := EXPcountDev.GetLevel[FirstPlayer]):
                        EXPCountText.SetText(StringToMessage("{EXPCount}"))

            Sleep(UpdateInterval)

    GetItemCount(Agent : agent) : int =
        ItemButton.GetItemCount(Agent, 0)
    GetParts1Count(Agent:agent):int =
        Parts1Button.GetItemCount(Agent, 0)
    GetParts2Count(Agent:agent):int =
        Parts2Button.GetItemCount(Agent, 0)
    GetParts3Count(Agent:agent):int =
        Parts3Button.GetItemCount(Agent, 0)
    GetParts4Count(Agent:agent):int =
        Parts4Button.GetItemCount(Agent, 0)
    GetParts5Count(Agent:agent):int =
        Parts5Button.GetItemCount(Agent, 0)
    GetParts6Count(Agent:agent):int =
        Parts6Button.GetItemCount(Agent, 0)
    

    RemoveWidgetFromPlayer(Player : player) : void =
        if:
            PlayerUI := GetPlayerUI[Player]
            Widget := MyWidget?
        then:
            PlayerUI.RemoveWidget(Widget)
            set MyWidget = false
