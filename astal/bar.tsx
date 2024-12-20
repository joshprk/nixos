import { Variable, GLib } from "astal"
import { Astal, Gtk } from "astal/gtk3"
import Battery from "gi://AstalBattery"

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
    className="Bar"
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}>
    <centerbox>
      <box hexpand halign={Gtk.Align.START}>
        It works
      </box>
      <box>
      </box>
      <box hexpand halign={Gtk.Align.END}>
        <Time />
      </box>
    </centerbox>
  </window>
}
