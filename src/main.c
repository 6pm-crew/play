#include "raylib.h"

#define TARGET_FPS         60

#define SCREEN_WIDTH       800
#define SCREEN_HEIGHT      600

#define BACKGROUND_COLOR   ((Color) { 26, 26, 26, 255 })

int main(void) {
    // 게임 창을 생성한다.
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "6pm-crew/play");

    // 게임의 목표 FPS를 설정한다.
    SetTargetFPS(TARGET_FPS);

    // 6PM 로고 파일로 텍스처를 생성한다.
    // 텍스처를 생성하기 전에 반드시 `InitWindow()`를 호출해야 함을 기억하자!
    Texture2D texture = LoadTexture("res/images/6pm-logo_512x512.png");
    
    // 게임 화면의 경계를 나타내는 직사각형을 정의한다.
    const Rectangle bounds = { .width = SCREEN_WIDTH, .height = SCREEN_HEIGHT };

    // 6PM 로고를 그릴 위치를 정의한다.
    const Vector2 position = { 
        0.5f * (SCREEN_WIDTH - texture.width),
        0.5f * (SCREEN_HEIGHT - texture.height)
    };

    // 사용자가 창을 닫거나, `ESC` 키를 누르기 전까지 반복한다.
    while (!WindowShouldClose()) {
        // 게임 화면을 그리기 위해 프레임 버퍼를 초기화한다.
        BeginDrawing();
        
        // 프레임 버퍼를 검은색으로 채운다.
        ClearBackground(BLACK);

        // 게임 화면에 어두운 회색 색상의 직사각형을 그린다.
        DrawRectangleRec(bounds, BACKGROUND_COLOR);

        // 게임 화면의 가운데에 6PM 로고를 그린다.
        DrawTextureV(texture, position, WHITE);

        // 게임 화면에 현재 FPS를 표시한다.
        DrawFPS(8, 8);

        // 더블 버퍼링 기법을 사용하여 게임 화면을 그리고,
        // 다음 프레임 버퍼를 준비한다.
        EndDrawing();
    }

    // 텍스처에 할당된 메모리를 해제한다.
    UnloadTexture(texture);
    
    // 게임 창에 할당된 메모리를 해제한다.
    CloseWindow();

    return 0;
}