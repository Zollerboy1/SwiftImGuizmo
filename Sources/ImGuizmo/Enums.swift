//
//  Enums.swift
//  
//
//  Created by Josef Zoller on 24.01.21.
//

extension ImGuizmo {
    public enum Operation: UInt32 {
        case translate
        case rotate
        case scale
        case bounds
    }

    public enum Mode: UInt32 {
        case local
        case world
    }
}
