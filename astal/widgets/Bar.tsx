import { Variable, GLib, bind } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk4"

export default function Bar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor
  
  return <window
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    css={"background: rgba(24, 24, 37, 0.9);"}>
    <centerbox
      css={"padding: 5px; font-size: 14px; margin-left: 5px; margin-right: 5px;"}>
      <box hexpand halign={Gtk.Align.START}>
      </box>
      <box>
      </box>
      <box hexpand halign={Gtk.Align.END}>
      </box>
    </centerbox>
  </window>
}
