import { Astal, Gtk, Gdk } from "astal/gtk3"

export default function Bar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return <window
    centerName="Bar"
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}>
    <centerbox>
      <box hexpand halign={Gtk.Align.START}>
      </box>
      <box>
      </box>
      <box hexpand halign={Gtk.Align.END}>
      </box>
    </centerbox>
  </window>
}
