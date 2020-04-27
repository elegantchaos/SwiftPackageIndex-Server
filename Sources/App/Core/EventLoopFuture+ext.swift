import NIO


extension EventLoopFuture {
    static func just<T>(value: T) -> EventLoopFuture<T> {
        EmbeddedEventLoop().makeSucceededFuture(value)
    }
}
