import Raylib

public final class SpriteAnimator {
    public var sprite: Sprite
    public var origin: Vector2
    public var rotation: Float32
    public var startingFrame: UInt
    public var endingFrame: UInt
    public var column: UInt
    public var duration: Float32
    public var animationSpeed: Float32
    public var repeatable: Bool
    public var tintColor: Color

    internal var timeSinceStart: Float32 = 0
    internal var isAnimationFinished: Bool = false
    internal var spriteSize: Vector2

    public init(sprite: Sprite,origin: Vector2, rotation: Float32, startingFrame: UInt, endingFrame: UInt, column: UInt, duration: Float32, animationSpeed: Float32, repeatable: Bool, tintColor: Color) {
        self.sprite = sprite
        self.origin = origin
        self.rotation = rotation
        self.startingFrame = startingFrame
        self.endingFrame = endingFrame
        self.column = column
        self.duration = duration
        self.animationSpeed = animationSpeed
        self.repeatable = repeatable
        self.tintColor = tintColor

        self.spriteSize = self.sprite.frameDimensions
    }
}

extension SpriteAnimator {
    /// Main Render function for the Sprite Animator that renders the animation with drawTexturePro using data from Sprite type and assigned variable data during construction.
    public func render() {
        Raylib.drawTexturePro(self.sprite.spriteSheet, 
        Rectangle(x: Float32(startingFrame) * Float32(self.sprite.frameDimensions.x), y: Float32(column) * Float32(self.sprite.frameDimensions.y), width: Float32(self.spriteSize.x), height: Float32(self.spriteSize.y)), 
        Rectangle(x: self.sprite.position.x, y: self.sprite.position.y, width: Float32(self.sprite.frameDimensions.x) * self.sprite.scale.x, height: self.sprite.frameDimensions.y * self.sprite.scale.y), 
        Vector2(x: self.origin.x, y: self.origin.y), 
        self.rotation, 
        self.tintColor)
    }
}

extension SpriteAnimator {
    public func update() {

        if !isAnimationFinished {
            timeSinceStart += Raylib.getFrameTime()
            duration -= Raylib.getFrameTime()

            if timeSinceStart >= self.animationSpeed {
                timeSinceStart = 0
                startingFrame += 1
            }

            if startingFrame >= endingFrame {
                startingFrame = 0
            }
        }

        if !repeatable && duration <= 0{
            isAnimationFinished = true
            duration = 0
        }
    }
}

extension SpriteAnimator {
    public func flipSprite(horizontal: Bool, vertical: Bool) {
        self.spriteSize.x = abs(self.spriteSize.x) * (horizontal ? -1 : 1)
        self.spriteSize.y = abs(self.spriteSize.y) * (vertical ? -1 : 1)
    }
}
