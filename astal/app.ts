import { App } from "astal/gtk3"
import Bar from "./bar"

function onRequest(request: string, res: (response: any) => void) {
  res("Hello world")
}

App.start({
  instanceName: "astal",
  requestHandler: onRequest,
  main() {
    App.get_monitors().map(Bar)
  }
})
