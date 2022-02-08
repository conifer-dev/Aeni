import Raylib

public final class SpriteAnimator {
    public var sprite: Sprite
    public var origin: Vector2
    public var rotation: Float32
    public var startingFrame: UInt
    public var endingFrame: UInt
    public var column: UInt
    public var animationSpeed: Float32
    public var tintColor: Color

    internal var timeSinceStart: Float32 = 0

    public init(sprite: Sprite, origin: Vector2, rotation: Float32, startingFrame: UInt, endingFrame: UInt, column: UInt, animationSpeed: Float32, tintColor: Color) {
        self.sprite = sprite
        self.origin = origin
        self.rotation = rotation
        self.startingFrame = startingFrame
        self.endingFrame = endingFrame
        self.column = column
        self.animationSpeed = animationSpeed
        self.tintColor = tintColor
    }

    public func render() {

        Raylib.drawTexturePro(self.sprite.spriteSheet, Rectangle(x: Float32(startingFrame) * Float32(self.sprite.frameDimensions.x), y: Float32(column) * Float32(self.sprite.frameDimensions.y), width: Float32(self.sprite.frameDimensions.x), height: Float32(self.sprite.frameDimensions.y)), Rectangle(x: self.sprite.position.x, y: self.sprite.position.y, width: Float32(self.sprite.frameDimensions.x) * self.sprite.scale.x, height: self.sprite.frameDimensions.y * self.sprite.scale.x), Vector2(x: self.origin.x, y: self.origin.y), self.rotation, self.tintColor)
    }

    public func update() {
        timeSinceStart += Raylib.getFrameTime()

        if timeSinceStart >= self.animationSpeed {
            timeSinceStart = 0
            startingFrame += 1
        }
    }
}