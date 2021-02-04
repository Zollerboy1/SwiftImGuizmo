import ImGui
import SGLMath

@_exported import cImGuizmo

extension Optional where Wrapped: PointerProvider {
    @usableFromInline
    internal func withUnsafePointer<R>(_ body: (UnsafePointer<Wrapped.Value>?) throws -> R) rethrows -> R {
        if let wrapped = self {
            return try wrapped.withUnsafePointer {
                try body($0)
            }
        } else {
            return try body(nil)
        }
    }
}

extension Optional where Wrapped: MatrixType {
    @usableFromInline
    internal func withUnsafePointer<R>(_ body: (UnsafePointer<Wrapped.Element>?) throws -> R) rethrows -> R {
        if let wrapped = self {
            return try wrapped.withUnsafePointer {
                try body($0)
            }
        } else {
            return try body(nil)
        }
    }
}

public enum ImGuizmo {
    @inlinable
    public static func setDrawlist(to drawlist: UnsafeMutablePointer<CImDrawList>? = nil) {
        igzSetDrawlist(drawlist)
    }

    @inlinable
    public static func beginFrame() {
        igzBeginFrame()
    }

    @inlinable
    public static func setImGuiContext(to context: ImGuiContext) {
        igzSetImGuiContext(context.pointer)
    }

    @inlinable
    public static func isOver() -> Bool {
        igzIsOver()
    }

    @inlinable
    public static func isUsing() -> Bool {
        igzIsUsing()
    }

    @inlinable
    public static func enable(_ enable: Bool) {
        igzEnable(enable)
    }

    @inlinable
    public static func decompose(matrix: mat4) -> (translation: vec3, rotation: vec3, scale: vec3) {
        var translation = vec3()
        var rotation = vec3()
        var scale = vec3()

        matrix.withUnsafePointer { matrixPointer in
            translation.withUnsafeMutablePointer { translationPointer in
                rotation.withUnsafeMutablePointer { rotationPointer in
                    scale.withUnsafeMutablePointer { scalePointer in
                        igzDecomposeMatrixToComponents(matrixPointer, translationPointer, rotationPointer, scalePointer)
                    }
                }
            }
        }

        return (translation, rotation, scale)
    }

    @inlinable
    public static func recomposeMatrix(fromTranslation translation: vec3, rotation: vec3, scale: vec3) -> mat4 {
        var matrix = mat4()

        translation.withUnsafePointer { translationPointer in
            rotation.withUnsafePointer { rotationPointer in
                scale.withUnsafePointer { scalePointer in
                    matrix.withUnsafeMutablePointer { matrixPointer in
                        igzRecomposeMatrixFromComponents(translationPointer, rotationPointer, scalePointer, matrixPointer)
                    }
                }
            }
        }

        return matrix
    }

    @inlinable
    public static func setRect(toX x: Float, y: Float, width: Float, height: Float) {
        igzSetRect(x, y, width, height)
    }

    @inlinable
    public static func setOrthographic(_ isOrthographic: Bool) {
        igzSetOrthographic(isOrthographic)
    }

    @inlinable
    public static func drawCubes(withMatrices matrices: [mat4], viewMatrix view: mat4, projectionMatrix projection: mat4) {
        let count = matrices.count

        matrices.withContiguousStorageIfAvailable { matricesBuffer in
            view.withUnsafePointer { viewPointer in
                projection.withUnsafePointer { projectionPointer in
                    let matricesPointer = UnsafeRawPointer(matricesBuffer.baseAddress)?.assumingMemoryBound(to: Float.self)
                    igzDrawCubes(viewPointer, projectionPointer, matricesPointer, Int32(count))
                }
            }
        }
    }

    @inlinable
    public static func drawGrid(withSize gridSize: Float, matrix: mat4, viewMatrix view: mat4, projectionMatrix projection: mat4) {
        matrix.withUnsafePointer { matrixPointer in
            view.withUnsafePointer { viewPointer in
                projection.withUnsafePointer { projectionPointer in
                    igzDrawGrid(viewPointer, projectionPointer, matrixPointer, gridSize)
                }
            }
        }
    }

    @inlinable
    public static func manipulate(matrix: inout mat4, withViewMatrix view: mat4, projectionMatrix projection: mat4, operation: Operation, mode: Mode, snap: vec3? = nil, localBounds: [Float]? = nil, boundsSnap: vec3? = nil) -> Bool {
        matrix.withUnsafeMutablePointer { matrixPointer in
            view.withUnsafePointer { viewPointer in
                projection.withUnsafePointer { projectionPointer in
                    snap.withUnsafePointer { snapPointer in
                        localBounds.withUnsafePointer { localBoundsPointer in
                            boundsSnap.withUnsafePointer { boundsSnapPointer in
                                igzManipulate(viewPointer, projectionPointer, C_OPERATION(rawValue: operation.rawValue), C_MODE(rawValue: mode.rawValue), matrixPointer, nil, snapPointer, localBoundsPointer, boundsSnapPointer)
                            }
                        }
                    }
                }
            }
        }
    }

    @inlinable
    public static func manipulate(matrix: inout mat4, withViewMatrix view: mat4, projectionMatrix projection: mat4, operation: Operation, mode: Mode, deltaMatrix: inout mat4, snap: vec3? = nil, localBounds: [Float]? = nil, boundsSnap: vec3? = nil) -> Bool {
        matrix.withUnsafeMutablePointer { matrixPointer in
            view.withUnsafePointer { viewPointer in
                projection.withUnsafePointer { projectionPointer in
                    deltaMatrix.withUnsafeMutablePointer { deltaMatrixPointer in
                        snap.withUnsafePointer { snapPointer in
                            localBounds.withUnsafePointer { localBoundsPointer in
                                boundsSnap.withUnsafePointer { boundsSnapPointer in
                                    igzManipulate(viewPointer, projectionPointer, C_OPERATION(rawValue: operation.rawValue), C_MODE(rawValue: mode.rawValue), matrixPointer, deltaMatrixPointer, snapPointer, localBoundsPointer, boundsSnapPointer)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    @inlinable
    public static func manipulate(viewMatrix view: inout mat4, withLength length: Float, position: CImVec2, size: CImVec2, backgroundColor: CImU32) {
        view.withUnsafeMutablePointer { viewPointer in
            igzViewManipulate(viewPointer, length, position, size, backgroundColor)
        }
    }

    @inlinable
    public static func setID(to id: Int32) {
        igzSetID(id)
    }

    @inlinable
    public static func isOver(gizmoForOperation operation: Operation) {
        igzIsOverOperation(C_OPERATION(rawValue: operation.rawValue))
    }

    @inlinable
    public static func setGizmosSizeClipSpace(to value: Float) {
        igzSetGizmoSizeClipSpace(value)
    }
}
