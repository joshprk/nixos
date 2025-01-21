import { App } from "astal/gtk4"
import Bar from "./widgets/Bar.tsx"

function onRequest(request: string, res: (response: any) => void) {
  res("Hello world!")
}

App.start({
  instanceName: "astal",
  requestHandler: onRequest,
  main() {
    App.get_monitors().map(Bar)
  }
})
