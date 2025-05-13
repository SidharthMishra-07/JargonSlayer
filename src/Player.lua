
Player = Class {
    __includes = BaseState
}

function Player:init()
    -- Load sprite sheet
    self.image =love.graphics.newImage('assets/player_spritesheet.png')

    -- Frame size
    local frameWidth, frameHeight = 16,16

    -- Create grid
    local g = anim8.newGrid(frameWidth, frameHeight, self.image:getWidth(), self.image:getHeight())

    -- Define animations for each direction
    self.animations = {
        down  = anim8.newAnimation(g('13-15', 1), 0.1),
        left  = anim8.newAnimation(g('13-15', 2), 0.1),
        right = anim8.newAnimation(g('13-15', 3), 0.1),
        up    = anim8.newAnimation(g('13-15', 4), 0.1)
    }

    self.currentAnimation = self.animations.down
    self.x, self.y = 500, 100
    self.speed = 200 
    self.width = frameWidth*3
    self.height = frameHeight*3
end

function Player:update(dt)
    local moving = false

    if love.keyboard.isDown('up') then
        self.y = self.y - self.speed * dt
        self.currentAnimation = self.animations.up
        moving = true
    elseif love.keyboard.isDown('down') then
        self.y = self.y + self.speed * dt
        self.currentAnimation = self.animations.down
        moving = true
    elseif love.keyboard.isDown('left') then
        self.x = self.x - self.speed * dt
        self.currentAnimation = self.animations.left
        moving = true
    elseif love.keyboard.isDown('right') then
        self.x = self.x + self.speed * dt
        self.currentAnimation = self.animations.right
        moving = true
    end

    -- Clamp position within screen boundaries
    self.x = math.max(0, math.min(self.x, WINDOW_WIDTH - self.width))
    self.y = math.max(0, math.min(self.y, WINDOW_HEIGHT - self.height))

    if moving then
        self.currentAnimation:update(dt)
        -- self.currentAnimation:gotoFrame(1) -- idle frame (optional)
    end
end

function Player:render()
    -- Draw the animation (scaled by 3x)
    self.currentAnimation:draw(self.image, self.x, self.y, 0, 3, 3)

    -- Draw the name "SID" above the character
    local text = "SID"
    local font = love.graphics.getFont()
    local textWidth = font:getWidth(text)
    love.graphics.print(text, self.x + self.width / 2 - textWidth / 2, self.y - 20)

    -- Optional: Draw bounding box for debug
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end

