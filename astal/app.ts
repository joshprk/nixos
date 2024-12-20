import { App } from "astal/gtk3"
import Style from "./style.scss"
import Bar from "./bar"

function onRequest(request: string, res: (response: any) => void) {
  res("Hello world")
}

App.start({
  css: Style,
  instanceName: "astal",
  requestHandler: onRequest,
  main() {
    App.get_monitors().map(Bar)
  }
})
