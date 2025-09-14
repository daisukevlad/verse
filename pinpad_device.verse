
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI}
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }
using { /Verse.org/Colors }
using { /Verse.org/Colors/NamedColors }
# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.


# A Verse-authored creative device that can be placed in a level


PinSystem<public> := class<concrete>:
    @editable
    PINcode : string = ""
    @editable
    PINSuccessTrigger : trigger_device = trigger_device{}
    

    var PINSuccessLogic : logic = false


pinpad_device<public> := class(creative_device):

    @editable
    AssignPinPadButton : button_device = button_device{}
    @editable
    BackGroundColor : color = color{R := 1.0, G := 0.5, B := 0.0}
    @editable
    PinPadColor : color = color{R := 1.0, G := 0.5, B := 0.0}

    @editable
    PINs : []PinSystem = array{}

    @editable
    PINFailTrigger : trigger_device = trigger_device{}
    @editable
    PINUsedTrigger : trigger_device = trigger_device{}


    var StuffPerAgent : [agent]?tuple(canvas,text_block,string)=map{}

    OnBegin<override>()<suspends>:void=
        
        AssignPinPadButton.InteractedWithEvent.Subscribe(AddPinPad)



    S2M<localizes>(S:string):message="{S}"

    AddPinPad(A:agent):void=
        if(Stuff:=StuffPerAgent[A]?):

        else:
            Val := MakeCanvas()
            if:
                PlayerUI:=GetPlayerUI[player[A]]
            then:
                PlayerUI.AddWidget(Val(0),player_ui_slot{InputMode:=ui_input_mode.All})
                if(set StuffPerAgent[A] = option{(Val(0),Val(1),"")}){}
        

    RemovePinPad(A:agent):void=
        if(Stuff:=StuffPerAgent[A]?):
            if:
                PlayerUI:=GetPlayerUI[player[A]]
            then:
                PlayerUI.RemoveWidget(Stuff(0))
                if(set StuffPerAgent[A] = false){}



    MakeCanvas():tuple(canvas,text_block)=
        Button0 := button_loud{DefaultText:=S2M("0")}
        Button0.OnClick().Subscribe(Add0)
        Button1 := button_loud{DefaultText:=S2M("1")}
        Button1.OnClick().Subscribe(Add1)
        Button2 := button_loud{DefaultText:=S2M("2")}
        Button2.OnClick().Subscribe(Add2)
        Button3 := button_loud{DefaultText:=S2M("3")}
        Button3.OnClick().Subscribe(Add3)
        Button4 := button_loud{DefaultText:=S2M("4")}
        Button4.OnClick().Subscribe(Add4)
        Button5 := button_loud{DefaultText:=S2M("5")}
        Button5.OnClick().Subscribe(Add5)
        Button6 := button_loud{DefaultText:=S2M("6")}
        Button6.OnClick().Subscribe(Add6)
        Button7 := button_loud{DefaultText:=S2M("7")}
        Button7.OnClick().Subscribe(Add7)
        Button8 := button_loud{DefaultText:=S2M("8")}
        Button8.OnClick().Subscribe(Add8)
        Button9 := button_loud{DefaultText:=S2M("9")}
        Button9.OnClick().Subscribe(Add9)
        Delete := button_regular{DefaultText:=S2M("Del")}
        Delete.OnClick().Subscribe(DeleteLastChar)
        Enter := button_regular{DefaultText:=S2M("Ent")}
        Enter.OnClick().Subscribe(EnterFunc)
        Exit := button_quiet{DefaultText:=S2M("X")}
        Exit.OnClick().Subscribe(ExitFunc)

        NumTB := text_block{DefaultText:=S2M(""),DefaultTextColor:=White}









        MyCanvas:=canvas:
            Slots:=array:
                canvas_slot:
                    Anchors:=anchors{Minimum:=vector2{X:=0.5,Y:=0.5},Maximum:=vector2{X:=0.5,Y:=0.5}}
                    Alignment:=vector2{X:=0.5,Y:=0.5}
                    SizeToContent:=true
                    Widget:=overlay:
                        Slots:=array:
                            overlay_slot:
                                #outside colorblock
                                HorizontalAlignment:=horizontal_alignment.Fill
                                VerticalAlignment:=vertical_alignment.Fill
                                Widget:=color_block{DefaultColor:=BackGroundColor,DefaultDesiredSize:=vector2{X:=665.0,Y:=660.0}}
                            overlay_slot:
                                HorizontalAlignment:=horizontal_alignment.Center
                                VerticalAlignment:=vertical_alignment.Bottom
                                Padding:=margin{Bottom:=20.0}
                                Widget:=overlay:
                                    Slots:=array:
                                        #pinpad clorBlock
                                        overlay_slot:
                                            HorizontalAlignment:=horizontal_alignment.Fill
                                            VerticalAlignment:=vertical_alignment.Fill

                                            Widget:=color_block{DefaultColor:=PinPadColor}
                                    #pinpad
                                        overlay_slot:
                                            HorizontalAlignment:=horizontal_alignment.Center
                                            VerticalAlignment:=vertical_alignment.Center
                                            Padding:=margin{Top:=20.0,Left:=20.0,Bottom:=20.0,Right:=20.0} 
                                            Widget:=stack_box:
                                                Orientation:=orientation.Vertical
                                                Slots:=array:
                                                    #1-3 stack
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=20.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button1
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button2
                                                                    Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button3
                                                    #4-6 stack
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=20.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button4
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button5
                                                                    Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button6
                                                    #7-9 stack
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=20.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button7
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button8
                                                                    Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button9
                                                    
                                                    #Enter 0 delete stack
                                                    stack_box_slot:
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                        Padding:=margin{Top:=25.0,Bottom:=20.0}
                                                        Widget:=stack_box:
                                                            Orientation:=orientation.Horizontal
                                                            Slots:=array:
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Delete
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Button0
                                                                    Padding:=margin{Left:=20.0,Right:=20.0}
                                                                stack_box_slot:
                                                                    Distribution:=option{1.0}
                                                                    HorizontalAlignment:=horizontal_alignment.Fill
                                                                    VerticalAlignment:=vertical_alignment.Center
                                                                    Widget:=Enter
                            
                            
                            # Textblock stuff
                            overlay_slot:
                                HorizontalAlignment:=horizontal_alignment.Fill
                                VerticalAlignment:=vertical_alignment.Top
                                Padding:=margin{Top:=20.0}
                                Widget:=stack_box:
                                    Orientation:=orientation.Horizontal
                                    Slots:=array:
                                        stack_box_slot:
                                            Distribution:=option{1.0}
                                            HorizontalAlignment:=horizontal_alignment.Fill
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget:=color_block{DefaultOpacity := 0.0}
                                        stack_box_slot:
                                            Distribution:=option{1.0}
                                            HorizontalAlignment:=horizontal_alignment.Fill
                                            VerticalAlignment:=vertical_alignment.Center
                                            Padding:=margin{Left:=20.0,Right:=20.0}
                                            Widget:=overlay:
                                                Slots:=array:
                                                    overlay_slot:
                                                        Widget:=color_block{DefaultColor:=Black,DefaultDesiredSize:=vector2{X:=400.0,Y:=32.0}}
                                                        HorizontalAlignment:=horizontal_alignment.Fill
                                                        VerticalAlignment:=vertical_alignment.Fill
                                                    overlay_slot:
                                                        Widget:=NumTB
                                                        HorizontalAlignment:=horizontal_alignment.Center
                                                        VerticalAlignment:=vertical_alignment.Center
                                        stack_box_slot:
                                            Distribution:=option{1.0}
                                            HorizontalAlignment:=horizontal_alignment.Center
                                            VerticalAlignment:=vertical_alignment.Center
                                            Widget:=Exit
                                        
        
        
        
        return (MyCanvas,NumTB)
    
    Add0(WM:widget_message):void=AddNum(0,WM)
    Add1(WM:widget_message):void=AddNum(1,WM)
    Add2(WM:widget_message):void=AddNum(2,WM)
    Add3(WM:widget_message):void=AddNum(3,WM)
    Add4(WM:widget_message):void=AddNum(4,WM)
    Add5(WM:widget_message):void=AddNum(5,WM)
    Add6(WM:widget_message):void=AddNum(6,WM)
    Add7(WM:widget_message):void=AddNum(7,WM)
    Add8(WM:widget_message):void=AddNum(8,WM)
    Add9(WM:widget_message):void=AddNum(9,WM)

    EnterFunc(WM:widget_message):void=
        Print("Enter")
        
        var PinUsed : logic=false
        for(PIN:PINs):
            PinAsString:=PIN.PINcode
            if(Stuff:=StuffPerAgent[WM.Player]?):
                if(PinAsString = Stuff(2) and PIN.PINSuccessLogic = false):
                    Print("SUCCESS {PIN.PINcode} = {Stuff(2)}")
                    PIN.PINSuccessTrigger.Trigger(WM.Player)
                    set PIN.PINSuccessLogic = true
                    RemovePinPad(WM.Player)
                    return
                else if(PinAsString = Stuff(2) and PIN.PINSuccessLogic = true):
                    
                    set PinUsed = true
                else:
                    Print("FAil: {PIN.PINcode} != {Stuff(2)}")
        if(PinUsed = true):
            Print("PIN USE TRUE")
            PINUsedTrigger.Trigger(WM.Player)
        else:
            Print("PIN USE FALSE")
            PINFailTrigger.Trigger(WM.Player)




        RemovePinPad(WM.Player)
        
        


    ExitFunc(WM:widget_message):void=
        RemovePinPad(WM.Player)


    AddNum(Num:int,WM:widget_message):void=
        if(Stuff:=StuffPerAgent[WM.Player]?):
            var String:string=Stuff(2)
            set String +="{Num}"
            if(set StuffPerAgent[WM.Player] = option{(Stuff(0),Stuff(1),String)}){}
            UpdateUI(WM)

    UpdateUI(WM:widget_message):void=
        if(Stuff:=StuffPerAgent[WM.Player]?):
            var String:string=Stuff(2)
            TB:=Stuff(1)
            TB.SetText(S2M("{String}"))
           
    DeleteLastChar(WM:widget_message):void=
        if(Stuff:=StuffPerAgent[WM.Player]?):
            var String:string = Stuff(2)
            var UpdateString : string = ""
            for(Index->S:String):
                if(Index = String.Length-1):


                else:
                    set UpdateString+="{S}"
            if(set StuffPerAgent[WM.Player] = option{(Stuff(0),Stuff(1),UpdateString)}){}
            UpdateUI(WM)
