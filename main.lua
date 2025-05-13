require 'src/Dependencies'

function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
    gStateStack = StateStack()
    gStateStack:push(MainMenu())
    -- keep track of keypressed
    love.keyboard.keysPressed = {}
end

function love.update(dt)
    gStateStack:update(dt)
    love.keyboard.keysPressed = {}
end 


function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    love.keyboard.keysPressed[key] = true
end 


function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.draw()
    gStateStack:render()
end
