import {Socket} from "phoenix"

let chatInput         = $("#chat-input")
let messagesContainer = $("#messages")

let socket = new Socket("/socket")
socket.connect()
let chan = socket.chan("rooms:lobby", {})

chatInput.on("keypress", event => {
  if(event.keyCode === 13){
    chan.push("new_msg", {body: chatInput.val()})
    chatInput.val("")
  }
})

chan.on("new_msg", payload => {
  messagesContainer.append(`<br/>[${Date()}] ${payload.body}`)
})

chan.join().receive("ok", chan => {
  console.log("Welcome to Phoenix Chat!")
})




// let socket = new Socket("/ws")
// socket.connect()
// let chan = socket.chan("topic:subtopic", {})
// chan.join().receive("ok", resp => {
//   console.log("Joined succesffuly!", resp)
// })

// let socket = new Socket("/socket")
// socket.connect()
// let chan = socket.chan("rooms:lobby", {})
// chan.join().receive("ok", chan => {
//   console.log("Welcome to Phoenix Chat!!!!")
// })

// let App = {
//   let socket = new Socket("/socket")
//   socket.connect()
//   let chan = socket.chan("rooms:lobby", {})
//   chan.join().receive("ok", chan => {
//     console.log("Welcome to Phoenix Chat!")
//   })
// }

// export default App
