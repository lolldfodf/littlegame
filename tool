<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dino Game</title>
<style>
    body {
        margin: 0;
        padding: 0;
        overflow: hidden;
    }
    canvas {
        display: block;
    }
</style>
</head>
<body>
<canvas id="gameCanvas" width="800" height="400"></canvas>
<script>
    // Game Variables
    let canvas, ctx;
    let dino, obstacle;
    let gravity;
    let isGameOver;
    let obstacleSpeed;
    let score;

    // Dino Class
    class Dino {
        constructor() {
            this.x = 50;
            this.y = 300;
            this.width = 50;
            this.height = 50;
            this.jump = false;
            this.jumpSpeed = 0;
            this.jumpHeight = 200;
        }
        draw() {
            ctx.fillStyle = "green";
            ctx.fillRect(this.x, this.y, this.width, this.height);
        }
        jumpAction() {
            if (!this.jump) {
                this.jump = true;
                this.jumpSpeed = 5;
            }
        }
        update() {
            if (this.jump) {
                this.y -= this.jumpSpeed;
                this.jumpSpeed -= 0.2;
                if (this.jumpSpeed <= 0) {
                    this.jump = false;
                }
            }
            if (this.y < 300) {
                this.y += gravity;
            }
        }
    }

    // Obstacle Class
    class Obstacle {
        constructor() {
            this.x = 800;
            this.y = 300;
            this.width = 20;
            this.height = 40;
        }
        draw() {
            ctx.fillStyle = "red";
            ctx.fillRect(this.x, this.y, this.width, this.height);
        }
        update() {
            this.x -= obstacleSpeed;
            if (this.x + this.width < 0) {
                this.x = 800;
                score++;
            }
            if (this.x < dino.x + dino.width && this.x + this.width > dino.x &&
                this.y < dino.y + dino.height && this.y + this.height > dino.y) {
                isGameOver = true;
            }
        }
    }

    // Game Loop
    function gameLoop() {
        if (!isGameOver) {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            dino.draw();
            dino.update();
            obstacle.draw();
            obstacle.update();
            drawScore();
            requestAnimationFrame(gameLoop);
        } else {
            endGame();
        }
    }

    // Draw Score
    function drawScore() {
        ctx.fillStyle = "#000";
        ctx.font = "20px Arial";
        ctx.fillText("Score: " + score, 10, 30);
    }

    // End Game
    function endGame() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = "#000";
        ctx.font = "30px Arial";
        ctx.fillText("Game Over!", canvas.width / 2 - 100, canvas.height / 2);
        ctx.fillText("Score: " + score, canvas.width / 2 - 50, canvas.height / 2 + 40);
    }

    // Initialize Game
    function init() {
        canvas = document.getElementById("gameCanvas");
        ctx = canvas.getContext("2d");
        dino = new Dino();
        obstacle = new Obstacle();
        gravity = 0.5;
        obstacleSpeed = 2;
        isGameOver = false;
        score = 0;
        document.addEventListener("keydown", function(event) {
            if (event.keyCode === 32) {
                dino.jumpAction();
            }
        });
        gameLoop();
    }

    // Start Game
    window.onload = function() {
        init();
    };
</script>
</body>
</html>
