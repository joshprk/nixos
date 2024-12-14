import { App } from "astal/gtk3"
import Bar from "./bar"

App.start({
  main() {
    Bar(0)
  }
})
