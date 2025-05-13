PlayState = Class {
    __includes = BaseState
}

function PlayState:init()
    self.player = Player()  
end

function PlayState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateStack:pop()
        gStateStack:push(MainMenu())
    end
    self.player:update(dt)

end

function AABB(a, b)

end

function PlayState:render()
    self.player:render() 
end
