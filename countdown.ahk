#Requires AutoHotkey v2.0
#SingleInstance

INTERVAL := 1000
START_COUNT := 44

POS_X := -500
POS_Y := 2850

counter := SecondCounter()

XButton1::{
    counter.start()
}
XButton2::{
    counter.stop()
}

class SecondCounter {
    __New() {
        this.count := START_COUNT
        this.started := false
        this.timer := ObjBindMethod(this, "Tick")

        ; create a tiny window at top left and hide it
        this.gui := Gui("+AlwaysOnTop -Border -Caption +ToolWindow")

        this.gui.Show("x0 y0 w300 h300")
        this.gui.hide()
        WinMove POS_X, POS_Y,,, this.gui
        this.gui.SetFont("cBlack s206 bold")
        this.gui.Add("Text","w300 h300 X0 Y0 vTime center", this.count).Name := "counter"
    }

    Start() {
        this.count := START_COUNT
        this.gui["counter"].SetFont("cBlack")

        if (!this.started) {
            this.gui.show()
            SetTimer this.timer, INTERVAL ; start timer
            this.started := true
        }
    }

    Stop() {
        SetTimer this.timer, 0 ; turn off timer
        this.started := false
        this.gui.hide()
    }

    Tick() {
        if (this.count = 10) {
            this.gui["counter"].SetFont("cRed")
        }
        if (this.count <= 0) {
            this.count := START_COUNT
            this.gui["counter"].SetFont("cBlack")
        }
        ; update text
        this.gui["counter"].Text := --this.count
    }
}
