import { Variable, GLib } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"

function Time({ format = "%I:%M %p" }) {
  const time = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format(format)!)

  return <label
    className="Time"
    onDestroy={() => time.drop()}
    label={time()}
  />
}

export default function Bar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
  
  return <window
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    css={"background: rgba(30, 30, 46, 0.9);"}>
    <centerbox
      css={"padding: 5px; font-size: 14px; margin-left: 5px; margin-right: 5px;"}>
      <box hexpand halign={Gtk.Align.START}> </box>
      <box>
      </box>
      <box hexpand halign={Gtk.Align.END}>
        <Time />
      </box>
    </centerbox>
  </window>
}
