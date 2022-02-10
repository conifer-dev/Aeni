<p align="center">
  <img src="https://i.imgur.com/uYwVATH.png" />
</p>

# About
*A simple spritesheet animation system* for [Raylib on Swift.](https://github.com/STREGAsGate/Raylib)

Aeni allows you to quickly and easily animate your spritesheet in your Raylib for Swift project! It divides the process into two simple steps to create a working animation.

Aeni is a shortened word for *"aenimeisheon"* in Korean which translates to "Animation".

Instructions
=====
Getting Aeni set up and running is easy, you can have it ready to go in no more than three minutes! 

Firstly make sure you added Aeni as your dependency package!

```swift
// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Aeni Example",
    dependencies: [
        .package(url: "https://github.com/STREGAsGate/Raylib.git", .branch("master")),
        .package(url: "https://github.com/conifer-dev/Aeni.git", .branch("main"))
    ],
    targets: [
        .executableTarget(name: "AeniExample",
                          dependencies: ["Raylib", "Aeni"],
                          resources: [.process("Assets")]),
    ]
)
```

The library is split into two parts, the Sprite type that is used to create a custom Sprite type and the Sprite Animator that accepts Sprite as a requirement in order to animate through the spritesheet that the Sprite holds.

Check the example below to see how to easily set it up:

```swift
import Raylib
import Aeni

Raylib.initWindow(800, 450, "Aeni Example")
Raylib.setTargetFPS(60)

let spriteLocation = Bundle.module.url(forResource: "player_sheet", withExtension: "png")
let playerSprite = Raylib.loadTexture(spriteLocation!.path)
let player = Sprite(spriteSheet: playerSprite, frameDimensions: Vector2(x: 24, y: 24), scale: Vector2(x: 2, y: 2), position: Vector2(x: 50, y: 50))
let playerIdle = SpriteAnimator(sprite: player, origin: Vector2(x: player.frameDimensions.x, y: player.frameDimensions.y), rotation: 0, startingFrame: 0, endingFrame: 4, column: 0, duration: 0, animationSpeed: 0.17, repeatable: true, tintColor: .white)

// You can continue adding more animations using the same Sprite and easily swap them around using a variable that holds the current animation or store them in a dictionary.

while !Raylib.windowShouldClose {
    Raylib.beginDrawing()
        Raylib.clearBackground(.black)
        playerIdle.render()
        playerIdle.update()
    Raylib.endDrawing()
}
Raylib.unloadTexture(playerSprite)
Raylib.closeWindow()
```

A very barebones example of how to get Aeni running! Yes, this is all you need!

Let's go through Sprite and SpriteAnimator one by one and the properties mean:

### Sprite

| Property    | Example               | Description                                                                                                                                                                               |
| ----------|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| __spriteSheet - Texture2D__ | `playerSprite`  | Required path to the spritesheet itself.
| __frameDimensions - Vector2__ | `Vector2(x: 24, y: 24)`   | These are the dimensions of the animation frames stored in a Vector2 type, x representing width and y representing height. These dimensions will be the same size as your character. In our example, the character is 24x24. |
| __scale - Vector2__   | `Vector2(x: 2, y: 2)` | The scale represents how much we would like to scale up our sprite by. If you don't want to scale up your sprite you can simply put 0 on both x & y.                                              |
| __position - Vector2__ | `Vector2(x: 50, y: 50)`  | Position property represents the location of your sprite, its x & y properties can be used to move the sprite in your window/game.| 


### Sprite Animator

| Property    | Example               | Description                                                                                                                                                                               |
| ----------|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| __sprite - Sprite__ | `player`  | Sprite type required to for the Sprite Animator to work.
| __origin - Vector2__ | `Vector2(x: player.frameDimensions.x, y: player.frameDimensions.y)`   | The origin point of the Sprite (rotation/scale point) will usually be your frame dimensions. |
| __startingFrame - UInt__   | `0` | The starting point of your animation.                                              |
| __endingFrame - UInt__ | `4`  | The last frame in the row of your animation is where your animation will end or begin looping through if repeatable is set to true.| 
| __column - UInt__ | `0`  | Which column you would like to animate through. Every spritesheet starts from 0, therefore your first row of animation will be on column 0.| 
| __duration - Float32__ | `3`  | How long you would like your animation to last. It's counted in seconds.| 
| __animationSpeed - Float32__ | `0.17`  | How fast you would like to have your sprite to be animated.| 
| __repeatable - Bool__ | `true`  | This value when set to true will loop your animation.| 

Future plans
=====
There are many things I want to add to Aeni, mainly internal collision detection between two Sprites so that it would be integrated within the Sprite type. If you have any suggestions on what to add please let me know and I will do my best!

Closing notes
=====
This is the first-ever public library I've ever made... I'm no professional programmer, but a simple beginner who's trying to learn as much as possible so please bear with me, and if you think there's any way Aeni can be updated to work better feel free to send a PR! I would love to learn more and know better ways of programming in Swift & overall.

A massive thank you to [Dustin from STREGAsGate](https://github.com/STREGAsGate) for the neverending support and as a massive inspiration to me. Not to also forget the best man [Novacti](https://github.com/novacti3) for his support during my work on Aeni.
