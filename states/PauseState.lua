PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.pipePairs = params.pipePairs
    self.score = params.score
    self.bird = params.bird
    self.timer = params.timer
    
    sounds['music']:pause()

end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('countdown', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            score = self.score,
            timer = self.timer
        })
    end
end

function PauseState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    --TODO: Сделать летающую по диагонали надпись pause (логика движения как в pong у мяча)
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()

    love.graphics.setFont(hugeFont)
    love.graphics.printf('PAUSE', 0, 120, VIRTUAL_WIDTH, 'center')
end


function PauseState:exit()
    sounds['pause']:play()
    sounds['music']:play()
end