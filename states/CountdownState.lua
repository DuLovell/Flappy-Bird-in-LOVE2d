--[[
    Countdown State
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Counts down visually on the screen (3,2,1) so that the player knows the
    game is about to begin. Transitions to the PlayState as soon as the
    countdown is complete.
]]

CountdownState = Class{__includes = BaseState}

function CountdownState:enter(params)
    self.pipePairs = params.pipePairs or {}
    self.score = params.score or 0
    self.bird = params.bird or nil
    self.global_timer = params.timer
    
    self.timer =  0
    self.count = 3
end

-- takes 1 second to count down each time
COUNTDOWN_TIME = 0.75

--[[
    Keeps track of how much time has passed and decreases count if the
    timer has exceeded our countdown time. If we have gone down to 0,
    we should transition to our PlayState.
]]
function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play', {
                bird = self.bird,
                pipePairs = self.pipePairs,
                score = self.score,
                timer = self.global_timer
            })
        end
    end
end

function CountdownState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    if self.bird then
        self.bird:render()
    end
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end