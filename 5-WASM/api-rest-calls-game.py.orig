import pygame
import random
import requests
import json

# Initialize Pygame
pygame.init()

# Set screen dimensions
screen_width = 600
screen_height = 400
screen = pygame.display.set_mode((screen_width, screen_height))
pygame.display.set_caption("Funny Character Game")

# Define colors
WHITE = (255, 255, 255)
RED = (255, 0, 0)
BLUE = (0, 0, 255)
GREEN = (0, 255, 0)
YELLOW = (255, 255, 0)

# Character and Object setup
character = pygame.Rect(100, 100, 50, 50)  # Simple square as the character
character_color = (255, 165, 0)  # Orange color
speed = 5  # Movement speed

# Objects (e.g., 4 corners)
objects = [
    pygame.Rect(50, 50, 50, 50),  # Top-left corner
    pygame.Rect(500, 50, 50, 50),  # Top-right corner
    pygame.Rect(50, 350, 50, 50),  # Bottom-left corner
    pygame.Rect(500, 350, 50, 50),  # Bottom-right corner
]
object_colors = [RED, BLUE, GREEN, YELLOW]

# Set up font for text
font = pygame.font.SysFont(None, 30)

# Function to draw text on the screen
def draw_text(text, x, y):
    text_surface = font.render(text, True, (0, 0, 0))
    screen.blit(text_surface, (x, y))

# Function to handle collisions with objects
def handle_collision():
    for i, obj in enumerate(objects):
        if character.colliderect(obj):
            # When collision happens, trigger the JavaScript API call
            object_name = f"Object {i + 1}"
            call_api(object_name)
            draw_text(f"Collided with {object_name}!", 200, 10)
            pygame.display.update()
            break
def call_api(object_name):
    match object_name:
        case "Object 1":
            url = "http://172.22.104.3:30008"
        case "Object 2":
            url = "http://172.22.104.3:30008/tasks"
        case "Object 3":
            url = "http://172.22.104.3:30008/tasks"
        case "Object 4":
            url = "http://172.22.104.3:30008/tasks"
            
    # Make the GET request
    response = requests.get(url)

    # Check the status code (200 means OK)
    if response.status_code == 200:
        draw_text(f"API code OK {response.status_code}", 100, 50)
        #draw_text(response.json(), 200, 100)
    else:
        draw_text(f"Error API status code: {response.status_code}", 100, 50)
 
# Game loop
running = True
clock = pygame.time.Clock()

while running:
    screen.fill(WHITE)

    # Event handling
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    # Get keys pressed for movement
    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT]:
        character.x -= speed
    if keys[pygame.K_RIGHT]:
        character.x += speed
    if keys[pygame.K_UP]:
        character.y -= speed
    if keys[pygame.K_DOWN]:
        character.y += speed

    # Handle collisions with objects
    handle_collision()

    # Draw objects (colored squares)
    for i, obj in enumerate(objects):
        pygame.draw.rect(screen, object_colors[i], obj)

    # Draw character
    pygame.draw.rect(screen, character_color, character)

    pygame.display.update()
    clock.tick(60)

pygame.quit()