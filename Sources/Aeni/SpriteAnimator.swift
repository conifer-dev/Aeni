import Raylib

// MARK: Sprite Animation System
public final class SpriteAnimator {

    // Public variable declerations
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

    // Internal variables declarations
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

    /// Main render function for the Sprite Animator that renders the animation with drawTexturePro using data from Sprite type and assigned variable data during construction. 
    /// Destination rectangle for drawTexturePro uses internal variable spriteSize and not the frameDimensions in order to flip the sprite in the flipSprite function.
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

    /// Main update function for the Sprite Animator, not much to say other than it makes your animation go bbrrrrr
    public func update() {

        // Run only when animation is not finished.
        if !isAnimationFinished {
            timeSinceStart += Raylib.getFrameTime()
            duration -= Raylib.getFrameTime()

            // Iterating our startingFrame by one based on the speed provided.
            if timeSinceStart >= self.animationSpeed {
                timeSinceStart = 0
                startingFrame += 1
            }

            // If our starting frame is greater than or equal to the ending frame, set it back to 0 and loop through until duration reaches 0 unless animation is set as repeatable. 
            if startingFrame >= endingFrame {
                startingFrame = 0
            }
        }
        // If animation is not set as repeatable and once duration is less than or equal to 0, set animation is finished bool to true to end the animation.
        if !repeatable && duration <= 0{
            isAnimationFinished = true
            duration = 0
        }
    }
}

extension SpriteAnimator {

    /// flipSprite function is used to flip the selected animation sprite either vertically, horizontally or both.
    public func flipSprite(horizontal: Bool, vertical: Bool) {
        self.spriteSize.x = abs(self.spriteSize.x) * (horizontal ? -1 : 1)
        self.spriteSize.y = abs(self.spriteSize.y) * (vertical ? -1 : 1)
    }
}
