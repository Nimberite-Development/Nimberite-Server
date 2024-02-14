import std/[
  asyncdispatch,
  strutils,
  asyncnet
]

import modernnet
import pulse

import ./nimberite/[
  handlers,
  packets,
  types
]

template fire[T: ServerboundPacket](c: Connection, packet: T): Future[void] =
  c.eh.fire(c, packet)

func packetHexData(dat: seq[byte]): string =
  for byt in dat:
    result &= byt.toHex(2) & " "

proc processClient*(client: Connection) {.async.} =
  var state = 0

  while true:
    await sleepAsync(1)

    var
      packetLength: int32
      packet: Buffer
      packetId: int32

    try:
      packetLength = await client.sock.readVarNum[:int32]()
      packet = await client.sock.read(packetLength)
      packetId = packet.readVarNum[:int32]()
    except MnEndOfBufferError:
      echo "Connection Closed."
      break

    echo "======================"
    echo "Packet ID: " & $packetId
    echo "Packet Length: ", packetLength
    echo "Packet Data: ", packetHexData(packet.buf)

    try:
      case packetId:
        of 0x00:
          if packetLength == 1:
            await client.fire(ServerboundStatusRequest())
            continue

          var dat = packet.read[:ServerboundHandshake]()

          echo '\n', $dat

          await client.fire(dat)

        of 0x01:
          var dat = packet.read[:ServerboundPingRequest]()

          echo '\n', $dat

          await client.fire(dat)

        else:
          echo "\nUnimplemented packet ID: " & $packetId
          client.sock.close()
          echo "Status: Connection terminated."
          break

    finally:
      echo "======================"

proc networkHandler*(s: Server, port: Port) {.async.} =
  let server = newAsyncSocket()
  server.setSockOpt(OptReuseAddr, true)
  server.bindAddr(port)
  server.listen()

  while true:
    let client = Connection(serv: s, sock: await server.accept(),
      eh: newAsyncEventHandler[Connection]())

    client.eh.registerHandshake()

    asyncCheck processClient(client)

proc main*(s: Server) {.async.} =
  await networkHandler(s, Port(25565))

let s = Server(maxPlayers: 10)
waitFor main(s)