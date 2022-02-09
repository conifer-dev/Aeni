import Raylib

// MARK: Sprite Type
public final class Sprite {

    // Public variable decleration
    public var spriteSheet: Texture2D
    public var frameDimensions: Vector2
    public var scale: Vector2
    public var position: Vector2

    public init(spriteSheet: Texture2D, frameDimensions: Vector2, scale: Vector2, position: Vector2) {
        self.spriteSheet = spriteSheet
        self.frameDimensions = frameDimensions
        self.scale = scale
        self.position = position
    }
}