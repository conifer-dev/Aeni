import Raylib

// MARK: Sprite Animation System.
public final class SpriteAnimator {

    // Public variable declerations.
    public var sprite: Sprite
    public var position: Vector2
    public var origin: Vector2
    public var rotation: Float32
    public var startingFrame: UInt
    public var endingFrame: UInt
    public var column: UInt
    public var duration: Float32
    public var animationSpeed: Float32
    public var repeatable: Bool
    public var tintColor: Color
    public var debugMode: Bool

    // Pre-set variables without need to initialise.
    public private (set) var destRect: Rectangle = Rectangle()

    // Internal variables declarations.
    internal var timeSinceStart: Float32 = 0
    internal var isAnimationFinished: Bool = false
    internal var spriteSize: Vector2

    public init(sprite: Sprite, position: Vector2, origin: Vector2, rotation: Float32, startingFrame: UInt, endingFrame: UInt, column: UInt, duration: Float32, animationSpeed: Float32, repeatable: Bool, tintColor: Color, debugMode: Bool) {
        self.sprite = sprite
        self.position = position
        self.origin = origin
        self.rotation = rotation
        self.startingFrame = startingFrame
        self.endingFrame = endingFrame
        self.column = column
        self.duration = duration
        self.animationSpeed = animationSpeed
        self.repeatable = repeatable
        self.tintColor = tintColor
        self.debugMode = debugMode

        // Internal variable pre-initialisation.
        self.spriteSize = self.sprite.frameDimensions
    }
}

extension SpriteAnimator {

    /// Main render function for the Sprite Animator that renders the animation with drawTexturePro using data from Sprite type and assigned variable data during construction. 
    /// Destination rectangle for drawTexturePro uses internal variable spriteSize and not the frameDimensions in order to flip the sprite in the flipSprite function.
    public func render() {

        // Internal Sprite type rectangle assigned to renderer
        self.sprite.sourceRect = Rectangle(x: Float32(startingFrame) * Float32(self.sprite.frameDimensions.x), y: Float32(column) * Float32(self.sprite.frameDimensions.y), width: Float32(self.spriteSize.x), height: Float32(self.spriteSize.y))
        // Sprite Animators assigned destination rectangle that is responsible for rendering the position and scale of the Sprite.
        self.destRect = Rectangle(x: self.position.x, y: self.position.y, width: self.sprite.frameDimensions.x * self.sprite.scale.x, height: self.sprite.frameDimensions.y * self.sprite.scale.y)
        
        // Rendering the animation.
        Raylib.drawTexturePro(self.sprite.spriteSheet, 
        self.sprite.sourceRect, 
        destRect, 
        Vector2(x: self.origin.x, y: self.origin.y), 
        self.rotation, 
        self.tintColor)

        // If enabled, debug mode will render a box around the sprite that represents its hitbox for collision detection. 
        // Highly recommended to enable in order to find the sweet spot for your origin point.
        if self.debugMode {
            Raylib.drawRectangleLines(Int32(self.position.x), Int32(self.position.y), Int32(destRect.width), Int32(destRect.height), .red)
        }
        
    }
}

extension SpriteAnimator {

    /// Main update function for the Sprite Animator, not much to say other than it makes your animation go bbrrrrr.
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

extension SpriteAnimator {

    /// hasCollided function requires you to provide anothers sprite animations destination rectangle. It's a public animator variable called destRect.
    /// Returns true on collision and false when no collision is detected.
    public func hasCollided(with secondSprite: Rectangle) -> Bool {
        if Raylib.checkCollisionRecs(self.destRect, secondSprite) {
            return true
        } else {
            return false
        }
    }
}