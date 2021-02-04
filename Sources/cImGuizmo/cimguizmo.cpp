//
//  cimguizmo.cpp
//  
//
//  Created by Josef Zoller on 24.01.21.
//

#include "cimguizmo.h"

#include <conversions.h>

#include <cppimguizmo.hpp>

void igzSetDrawlist(CImDrawList * drawlist) {
    ImGuizmo::SetDrawlist(toIm(drawlist));
}

void igzBeginFrame() {
    ImGuizmo::BeginFrame();
}


void igzSetImGuiContext(CImGuiContext * ctx) {
    ImGuizmo::SetImGuiContext(ctx);
}


bool igzIsOver() {
    return ImGuizmo::IsOver();
}

bool igzIsUsing() {
    return ImGuizmo::IsUsing();
}

void igzEnable(bool enable) {
    ImGuizmo::Enable(enable);
}


void igzDecomposeMatrixToComponents(const float * matrix, float * translation, float * rotation, float * scale) {
    ImGuizmo::DecomposeMatrixToComponents(matrix, translation, rotation, scale);
}

void igzRecomposeMatrixFromComponents(const float * translation, const float * rotation, const float * scale, float * matrix) {
    ImGuizmo::RecomposeMatrixFromComponents(translation, rotation, scale, matrix);
}


void igzSetRect(float x, float y, float width, float height) {
    ImGuizmo::SetRect(x, y, width, height);
}

void igzSetOrthographic(bool isOrthographic) {
    ImGuizmo::SetOrthographic(isOrthographic);
}


void igzDrawCubes(const float * view, const float * projection, const float * matrices, int matrixCount) {
    ImGuizmo::DrawCubes(view, projection, matrices, matrixCount);
}

void igzDrawGrid(const float * view, const float * projection, const float * matrix, const float gridSize) {
    ImGuizmo::DrawGrid(view, projection, matrix, gridSize);
}


bool igzManipulate(const float * view, const float * projection, C_OPERATION operation, C_MODE mode, float * matrix, float * deltaMatrix, const float * snap, const float * localBounds, const float * boundsSnap) {
    return ImGuizmo::Manipulate(view, projection, (ImGuizmo::OPERATION)operation, (ImGuizmo::MODE)mode, matrix, deltaMatrix, snap, localBounds, boundsSnap);
}

void igzViewManipulate(float * view, float length, CImVec2 position, CImVec2 size, CImU32 backgroundColor) {
    ImGuizmo::ViewManipulate(view, length, toIm(position), toIm(size), backgroundColor);
}


void igzSetID(int id) {
    ImGuizmo::SetID(id);
}


bool igzIsOverOperation(C_OPERATION op) {
    return ImGuizmo::IsOver((ImGuizmo::OPERATION)op);
}

void igzSetGizmoSizeClipSpace(float value) {
    ImGuizmo::SetGizmoSizeClipSpace(value);
}

