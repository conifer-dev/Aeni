import Raylib

public final class Sprite {
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