local myFunctions = {}

function myFunctions.isRadiusCollide(objet1, objet2)
    return math.dist(objet1.x, objet1.y, objet2.x, objet2.y) < objet1.r + objet2.r
end

function myFunctions.AfficheCentree(objet)
    love.graphics.draw(
        objet.image,
        objet.x,
        objet.y,
        objet.angle,
        1,
        1,
        objet.image:getWidth() / 2,
        objet.image:getHeight() / 2
    )
end

return myFunctions
