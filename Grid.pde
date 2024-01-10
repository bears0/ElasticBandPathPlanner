class Grid {
    int[][] grid = new int[80][80];

    Grid() {
        for (int i = 0; i < 80; i++) {
            for (int j = 0; j < 80; j++)
                grid[i][j] = 0;
        }
    }

    void set(int x, int y, int value) {
        grid[x][y] = value;
    }

    int get(int x, int y) {
        return grid[x][y];
    }

    PVector getClosestObstacle(int x, int y) {
        float min = 100000;
        PVector closest = new PVector(-1, -1);
        for (int i = 0; i < 80; i++) {
            for (int j = 0; j < 80; j++) {
                if (grid[i][j] == 1) {
                    float dist = (float) Math.sqrt(Math.pow(i - x, 2) + Math.pow(j - y, 2));
                    if (dist < min) {
                        min = dist;
                        closest.x = i*10+5;
                        closest.y = j*10+5;
                    }
                }
            }
        }
        //println(closest);
        return closest; // Returns pixel position of closest obstacle
    }

    void show() {
        stroke(0);
        strokeWeight(1);
        for (int i = 0; i < 80; i++) {
            for (int j = 0; j < 80; j++){
                if(grid[i][j] == 1){
                    fill(255);
                } else {
                    fill(0,0,0,0);
                }
                rect(i * 10, j * 10, 10, 10);
            }
        }
    }

    void addRect(int x1, int y1, int x2, int y2) {
        stroke(51);
        strokeWeight(1);
        fill(255, 0, 0, 100);
        if(x1 > x2) {
            int temp = x1;
            x1 = x2;
            x2 = temp;
        }
        if(y1 > y2) {
            int temp = y1;
            y1 = y2;
            y2 = temp;
        }
        for(int i = 0; i < 80; i++) {
            for (int j = 0; j < 80; j++) {
                if(i >= x1 && i <= x2 && j >= y1 && j <= y2) {
                    grid[i][j] = 1;
                }
            }
        }
    }

    void clear() {
        for(int i = 0; i < 80; i++) {
            for (int j = 0; j < 80; j++) {
                grid[i][j] = 0;
            }
        }
    }
}
